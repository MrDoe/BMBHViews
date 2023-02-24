using ColorCode;
using HtmlAgilityPack;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BMBHviews
{
    public partial class RoleManager : Page
    {
        public static string Base64Decode(string base64EncodedData)
        {
            byte[] base64EncodedBytes = Convert.FromBase64String(base64EncodedData);
            return Encoding.UTF8.GetString(base64EncodedBytes);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) // on first load
            {
                if(Session["RoleId"] != null)
                    cboRole.SelectedValue = (string)Session["RoleId"];
            }

            if (Request["__EVENTARGUMENT"] != null)
            {
                if (Request["__EVENTARGUMENT"] == "PostFromNew_Send") // add new role
                {
                    SQLexecute("insert into Roles (RoleName) VALUES ('" + txtRoleName.Text.Trim() + "')");
                    Response.Redirect("RoleMgr.aspx");
                }

                if (Request["__EVENTARGUMENT"] == "EditView_OK") // confirm edit view
                {
                    string sViewDefinition = Server.UrlDecode(Base64Decode(HiddenField1.Value));
                    SQLexecute(GetTextOnly(sViewDefinition));
                    //Response.Redirect("RoleMgr.aspx");
                }

                if (Request["__EVENTTARGET"] != null && Request["__EVENTTARGET"] == updViews.ClientID) // search views by filter textbox
                {
                    string value = Request["__EVENTARGUMENT"];
                    SqlDataSource2.SelectCommand = "GetPermittedViewsByRole @RoleId,'" + value + "'";
                    dgdViewPermissions.DataBind();
                }
                else // just show all views from role
                {
                    SqlDataSource2.SelectCommand = "GetPermittedViewsByRole @RoleId,''";
                }
            }
            else
            {
                SqlDataSource2.SelectCommand = "GetPermittedViewsByRole @RoleId,''";
            }
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

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
                //throw;
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
            ScriptManager.RegisterClientScriptBlock((Page as Control), GetType(), "alert", message, true);
        }

        protected void chkPermission_CheckedChanged(object sender, EventArgs e)
        {
            if (e == null)
            {
                throw new ArgumentNullException(nameof(e));
            }

            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            CheckBox chk = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chk.NamingContainer;
            string sViewName = row.Cells[0].Text;
            string sSQL;

            if (chk.Checked)
            {
                sSQL = "EXEC SetRolePermission " + cboRole.SelectedValue + ",'" + sViewName + "'";
                try { SQLexecute(sSQL); } catch (Exception ex) { ShowMsg(ex.ToString()); }
                sSQL = "EXEC SetRolePermission " + cboRole.SelectedValue + ",'" + sViewName + "'"; // hack to prevent from clicking two times
                try { SQLexecute(sSQL); } catch (Exception ex) { ShowMsg(ex.ToString()); }
            }
            else
            {
                sSQL = "EXEC UnsetRolePermission " + cboRole.SelectedValue + ",'" + sViewName + "'";
                try { SQLexecute(sSQL); } catch (Exception) { }
            }
        }

        protected void btnShowView_Click(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            Session["View"] = row.Cells[0].Text;
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Search.aspx");
        }

        protected void btnValueCnt_Click(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string sView = row.Cells[0].Text;
            SQLexecute("EXEC UPDATE_VALCOUNT '" + sView + "'");
            ShowMsg("Die Werte wurden neu berechnet!");
        }

        // OK button to confirm changes on button text and selected panel
        protected void btnOK_Click(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            string sCaption = ((TextBox)row.FindControl("txtCaption")).Text;
            string sView = row.Cells[0].Text;

            SQLexecute("EXEC AddViewToPanel '" + sView + "','" + sCaption + "'");
            SQLexecute("EXEC AddViewToPanel '" + sView + "','" + sCaption + "'"); // hack to prevent from clicking two times
            //Server.Transfer("RoleMgr.aspx");
        }

        protected void btnOK_Sorter_Click(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            string sSorter = ((TextBox)row.FindControl("txtSorter")).Text;
            string sView = row.Cells[0].Text;

            SQLexecute("UPDATE VIEW_SETTINGS SET SORTER=" + sSorter + " WHERE VIEW_NAME='" + sView + "'");
            //Server.Transfer("RoleMgr.aspx");
        }

        protected void cboPanel_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

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

        private static string SQLexecute_SingleResult(string sSQL)
        {
            string sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            using (SqlCommand command = new SqlCommand(sSQL, con))
            {
                con.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    reader.Read();
                    return reader.GetString(0);
                }
            }
        }

        protected void btnEditView_Click(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

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
        }

        protected void btnAddRole_Click(object sender, EventArgs e)
        {
        }

        // update lookup values for selected view
        protected void btnUpdateLookups_Click(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            string sView = row.Cells[0].Text;
            ScriptManager.RegisterClientScriptBlock((Page as Control), GetType(), "ShowHourglass", "document.body.style.cursor = 'wait';", true);
            SQLexecute("EXEC CreateLookups '" + sView + "'");
            ScriptManager.RegisterClientScriptBlock((Page as Control), GetType(), "HideHourglass", "document.body.style.cursor = 'default';", true);
        }

        protected void chkUseLookups_CheckedChanged(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            GridViewRow row = (GridViewRow)((CheckBox)sender).NamingContainer;
            string sView = row.Cells[0].Text;
            string sUseLookup = ((CheckBox)sender).Checked ? "1" : "0";
            SQLexecute("update VIEW_SETTINGS set USE_LOOKUPS = " + sUseLookup + " where View_Name = '" + sView + "'");
        }

        protected void btnDelView_Click(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            string sView = row.Cells[0].Text;
            SQLexecute("delete from RoleViews where ViewName='" + sView + "'");
            dgdViewPermissions.DataBind();
        }

        protected void dgdViewPermissions_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void chkUseTempTable_CheckedChanged(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            GridViewRow row = (GridViewRow)((CheckBox)sender).NamingContainer;
            string sView = row.Cells[0].Text;
            string sUseTempTable = ((CheckBox)sender).Checked ? "1" : "0";
            SQLexecute("update VIEW_SETTINGS set USE_TEMPTABLE = " + sUseTempTable + " where View_Name = '" + sView + "'");
        }
    }
}