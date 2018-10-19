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
using RestSharp;

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

        // Show dataset contents (for debugging reasons)
        private void ShowDataSet(DataSet ds)
        {
            StringWriter sw = new StringWriter();
            ds.WriteXml(sw);
            ShowMsg("DataSet: " + sw.ToString());
        }

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

        protected Panel GeneratePanel(string sPanelId, String[][] aPanels)
        {
            for (int i = 0; i < aPanels.Length; ++i)
            {
                if(sPanelId == aPanels[i][0])
                {
                    Panel pnl = new Panel();
                    pnl.ID = sPanelId;
                    pnl.BackColor = System.Drawing.ColorTranslator.FromHtml(aPanels[i][3]);
                    pnl.ForeColor = System.Drawing.ColorTranslator.FromHtml(aPanels[i][4]);
                    pnl.BorderColor = System.Drawing.ColorTranslator.FromHtml(aPanels[i][5]);
                    pnl.Height = Convert.ToInt32(aPanels[i][6]);
                    pnl.Width = Convert.ToInt32(aPanels[i][7]);
                    pnl.BorderWidth = 3;
                    pnl.CssClass = "inlineBlock";
                    Label lblHeading = new Label();
                    Label lblSubHeading = new Label();
                    lblHeading.Text = "<h2>" + aPanels[i][1] + "</h2>";
                    pnl.Controls.Add(lblHeading);
                    lblSubHeading.Text = "<p>" + aPanels[i][2] + "</p>";
                    pnl.Controls.Add(lblSubHeading);

                    if (aPanels[i][9] == "True") // show patient search button
                    {
                        Button btn = new Button();
                        btn.ID = "btn_" + aPanels[i][0];
                        btn.BackColor = System.Drawing.ColorTranslator.FromHtml("#EDFDFE");
                        btn.CssClass = "btn btn-default";
                        btn.Height = 34;
                        btn.Width = 170;
                        btn.Text = "Patientensuche »";
                        btn.Click += new EventHandler(btnPatientSearch_Click);
                        pnl.Controls.Add(btn);
                    }

                    pnlContainer.Controls.Add(pnl);
                    return pnl;
                }
            }
            return null;
        }

        protected void GenerateButton(string sView, string sCaption, Panel pnl)
        {
            pnl.Visible = true;
            if (pnl.Parent.GetType().Equals(typeof(Panel)))
                pnl.Parent.Visible = true;

            Button btnNew = new Button();
            btnNew.ID = "btn" + sView;
            btnNew.Text = sCaption + " » ";
            btnNew.ControlStyle.CssClass = "btn btn-default";
            btnNew.ToolTip = sView;
            btnNew.Click += new EventHandler(btnGeneric_Click);
            if (btnNew.Text.Length < 25)
                btnNew.Width = 170;
            pnl.Controls.Add(btnNew);
        }

        protected void GenerateControls(String[][] aUserPerm, String[][] aPanels)
        {
            if (aUserPerm.Length > 0)
            {
                for (int i = 0; i < aUserPerm.Length; ++i)
                {
                    if (aUserPerm[i][2].Length > 0)
                    {
                        Panel pnl = (Panel)Utils.FindAnyControl(Page, aUserPerm[i][2]);
                        if(pnl == null)
                            pnl = GeneratePanel(aUserPerm[i][2], aPanels);
                        if (pnl != null)
                        {
                            GenerateButton(aUserPerm[i][0], aUserPerm[i][1], pnl);
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
            string sRealUserName = Page.User.Identity.Name;
            //string sRealUserName = "KHD\\doellingerchristoph";

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
            GenerateControls(aUserPerm, aPanels);
        }

        protected void btnDZIFupload_Click(object sender, EventArgs e)
        {
        }

        protected void btnGeneric_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            Session["View"] = btn.ToolTip;
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Search.aspx");
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