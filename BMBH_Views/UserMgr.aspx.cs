﻿using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace BMBHviews
{
    public partial class UserManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsAdmin"] != null && (bool)Session["IsAdmin"] == false) // no admin, go back to previous page
            {
                Response.Redirect(Request.UrlReferrer.ToString());
            }

            if (Request["__EVENTARGUMENT"] != null)
            {
                if (Request["__EVENTARGUMENT"] == "PostFromNew_Send") // add new user
                {
                    string sUsername = txtUserName.Text.Trim();
                    SQLexecute("EXEC AddNewUser '" + sUsername + "'");
                    string eMail = (Master as SiteMaster).GetEmailFromUser(sUsername);
                    SiteMaster.SendEmail(eMail, "Sehr geehrter Nutzer,\n\nIhr Benutzerkonto wurde für das Datawarehouse BMBH_Views freigeschaltet.\nSie können sich im Klinikumsnetz unter https://bmbh02.ads.krz.uni-heidelberg.de/views mit Ihrem Windows-Benutzernamen und Passwort anmelden.\n\nMit freundlichen Grüßen\n\nIhr BMBH-IT Team", "BMBH_Views Account-Freischaltung");

                    Response.Redirect("UserMgr.aspx");
                }
                if (Request["__EVENTTARGET"] != null && Request["__EVENTTARGET"] == updUsers.ClientID)
                {
                    string value = Request["__EVENTARGUMENT"];

                    SqlDataSource1.SelectCommand = value.Length > 0 ? "SELECT * FROM [UserRoles] where UserId LIKE '%" + value + "%'" : "SELECT * FROM [UserRoles]";

                    dgdUsers.DataBind();
                }
            }
        }

        protected void btnRoleMgr_Click(object sender, EventArgs e)
        {
            Response.Redirect("RoleMgr.aspx");
        }

        private static void SQLexecute(string sSQL)
        {
            string sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            SqlCommand cmd = new SqlCommand
            {
                CommandType = CommandType.Text,
                CommandText = sSQL,
                Connection = con,
                CommandTimeout = 900
            };

            con.Open();

            try
            {
                _ = cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                if (con != null)
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }

        protected void cboRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            DropDownList cboRole = (DropDownList)sender;
            GridViewRow row = (GridViewRow)cboRole.NamingContainer;
            string sUserName = row.Cells[0].Text;
            string nRoleId = cboRole.SelectedValue;
            string sSQL;
            sSQL = "EXEC SetUserRole '" + sUserName + "','" + nRoleId.ToString() + "'";
            try { SQLexecute(sSQL); } catch (Exception) { }
        }

        protected void btnChangeToUser_Click(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Session["UserName"] = row.Cells[0].Text;
            Response.Redirect("~/");
        }

        protected void chkPatientSearch_CheckedChanged(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            CheckBox chk = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chk.NamingContainer;
            string sUserName = row.Cells[0].Text;
            string sSQL;
            if (chk.Checked)
            {
                sSQL = "EXEC GrantPatientSearch '" + sUserName + "'";
                try { SQLexecute(sSQL); } catch (Exception) { }
            }
            else
            {
                sSQL = "EXEC DenyPatientSearch '" + sUserName + "'";
                try { SQLexecute(sSQL); } catch (Exception) { }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
        }

        protected void btnDeleteUser_Click(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string sUserName = row.Cells[0].Text;
            try
            {
                SQLexecute("EXEC DeleteUser '" + sUserName + "'");
            }
            catch (Exception) { }

            Response.Redirect("UserMgr.aspx");
        }
    }
}