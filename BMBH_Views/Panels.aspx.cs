using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BMBH_View
{
    public partial class Panels : System.Web.UI.Page
    {
        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Request["__EVENTARGUMENT"] == "PostFromNew_Send") // add new panel
            {
                SQLexecute("insert into PANELS (PanelID) values ('" + txtPanelId.Text.Trim() + "')");
                Response.Redirect("Panels.aspx");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
        }

        private void SQLexecute(string sSQL)
        {
            String sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = sSQL;
            cmd.Connection = con;
            cmd.CommandTimeout = 900;

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

        protected void dgdPanels_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            Label lblBackColor = (Label)e.Row.FindControl("lblBackColor");
            Label lblTextColor = (Label)e.Row.FindControl("lblTextColor");
            Label lblBorderColor = (Label)e.Row.FindControl("lblBorderColor");

            if (lblBackColor != null)
            {
                lblBackColor.BackColor = System.Drawing.ColorTranslator.FromHtml(lblBackColor.Text);
                e.Row.Cells[4].BackColor = System.Drawing.ColorTranslator.FromHtml(lblBackColor.Text);
            }
            if (lblTextColor != null)
            {
                lblTextColor.ForeColor = System.Drawing.ColorTranslator.FromHtml(lblTextColor.Text);
                e.Row.Cells[5].ForeColor = System.Drawing.ColorTranslator.FromHtml(lblTextColor.Text);
                lblTextColor.BackColor = System.Drawing.ColorTranslator.FromHtml(lblBackColor.Text);
                e.Row.Cells[5].BackColor = System.Drawing.ColorTranslator.FromHtml(lblBackColor.Text);
            }
            if (lblBorderColor != null)
            {
                lblBorderColor.BackColor = System.Drawing.ColorTranslator.FromHtml(lblBorderColor.Text);
                e.Row.Cells[6].BackColor = System.Drawing.ColorTranslator.FromHtml(lblBorderColor.Text);
            }
        }
    }
}