﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BMBH_View
{
    public partial class RoleMan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Boolean)Session["IsAdmin"] == false) // no admin, go back to previous page
                Response.Redirect(Request.UrlReferrer.ToString());
        }

        protected void btnRoleMgr_Click(object sender, EventArgs e)
        {
            Response.Redirect("RoleMgr.aspx");
        }

        private void SQLexecute(string sSQL)
        {
            String sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = sSQL;
            cmd.Connection = con;
            cmd.CommandTimeout = 900;

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                //cmd.BeginExecuteNonQuery();
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

        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        protected void cboRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cboRole = (DropDownList)sender;
            GridViewRow row = (GridViewRow)cboRole.NamingContainer;
            var sUserName = row.Cells[0].Text;
            var nRoleId = cboRole.SelectedValue;
            string sSQL;
            sSQL = "EXEC SetUserRole '" + sUserName + "','" + nRoleId.ToString() + "'";
            try { SQLexecute(sSQL); } catch (Exception ex) { }
        }

        protected void btnChangeToUser_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Session["UserName"] = row.Cells[0].Text;
            Response.Redirect("Default.aspx");
        }
    }
}