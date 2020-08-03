﻿using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BMBHviews
{
    public partial class ViewDocument : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["DocRoleId"] = "1";
        }

        //private void ShowMsg(string message)
        //{
        //    Response.Write("<script>alert(\"" + message + "\");</script>");
        //}

        private static void SQLexecute(string sSQL)
        {
            string sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            SqlCommand cmd = new SqlCommand
            {
                CommandType = CommandType.Text,
                CommandText = sSQL,
                Connection = con
            };
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
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

        protected void AjaxFileUpload1_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            if (e == null)
            {
                throw new ArgumentNullException(nameof(e));
            }

            string sFileName = e.FileName.ToString();
            string sServerPath = Server.MapPath("~/Documents/") + sFileName;
            string sFilePath = "~/Documents/" + sFileName;
            AjaxFileUpload1.SaveAs(sServerPath);
            string sRoleId = (string)Session["DocRoleId"];
            SQLexecute("EXEC UploadFile '" + sFilePath + "','" + sFileName + "'," + sRoleId);
        }

        protected void dgdDocs_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (e == null)
            {
                throw new ArgumentNullException(nameof(e));
            }

            TableCell cell = dgdDocs.Rows[e.RowIndex].Cells[6];
            string sPath = cell.Text;
            if (File.Exists(sPath))
            {
                File.Delete(sPath);
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
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            ImageButton btnView = (ImageButton)sender;
            GridViewRow row = (GridViewRow)btnView.NamingContainer;
            string fileName = row.Cells[6].Text;
            DownloadFile(fileName);
        }

        protected void cboRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sRoleId = cboRole.SelectedValue;
            Session["DocRoleId"] = sRoleId;
            SQLexecute("EXEC GenerateRoleDocs " + sRoleId);
        }

        protected void chkPermission_CheckedChanged(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            string sRoleId = cboRole.SelectedValue;
            CheckBox chkPermission = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkPermission.NamingContainer;
            string sDocId = row.Cells[2].Text;
            string sPermission = chkPermission.Checked ? "1" : "0";

            SQLexecute("EXEC SetDocPermission " + sRoleId + "," + sDocId + "," + sPermission);
        }

        public static string ReadPdfFile(string fileName)
        {
            string text = "";

            if (File.Exists(fileName))
            {
                PdfReader pdfReader = new PdfReader(fileName);
                FdfWriter fdfWriter = new FdfWriter();
                AcroFields pdfFormFields = pdfReader.AcroFields;
                pdfFormFields.ExportAsFdf(fdfWriter);
                Dictionary<string, object> ff = fdfWriter.GetFields();
                pdfReader.Close();

                foreach (KeyValuePair<string, object> field in ff)
                {
                    text += field.Key + "  :  " + field.Value + "\n";
                }
            }
            return text;
        }

        protected void btnPDF_Click(object sender, ImageClickEventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            ImageButton btnPDF = (ImageButton)sender;
            GridViewRow row = (GridViewRow)btnPDF.NamingContainer;
            string sFileName = row.Cells[6].Text;
            sFileName = Server.MapPath(sFileName);
            string sContent = ReadPdfFile(sFileName);
            txtResult.Text = sContent;
        }
    }
}