using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.WebControls;

namespace BMBHviews
{
    public partial class Panels : System.Web.UI.Page
    {
        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["__EVENTARGUMENT"] == "PostFromNew_Send") // add new panel
            {
                SQLexecute("insert into PANELS (PanelID) values ('" + txtPanelId.Text.Trim() + "')");
                Response.Redirect("Panels.aspx");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
        }

        private static void SQLexecute(string sSQL)
        {
            string sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            SqlCommand cmd = new SqlCommand
            {
                CommandType = CommandType.Text,
                CommandText = sSQL,
                Connection = con,
                CommandTimeout = 900
            };

            try
            {
                con.Open();
                _ = cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }

        protected void dgdPanels_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            if (e == null)
            {
                throw new ArgumentNullException(nameof(e));
            }

            Label lblBackColor = (Label)e.Row.FindControl("lblBackColor");
            Label lblTextColor = (Label)e.Row.FindControl("lblTextColor");
            Label lblBorderColor = (Label)e.Row.FindControl("lblBorderColor");

            if (lblBackColor != null)
            {
                lblBackColor.BackColor = ColorTranslator.FromHtml(lblBackColor.Text);
                e.Row.Cells[4].BackColor = ColorTranslator.FromHtml(lblBackColor.Text);
            }
            if (lblTextColor != null)
            {
                lblTextColor.ForeColor = ColorTranslator.FromHtml(lblTextColor.Text);
                e.Row.Cells[5].ForeColor = ColorTranslator.FromHtml(lblTextColor.Text);
                lblTextColor.BackColor = ColorTranslator.FromHtml(lblBackColor.Text);
                e.Row.Cells[5].BackColor = ColorTranslator.FromHtml(lblBackColor.Text);
            }
            if (lblBorderColor != null)
            {
                lblBorderColor.BackColor = ColorTranslator.FromHtml(lblBorderColor.Text);
                e.Row.Cells[6].BackColor = ColorTranslator.FromHtml(lblBorderColor.Text);
            }
        }
    }
}