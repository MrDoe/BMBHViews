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
    public partial class Documents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["DocRoleId"] = "1";
        }

        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        private void SQLexecute(string sSQL)
        {
            String sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
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

        protected void AjaxFileUpload1_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            string sFileName = e.FileName.ToString();
            string sServerPath = Server.MapPath("~/Documents/") + sFileName;
            string sFilePath = "~/Documents/" + sFileName;
            AjaxFileUpload1.SaveAs(sServerPath);
            string sRoleId = (string)Session["DocRoleId"];
            SQLexecute("EXEC UploadFile '" + sFilePath + "','" + sFileName + "'," + sRoleId);
        }

        protected void dgdDocs_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            TableCell cell = dgdDocs.Rows[e.RowIndex].Cells[6];
            string sPath = cell.Text;
            if (System.IO.File.Exists(sPath))
            {
                System.IO.File.Delete(sPath);
            }
        }
        protected void ReloadGrid(object sender, EventArgs e)
        {
            // Reload your grid
            dgdDocs.DataBind();
        }

        public void DownloadFile(string fileName)
        {
            Response.Clear();
            System.IO.FileInfo file = new System.IO.FileInfo(Server.MapPath(fileName));
            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
            Response.AddHeader("Content-Length", file.Length.ToString());
            Response.ContentType = "application/octet-stream";
            Response.WriteFile(file.FullName);
            Response.Flush();
        }

        protected void btnView_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton btnView = (ImageButton)sender;
            GridViewRow row = (GridViewRow)btnView.NamingContainer;
            string fileName = row.Cells[6].Text;
            DownloadFile(fileName);
        }

        protected void cboRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sRoleId = (string)cboRole.SelectedValue;
            Session["DocRoleId"] = sRoleId;
            SQLexecute("EXEC GenerateRoleDocs " + sRoleId);
        }

        protected void chkPermission_CheckedChanged(object sender, EventArgs e)
        {
            string sRoleId = (string)cboRole.SelectedValue;
            CheckBox chkPermission = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkPermission.NamingContainer;
            string sDocId = row.Cells[2].Text;
            string sPermission = chkPermission.Checked ? "1" : "0";

            SQLexecute("EXEC SetDocPermission " + sRoleId + "," + sDocId + "," + sPermission);
        }
    }
}