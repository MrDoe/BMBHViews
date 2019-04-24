using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.IO;
using System.Drawing;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using AjaxControlToolkit;

namespace BMBH_View
{
    public partial class Search : System.Web.UI.Page
    {
        const string sCurrentPage = "Search.aspx";
        const string sParentPage = "Results.aspx";

        protected void SetDataSource()
        {
            dsSearch.SelectCommand = "SELECT * FROM [" + Session["FormTable"] + "] WHERE ([UserId] = '" + (String)Session["UserName"] + "') order by Sorter";
            dsSearch.UpdateCommand = "UPDATE [" + Session["FormTable"] + "] SET [Operator] = @Operator, [Wert] = @Wert, [Controltype] = @Controltype, [Logic] = @Logic WHERE [ID] = @ID";
            dsSearch.InsertCommand = "INSERT INTO [" + Session["FormTable"] + "] ([Attribut], [Operator], [Wert], [Datatype], [UserId]) VALUES (@Attribut, @Operator, @Wert, @Datatype, @UserId)";
            dsSearch.DeleteCommand = "DELETE FROM [" + Session["FormTable"] + "] WHERE [ID] = @ID";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //Session["UserName"] = Page.User.Identity.Name;
                Session["JumpedBack"] = false;
                Session["ShowListDialog"] = null;
                Session["PreviousIndex"] = null;
                Session["MainTable"] = null;

                // hashtable for brackets
                if(Session["htBracket1"] == null)
                    Session["htBracket1"] = new Hashtable();
                if (Session["htBracket2"] == null)
                    Session["htBracket2"] = new Hashtable();

                //if (Session["LastQuery"] == null)
                ClearTempTable();

                if (Session["GUID"] == null)
                {
                    Session["GUID"] = Guid.NewGuid().ToString();
                    Session["Iteration"] = 1;
                }

                Session["LastQuery"] = null;

                if((int)Session["Iteration"] > 1)
                    pnlSQLhistory.Visible = true;

                if (Session["Recursive"] != null)
                {
                    if(Session["Recursive"].ToString() == "False")
                        chkRecursive.Checked = false;

                    if (Session["Recursive"].ToString() == "True")
                    {
                        chkRecursive.Checked = true;

                        if (Session["DataCount"] != null)
                            lblRecursive.Text = "Rekursive Suche (" + Session["DataCount"] + " Datensätze)";
                    }
                }

                if (Session["Additive"] != null)
                {
                    if (Session["Additive"].ToString() == "False")
                        chkAdditive.Checked = false;

                    if (Session["Additive"].ToString() == "True")
                    {
                        chkAdditive.Checked = true;
                        pnlSQLhistory.Visible = true;

                        if (Session["DataCount"] != null)
                            lblAdditive.Text = "Additive Suche (" + Session["DataCount"] + " Datensätze)";
                    }
                }

                // german date format
                System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("de-DE");

                Session["UseLookups"] = SQLexecute_SingleResult("select CAST(USE_LOOKUPS as Char(1)) from VIEW_SETTINGS where VIEW_NAME='" + Session["View"] + "'");
            }

            SetDataSource();

            string parameter = this.Request["__EVENTARGUMENT"];

            if (parameter == "PostFromSave")
            {
                if (txtSearchName.Text != "")
                {
                    SaveSearch(txtSearchName.Text);
                    cboSaveSearch.DataBind();
                    cboSaveSearch.SelectedValue = txtSearchName.Text;
                }
            }

