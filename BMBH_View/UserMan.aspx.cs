using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace BMBH_View
{
    public partial class UserMan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        private void SQLexecute(string sSQL)
        {
            String sConnString = ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = sSQL;
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

        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        protected void chkPermission_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chk.NamingContainer;
            var sViewName = row.Cells[0].Text;
            string sSQL;

            if (chk.Checked)
            {
                sSQL = "EXEC AddSearchForm @View='" + sViewName + "'";
                try { SQLexecute(sSQL); } catch (Exception ex) { }
                
                sSQL = "EXEC SetPermission @User='" + cboUser.SelectedValue + "',@View='" + sViewName + "'";
                try { SQLexecute(sSQL); } catch (Exception ex) { }
            }
            else
            {
                sSQL = "EXEC UnsetPermission @User='" + cboUser.SelectedValue + "',@View='" + sViewName + "'";
                try { SQLexecute(sSQL); } catch (Exception ex) { }
            }
        }

        protected void btnShowView_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Session["View"] = row.Cells[0].Text;
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Search.aspx");
        }

        protected void btnClearTemp_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string sView = row.Cells[0].Text;
            string sUser = cboUser.SelectedValue;
            SQLexecute("TRUNCATE TABLE [" + sView + "_Search]");
            SQLexecute("EXEC RecreateSearchTable '" + sUser + "','" + sView + "'");
            ShowMsg("Die Temp-Tabelle wurde neu erstellt!");
        }
    }
}