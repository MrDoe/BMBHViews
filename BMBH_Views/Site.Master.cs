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
            if(Session["UserName"] != null && Page.FindControl("lblUserName") != null)
                lblUserName.Text = (String)Session["UserName"];

            if ((Boolean)Session["IsAdmin"] == true)
                lnkUserMan.Visible = true;
            else
                lnkUserMan.Visible = false;
        }
    }
}