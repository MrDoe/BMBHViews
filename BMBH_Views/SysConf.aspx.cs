using System;
using System.DirectoryServices.AccountManagement;

namespace BMBHviews
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
            SiteMaster.SendEmail(eMail, "Dies ist ein Test.", "Test-E-Mail");
        }
    }
}