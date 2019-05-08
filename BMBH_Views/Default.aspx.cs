using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
//using System.Net;

namespace BMBH_View
{
    static class Utils
    {
        public static Control FindAnyControl(this Page page, string controlId)
        {
            return FindControlRecursive(controlId, page.Form);
        }

        public static Control FindAnyControl(this UserControl control, string controlId)
        {
            return FindControlRecursive(controlId, control);
        }

        public static Control FindControlRecursive(string controlId, Control parent)
        {
            foreach (Control control in parent.Controls)
            {
                Control result = FindControlRecursive(controlId, control);
                if (result != null)
                {
                    return result;
                }
            }
            return parent.FindControl(controlId);
        }
    }

    public partial class _Default : Page
    {
        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        //// Show dataset contents (for debugging reasons)
        //private void ShowDataSet(DataSet ds)
        //{
        //    StringWriter sw = new StringWriter();
        //    ds.WriteXml(sw);
        //    ShowMsg("DataSet: " + sw.ToString());
        //}

        // convert dataset to 2D string array
        private string[][] StringArray3(DataSet ds)
        {
            int nRows = ds.Tables[0].Rows.Count;
            string[][] stringArray = new string[nRows][];

            for (int row = 0; row < nRows; ++row)
            {
                stringArray[row] = new string[3]
                                   { ds.Tables[0].Rows[row][0].ToString(),
                                     ds.Tables[0].Rows[row][1].ToString(),
                                     ds.Tables[0].Rows[row][2].ToString() };
            }

            return stringArray;
        }

        // convert dataset to 2D string array
        private string[][] StringArray10(DataSet ds)
        {
            int nRows = ds.Tables[0].Rows.Count;
            string[][] stringArray = new string[nRows][];

            for (int row = 0; row < nRows; ++row)
            {
                stringArray[row] = new string[10]
                                   { ds.Tables[0].Rows[row][0].ToString(),
                                     ds.Tables[0].Rows[row][1].ToString(),
                                     ds.Tables[0].Rows[row][2].ToString(),
                                     ds.Tables[0].Rows[row][3].ToString(),
                                     ds.Tables[0].Rows[row][4].ToString(),
                                     ds.Tables[0].Rows[row][5].ToString(),
                                     ds.Tables[0].Rows[row][6].ToString(),
                                     ds.Tables[0].Rows[row][7].ToString(),
                                     ds.Tables[0].Rows[row][8].ToString(),
                                     ds.Tables[0].Rows[row][9].ToString() };
            }

            return stringArray;
        }

