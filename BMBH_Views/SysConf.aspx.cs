using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BMBH_View
{
    public partial class SysConf : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        protected void btnSendEmail_Click(object sender, EventArgs e)
        {
            //string eMail = (this.Master as SiteMaster).GetEmailFromUser("doellingerchristoph");
            string eMail = UserPrincipal.Current.EmailAddress;
            (this.Master as SiteMaster).SendEmail(eMail, "Dies ist ein Test.", "Test-E-Mail");
        }
    }
}