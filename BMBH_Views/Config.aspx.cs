using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BMBH_View
{
    public partial class Config : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnUserConf_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("UserMgr.aspx");
        }

        protected void btnPanelConf_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Panels.aspx");
        }

        protected void btnDiagConf_Click(object sender, ImageClickEventArgs e)
        {
            //Response.Redirect("");
        }

        protected void btnSysConf_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("SysConf.aspx");
        }

        protected void btnDocConf_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Docs.aspx");
        }
    }
}