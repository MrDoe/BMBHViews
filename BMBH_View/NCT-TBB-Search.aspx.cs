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
        // constant definitions
        string sView = "V_NCT_TBB_Gesamt";
        string sFormTable = "Views_TBB_Search";
        string sFormView = "V_NCT_TBB_SearchForm";
        string sParentPage = "NCT-TBB.aspx";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session["UserName"] = Page.User.Identity.Name;
                Session["LastQuery"] = null;
                CreateTempTable();
            }
        }

        private void CreateTempTable()
        {
            String strConnString = ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            string sUser = (string)Session["UserName"];
            cmd.Parameters.Add("@UserId", SqlDbType.NVarChar).Value = sUser;
            cmd.CommandText = "delete from " + sFormTable + " where UserId = '" + sUser + "'"
                            + " insert into " + sFormTable
                            + " select Attribut, Operator, '', Datentyp, '" + sUser + "' from " + sFormView;
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
            }
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            CreateTempTable();
            dgdSearch.DataBind();
        }

        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string sSelect = "select * ";
            string sFrom = " from " + sView;
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
                            sWhere += sAttribute + " IN (" + sValue + ")";
                            break;

                        case "LIKE":
                            sWhere += sAttribute + " LIKE '%" + sValue + "%'";
                            break;

                        default:
                            switch (sDatatype)
                            {
                                case "int":
                                case "decimal":
                                    sWhere += sAttribute + sOperator + sValue;
                                    break;

                                default:
                                    sWhere += sAttribute + sOperator + "'" + sValue + "'";
                                    break;
                            }
                            break;
                    }
                }
            }

            sWhere += " order by InventarID";

            string sSQL = sSelect + sFrom + sWhere;

            //ShowMsg(Server.HtmlDecode(sSQL).ToString());

            Session["LastQuery"] = Server.HtmlDecode(sSQL);
            Server.Transfer(sParentPage, true);
        }

        public bool SetVisibility(string sDatatype)
        {
            switch (sDatatype)
            {
                case "char":
                case "varchar":
                case "nvarchar":
                    return false;

                case "int":
                case "datetime":
                    return true;
            }

            return true;
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
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
        }

        protected void cboOperator_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cboOperator = (DropDownList)sender;
            GridViewRow row = (GridViewRow)cboOperator.NamingContainer;
            string sDatatype = row.Cells[4].Text;

            if (sDatatype == "nvarchar" || sDatatype == "char")
            {
                if (cboOperator.SelectedValue == "LIKE")
                {
                    DropDownList cboValue = (DropDownList)(row.Cells[3].FindControl("cboValue"));
                    cboValue.Visible = false;

                    TextBox txtValue = ((TextBox)(row.Cells[3].FindControl("txtValue")));
                    txtValue.Visible = true;
                    txtValue.Text = cboValue.SelectedValue;
                    txtValue.Width = cboValue.Width;
                }
                else
                {
                    DropDownList cboValue = (DropDownList)(row.Cells[3].FindControl("cboValue"));
                    cboValue.Visible = true;

                    TextBox txtValue = ((TextBox)(row.Cells[3].FindControl("txtValue")));
                    txtValue.Visible = false;
                }
            }
        }
    }
}