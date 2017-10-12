﻿using System;
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
            string sRealUserName = Page.User.Identity.Name;

            if (Session["UserName"] == null)
                Session["UserName"] = sRealUserName;
            
            lblUserName.Text = (String)Session["UserName"];
            
            if (sRealUserName.ToUpper() == "KHD\\DOELLINGERCHRISTOPH" ||
                sRealUserName.ToUpper() == "KHD\\WIELANDMATHIAS")
                Session["IsAdmin"] = true;
            else
                Session["IsAdmin"] = false;
            
            if((Boolean)Session["IsAdmin"] == true)
                lnkUserMan.Visible = true;
            else
                lnkUserMan.Visible = false;
        }
    }
}