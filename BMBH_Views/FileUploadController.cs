using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace BMBH_View
{
    public class FileUploadController : ApiController
    {

        List<UploadedFile> files = new List<UploadedFile>();
        private int fileCounter = 0;

        //// GET api/<controller>
        //public IEnumerable<string> Get()
        //{
        //    return new string[] { "value1", "value2" };
        //}

        // GET api/<controller>/5
        public string Get(int id)
        {
            HttpResponseMessage result = null;
            HttpRequest httpRequest = HttpContext.Current.Request;

            if (httpRequest.Files.Count > 0)
            {
                List<string> docfiles = new List<string>();
                foreach (string file in httpRequest.Files)
                {
                    var postedFile = httpRequest.Files[file];
                    string sFilePath = HttpContext.Current.Server.MapPath("~/Documents/" + postedFile.FileName);
                    postedFile.SaveAs(sFilePath);
                    ++fileCounter;
                    docfiles.Add("ID: " + fileCounter + ", Path = " + sFilePath);
                    AddFileToDB(postedFile.FileName, "~/Documents/" + postedFile.FileName, "1");
                }
                result = Request.CreateResponse(HttpStatusCode.Created, docfiles);
            }
            else
            {
                result = Request.CreateResponse(HttpStatusCode.BadRequest);
            }

            if (fileCounter < id)
               return "ID " + id.ToString() + " ungültig! Filecounter: " + fileCounter.ToString();
            else
               return "ID: " + files[id-1].nID.ToString() + ", Path = " + files[id-1].sFilePath;
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

        private void AddFileToDB(string sFileName, string sFilePath, string sRoleId)
        {
            SQLexecute("EXEC UploadFile '" + sFilePath + "','" + sFileName + "'," + sRoleId);
        }

        //// POST api/<controller>
        public HttpResponseMessage Post()
        {
            HttpResponseMessage result = null;
            HttpRequest httpRequest = HttpContext.Current.Request;

            if (httpRequest.Files.Count > 0)
            {
                List<string> docfiles = new List<string>();
                foreach (string file in httpRequest.Files)
                {
                    var postedFile = httpRequest.Files[file];
                    string sFilePath = HttpContext.Current.Server.MapPath("~/Documents/" + postedFile.FileName);
                    postedFile.SaveAs(sFilePath);
                    ++fileCounter;
                    docfiles.Add("ID: " + fileCounter + ", Path = " + sFilePath);
                    AddFileToDB(postedFile.FileName, "~/Documents/" + postedFile.FileName, "1");
                }
                result = Request.CreateResponse(HttpStatusCode.Created, docfiles);
            }
            else
            {
                result = Request.CreateResponse(HttpStatusCode.BadRequest);
            }
            return result;
        }

        //// PUT api/<controller>/5
        //public void Put(int id, [FromBody]string value)
        //{
        //}

        //// DELETE api/<controller>/5
        //public void Delete(int id)
        //{
        //}
    }
}