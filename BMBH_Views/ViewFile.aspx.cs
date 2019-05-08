using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BMBH_View
{
    public partial class ViewFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            OpenFile_((string)Session["FilePath"]);
        }
        private void ShowMsg(string message)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect",
            "alert('" + message + "'); window.location='" +
            Request.ApplicationPath + "default.aspx';", true);
        }

        public void OpenFile_(string fileName)
        {
            System.IO.FileInfo file = new System.IO.FileInfo(Server.MapPath(fileName));

            if (!file.Exists) // file not found
            {
                ShowMsg("Fehler: Dokument \"" + fileName + "\" nicht gefunden!");
                return;
            }

            Response.AddHeader("Content-Disposition", "inline; name=" + file.Name + " filename=" + file.Name);
            string sFiletype = file.Extension.ToUpper();
            
            switch (sFiletype)
            {
                case ".PDF":
                    Response.ContentType = "application/pdf";
                    break;
                case ".DOC":
                    Response.ContentType = "application/msword";
                    break;
                case ".DOCX":
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                    break;
                case ".XLS":
                    Response.ContentType = "application/vnd.ms-excel";
                    break;
                case ".XLSX":
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.shee";
                    break;
                default:
                    Response.ContentType = "application/octet-stream";
                    break;
            }
            Response.AddHeader("Content-Length", file.Length.ToString());
            Response.WriteFile(file.FullName);
            Response.Flush();
        }
    }
}