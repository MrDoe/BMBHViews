using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace BMBH_View
{
    public class PDFController : ApiController
    {
        // GET api/<controller>
        [AllowAnonymous]
        public IEnumerable<string> Get()
        {
            HttpRequest httpRequest = HttpContext.Current.Request;
            string sFilePath = HttpContext.Current.Server.MapPath("~/Documents/test.log");
            httpRequest.SaveAs(sFilePath, false);
            return new string[] { "saved", "file" };
        }

        // GET api/<controller>/5
        public string Get(int id)
        {
            //return "value";
            return "Saved.";
        }

        // POST api/<controller>
        public void Post([FromBody]string value)
        {
            HttpRequest httpRequest = HttpContext.Current.Request;
            string sFilePath = HttpContext.Current.Server.MapPath("~/Documents/test.log");
            httpRequest.SaveAs(sFilePath, false);
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}