        public String[][] GetUserPermissions()
        {
            string sUser = (string)Session["UserName"];
            DataSet ds = new DataSet("Permissions");

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetPermittedViews", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@User", sUser);
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                    return StringArray3(ds);
                else
                    return null;
            }
        }

        public String[][] GetDocPermissions()
        {
            string sUser = (string)Session["UserName"];
            DataSet ds = new DataSet("Permissions");

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetPermittedDocs", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@User", sUser);
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                    return StringArray3(ds);
                else
                    return null;
            }
        }

        public String[][] GetPanels()
        {
            DataSet ds = new DataSet("Panels");

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetPanels", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                    return StringArray10(ds);
                else
                    return null;
            }
        }

        protected Panel GeneratePanel(string sPanelId, String[][] aProperties)
        {
            for (int i = 0; i < aProperties.Length; ++i)
            {
                if(sPanelId == aProperties[i][0])
                {
                    Panel pnl = new Panel();
                    pnl.ID = sPanelId;
                    
                    // set color, size and style
                    pnl.BackColor = System.Drawing.ColorTranslator.FromHtml(aProperties[i][3]);
                    pnl.ForeColor = System.Drawing.ColorTranslator.FromHtml(aProperties[i][4]);
                    pnl.BorderColor = System.Drawing.ColorTranslator.FromHtml(aProperties[i][5]);
                    pnl.Height = Convert.ToInt32(aProperties[i][6]);
                    pnl.Width = Convert.ToInt32(aProperties[i][7]);
                    pnl.BorderWidth = 3;
                    pnl.CssClass = "inlineBlock";
                    
                    // add heading
                    Label lblHeading = new Label();
                    lblHeading.Text = "<h3>" + aProperties[i][1] + "</h3>";
                    pnl.Controls.Add(lblHeading);

                    // add tab container
                    AjaxControlToolkit.TabContainer tcPnl = new AjaxControlToolkit.TabContainer();

                    // add first page (views panel)
                    Panel pnlViews = new Panel();
                    pnlViews.ID = sPanelId + "_views";

                    // add subheading
                    Label lblSubHeading = new Label();
                    lblSubHeading.Text = "<p>" + aProperties[i][2] + "</p>";
                    lblSubHeading.ID = sPanelId + "_sub";
                    pnlViews.Controls.Add(lblSubHeading);

                    // create views tab page
                    AjaxControlToolkit.TabPanel tpViews = new AjaxControlToolkit.TabPanel();
                    tpViews.HeaderText = "Views";
                    tpViews.ForeColor = System.Drawing.Color.Black;

                    // create empty documents tab page
                    AjaxControlToolkit.TabPanel tpDocs = new AjaxControlToolkit.TabPanel();
                    tpDocs.HeaderText = "Dokumente";
                    Panel pnlDocuments = new Panel();
                    pnlDocuments.ID = sPanelId + "_docs";

                    // add subheading for documents (fixed)
                    Label lblDocSubHeading = new Label();
                    lblDocSubHeading.Text = "<p>Dokumente:</p>";
                    lblDocSubHeading.ID = sPanelId + "_docsub";
                    pnlDocuments.Controls.Add(lblDocSubHeading);

                    // add panels to tabs & tabs to tab control
                    tpDocs.Controls.Add(pnlDocuments);
                    tpViews.Controls.Add(pnlViews);
                    tcPnl.Tabs.Add(tpViews);
                    tcPnl.Tabs.Add(tpDocs);
                    tcPnl.ActiveTabIndex = 0;
                    pnl.Controls.Add(tcPnl);

                    if (aProperties[i][9] == "True") // show patient search button
                    {
                        Button btn = new Button();
                        btn.ID = "btn_" + aProperties[i][0];
                        btn.BackColor = System.Drawing.ColorTranslator.FromHtml("#EDFDFE");
                        btn.CssClass = "btn btn-default";
                        btn.Height = 34;
                        btn.Width = 170;
                        btn.Text = "Patientensuche »";
                        btn.Click += new EventHandler(btnPatientSearch_Click);
                        pnl.Controls.Add(new LiteralControl("<br />"));
                        pnl.Controls.Add(btn);
                    }
                    return pnl;
                }
            }
            return null;
        }

        protected void GenerateButton(string sView, string sCaption, Panel pnl, bool bIsDocButton)
        {
            Button btnNew = new Button();
            pnl.Visible = true;
            
            btnNew.ControlStyle.CssClass = "btn btn-default";
            btnNew.Click += new EventHandler(btnGeneric_Click);

            if (!bIsDocButton)
            {
                if (pnl.Parent.GetType().Equals(typeof(Panel))) // button in nested panel -> show parent panel
                    pnl.Parent.Visible = true;

                btnNew.ID = "btn" + sView;
                btnNew.ToolTip = "Suche in View \"" + sView + "\" starten";
                btnNew.Attributes.Add("VIEWNAME", sView);
                btnNew.Text = sCaption + " » ";
            }
            else
            {
                btnNew.ID = "btnDoc" + sView;
                btnNew.ToolTip = "Dokument \"" + sView + "\" öffnen";
                btnNew.Attributes.Add("DOCNAME", sView);
                btnNew.Attributes.Add("DOCPATH", sCaption);
                btnNew.Text = sView + " » ";
            }

            if (btnNew.Text.Length < 25)
                btnNew.Width = 170;

            pnl.Controls.Add(btnNew);
        }

        protected void GenerateControls(String[][] aViewPerm, String[][] aDocPerm, String[][] aPanels)
        {
            if (aViewPerm.Length > 0) // generate main panel and tabs
            {
                for (int i = 0; i < aViewPerm.Length; ++i)
                {
                    if (aViewPerm[i][2].Length > 0)
                    {
                        Panel pnlDept = (Panel)Utils.FindAnyControl(Page, aViewPerm[i][2]);
                        if (pnlDept == null) 
                        {
                            // create main panel for department
                            pnlDept = GeneratePanel(aViewPerm[i][2], aPanels);
                            pnlContainer.Controls.Add(pnlDept);
                        }

                        Panel pnlViews = (Panel)Utils.FindAnyControl(Page, aViewPerm[i][2] + "_views");
                        if (pnlViews != null) // populate views panel with buttons
                        {
                            GenerateButton(aViewPerm[i][0], aViewPerm[i][1], pnlViews, false);
                        }
                    }
                }
            }

            if (aDocPerm != null) // populate documents panel with buttons
            {
                for (int i = 0; i < aDocPerm.Length; ++i)
                {
                    if (aDocPerm[i][2].Length > 0)
                    {
                        Panel pnlDocs = (Panel)Utils.FindAnyControl(Page, aDocPerm[i][2] + "_docs");

                        if (pnlDocs != null)
                        {
                            GenerateButton(aDocPerm[i][1], aDocPerm[i][0], pnlDocs, true);
                        }
                    }
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
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
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

        private void SetUser()
        {
            string sRealUserName = Context.User.Identity.Name.ToString();

            if (sRealUserName == "W20005345\\christoph") // override username
                sRealUserName = "KHD\\doellingerchristoph";
            else
                sRealUserName = Page.User.Identity.Name;

            if (Session["UserName"] == null)
                Session["UserName"] = sRealUserName;
            
            // get user role
            string sRoleId = SQLexecute_SingleResult("select RoleId from UserRoles where UserId = '" + sRealUserName + "'");
            Session["RoleId"] = sRoleId;

            if (sRoleId == "1")
                Session["IsAdmin"] = true;
            else
                Session["IsAdmin"] = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["LastQuery"] = null;
            Session["ShowListDialog"] = null;
            Session["DateCols"] = null;
            Session["DateTimeCols"] = null;
            Session["init"] = null;
            Session["QuitFromList"] = false;
            Session["CurrentPage"] = 1;

            if (Session["GUID"] != null)
            {
                SQLexecute("delete from V_Recursive_Temp where GUID='" + Session["GUID"] + "'");
                SQLexecute("delete from V_Recursive_Log where GUID='" + Session["GUID"] + "'");
            }

            Session["GUID"] = null;
            Session["Recursive"] = null;

            SetUser();

            String[][] aUserPerm = GetUserPermissions();
            String[][] aPanels = GetPanels();
            String[][] aDocPerm = GetDocPermissions();
            GenerateControls(aUserPerm, aDocPerm, aPanels);
        }

        protected void btnGeneric_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            if (btn.Attributes["VIEWNAME"] != null)
            {
                Session["View"] = btn.Attributes["VIEWNAME"];
                Session["FormTable"] = Session["View"] + "_Search";
                Session["FormView"] = Session["View"] + "_SearchForm";
                Response.Redirect("Search.aspx");
            }
            if (btn.Attributes["DOCNAME"] != null)
            {
                string fileName = btn.Attributes["DOCPATH"];
                Session["FilePath"] = fileName;
                Response.Redirect("ViewFile.aspx");
            }
        }

        protected void btnDiagram_Click(object sender, EventArgs e)
        {
            Response.Redirect("DiagramView.aspx");
        }

        protected void btnPatientSearch_Click(object sender, EventArgs e)
        {
            if (((Button)sender).ID == "btn_pnlTBB")
                Session["OE"] = "NCT-Gewebebank";
            else if (((Button)sender).ID == "btn_pnlPraevOnk")
                Session["OE"] = "Präv. Onkologie";
            else if (((Button)sender).ID == "btn_pnlLiquid")
                Session["OE"] = "Präv. Onkologie";
            else if (((Button)sender).ID == "btn_pnlPanco")
                Session["OE"] = "PancoBank-EPZ";
            else if (((Button)sender).ID == "btn_pnlMedV")
                Session["OE"] = "Med. Klinik V";
            else if (((Button)sender).ID == "btn_pnlGyn")
                Session["OE"] = "Frauenklinik";
            else
                return;

            Response.Redirect("MultipleSearch.aspx");
        }
    }
}