using System.Collections.Generic;
using System.Web;
using System.Web.Http;

namespace BMBHviews
{
    public class PDFController : ApiController
    {
        // GET api/<controller>
        [AllowAnonymous]
        public static IEnumerable<string> Get()
        {
            HttpRequest httpRequest = HttpContext.Current.Request;
            string sFilePath = HttpContext.Current.Server.MapPath("~/Documents/test.log");
            httpRequest.SaveAs(sFilePath, false);
            return new string[] { "saved", "file" };
        }

        // GET api/<controller>/5
        public static string Get(int id)
        {
            //return "value";
            return "Saved.";
        }

        // POST api/<controller>
        public static void Post([FromBody]string value)
        {
            HttpRequest httpRequest = HttpContext.Current.Request;
            string sFilePath = HttpContext.Current.Server.MapPath("~/Documents/test.log");
            httpRequest.SaveAs(sFilePath, false);
        }

        // PUT api/<controller>/5
        public static void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public static void Delete(int id)
        {
        }
    }
}