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
        private string[][] StringArray(DataSet ds)
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
                    return StringArray(ds);
                else
                    return null;
            }
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
            if(btnNew.Text.Length < 25)
                btnNew.Width = 170;
            pnl.Controls.Add(btnNew);
        }

        protected void GenerateButtons(String[][] aUserPerm)
        {
            for (int i = 0; i < aUserPerm.Length; ++i)
            {
                if (aUserPerm[i][2].Length > 0)
                {
                    Panel pnl = (Panel)Utils.FindAnyControl(Page, aUserPerm[i][2]);
   
                    if(pnl != null)
                        GenerateButton(aUserPerm[i][0], aUserPerm[i][1], pnl);
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

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["LastQuery"] = null;
            Session["ShowListDialog"] = null;
            Session["DateCols"] = null;
            Session["DateTimeCols"] = null;
            Session["QuitFromList"] = false;

            if (Session["GUID"] != null)
            {
                SQLexecute("delete from V_Recursive_Temp where GUID='" + Session["GUID"] + "'");
                SQLexecute("delete from V_Recursive_Log where GUID='" + Session["GUID"] + "'");
            }

            Session["GUID"] = null;

            Session["Recursive"] = null;

            if (Session["UserName"] == null)
                Session["UserName"] = Page.User.Identity.Name;

            String[][] aUserPerm = GetUserPermissions();
            GenerateButtons(aUserPerm);
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
    }
}