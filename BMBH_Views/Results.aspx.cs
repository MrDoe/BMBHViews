using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using OfficeOpenXml;
using System.Collections.Generic;

namespace BMBH_View
{
    public partial class Results : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack ||
                this.Request["__EVENTARGUMENT"] == "PostFromList_Send" ||
                this.Request["__EVENTARGUMENT"] == "PostFromList_Cancel")
            {
                if (this.Request["__EVENTARGUMENT"] == "PostFromList_Send")
                    btnSendList_Click(sender, e);

                if (Session["MainTable"] == null)
                    dgdNCT.DataSource = GetData();
                else
                    dgdNCT.DataSource = Session["MainTable"] as DataTable;
                dgdNCT.DataBind();

                // set page count
                Session["MaxPage"] = dgdNCT.PageCount;
                txtMaxPage.Text = dgdNCT.PageCount.ToString();

                // set default button for submit action
                pnlMain.DefaultButton = btnRefresh.UniqueID;

                // adapt scrollbars to window size
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "SetScrollBars(); ", true);
            }
        }
         
        private void ShowMsg(string message)
        {
            ScriptManager.RegisterClientScriptBlock((Page as Control), this.GetType(), "alert", "alert('" + message + "');", true);
        }

        public DataTable GetData()
        {
            string sSQL;
            string sOrderBy = "";

            //if (Session["SortCriteria"] != null && Session["SortDirection"] != null)
            //    sOrderBy = "order by v.[" + Session["SortCriteria"].ToString() + "], ID " + Session["SortDirection"].ToString();
            //else
            //    sOrderBy = "order by v.[ID]";

            if (Session["LastQuery"] == null)
                sSQL = "SELECT * FROM [" + Session["View"] + "] v " + sOrderBy;
            else
                sSQL = Session["LastQuery"].ToString() + " " + sOrderBy;
           
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            using (var cmd = new SqlCommand(sSQL, conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var dt = new DataTable();
                adapter.Fill(dt);
                Session["MainTable"] = dt;
                txtTotalRows.Text = dt.Rows.Count.ToString();
                Session["DataCount"] = txtTotalRows.Text;
                return dt;
            }
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            var datatable = (Session["MainTable"] as DataTable).DefaultView.ToTable();
            ExcelPackage excel = new ExcelPackage();
            var workSheet = excel.Workbook.Worksheets.Add("Exportierte Daten");
            var totalCols = datatable.Columns.Count;
            var totalRows = datatable.Rows.Count;
            HashSet<string> DateCols = Session["DateCols"] as HashSet<string>;
            HashSet<string> DateTimeCols = Session["DateTimeCols"] as HashSet<string>;

            for (var col = 1; col <= totalCols; col++)
                workSheet.Cells[1, col].Value = datatable.Columns[col - 1].ColumnName;

            for (var row = 1; row <= totalRows; row++)
                for (var col = 0; col < totalCols; col++)
                {
                    workSheet.Cells[row + 1, col + 1].Value = datatable.Rows[row - 1][col];

                    string sColName = datatable.Columns[col].ColumnName;
                   
                    if (DateCols.Contains(sColName))
                        workSheet.Cells[row + 1, col + 1].Style.Numberformat.Format = "dd.mm.yyyy";
                    if (DateTimeCols.Contains(sColName))
                        workSheet.Cells[row + 1, col + 1].Style.Numberformat.Format = "dd.mm.yyyy HH:mm";
                }

            using (var memoryStream = new MemoryStream())
            {
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                string sFileName = (string)Session["View"] + DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss") + ".xlsx";
                Response.AddHeader("content-disposition", "attachment;  filename=" + sFileName);
                excel.SaveAs(memoryStream);
                memoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();
            }
        }

        protected void RefreshPage()
        {
            dgdNCT.DataSource = Session["MainTable"];
            dgdNCT.PageIndex = Int32.Parse(txtPage.Text)-1;
            dgdNCT.PageSize = Int32.Parse(txtRowPerPage.Text);
            dgdNCT.DataBind();
            Session["CurrentPage"] = dgdNCT.PageIndex + 1;
            Session["MaxPage"] = dgdNCT.PageCount;
            txtMaxPage.Text = dgdNCT.PageCount.ToString();
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            RefreshPage();
        }

        protected void btnPrevPage_Click(object sender, ImageClickEventArgs e)
        {
            int nPageNo = (int)Session["CurrentPage"];
            if (nPageNo > 1)
            {
                txtPage.Text = (nPageNo - 1).ToString();
            }
            RefreshPage();
        }

        protected void btnNextPage_Click(object sender, ImageClickEventArgs e)
        {       
            int nPageNo = (int)Session["CurrentPage"];
            int nMaxPage = (int)Session["MaxPage"];
 
            if (nPageNo < nMaxPage)
            {
                txtPage.Text = (nPageNo + 1).ToString();
            }
            RefreshPage();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Session["ShowListDialog"] = null;
            Session["UserDept"] = null;
        }

        protected void btnList_Click(object sender, EventArgs e)
        {
            Session["ShowListDialog"] = true;
            txtListName.Focus();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Search.aspx");
        }

        private string GetSortDirection(string column)
        {
            // By default, set the sort direction to ascending.
            string sortDirection = "ASC";

            // Retrieve the last column that was sorted.
            string sortExpression = ViewState["SortExpression"] as string;

            if (sortExpression != null)
            {
                // Check if the same column is being sorted.
                // Otherwise, the default value can be returned.
                if (sortExpression == column)
                {
                    string lastDirection = ViewState["SortDirection"] as string;
                    if ((lastDirection != null) && (lastDirection == "ASC"))
                    {
                        sortDirection = "DESC";
                    }
                }
            }

            // Save new values in ViewState.
            ViewState["SortDirection"] = sortDirection;
            ViewState["SortExpression"] = column;

            return sortDirection;
        }

        protected void dgdNCT_Sorting(object sender, GridViewSortEventArgs e)
        {
            //Retrieve the table from the session object.
            DataTable dt = Session["MainTable"] as DataTable;

            if (dt != null)
            {
                //Sort the data.
                string sSorting = e.SortExpression + " " + GetSortDirection(e.SortExpression);
                dt.DefaultView.Sort = sSorting;
                //Session["Sorting"] = sSorting;
                RefreshPage();
                //dgdNCT.DataSource = Session["MainTable"];
                //dgdNCT.DataBind();
            }
        }

        protected void cboDept_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["UserDept"] = cboDept.SelectedValue;
            //cboSLuser.DataBind();
            MPE.Show();
        }

        private void CreateCart(string sCartName, string sUserName)
        {
            String sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "dbo.CreateSTARLIMScart";
            cmd.Connection = con;
            
            // Add the input parameter and set its properties.
            SqlParameter parameter = new SqlParameter();
            parameter.ParameterName = "@CartName";
            parameter.SqlDbType = SqlDbType.NVarChar;
//            parameter.Direction = ParameterDirection.Input;
            parameter.Value = sCartName;
            cmd.Parameters.Add(parameter);

            SqlParameter parameter2 = new SqlParameter();
            parameter2.ParameterName = "@UserName";
            parameter2.SqlDbType = SqlDbType.NVarChar;
//            parameter2.Direction = ParameterDirection.Input;
            parameter2.Value = sUserName;
            cmd.Parameters.Add(parameter2);

            SqlParameter parameter3 = new SqlParameter();
            parameter3.ParameterName = "@GUID";
            parameter3.SqlDbType = SqlDbType.NVarChar;
//            parameter3.Direction = ParameterDirection.Input;
            parameter3.Value = Session["GUID"];
            cmd.Parameters.Add(parameter3);

            SqlParameter parameter4 = new SqlParameter();
            parameter4.ParameterName = "@Iteration";
            parameter4.SqlDbType = SqlDbType.Int;
            //            parameter3.Direction = ParameterDirection.Input;
            parameter4.Value = Session["Iteration"];
            cmd.Parameters.Add(parameter4);

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        protected void btnSendList_Click(object sender, EventArgs e)
        {
            if (txtListName.Text.Trim().Length > 0 && cboSLuser.SelectedValue.Length > 0)
            {
                CreateCart(txtListName.Text.Trim(), cboSLuser.SelectedValue);
                Session["ListSentMsg"] = "Die Liste \'" + txtListName.Text.Trim() + "\' wurde an den STARLIMS-Benutzer \'" + cboSLuser.SelectedValue + "\' gesendet!";
                ShowMsg((string)Session["ListSentMsg"]);
                RefreshPage();
            }
            else
            {
                ShowMsg("Bitte einen Listennamen eingeben und einen Benutzer auswählen.");
                MPE.Show();
                txtListName.Focus();
            }
        }

        protected void txtRowPerPage_TextChanged(object sender, EventArgs e)
        {
            txtPage.Text = "1";
        }

        protected void dgdNCT_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.RowIndex == 0)
                    e.Row.Style.Add("padding-top", "30px");
            }
        }
    }
}