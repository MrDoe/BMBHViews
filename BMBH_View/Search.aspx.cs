using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.IO;
using System.Drawing;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace BMBH_View
{
    public partial class NCT_TBB_Search : System.Web.UI.Page
    {
        const string sCurrentPage = "Search.aspx";
        const string sParentPage = "Results.aspx";

        protected void SetDataSource()
        {
            dsSearch.SelectCommand = "SELECT * FROM [" + Session["FormTable"] + "] WHERE ([UserId] = '" + (String)Session["UserName"] + "')";
            dsSearch.UpdateCommand = "UPDATE [" + Session["FormTable"] + "] SET [Operator] = @Operator, [Wert] = @Wert, [Controltype] = @Controltype WHERE [ID] = @ID";
            dsSearch.InsertCommand = "INSERT INTO [" + Session["FormTable"] + "] ([Attribut], [Operator], [Wert], [Datatype], [UserId]) VALUES (@Attribut, @Operator, @Wert, @Datatype, @UserId)";
            dsSearch.DeleteCommand = "DELETE FROM [" + Session["FormTable"] + "] WHERE [ID] = @ID";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session["UserName"] = Page.User.Identity.Name;
                Session["LastQuery"] = null;

                CreateTempTable();
            }

            SetDataSource();
        }

        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        private void CreateTempTable()
        {
            String sConnString = ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            string sUser = (string)Session["UserName"];
            cmd.Parameters.Add("@UserId", SqlDbType.NVarChar).Value = sUser;
            cmd.CommandText = "IF NOT EXISTS(select 1 from " + Session["FormTable"] + " where UserId='" + sUser + "')" +
                              " BEGIN" +
                              " insert into " + Session["FormTable"] +
                              " select Attribut, Operator, '', Datentyp, '" + sUser + "', Controltype from " + Session["FormView"] +
                              " END ELSE BEGIN" +
                              " update " + Session["FormTable"] +
                              " set Wert = null, Operator = '=' where UserId = '" + sUser + "'" +
                              " END";
            cmd.Connection = con;
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
                dgdSearch.DataBind();
            }
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            CreateTempTable();
            dgdSearch.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string sSelect = "select * ";
            string sFrom = " from " + Session["View"];
            string sWhere = "";
            bool bIsFirst = true;

            foreach (GridViewRow row in dgdSearch.Rows)
            {
                string sAttribute = row.Cells[1].Text;
                string sValue = ((Label)row.Cells[3].FindControl("Label2")).Text;
                string sDatatype = row.Cells[4].Text;

                // get value from drop down list
                Label lb = (Label)row.Cells[2].FindControl("Label1");
                string sOperator = lb.Text;

                if (sValue != "")
                {
                    if (!bIsFirst)
                    {
                        sWhere += " AND ";
                    }
                    else
                    {
                        sWhere += " WHERE ";
                        bIsFirst = false;
                    }

                    switch (sOperator)
                    {
                        case "IN":
                            sWhere += "[" + sAttribute + "] IN " + sValue;
                            break;

                        case "LIKE":
                            sWhere += "[" + sAttribute + "] LIKE '%" + sValue + "%'";
                            break;

                        default:
                            switch (sDatatype)
                            {
                                case "int":
                                case "decimal":
                                case "date":
                                case "datetime":
                                    sWhere += "[" + sAttribute + "]" + sOperator + sValue;
                                    break;

                                default:
                                    sWhere += "[" + sAttribute + "]" + sOperator + "'" + sValue + "'";
                                    break;
                            }
                            break;
                    }
                }
            }

            sWhere += " order by ID";

            string sSQL = sSelect + sFrom + sWhere;

            Session["LastQuery"] = Server.HtmlDecode(sSQL);
            Response.Redirect(sParentPage, true);
        }

        private DataSet GetData(string query)
        {
            string conString = ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString;
            SqlCommand cmd = new SqlCommand(query);
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        sda.Fill(ds);
                        return ds;
                    }
                }
            }
        }

        protected void dgdSearch_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string sCurrentField = (string)dgdSearch.Rows[e.NewEditIndex].Cells[1].Text;
            Session["CurrentField"] = sCurrentField;
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            TextBox txtValue = ((TextBox)(row.Cells[3].FindControl("txtValue")));
            DropDownList cboValue = (DropDownList)(row.Cells[3].FindControl("cboValue"));

            if (cboValue.Visible)
                txtValue.Text = cboValue.SelectedValue;

            btnNew.Enabled = true;
            btnSubmit.Enabled = true;
        }

        protected void cboOperator_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cboOperator = (DropDownList)sender;
            GridViewRow row = (GridViewRow)cboOperator.NamingContainer;
            EnableControls(row);
        }

        public void GetFromClipboard(string sFieldId, string sDatatype)
        { // call javascript function
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "pasteContent('" + sFieldId + "','" + sDatatype + "')", true);
            //Page.ClientScript.RegisterStartupScript(Page.GetType(), "pasteContent", "pasteContent()", true);
        }

        protected void btnInSelect_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string sRow = row.RowIndex.ToString();
            string sDatatype = row.Cells[4].Text;
            GetFromClipboard("MainContent_dgdSearch_txtValue_" + sRow, sDatatype);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            btnNew.Enabled = false;
            btnSubmit.Enabled = false;
        }

        protected void calFrom_SelectionChanged(object sender, EventArgs e)
        {
            Calendar calFrom = (Calendar)sender;
            GridViewRow row = (GridViewRow)calFrom.NamingContainer;
            TextBox txtValue = ((TextBox)(row.Cells[3].FindControl("txtValue")));
            txtValue.Text = calFrom.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss");
            string sOperator = ((DropDownList)row.Cells[2].FindControl("cboOperator")).SelectedValue;
            if (sOperator == "BETWEEN")
            {
                Calendar calTo = (Calendar)(row.FindControl("calTo"));
                txtValue.Text = "('" + calFrom.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + calTo.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss") + "')";
            }
            else
            {
                txtValue.Text = calFrom.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss");
            }
        }

        protected void calTo_SelectionChanged(object sender, EventArgs e)
        {
            Calendar calTo = (Calendar)sender;
            GridViewRow row = (GridViewRow)calTo.NamingContainer;
            TextBox txtValue = ((TextBox)(row.Cells[3].FindControl("txtValue")));
            string sOperator = ((DropDownList)row.Cells[2].FindControl("cboOperator")).SelectedValue;
            if (sOperator == "BETWEEN")
            {
                Calendar calFrom = (Calendar)(row.FindControl("calFrom"));
                txtValue.Text = "('" + calFrom.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss") + "', '" + calTo.SelectedDate.ToString("yyyy-MM-dd HH:mm:ss") + "')";
            }
        }

        public DataTable GetCboData(string sCurrentField)
        {
            string sSQL;
            sSQL = "exec('select null as TEXT union select distinct [" + sCurrentField + "] as TEXT from " + Session["View"] + " order by TEXT')";
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString))
            using (var cmd = new SqlCommand(sSQL, conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var dt = new DataTable();
                adapter.Fill(dt);
                conn.Close();
                return dt;
            }
        }

        public void EnableControls(GridViewRow row)
        {
            // controls
            DropDownList cboValue = (DropDownList)row.FindControl("cboValue");
            TextBox txtValue = (TextBox)(row.FindControl("txtValue"));
            ImageButton btnInSelect = (ImageButton)(row.FindControl("btnInSelect"));
            Calendar calFrom = (Calendar)(row.FindControl("calFrom"));
            Calendar calTo = (Calendar)(row.FindControl("calTo"));

            // hide all controls
            cboValue.Visible = false;
            cboValue.DataSource = null;
            txtValue.Visible = false;
            btnInSelect.Visible = false;
            calFrom.Visible = false;
            calTo.Visible = false;

            // get cell values
            string sCurrentField = (string)row.Cells[1].Text;
            //string sOperator = (string)row.Cells[2].Text;
            string sOperator = ((DropDownList)row.Cells[2].FindControl("cboOperator")).SelectedValue;
            string sValue = (string)row.Cells[3].Text;
            string sDatatype = (string)row.Cells[4].Text;
            string sControltype = ((DropDownList)row.Cells[3].FindControl("cboControltype")).SelectedValue;
            //ShowMsg(sCurrentField + sOperator + sValue + sDatatype + sControltype);

            switch (sControltype)
            {
                case "DropDownList":
                    switch (sOperator)
                    {
                        case "IN":
                            txtValue.Visible = true;
                            btnInSelect.Visible = true;
                            break;

                        case "LIKE":
                            txtValue.Visible = true;
                            break;

                        default:
                            cboValue.Visible = true;
                            cboValue.DataSource = GetCboData(sCurrentField);
                            cboValue.DataTextField = "TEXT";
                            cboValue.DataValueField = "TEXT";
                            cboValue.DataBind();
                            cboValue.SelectedValue = sValue;
                            break;
                    }
                    break;

                case "TextBox":
                    txtValue.Visible = true;

                    if (sOperator == "IN")
                        btnInSelect.Visible = true;
                    break;

                case "Calendar":
                    calFrom.Visible = true;

                    if (sOperator == "BETWEEN")
                        calTo.Visible = true;

                    txtValue.Visible = true;
                    break;
            }

            //DataRowView dr = e.Row.DataItem as DataRowView;
            //cboValue.SelectedValue = dr["YourCOLName"].ToString();
        }

        // called after hitting the "Edit" button
        protected void dgdSearch_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                    EnableControls(e.Row);
        }

        protected void cboControltype_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cboOperator = (DropDownList)sender;
            GridViewRow row = (GridViewRow)cboOperator.NamingContainer;
            EnableControls(row);
        }

        protected void chkList_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}