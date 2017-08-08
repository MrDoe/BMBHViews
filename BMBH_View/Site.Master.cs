using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BMBH_View
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["UserName"] = Page.User.Identity.Name;

            if (((String)Session["UserName"]).ToUpper() == "KHD\\DOELLINGERCHRISTOPH" ||
                ((String)Session["UserName"]).ToUpper() == "KHD\\WIELANDMATHIAS")
                lnkUserMan.Visible = true;
            else
                lnkUserMan.Visible = false;
        }
    }
}