            if(parameter == "PostfromDelete")
            {
                if(HiddenInputBox.Value == "YES")
                    DeleteSearch(cboSaveSearch.SelectedValue);

                cboSaveSearch.DataBind();
                btnNew_Click(sender, e);
            }
        }

        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        private void ClearTempTable()
        {
            if (Session["View"] != null && Session["UserName"] != null)
            {
                SQLexecute("EXEC RecreateSearchTableForUser '" + Session["View"] + "','" + (String)Session["UserName"] + "'");
                dgdSearch.DataBind();
            }
            else
                Response.Redirect("default.aspx");
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

        protected void btnNew_Click(object sender, EventArgs e)
        {
            if (Session["GUID"] != null)
            {
                SQLexecute("delete from V_Recursive_Temp where GUID='" + Session["GUID"] + "'");
                SQLexecute("delete from V_Recursive_Log where GUID='" + Session["GUID"] + "'");
                lblRecursive.Text = "Rekursive Suche";
                Session["GUID"] = Guid.NewGuid().ToString();
                Session["Iteration"] = 1;
                Session["Recursive"] = null;
                Session["Additive"] = null;
                Session["LastQuery"] = null;
                chkAdditive.Checked = false;
                chkRecursive.Checked = false;
            }

            ClearTempTable();
            dgdSearch.DataBind();
            txtSQLselect.Text = "";
            txtSQLwhere.Text = "";
        }

        // escape SQL string for saving query in history
        protected string EscapeSQL(string SQL)
        {
            SQL = SQL.Replace("'", "''")
                      .Replace("[", "")
                      .Replace("]", "")
                      .Replace("=", " = ")
                      .Replace("WHERE v.", "")
                      .Replace("LIKE", "ENTHÄLT")
                      .Replace("NOT LIKE", "ENTHÄLT NICHT")
                      .Replace("IS NULL", "IST LEER")
                      .Replace("IS NOT NULL", "IST NICHT LEER")
                      .Replace("%", "*")
                      .Replace("<", " < ")
                      .Replace(">", " > ")
                      .Replace("BETWEEN", "ZWISCHEN");
            int nLastIndex = SQL.IndexOf("union") > 0 ? SQL.IndexOf("union")-1 : SQL.Length;
            SQL = SQL.Substring(0, nLastIndex);
            return Server.HtmlDecode(SQL);
        }

        protected void GenerateSQL(bool bSubmit)
        {
            string sSelect = "select v.* ";
            string sFrom = " from [" + Session["View"] + "] v ";
            string sWhere = "";
            int nLastIteration = Session["Iteration"] == null ? 0 : (int)(Session["Iteration"]) - 1;
            bool bRecursive = false;
            bool bAdditive = false;
            bool bStandard = false;

            if (bSubmit) // submit search
            {
                if (Session["Recursive"] != null)
                    bRecursive = (Session["Recursive"].ToString() == "True");

                if (Session["Additive"] != null)
                    bAdditive = (Session["Additive"].ToString() == "True");

                if (!bRecursive && !bAdditive)
                    bStandard = true;

                if ((bRecursive && nLastIteration > 0 || (bStandard && (bool)Session["JumpedBack"])))
                    sFrom += " inner join V_Recursive_Temp t on v.ID=t.ID and t.GUID='" + Session["GUID"] + "' and t.ITERATION=" + nLastIteration.ToString();
            }

            if (!bSubmit) // don't submit search, just fill the query editor
            {
                txtSQLselect.Text = sSelect + sFrom + "WHERE ";

                // where clause
                string sLogic = "";
                bool bIsFirst = true;

                foreach (GridViewRow row in dgdSearch.Rows)
                {
                    string sAttribute = row.Cells[2].Text;
                    string sOperator = row.Cells[3].Text;
                    string sValue = row.Cells[4].Text;
                    string sDatatype = row.Cells[6].Text;
                    bool bLeadingBracket = row.Cells[1].BackColor == System.Drawing.Color.Aquamarine ? true : false;
                    bool bEndingBracket = row.Cells[12].BackColor == System.Drawing.Color.Aquamarine ? true : false;

                    if (row.FindControl("lblValue") != null)
                        sValue = ((Label)row.FindControl("lblValue")).Text;

                    if (row.FindControl("cboControltype") != null) // only available for selected row
                    {
                        string sControltype = ((DropDownList)row.Cells[8].FindControl("cboControltype")).SelectedValue;
                        switch (sControltype)
                        {
                            case "TextBox":
                                if (row.FindControl("txtValue") != null)
                                    sValue = ((TextBox)row.FindControl("txtValue")).Text;
                                break;
                            case "DropDownList":
                                if (row.FindControl("cboValue") != null)
                                    sValue = ((DropDownList)row.FindControl("cboValue")).SelectedValue;
                                if (row.FindControl("txtValue") != null)
                                    sValue = ((TextBox)row.FindControl("txtValue")).Text;
                                break;
                            case "Calendar":
                                if (row.FindControl("txtCalFrom") != null)
                                    sValue = ((TextBox)row.FindControl("txtCalFrom")).Text;
                                if (row.FindControl("txtCalFrom") != null && ((TextBox)row.FindControl("txtCalTo")).Text != "")
                                    sValue = ((TextBox)row.FindControl("txtCalFrom")).Text + ',' + ((TextBox)row.FindControl("txtCalTo")).Text;
                                break;
                        }
                    }

                    if (sValue.ToLower().Contains("select") || sValue.ToLower().Contains("delete") ||
                       sValue.ToLower().Contains("drop") || sValue.ToLower().Contains("truncate") ||
                       sValue.ToLower().Contains("alter") || sValue.ToLower().Contains("execute") ||
                       sValue.ToLower().Contains("call") || sValue.ToLower().Contains("updatexml") ||
                       sValue.ToLower().Contains("extractvalue") || sValue.ToLower().Contains("--") ||
                       sValue.ToLower().Contains("/*") || sValue.ToLower().Contains("*/") ||
                       sValue.ToLower().Contains("grant") || sValue.ToLower().Contains("update"))
                    {
                        ShowMsg("Fehler: Kann die Abfrage nicht ausführen! Nicht erlaubte Schlüsselwörter verwendet. Bitte ändern und noch einmal versuchen.");
                        return;
                    }
                    
                    // get value from drop down list
                    if (row.FindControl("lblOperator") != null)
                        sOperator = ((Label)row.FindControl("lblOperator")).Text;
                    if (row.FindControl("cboOperator") != null)
                        sOperator = ((DropDownList)row.FindControl("cboOperator")).SelectedValue;

                    if (sValue != "" || sOperator.Contains("LEER"))
                    { 
                        if (row.FindControl("lblLogic") != null)
                            sLogic = ((Label)row.FindControl("lblLogic")).Text;
                        if (row.FindControl("cboLogic") != null)
                            sLogic = ((DropDownList)row.FindControl("cboLogic")).SelectedValue;

                        if (bIsFirst)
                        {
                            sWhere += "WHERE ";
                            bIsFirst = false;
                        }

                        if (bLeadingBracket)
                            sWhere += "(";

                        switch (sOperator)
                        {
                            case "≠":
                                sOperator = "<>";
                                break;
                            
                            case "IN":
                                sWhere += "v.[" + sAttribute + "] IN " + sValue;
                                break;

                            case "ENTHÄLT":
                                sWhere += "v.[" + sAttribute + "] LIKE '%" + sValue + "%'";
                                break;

                            case "ENTHÄLT NICHT":
                                sWhere += "v.[" + sAttribute + "] NOT LIKE '%" + sValue + "%'";
                                break;

                            case "IST LEER":
                                sWhere += "v.[" + sAttribute + "] IS NULL";
                                break;

                            case "IST NICHT LEER":
                                sWhere += "v.[" + sAttribute + "] IS NOT NULL";
                                break;

                            default:
                                if(sOperator != "ZWISCHEN")
                                    sValue = sValue.Replace("'", "");

                                //sValue = sValue.Replace("('", "").Replace("')", "");

                                switch (sDatatype)
                                {
                                    case "int":
                                    case "smallint":
                                    case "bigint":
                                    case "float":
                                    case "decimal":
                                    case "bit":
                                    case "tinyint":
                                    case "real":
                                    case "numeric":
                                        if (sOperator == "ZWISCHEN")
                                        {
                                            int nSeparator = sValue.IndexOf(',');
                                            string sValue1 = sValue.Substring(0, nSeparator);
                                            string sValue2 = sValue.Substring(nSeparator + 1, sValue.Length - nSeparator - 1);
                                            sValue = sValue1 + " AND " + sValue2;
                                            sWhere += "v.[" + sAttribute + "] BETWEEN " + sValue;
                                        }
                                        else
                                            sWhere += "v.[" + sAttribute + "] " + sOperator + " " + sValue;
                                        break;
                                    case "date":
                                        if (sOperator == "ZWISCHEN")
                                        {
                                            int nSeparator = sValue.IndexOf(',');
                                            string sDate1 = "'" + sValue.Substring(0, nSeparator) + "'";
                                            string sDate2 = "'" + sValue.Substring(nSeparator + 1, sValue.Length - nSeparator - 1) + "'";
                                            sValue = sDate1 + " AND " + sDate2;

                                            sWhere += "v.[" + sAttribute + "] BETWEEN " + sValue;
                                        }
                                        else
                                            sWhere += "v.[" + sAttribute + "] " + sOperator + " CONVERT(date, '" + sValue + "', 104)";
                                        break;
                                    case "smalldatetime":
                                    case "datetime":
                                    case "datetime2":
                                        if (sOperator == "ZWISCHEN")
                                        {
                                            int nSeparator = sValue.IndexOf(',');
                                            string sDate1 = "'" + sValue.Substring(0, nSeparator) + ":00.00'";
                                            string sDate2 = "'" + sValue.Substring(nSeparator + 1, sValue.Length - nSeparator - 1) + ":00.00'";
                                            sValue = sDate1 + " AND " + sDate2;

                                            sWhere += "v.[" + sAttribute + "] BETWEEN " + sValue;
                                        }
                                        else
                                            sWhere += "v.[" + sAttribute + "] " + sOperator + " CONVERT(datetime, '" + sValue + "', 104)";
                                        break;

                                    default:
                                        sWhere += "v.[" + sAttribute + "] " + sOperator + " '" + sValue + "'";
                                        break;
                                }
                                break;
                        }

                        if (bEndingBracket)
                            sWhere += ")";

                        sWhere += "\n" + sLogic.Replace("UND", "AND").Replace("ODER", "OR") + " ";
                    }
                }

                if (sWhere.Length > 6)
                {
                    // cut last AND
                    if (sLogic == "UND")
                        sWhere = sWhere.Substring(0, sWhere.Length - 5);
                    // cut last OR
                    if (sLogic == "ODER")
                        sWhere = sWhere.Substring(0, sWhere.Length - 4);

                    txtSQLwhere.Text = sWhere.Replace("WHERE", "") + " ORDER BY v.ID";
                }
            }
            else // submit search
            {
                sWhere = txtSQLwhere.Text;

                if (bAdditive && nLastIteration > 0) // additive search
                {
                    sWhere += " union select v2.*" +
                              " from [" + Session["View"] + "] v2" +
                              " inner join V_Recursive_Temp t on v2.ID=t.ID and t.GUID='" + Session["GUID"] + "' and t.ITERATION=" + nLastIteration.ToString();
                }

                if(sWhere.Length > 6)
                    sWhere = " WHERE " + sWhere;

                string sSQL = Server.HtmlDecode(sSelect + sFrom + sWhere);
                Session["LastQuery"] = sSQL;

                if ((bool)Session["JumpedBack"] == false) // save result to temporary table
                {
                    string sInsert = "insert into V_Recursive_Temp (ID, GUID, ITERATION) ";
                    string sSQL2 = "";
                    string sMode = "";

                    if (bRecursive)
                    {
                        sSelect = "select v.ID, '" + Session["GUID"] + "'," + Session["Iteration"];
                        sSQL2 = Server.HtmlDecode(sInsert + sSelect + sFrom + sWhere);
                        sMode = "Rekursiv";
                    }
                    else if (bAdditive)
                    {
                        sSelect = "select u.ID, '" + Session["GUID"] + "'," + Session["Iteration"];
                        sSQL2 = Server.HtmlDecode(sInsert + sSelect + " from (" + sSQL + ") u");
                        sMode = "Additiv";
                    }
                    else // standard search
                    {
                        sSelect = "select v.ID, '" + Session["GUID"] + "'," + Session["Iteration"];
                        sSQL2 = Server.HtmlDecode(sInsert + sSelect + sFrom + sWhere);
                        sMode = "Standard";
                    }

                    SQLexecute(sSQL2);
                    SQLexecute("insert into V_Recursive_Log (GUID, Iteration, SQL, SEARCHMODE) values ('" + Session["GUID"] + "'," + Session["Iteration"] + ",'" + EscapeSQL(sWhere.Replace("WHERE","")) + "','" + sMode + "')");

                    Session["Iteration"] = (int)Session["Iteration"] + 1;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            GenerateSQL(true);
            Response.Redirect(sParentPage, true);
        }

        private DataSet GetData(string query)
        {
            string conString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlCommand cmd = new SqlCommand(query);
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        sda.Fill(ds);
                        return ds;
                    }
                }
            }
        }
        
