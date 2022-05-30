using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BMBHviews
{
    internal static class Utils
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
        private static string[][] StringArray3(DataSet ds)
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
        private static string[][] StringArray10(DataSet ds)
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

        public string[][] GetUserPermissions()
        {
            string sUser = (string)Session["UserName"];
            DataSet ds = new DataSet("Permissions");

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetPermittedViews", con)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@User", sUser);
                SqlDataAdapter da = new SqlDataAdapter
                {
                    SelectCommand = cmd
                };
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    return StringArray3(ds);
                }
                else
                {
                    return null;
                }
            }
        }

        public string[][] GetDocPermissions()
        {
            string sUser = (string)Session["UserName"];
            DataSet ds = new DataSet("Permissions");

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetPermittedDocs", con)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@User", sUser);
                SqlDataAdapter da = new SqlDataAdapter
                {
                    SelectCommand = cmd
                };
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    return StringArray3(ds);
                }
                else
                {
                    return null;
                }
            }
        }

        public static string[][] GetPanels()
        {
            DataSet ds = new DataSet("Panels");

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetPanels", con)
                {
                    CommandType = CommandType.StoredProcedure
                };
                SqlDataAdapter da = new SqlDataAdapter
                {
                    SelectCommand = cmd
                };
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    return StringArray10(ds);
                }
                else
                {
                    return null;
                }
            }
        }

        protected Panel GeneratePanel(string sPanelId, string[][] aProperties)
        {
            if (aProperties == null)
            {
                throw new ArgumentNullException(nameof(aProperties));
            }

            for (int i = 0; i < aProperties.Length; ++i)
            {
                if (sPanelId == aProperties[i][0])
                {
                    Panel pnl = new Panel
                    {
                        ID = sPanelId,

                        // set color, size and style
                        BackColor = ColorTranslator.FromHtml(aProperties[i][3]),
                        ForeColor = ColorTranslator.FromHtml(aProperties[i][4]),
                        BorderColor = ColorTranslator.FromHtml(aProperties[i][5]),
                        Height = Convert.ToInt32(aProperties[i][6]),
                        Width = Convert.ToInt32(aProperties[i][7]),
                        BorderWidth = 3,
                        CssClass = "inlineBlock"
                    };

                    // add heading
                    Label lblHeading = new Label
                    {
                        Text = "<h3>" + aProperties[i][1] + "</h3>"
                    };
                    pnl.Controls.Add(lblHeading);

                    // add tab container
                    AjaxControlToolkit.TabContainer tcPnl = new AjaxControlToolkit.TabContainer();

                    // add first page (views panel)
                    Panel pnlViews = new Panel
                    {
                        ID = sPanelId + "_views"
                    };

                    // add subheading
                    Label lblSubHeading = new Label
                    {
                        Text = "<p>" + aProperties[i][2] + "</p>",
                        ID = sPanelId + "_sub"
                    };
                    pnlViews.Controls.Add(lblSubHeading);

                    // create views tab page
                    AjaxControlToolkit.TabPanel tpViews = new AjaxControlToolkit.TabPanel
                    {
                        HeaderText = "Views",
                        ForeColor = Color.Black
                    };

                    // create empty documents tab page
                    AjaxControlToolkit.TabPanel tpDocs = new AjaxControlToolkit.TabPanel
                    {
                        HeaderText = "Dokumente"
                    };
                    Panel pnlDocuments = new Panel
                    {
                        ID = sPanelId + "_docs"
                    };

                    // add subheading for documents (fixed)
                    Label lblDocSubHeading = new Label
                    {
                        Text = "<p>Dokumente:</p>",
                        ID = sPanelId + "_docsub"
                    };
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
                        Button btn = new Button
                        {
                            ID = "btn_" + aProperties[i][0],
                            BackColor = ColorTranslator.FromHtml("#EDFDFE"),
                            CssClass = "btn btn-default",
                            Height = 34,
                            Width = 170,
                            Text = "Patientensuche »"
                        };
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
            if (pnl == null)
            {
                throw new ArgumentNullException(nameof(pnl));
            }

            Button btnNew = new Button();
            pnl.Visible = true;

            btnNew.ControlStyle.CssClass = "btn btn-default";
            btnNew.Click += new EventHandler(btnGeneric_Click);

            if (!bIsDocButton)
            {
                if (pnl.Parent.GetType().Equals(typeof(Panel))) // button in nested panel -> show parent panel
                {
                    pnl.Parent.Visible = true;
                }

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
            {
                btnNew.Width = 170;
            }

            pnl.Controls.Add(btnNew);
        }

        protected void GenerateControls(string[][] aViewPerm, string[][] aDocPerm, string[][] aPanels)
        {
            if (aViewPerm != null) // generate main panel and tabs
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

        private static void SQLexecute(string sSQL)
        {
            string sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            SqlCommand cmd = new SqlCommand
            {
                CommandType = CommandType.Text,
                CommandText = sSQL,
                Connection = con
            };

            // open connection
            con.Open();

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                con.Close();

                if (con != null)
                {
                    con.Dispose();
                }
            }
        }

        private string SQLexecute_SingleResult(string sSQL)
        {
            try
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
            catch(Exception ex)
            {
                ShowMsg("SQL-Fehler: " + ex.Message);
                return "";
            }
        }

        //private void ShowMsg(string message)
        //{
        //    message = "alert('" + message + "')";
        //    ScriptManager.RegisterClientScriptBlock((Page as Control), GetType(), "alert", message, true);
        //}

        private void SetUser()
        {
            string sRealUserName = Context.User.Identity.Name.ToString();

            if (Session["UserName"] == null)
                Session["UserName"] = sRealUserName;

            // get user role
            string sRoleId = SQLexecute_SingleResult($"select RoleId from UserRoles where UserId = '{sRealUserName}'");

            // set login date
            SQLexecute("update UserRoles set LastLogin = CONVERT(datetime, '" + DateTime.Now.ToString() + "', 104) where UserId = '" + sRealUserName + "'");
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

            string[][] aUserPerm = GetUserPermissions();
            string[][] aPanels = GetPanels();
            string[][] aDocPerm = GetDocPermissions();
            GenerateControls(aUserPerm, aDocPerm, aPanels);
        }

        protected void btnGeneric_Click(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

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
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            if (((Button)sender).ID == "btn_pnlTBB")
            {
                Session["OE"] = "NCT-Gewebebank";
            }
            else if (((Button)sender).ID == "btn_pnlPraevOnk")
            {
                Session["OE"] = "Präv. Onkologie";
            }
            else if (((Button)sender).ID == "btn_pnlLiquid")
            {
                Session["OE"] = "Präv. Onkologie";
            }
            else if (((Button)sender).ID == "btn_pnlPanco")
            {
                Session["OE"] = "PancoBank-EPZ";
            }
            else if (((Button)sender).ID == "btn_pnlMedV")
            {
                Session["OE"] = "Med. Klinik V";
            }
            else if (((Button)sender).ID == "btn_pnlGyn")
            {
                Session["OE"] = "Frauenklinik";
            }
            else if (((Button)sender).ID == "btn_pnlKinder")
            {
                Session["OE"] = "Kinderklinik";
            }
            else
            {
                return;
            }

            Response.Redirect("MultipleSearch.aspx");
        }
    }
}