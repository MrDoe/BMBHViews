﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace BMBH_View
{
    public partial class UserMan : System.Web.UI.Page
    {
        static string prevPage = String.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["LastRole"] != null)
                    cboRole.SelectedValue = (string)Session["LastRole"];
            }
        }

        private void SQLexecute_async(string sSQL)
        {
            // Given command text and connection string, asynchronously execute
            // the specified command against the connection. For this example,
            // the code displays an indicator as it is working, verifying the 
            // asynchronous behavior. 
            string sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(sConnString))
            {
                try
                {
                    //int count = 0;
                    SqlCommand command = new SqlCommand(sSQL, connection);
                    command.CommandTimeout = 300;
                    connection.Open();

                    IAsyncResult result = command.BeginExecuteNonQuery();
                    while (!result.IsCompleted)
                    {
                        //Console.WriteLine("Waiting ({0})", count++);
                        // Wait for 1/10 second, so the counter
                        // does not consume all available resources 
                        // on the main thread.
                        System.Threading.Thread.Sleep(100);
                    }
                    //Console.WriteLine("Command complete. Affected {0} rows.",
                    command.EndExecuteNonQuery(result);
                }
                catch (SqlException ex)
                {
                    ShowMsg(ex.Message);
                }
                catch (InvalidOperationException ex)
                {
                    ShowMsg(ex.Message);
                }
                catch (Exception ex)
                {
                    // You might want to pass these errors
                    // back out to the caller.
                    ShowMsg(ex.Message);
                }
            }
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

        protected void chkPermission_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chk.NamingContainer;
            var sViewName = row.Cells[0].Text;
            string sSQL;

            if (chk.Checked)
            {
                //sSQL = "EXEC AddSearchForm @View='" + sViewName + "'";
                //try { SQLexecute(sSQL); } catch (Exception ex) { }
                
                sSQL = "EXEC SetRolePermission " + cboRole.SelectedValue + ",'" + sViewName + "'";
                try { SQLexecute(sSQL); } catch (Exception ex) { ShowMsg(ex.ToString());  }
            }
            else
            {
                sSQL = "EXEC UnsetRolePermission " + cboRole.SelectedValue + ",'" + sViewName + "'";
                try { SQLexecute(sSQL); } catch (Exception ex) { }
            }
        }

        protected void btnShowView_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Session["View"] = row.Cells[0].Text;
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Search.aspx");
        }

        protected void btnClearTemp_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string sView = row.Cells[0].Text;
            string sRoleId = cboRole.SelectedValue;
            SQLexecute("EXEC RecreateSearchTable '" + sView + "'," + sRoleId);
            //ShowMsg("Die Suchtabelle wurde neu erstellt!");
        }

        protected void btnValueCnt_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string sView = row.Cells[0].Text;
            string sUser = cboRole.SelectedValue;
            SQLexecute("EXEC UPDATE_VALCOUNT '" + sView + "'");
            ShowMsg("Die Werte wurden neu berechnet!");
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            string sCaption = ((TextBox)row.FindControl("txtCaption")).Text;
            string sView = row.Cells[0].Text;
            SQLexecute("update VIEW_SETTINGS set VIEW_CAPTION='" + sCaption + "' where VIEW_NAME = '" + sView + "'");
        }

        protected void cboPanel_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((DropDownList)sender).NamingContainer;
            string sPanel = ((DropDownList)row.FindControl("cboPanel")).SelectedValue;
            string sView = row.Cells[0].Text;
            SQLexecute("update VIEW_SETTINGS set PANEL_NAME='" + sPanel + "' where VIEW_NAME = '" + sView + "'");
        }

        protected void btnUpdateViews_Click(object sender, EventArgs e)
        {
            string sRoleId = cboRole.SelectedValue;
            Session["LastRole"] = sRoleId;
            SQLexecute("EXEC UpdateRoleViews " + sRoleId);
            Server.Transfer("RoleMgr.aspx");
        }
    }
}