using System;
using System.Web.UI;

namespace BMBHviews
{
    public partial class ViewFile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            OpenFile_((string)Session["FilePath"]);
        }
        private void ShowMsg(string message)
        {
            string sPath = Request.ApplicationPath;

            if (sPath[sPath.Length - 1] != '/') // append '/' if missing
            {
                sPath += "/";
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "redirect",
            "alert('" + message + "'); window.location='" +
            sPath + "';", true);
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