        // executed after hitting the "Edit" button, but before loading controls
        protected void dgdSearch_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewRow newRow = dgdSearch.Rows[e.NewEditIndex];
            string sCurrentField = (string)newRow.Cells[2].Text;
            Session["CurrentField"] = sCurrentField;
        }

        // save current row to search form table
        protected void btnOK_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            TextBox txtValue = (TextBox)row.FindControl("txtValue");
            DropDownList cboValue = (DropDownList)row.FindControl("cboValue");
            CheckBoxList chkValue = (CheckBoxList)row.FindControl("chkValue");
            DropDownList cboOperator = (DropDownList)row.FindControl("cboOperator");
            DropDownList cboControltype = (DropDownList)row.FindControl("cboControltype");
            TextBox txtCalFrom = (TextBox)row.FindControl("txtCalFrom");
            TextBox txtCalTo = (TextBox)row.FindControl("txtCalTo");
            CheckBox chkSingleValue = (CheckBox)row.FindControl("chkSingleValue");
            string sOperator = cboOperator.SelectedValue;
            string sDatatype = row.Cells[6].Text;

            if (cboValue.Visible)
                txtValue.Text = cboValue.SelectedValue;

            if (chkValue.Visible) // handle checklist for IN operator
            {
                String sSelected = String.Join("','", chkValue.Items.OfType<ListItem>().Where(r => r.Selected).Select(r => r.Text));
                txtValue.Text = "('" + sSelected + "')";
            }

            if (cboOperator.SelectedValue == "IN" && cboControltype.SelectedValue == "TextBox") // handle copied lists from excel
            {
                if(sDatatype.Contains("int") || sDatatype == "decimal" || sDatatype == "float" || sDatatype == "numeric" || sDatatype == "real" || sDatatype == "bit")
                    txtValue.Text = "(" + txtValue.Text.Substring(0, txtValue.Text.Length - 1).Replace("\n", ",") + ")";
                else
                    txtValue.Text = "('" + txtValue.Text.Substring(0, txtValue.Text.Length - 1).Replace("\n", "','") + "')";
            }

            switch (sDatatype)
            {
                case "smalldatetime":
                case "datetime":
                case "datetime2":
                case "date":
                if (sOperator == "ZWISCHEN")
                {
                    if (txtCalFrom.Text.Length > 0 && txtCalTo.Text.Length > 0)
                        txtValue.Text = "'" + txtCalFrom.Text + "', '" + txtCalTo.Text + "'";
                    else
                        txtValue.Text = "";
                }
                else // Operator >, <, =
                {
                    if (txtCalFrom.Text.Length > 0)
                        txtValue.Text = "'" + txtCalFrom.Text + "'";
                    else
                        txtValue.Text = "";
                }
                break;

                case "int":
                case "tinyint":
                case "smallint":
                case "bigint":
                case "float":
                case "numeric":
                case "decimal":
                case "real":
                if (sOperator == "ZWISCHEN")
                {
                    if (txtCalFrom.Text.Length > 0 && txtCalTo.Text.Length > 0)
                        txtValue.Text = txtCalFrom.Text + "," + txtCalTo.Text;
                    else
                        txtValue.Text = "";
                }
                break;

                case "bit":
                    if (txtValue.Text != " ")
                        txtValue.Text = chkSingleValue.Checked == true ? "1" : "0";
                    else
                        txtValue.Text = "";
                break;
            }
            GenerateSQL(false);
        }

        protected void cboOperator_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cboOperator = (DropDownList)sender;
            GridViewRow row = (GridViewRow)cboOperator.NamingContainer;
            EnableControls(row, false);
        }

        public DataTable GetCboData(string sCurrentField)
        {
            string sSQL;

            if ((string)Session["UseLookups"] == "1")
                sSQL = "exec('select null as TEXT union select VALUE as TEXT from LOOKUPS where ViewName=''" + Session["View"] + "'' and Attribute=''" + sCurrentField + "'' ORDER BY TEXT')";
            else
                sSQL = "exec('select null as TEXT union select distinct [" + sCurrentField + "] as TEXT from " + Session["View"] + " ORDER BY TEXT')";

            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            using (var cmd = new SqlCommand(sSQL, conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var dt = new DataTable();
                adapter.Fill(dt);
                conn.Close();
                return dt;
            }
        }
    
        public void EnableControls(GridViewRow row, bool bLoadOperators)
        {
            // get controls
            DropDownList cboValue = (DropDownList)row.FindControl("cboValue");
            CheckBoxList chkValue = (CheckBoxList)row.FindControl("chkValue");
            TextBox txtValue = (TextBox)row.FindControl("txtValue");
            ImageButton btnCalFrom = (ImageButton)row.FindControl("btnCalFrom");
            ImageButton btnCalTo = (ImageButton)row.FindControl("btnCalTo");
            Label lblFrom = (Label)row.FindControl("lblFrom");
            Label lblTo = (Label)row.FindControl("lblTo");
            TextBox txtCalFrom = (TextBox)row.FindControl("txtCalFrom");
            TextBox txtCalTo = (TextBox)row.FindControl("txtCalTo");
            CheckBox chkSingleValue = (CheckBox)row.FindControl("chkSingleValue");
            DropDownList cboControltype = (DropDownList)row.FindControl("cboControltype");
            ImageButton btnClearValue = (ImageButton)row.FindControl("btnClearValue");
            DropDownList cboOperator = ((DropDownList)row.FindControl("cboOperator"));
            DropDownList cboLogic = (DropDownList)row.FindControl("cboLogic");
            if(cboLogic.SelectedValue == "")
                cboLogic.SelectedValue = "UND";

            // hide all controls
            cboValue.Visible = false;
            cboValue.DataSource = null;
            chkValue.Visible = false;
            chkValue.DataSource = null;
            txtValue.Visible = false;
            btnCalFrom.Visible = false;
            btnCalTo.Visible = false;
            //lblFrom.Visible = false;
            lblFrom.Text = " ";
            lblTo.Visible = false;
            txtCalFrom.Visible = false;
            txtCalTo.Visible = false;

            // populate operators
            string sDatatype = (string)row.Cells[6].Text;

            if (bLoadOperators) // Load Operator and Control Type Items
            {
                string sSelectedOperator = cboOperator.SelectedValue;
                cboOperator.Items.Clear();
                cboOperator.Items.Add(new ListItem("="));
                cboOperator.Items.Add(new ListItem("≠", "<>"));

                string sSelectedControlType = cboControltype.SelectedValue;
                cboControltype.Items.Clear();

                switch (sDatatype)
                {
                    case "date":
                    case "smalldatetime":
                    case "datetime":
                    case "datetime2":
                        cboOperator.Items.Add(new ListItem("<"));
                        cboOperator.Items.Add(new ListItem(">"));
                        cboOperator.Items.Add(new ListItem("ZWISCHEN"));
                        cboOperator.Items.Add(new ListItem("IST LEER"));
                        cboOperator.Items.Add(new ListItem("IST NICHT LEER"));
                        cboOperator.SelectedValue = sSelectedOperator;
                        
                        // calendar only
                        cboControltype.Items.Add(new ListItem("Calendar"));
                        break;
                    
                    case "int":
                    case "tinyint":
                    case "smallint":
                    case "bigint":
                    case "float":
                    case "real":
                    case "numeric":
                    case "decimal":
                        cboOperator.Items.Add(new ListItem("<"));
                        cboOperator.Items.Add(new ListItem(">"));
                        cboOperator.Items.Add(new ListItem("ZWISCHEN"));
                        cboOperator.Items.Add(new ListItem("ENTHÄLT"));
                        cboOperator.Items.Add(new ListItem("ENTHÄLT NICHT"));
                        cboOperator.Items.Add(new ListItem("IN"));
                        cboOperator.Items.Add(new ListItem("IST LEER"));
                        cboOperator.Items.Add(new ListItem("IST NICHT LEER"));
                        cboOperator.SelectedValue = sSelectedOperator;

                        // user can choose between TextBox and DropDown
                        cboControltype.Items.Add(new ListItem("TextBox"));
                        cboControltype.Items.Add(new ListItem("DropDownList"));
                        break;

                    case "varchar":
                    case "nvarchar":
                    case "char":
                    case "nchar":
                    case "text":
                    case "ntext":
                        cboOperator.Items.Add(new ListItem("ENTHÄLT"));
                        cboOperator.Items.Add(new ListItem("ENTHÄLT NICHT"));
                        cboOperator.Items.Add(new ListItem("IN"));
                        cboOperator.Items.Add(new ListItem("IST LEER"));
                        cboOperator.Items.Add(new ListItem("IST NICHT LEER"));

                        if (cboOperator.SelectedValue == "<" ||
                            cboOperator.SelectedValue == ">" ||
                            cboOperator.SelectedValue == "<>" ||
                            cboOperator.SelectedValue == "ZWISCHEN")
                            cboOperator.SelectedValue = "=";
                        else
                            cboOperator.SelectedValue = sSelectedOperator;

                        // user can choose between TextBox and DropDown
                        cboControltype.Items.Add(new ListItem("TextBox"));
                        cboControltype.Items.Add(new ListItem("DropDownList"));
                        break;

                    case "bit":
                        cboOperator.Items.Add(new ListItem("IST LEER"));
                        cboOperator.Items.Add(new ListItem("IST NICHT LEER"));
                        cboOperator.SelectedValue = sSelectedOperator;

                        // checkbox only
                        cboControltype.Items.Add(new ListItem("TextBox"));
                        break;
                }
                cboControltype.SelectedValue = sSelectedControlType;
            }

            // get cell values
            string sCurrentField = (string)row.Cells[2].Text;
            string sOperator = cboOperator.SelectedValue;
            string sControltype = cboControltype.SelectedValue;
            CalendarExtender calFrom = (CalendarExtender)row.FindControl("calFrom");
            CalendarExtender calTo = (CalendarExtender)row.FindControl("calTo");
            Label lblInsertValues = (Label)row.FindControl("lblInsertValues");
            lblInsertValues.Visible = false;

            switch (sControltype)
            {
                case "DropDownList":
                    switch (sOperator)
                    {
                        case "IN":
                            chkValue.Visible = true;
                            chkValue.DataSource = GetCboData(sCurrentField);
                            chkValue.DataTextField = "TEXT";
                            chkValue.DataValueField = "TEXT";
                            chkValue.DataBind();
                            break;

                        case "ENTHÄLT":
                        case "ENTHÄLT NICHT":
                            txtValue.Visible = true;
                            break;

                        case "IST LEER":
                        case "IST NICHT LEER":
                            break;
                        
                        default:
                            cboValue.Visible = true;
                            cboValue.DataSource = GetCboData(sCurrentField);
                            cboValue.DataTextField = "TEXT";
                            cboValue.DataValueField = "TEXT";
                            cboValue.DataBind();

                            if(txtValue.Text != "" && !txtValue.Text.Contains("("))
                                cboValue.SelectedValue = txtValue.Text;

                            break;
                    }
                    break;

                case "TextBox":
                    if (sDatatype == "bit")
                    {
                        chkSingleValue.Visible = true;
                        btnClearValue.Visible = true;
                        cboControltype.Enabled = false;
                        chkSingleValue.Checked = (txtValue.Text == "") ? false : Convert.ToBoolean(Convert.ToInt32(txtValue.Text));
                        break;
                    }
                    else // int, nvarchar, etc. ...
                    {
                        switch (sOperator)
                        {
                            case "IN":
                                txtValue.Visible = true;
                                txtValue.TextMode = TextBoxMode.MultiLine;
                                txtValue.Height = 150;
                                lblInsertValues.Visible = true;
                                break;

                            case "ZWISCHEN":
                                calFrom.Enabled = false;
                                calTo.Enabled = false;
                                txtCalFrom.Visible = true;
                                txtCalTo.Visible = true;
                                lblFrom.Visible = true;
                                lblFrom.Text = "Von:";
                                lblTo.Visible = true;
                                txtCalTo.Visible = true;
                                break;

                            case "IST LEER":
                            case "IST NICHT LEER":
                                break;

                            default:
                                txtValue.Visible = true;
                                txtValue.TextMode = TextBoxMode.SingleLine;
                                txtValue.Height = 25;
                                break;
                        }
                    }
                    break;

                case "Calendar":
                    btnCalFrom.Visible = true;
                    txtCalFrom.Visible = true;
                    lblFrom.Visible = true;
                    calFrom.Enabled = true;
                    cboControltype.Enabled = false;

                    if (sDatatype == "date")
                    {
                        calFrom.Format = "dd.MM.yyyy";
                        calTo.Format = "dd.MM.yyyy";
                    }
                    else
                    {
                        calFrom.Format = "dd.MM.yyyy HH:mm";
                        calTo.Format = "dd.MM.yyyy HH:mm";
                    }

                    switch(sOperator)
                    {
                        case "ZWISCHEN":
                            string sDate = txtValue.Text;
                            int nSplitPos = sDate.IndexOf(",");

                            if (txtValue.Text.Length > 15)
                                txtCalFrom.Text = sDate.Substring(1, nSplitPos-2) ;

                            if (txtValue.Text.Length > 25)
                                txtCalTo.Text = txtValue.Text.Substring(nSplitPos+3, sDate.Length-nSplitPos-4);

                            calTo.Enabled = true;
                            lblFrom.Text = "Von:";
                            lblTo.Visible = true;
                            btnCalTo.Visible = true;
                            txtCalTo.Visible = true;
                        break;

                        case "IST LEER":
                        case "IST NICHT LEER":
                            break;

                        default:
                        lblFrom.Text = "Datum:";
                        txtCalFrom.Text = txtValue.Text.Replace("'", "");
                        break;
                    }
                    break;
            }
        }

        // called after hitting the "Edit" or "OK" button
        protected void dgdSearch_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0) // edit mode
                    EnableControls(e.Row, true);

                // apply bracket colors
                if (((Hashtable)Session["htBracket1"]).Count > 0)
                {
                    Hashtable htBracket1 = (Hashtable)Session["htBracket1"];
                    if (Convert.ToBoolean(htBracket1[e.Row.RowIndex]) == true)
                        e.Row.Cells[1].BackColor = System.Drawing.Color.Aquamarine;
                    else
                        e.Row.Cells[1].BackColor = System.Drawing.Color.Transparent;
                }

                if (((Hashtable)Session["htBracket2"]).Count > 0)
                {
                    Hashtable htBracket2 = (Hashtable)Session["htBracket2"];
                    if (Convert.ToBoolean(htBracket2[e.Row.RowIndex]) == true)
                        e.Row.Cells[12].BackColor = System.Drawing.Color.Aquamarine;
                    else
                        e.Row.Cells[12].BackColor = System.Drawing.Color.Transparent;
                }
            }
            else // save date & datetime column names for correct excel export in results.aspx        
            {
                HashSet<string> DateCols = new HashSet<string>();
                HashSet<string> DateTimeCols = new HashSet<string>();
                foreach (GridViewRow row in dgdSearch.Rows)
                {
                    string sDatatype = row.Cells[6].Text;
                    string sColumnName = row.Cells[2].Text;

                    if (sDatatype =="date")
                    {
                        if (!DateCols.Contains(sColumnName))
                            DateCols.Add(sColumnName);
                    }

                    if (sDatatype == "datetime")
                    {
                        if (!DateTimeCols.Contains(sColumnName))
                            DateTimeCols.Add(sColumnName);
                    }
                }
                Session["DateCols"] = DateCols;
                Session["DateTimeCols"] = DateTimeCols;
            }
        }

        protected void cboControltype_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cboOperator = (DropDownList)sender;
            GridViewRow row = (GridViewRow)cboOperator.NamingContainer;
            EnableControls(row, false);
        }
        
        protected void chkAdditive_CheckedChanged(object sender, EventArgs e)
        {
            bool bChecked = ((CheckBox)sender).Checked;
            Session["Additive"] = bChecked;

            if (bChecked)
            {
                chkRecursive.Checked = false;
                Session["Recursive"] = false;
            }

            btnSubmit.Focus();
        }

        protected void chkRecursive_CheckedChanged(object sender, EventArgs e)
        {
            bool bChecked = ((CheckBox)sender).Checked;
            Session["Recursive"] = bChecked;

            if (bChecked)
            {
                chkAdditive.Checked = false;
                Session["Additive"] = false;
            }

            btnSubmit.Focus();
        }

        private void SaveSearch(string sSearchName)
        {
            // clear previous search
            DeleteSearch(sSearchName);

            // save new search
            string sSQL = "insert into V_Save_Search " +
                   "(ID, Attribut, Operator, Wert, Datatype, UserId, Controltype, ValueCnt, ViewName, SearchName, Logic, Sorter)" +
                   " select ID, Attribut, Operator, Wert, Datatype, UserId, Controltype, ValueCnt, '" + (String)Session["View"] + "', '" + sSearchName + "', Logic, Sorter" +
                   " from " + Session["FormTable"] + " where UserId='" + (String)Session["UserName"] + "'";

            SQLexecute(Server.HtmlDecode(sSQL));

            SaveExtSearch(sSearchName);
        }

        public static string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }

        public static string Base64Decode(string base64EncodedData)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }

        private void SaveExtSearch(string sSearchName)
        {
            string sSQLwhere = Base64Encode(txtSQLwhere.Text);
            
            string sSQL = "insert into V_Save_Ext_Search (SQL, UserId, ViewName, SearchName) " +
                          "values ('" + sSQLwhere + "','" + (String)Session["UserName"] + "','" + (String)Session["View"] + "','" + sSearchName + "')";

            SQLexecute(Server.HtmlDecode(sSQL));
        }

        private void DeleteSearch(string sSearchName)
        {

            string sSQL = "delete from V_Save_Search where SearchName = '" + sSearchName + "'" +
                                                   " and UserId = '" + (String)Session["UserName"] + "'" +
                                                   " and ViewName = '" + (String)Session["View"] + "'";
            SQLexecute(sSQL);

            DeleteExtSearch(sSearchName);
        }

        private void DeleteExtSearch(string sSearchName)
        {

            string sSQL = "delete from V_Save_Ext_Search where SearchName = '" + sSearchName + "'" +
                                                   " and UserId = '" + (String)Session["UserName"] + "'" +
                                                   " and ViewName = '" + (String)Session["View"] + "'";
            SQLexecute(sSQL);
        }

        private void LoadSearch(string sSearchName)
        {
            // clear previous search
            string sSQL = "delete from [" + Session["FormTable"] + "] where UserId = '" + (String)Session["UserName"] + "'";
            SQLexecute(sSQL);

            // pull new search into search table
            sSQL = "insert into [" + Session["FormTable"] + "] " +
                   "(Attribut, Operator, Wert, Datatype, UserId, Controltype, ValueCnt, Logic, Sorter)" +
                   " select Attribut, Operator, Wert, Datatype, UserId, Controltype, ValueCnt, Logic, Sorter" +
                   " from V_Save_Search where UserId='" + (String)Session["UserName"] + "' and ViewName = '" + Session["View"] + "' and SearchName = '" + sSearchName + "'";

            SQLexecute(Server.HtmlDecode(sSQL));
            dgdSearch.DataBind();
            
            // load sql string from V_Save_Ext_Search
            txtSQLselect.Text = "select v.* from [" + Session["View"] + "] v WHERE ";
            txtSQLwhere.Text = Base64Decode(SQLexecute_SingleResult("select SQL from V_Save_Ext_Search" +
                                                        " where UserId='" + (String)Session["UserName"] +
                                                        "' and ViewName = '" + Session["View"] +
                                                        "' and SearchName = '" + sSearchName + "'"));
        }

        protected void btnLoadSearch_Click(object sender, EventArgs e)
        {
            if (cboSaveSearch.SelectedValue != "")
            {
                LoadSearch(cboSaveSearch.SelectedValue);
                btnSubmit.Focus();
            }
        }

        protected void btnJumpBack_Click(object sender, EventArgs e)
        {
            Button btnJumpBack = (Button)sender;
            GridViewRow row = (GridViewRow)btnJumpBack.NamingContainer;

            int nIteration = Convert.ToInt16(Session["Iteration"]);
            string sIterationSelected = row.Cells[0].Text;
            int nIterationSelected = Convert.ToInt16(sIterationSelected);

            if (nIterationSelected < nIteration-1)
            {
                Session["Iteration"] = nIterationSelected + 1;
                Session["JumpedBack"] = true;
                lblRecursive.Text = "Rekursive Suche";
                lblAdditive.Text = "Additive Suche";
                SQLexecute("delete from V_Recursive_Log where GUID = '" + Session["GUID"] + "' and Iteration > " + sIterationSelected);
                dgdHistory.DataBind();
            }
        }
        protected void btnClearValue_Click(object sender, EventArgs e)
        {
            ImageButton btnClearValue = (ImageButton)sender;
            GridViewRow row = (GridViewRow)btnClearValue.NamingContainer;
            CheckBox chkSingleValue = (CheckBox)row.FindControl("chkSingleValue");
            TextBox txtValue = (TextBox)row.FindControl("txtValue");
            chkSingleValue.Checked = false;
            txtValue.Text = "NULL";
        }

        protected void chkSingleValue_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkSingleValue = (CheckBox)sender;
            GridViewRow row = (GridViewRow)chkSingleValue.NamingContainer;
            TextBox txtValue = (TextBox)row.FindControl("txtValue");

            if (chkSingleValue.Checked)
                txtValue.Text = "1";
            else
                txtValue.Text = "0";
        }

        protected void txtValue_TextChanged(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((TextBox)sender).NamingContainer;
            DropDownList cboLogic = (DropDownList)row.FindControl("cboLogic");
            if(cboLogic.SelectedValue == "")
                cboLogic.SelectedValue = "UND";
        }

        // called after hitting OK button
        protected void dgdSearch_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                // get row index
                Button btn = (Button)e.CommandSource;
                GridViewRow row = (GridViewRow)btn.NamingContainer;
                int newIndex = row.RowIndex;

                if (Session["PreviousIndex"] != null)
                {
                    int prevIndex = (int)Session["PreviousIndex"];

                    if (prevIndex != newIndex) // update previous row
                    {
                        object prevSender = dgdSearch.Rows[prevIndex].FindControl("btnOK");
                        if (prevSender != null)
                        {
                            btnOK_Click(prevSender, e);
                            dgdSearch.UpdateRow(prevIndex, false);
                        }
                    }
                }
                Session["PreviousIndex"] = newIndex;
            }
        }

        protected void chkExpertMode_CheckedChanged(object sender, EventArgs e)
        {
            if (((CheckBox)sender).Checked)
            {
                pnlSQLeditor.Visible = true;
            }
            else
            {
                pnlSQLeditor.Visible = false;
            }

            // column visibility is set in dgdSearch_RowCreated() event
            dgdSearch.DataBind();
        }

        protected void btnDown_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)(((Button)sender).NamingContainer);
            string sID = row.Cells[0].Text;
            int nRow = row.RowIndex;
            string sID2 = dgdSearch.Rows[++nRow].Cells[0].Text;
            string sSQL = "UPDATE [" + Session["FormTable"] + "] SET [Sorter] = [Sorter] + 1 where ID = " + sID;
            SQLexecute(sSQL);
            sSQL = "UPDATE [" + Session["FormTable"] + "] SET [Sorter] = [Sorter] - 1 where ID = " + sID2;
            SQLexecute(sSQL);
            dgdSearch.EditIndex = nRow;
            dgdSearch.DataBind();
        }

        protected void btnUp_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)(((Button)sender).NamingContainer);
            string sID = row.Cells[0].Text;
            int nRow = row.RowIndex;
            string sID2 = dgdSearch.Rows[--nRow].Cells[0].Text;
            string sSQL = "UPDATE [" + Session["FormTable"] + "] SET [Sorter] = [Sorter] - 1 where ID = " + sID;
            SQLexecute(sSQL);
            sSQL = "UPDATE [" + Session["FormTable"] + "] SET [Sorter] = [Sorter] + 1 where ID = " + sID2;
            SQLexecute(sSQL);
            dgdSearch.EditIndex = nRow;
            dgdSearch.DataBind();
        }

        protected void dgdSearch_RowCreated(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[0].Visible = false; // hide id column
            e.Row.Cells[11].Visible = false; // hide sorter column

            if (chkExpertMode.Checked)
            { // show ...
                if(e.Row.FindControl("btnCopyRow") != null)
                    e.Row.FindControl("btnCopyRow").Visible = true;

                e.Row.Cells[1].Visible = true; // leading bracket column
                e.Row.Cells[5].Visible = true; // logic column
                e.Row.Cells[6].Visible = true; // datatype column
                e.Row.Cells[8].Visible = true; // control type column
                e.Row.Cells[10].Visible = true; // sort buttons column
                e.Row.Cells[12].Visible = true; // ending bracket column
            }
            else
            { // hide ...
                if (e.Row.FindControl("btnCopyRow") != null)
                    e.Row.FindControl("btnCopyRow").Visible = false;

                e.Row.Cells[1].Visible = false; // leading bracket column
                e.Row.Cells[5].Visible = false; // logic column
                e.Row.Cells[6].Visible = false; // datatype column
                e.Row.Cells[8].Visible = false; // controltype column
                e.Row.Cells[10].Visible = false; // sort buttons column
                e.Row.Cells[12].Visible = false; // ending bracket column
            }
        }

        protected void btnBracket1_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)(((Button)sender).NamingContainer);

            if (Session["CellColor"] == null)
                Session["CellColor"] = row.Cells[1].BackColor;

            if (row.Cells[1].BackColor != System.Drawing.Color.Aquamarine)
            {
                row.Cells[1].BackColor = System.Drawing.Color.Aquamarine;

                ((Hashtable)Session["htBracket1"]).Add(row.RowIndex, true);
            }
            else
            {
                row.Cells[1].BackColor = (System.Drawing.Color)Session["CellColor"];
                ((Hashtable)Session["htBracket1"]).Remove(row.RowIndex);
            }
            GenerateSQL(false);
        }

        protected void btnBracket2_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)(((Button)sender).NamingContainer);

            if (Session["CellColor"] == null)
                Session["CellColor"] = row.Cells[12].BackColor;

            if (row.Cells[12].BackColor != System.Drawing.Color.Aquamarine)
            {
                row.Cells[12].BackColor = System.Drawing.Color.Aquamarine;
                ((Hashtable)Session["htBracket2"]).Add(row.RowIndex, true);
            }
            else
            {
                row.Cells[12].BackColor = (System.Drawing.Color)Session["CellColor"];
                ((Hashtable)Session["htBracket2"]).Remove(row.RowIndex);
            }
            GenerateSQL(false);
        }

        protected void btnCopyRow_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            string sID = row.Cells[0].Text;
            string sSQL = "INSERT INTO [" + Session["FormTable"] + "] ([Attribut], [Operator], [Wert], [Datatype], [ControlType], [UserId], [Logic], [Sorter]) " +
                          "select [Attribut], [Operator], NULL, [Datatype], [ControlType], [UserId], 'UND', [Sorter] from [" + Session["FormTable"] + "] where ID = " + sID;
            SQLexecute(sSQL);
            dgdSearch.DataBind();
        }
        
        // don't remove!
        protected void btnCancel_Click(object sender, EventArgs e)
        {
        }
    }
}