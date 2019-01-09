using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using ColorCode;
using System.Text.RegularExpressions;
using HtmlAgilityPack;
using System.Text;

namespace BMBH_View
{
    public partial class UserMan : System.Web.UI.Page
    {
        static string prevPage = String.Empty;

        public static string Base64Decode(string base64EncodedData)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) // on first load
            {
                cboRole.SelectedValue = (string)Session["RoleId"];
            }

            if (this.Request["__EVENTARGUMENT"] == "PostFromNew_Send") // add new user
            {
                SQLexecute("insert into Roles (RoleName) VALUES ('" + txtRoleName.Text.Trim() + "')");
                Response.Redirect("RoleMgr.aspx");
            }

            if (this.Request["__EVENTARGUMENT"] == "EditView_OK") // confirm edit view
            {
                string sViewDefinition = Server.UrlDecode(Base64Decode(HiddenField1.Value));
                SQLexecute(GetTextOnly(sViewDefinition));
                //Response.Redirect("RoleMgr.aspx");
            }

            if (this.Request["__EVENTTARGET"] == updViews.ClientID) // search views
            {
                string value = this.Request["__EVENTARGUMENT"];
                if (value.Length > 0) // TODO: move to stored procedure
                    SqlDataSource2.SelectCommand = "select r.ViewName, Permission, s.VIEW_CAPTION, s.PANEL_NAME, s.USE_LOOKUPS from RoleViews r LEFT JOIN VIEW_SETTINGS s on s.VIEW_NAME = r.ViewName where r.RoleId = @RoleId and r.ViewName LIKE '%" + value + "%'";
                else
                    SqlDataSource2.SelectCommand = "EXEC GetPermittedViewsByRole @RoleId";

                dgdViewPermissions.DataBind();
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
            message = "alert('" + message + "')";
            ScriptManager.RegisterClientScriptBlock((Page as Control), this.GetType(), "alert", message, true);
        }

        protected void chkPermission_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chk.NamingContainer;
            var sViewName = row.Cells[0].Text;
            string sSQL;

            if (chk.Checked)
            {
                sSQL = "EXEC SetRolePermission " + cboRole.SelectedValue + ",'" + sViewName + "'";
                try { SQLexecute(sSQL); } catch (Exception ex) { ShowMsg(ex.ToString());  }
                sSQL = "EXEC SetRolePermission " + cboRole.SelectedValue + ",'" + sViewName + "'"; // hack to prevent from clicking two times
                try { SQLexecute(sSQL); } catch (Exception ex) { ShowMsg(ex.ToString()); }
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

        protected void btnValueCnt_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string sView = row.Cells[0].Text;
            SQLexecute("EXEC UPDATE_VALCOUNT '" + sView + "'");
            ShowMsg("Die Werte wurden neu berechnet!");
        }

        // OK button to confirm changes on button text and selected panel
        protected void btnOK_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            string sCaption = ((TextBox)row.FindControl("txtCaption")).Text;
            string sView = row.Cells[0].Text;
            
            SQLexecute("EXEC AddViewToPanel '" + sView + "','" + sCaption + "'");
            SQLexecute("EXEC AddViewToPanel '" + sView + "','" + sCaption + "'"); // hack to prevent from clicking two times
            //Server.Transfer("RoleMgr.aspx");
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

        protected void btnCancel_Click(object sender, EventArgs e)
        {
        }

        private string SQLexecute_SingleResult(string sSQL)
        {
            String sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            using (var command = new SqlCommand(sSQL, con))
            {
                con.Open();
                using (var reader = command.ExecuteReader())
                {
                    reader.Read();
                    return reader.GetString(0);
                }
            }
        }

        protected void btnEditView_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            string sView = row.Cells[0].Text;
            string sSQL = "SELECT OBJECT_DEFINITION (OBJECT_ID(N'" + sView + "'))";
            string sResult = SQLexecute_SingleResult(sSQL).Replace("\r\nCREATE", "ALTER").Replace("CREATE", "ALTER").Replace("Create", "ALTER");
            sResult = new CodeColorizer().Colorize(sResult, Languages.Sql);
            sResult = sResult.Replace("<div style=\"color:Black;background-color:White;\">", "").Replace("</div>", "");
            txtViewDefinition.InnerHtml = sResult;
      
            MPE_EditView.Show();
        }

        public static string GetTextOnly(string sHTML)
        {
            string sHTML2 = HttpUtility.HtmlDecode(sHTML);
            HtmlDocument doc = new HtmlDocument();
            doc.LoadHtml(sHTML2);
            return doc.DocumentNode.InnerText;
        }

        protected void btnConfirmEditView_Click(object sender, EventArgs e)
        {
            //HiddenField1.Value = txtViewDefinition.InnerHtml;
            //ShowMsg(txtViewDefinition.Text);
            //ShowMsg(GetTextOnly(txtViewDefinition.Text));
            //SQLexecute(GetTextOnly(txtViewDefinition.Text));
        }

        protected void btnAddRole_Click(object sender, EventArgs e)
        {
        }

        // update lookup values for selected view
        protected void btnUpdateLookups_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            string sView = row.Cells[0].Text;
            SQLexecute("EXEC CreateLookups '" + sView + "'");
        }

        protected void chkUseLookups_CheckedChanged(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((CheckBox)sender).NamingContainer;
            string sView = row.Cells[0].Text;
            string sUseLookup = ((CheckBox)sender).Checked ? "1" : "0";
            SQLexecute("update VIEW_SETTINGS set USE_LOOKUPS = " + sUseLookup + " where View_Name = '" + sView + "'");
        }
    }
}