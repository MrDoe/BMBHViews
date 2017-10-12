using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using OfficeOpenXml;

namespace BMBH_View
{
    public partial class Results : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dgdNCT.AllowPaging = true;
                dgdNCT.DataSource = GetData();
                dgdNCT.DataBind();
            }

            pnlMain.DefaultButton = btnRefresh.UniqueID;
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "SetScrollBars(); ", true);

            //pnlGrid.Height = Convert.ToInt32(height.Value) - 100;
            txtMaxPage.Text = dgdNCT.PageCount.ToString();
        }
         
        private void ShowMsg(string message)
        {
            Response.Write("<script>alert('" + message + "');</script>");
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
            var datatable = GetData();
            ExcelPackage excel = new ExcelPackage();
            var workSheet = excel.Workbook.Worksheets.Add("Exportierte Daten");
            var totalCols = datatable.Columns.Count;
            var totalRows = datatable.Rows.Count;

            for (var col = 1; col <= totalCols; col++)
                workSheet.Cells[1, col].Value = datatable.Columns[col - 1].ColumnName;

            for (var row = 1; row <= totalRows; row++)
                for (var col = 0; col < totalCols; col++)
                    workSheet.Cells[row + 1, col + 1].Value = datatable.Rows[row - 1][col];

            using (var memoryStream = new MemoryStream())
            {
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                string sFileName = "Export_" + DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss") + ".xlsx";
                Response.AddHeader("content-disposition", "attachment;  filename=" + sFileName);
                excel.SaveAs(memoryStream);
                memoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            dgdNCT.PageIndex = Int32.Parse(txtPage.Text);
            dgdNCT.PageSize = Int32.Parse(txtRowPerPage.Text);
            dgdNCT.DataSource = GetData();
            dgdNCT.DataBind();
            txtMaxPage.Text = dgdNCT.PageCount.ToString();
        }

        protected void btnPrevPage_Click(object sender, ImageClickEventArgs e)
        {
            int nPageNo = Int32.Parse(txtPage.Text) - 1;
            if (nPageNo > 0)
            {
                txtPage.Text = nPageNo.ToString();
                dgdNCT.PageIndex = nPageNo - 1;
                dgdNCT.DataSource = GetData();
                dgdNCT.DataBind();
            }
        }

        protected void btnNextPage_Click(object sender, ImageClickEventArgs e)
        {
            int nPageNo = Int32.Parse(txtPage.Text) + 1;
            txtPage.Text = nPageNo.ToString();
            dgdNCT.PageIndex = nPageNo - 1;
            dgdNCT.DataSource = GetData();
            dgdNCT.DataBind();
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
                dt.DefaultView.Sort = e.SortExpression + " " + GetSortDirection(e.SortExpression);
                dgdNCT.DataSource = Session["MainTable"];
                dgdNCT.DataBind();
            }
        }
    }
}