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
            dsSearch.SelectCommand = "SELECT * FROM [" + Session["FormTable"] + "] WHERE ([UserId] = '" + (String)Session["UserName"] + "') order by ID";
            dsSearch.UpdateCommand = "UPDATE [" + Session["FormTable"] + "] SET [Operator] = @Operator, [Wert] = @Wert, [Controltype] = @Controltype WHERE [ID] = @ID";
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
            }

            SetDataSource();

            string parameter = Request["__EVENTARGUMENT"];
            
            if (parameter == "PostfromSave")
            {
                if (HiddenInputBox.Value != "")
                {
                    SaveSearch(HiddenInputBox.Value);
                    cboSaveSearch.DataBind();
                    cboSaveSearch.SelectedValue = HiddenInputBox.Value;
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
            String sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            string sUser = (string)Session["UserName"];
            cmd.Parameters.Add("@UserId", SqlDbType.NVarChar).Value = sUser;
            cmd.CommandText = " update " + Session["FormTable"] +
                              " set Wert = null, Operator = '=' where UserId = '" + sUser + "'";
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
                dgdSearch.DataBind();
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
        }

        protected string EscapeSQL(string SQL)
        {
            SQL = SQL.Replace("'", "''")
                      .Replace("[", "")
                      .Replace("]", "")
                      .Replace("=", " = ")
                      .Replace("WHERE v.", "")
                      .Replace("AND", "UND")
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string sSelect = "select v.* ";
            string sFrom = " from [" + Session["View"] + "] v ";
            bool bRecursive = false;
            bool bAdditive = false;
            bool bStandard = false;

            int nLastIteration = Session["Iteration"] == null? 0 : (int)(Session["Iteration"]) - 1;

            if (Session["Recursive"] != null)
                bRecursive = (Session["Recursive"].ToString() == "True");

            if (Session["Additive"] != null)
                bAdditive = (Session["Additive"].ToString() == "True");

            if (!bRecursive && !bAdditive)
                bStandard = true;

            if (bRecursive && nLastIteration > 0 || (bStandard && (bool)Session["JumpedBack"]))
                    sFrom += " inner join V_Recursive_Temp t on v.ID=t.ID and t.GUID='" + Session["GUID"] + "' and t.ITERATION=" + nLastIteration.ToString();

            string sWhere = "";
            bool bIsFirst = true;

            foreach (GridViewRow row in dgdSearch.Rows)
            {
                string sAttribute = row.Cells[1].Text;
                string sValue = ((Label)row.Cells[3].FindControl("Label2")).Text;
                string sDatatype = row.Cells[4].Text;

                if(sValue.ToLower().Contains("select") || sValue.ToLower().Contains("delete") || 
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
                Label lb = (Label)row.Cells[2].FindControl("Label1");
                string sOperator = lb.Text;

                if (sValue != "" || sOperator.Contains("NULL"))
                {
                    if (!bIsFirst)
                    {
                        sWhere += " AND ";
                    }
                    else
                    {
                        sWhere += " WHERE ";
                        bIsFirst = false;
                    }

                    switch (sOperator)
                    {
                        case "IN":
                            sWhere += "v.[" + sAttribute + "] IN " + sValue;
                            break;

                        case "LIKE":
                            sWhere += "v.[" + sAttribute + "] LIKE '%" + sValue + "%'";
                            break;

                        case "NOT LIKE":
                            sWhere += "v.[" + sAttribute + "] NOT LIKE '%" + sValue + "%'";
                            break;

                        case "IS NULL":
                            sWhere += "v.[" + sAttribute + "] IS NULL";
                            break;
                        
                        case "IS NOT NULL":
                            sWhere += "v.[" + sAttribute + "] IS NOT NULL";
                            break;
                        
                        default:
                            switch (sDatatype)
                            {
                                case "int":
                                case "bigint":
                                case "float":
                                case "bit":
                                    if (sOperator == "BETWEEN")
                                    {
                                        int nSeperator = sValue.IndexOf(',');
                                        string sValue1 = sValue.Substring(0, nSeperator);
                                        string sValue2 = sValue.Substring(nSeperator + 1, sValue.Length - nSeperator - 1);
                                        sValue = sValue1 + " AND " + sValue2;
                                        sWhere += "v.[" + sAttribute + "] " + sOperator + " " + sValue;
                                    }
                                    else
                                        sWhere += "v.[" + sAttribute + "]" + sOperator + sValue;
                                    break;
                                case "date":
                                    if (sOperator == "BETWEEN")
                                    {
                                        int nSeperator = sValue.IndexOf(',');
                                        string sDate1 = sValue.Substring(0, nSeperator);
                                        string sDate2 = sValue.Substring(nSeperator + 2, sValue.Length - nSeperator - 2);
                                        sValue = sDate1 + " AND " + sDate2;
                                        //ShowMsg(sValue);
                                        sWhere += "v.[" + sAttribute + "] " + sOperator + " " + sValue;
                                    }
                                    else
                                        sWhere += "v.[" + sAttribute + "] " + sOperator + " CONVERT(date, " + sValue + ")";
                                    break;

                                case "datetime":
                                    if (sOperator == "BETWEEN")
                                    {
                                        int nSeperator = sValue.IndexOf(',');
                                        string sDate1 = sValue.Substring(0, nSeperator - 2) + ":00.00'";
                                        string sDate2 = sValue.Substring(nSeperator + 2, sValue.Length - nSeperator - 3) + ":00.00'";
                                        sValue = sDate1 + " AND " + sDate2;
                                        ShowMsg(sValue);
                                        sWhere += "v.[" + sAttribute + "] " + sOperator + " " + sValue;
                                    }
                                    else
                                        sWhere += "v.[" + sAttribute + "] " + sOperator + " CONVERT(datetime, " + sValue + ")";
                                    break;
                                
                                default:
                                    sWhere += "v.[" + sAttribute + "]" + sOperator + "'" + sValue + "'";
                                    break;
                            }
                            break;
                    }
                }
            }

            if (bAdditive && nLastIteration > 0) // additive search
            {
                sWhere += " union select v2.*" +
                          " from [" + Session["View"] + "] v2" +
                          " inner join V_Recursive_Temp t on v2.ID=t.ID and t.GUID='" + Session["GUID"] + "' and t.ITERATION=" + nLastIteration.ToString();
            }

            string sSQL = Server.HtmlDecode(sSelect + sFrom + sWhere);

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
                SQLexecute("insert into V_Recursive_Log (GUID, Iteration, SQL, SEARCHMODE) values ('" + Session["GUID"] + "'," + Session["Iteration"] + ",'" + EscapeSQL(sWhere) + "','" + sMode + "')");

                Session["Iteration"] = (int)Session["Iteration"] + 1;
            }

            //ShowMsg(sSQL);

            Session["LastQuery"] = sSQL;
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
            string sCurrentField = (string)dgdSearch.Rows[e.NewEditIndex].Cells[1].Text;
            Session["CurrentField"] = sCurrentField;
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            TextBox txtValue = (TextBox)row.Cells[3].FindControl("txtValue");
            DropDownList cboValue = (DropDownList)row.Cells[3].FindControl("cboValue");
            CheckBoxList chkValue = (CheckBoxList)row.Cells[3].FindControl("chkValue");
            DropDownList cboOperator = (DropDownList)row.Cells[2].FindControl("cboOperator");
            TextBox txtCalFrom = (TextBox)row.Cells[3].FindControl("txtCalFrom");
            TextBox txtCalTo = (TextBox)row.Cells[3].FindControl("txtCalTo");
            CheckBox chkSingleValue = (CheckBox)row.Cells[3].FindControl("chkSingleValue");
            string sOperator = cboOperator.SelectedValue;
            string sDatatype = row.Cells[4].Text;

            if (cboValue.Visible)
                txtValue.Text = cboValue.SelectedValue;

            if (chkValue.Visible)
            {
                String sSelected = String.Join("','", chkValue.Items.OfType<ListItem>().Where(r => r.Selected).Select(r => r.Text));
                txtValue.Text = "('" + sSelected + "')";
            }

            switch (sDatatype)
            {
                case "datetime":
                case "date":
                if (sOperator == "BETWEEN")
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
                case "bigint":
                case "float":
                case "numeric":
                if (sOperator == "BETWEEN")
                {
                    if (txtCalFrom.Text.Length > 0 && txtCalTo.Text.Length > 0)
                        txtValue.Text = txtCalFrom.Text + "," + txtCalTo.Text;
                    else
                        txtValue.Text = "";
                }
                break;

                case "bit":
                    if (txtValue.Text != "NULL")
                        txtValue.Text = chkSingleValue.Checked == true ? "1" : "0";
                    else
                        txtValue.Text = "";
                break;
            }
            
            btnNew.Enabled = true;
            btnSubmit.Enabled = true;
            btnLoadSearch.Enabled = true;
            btnSaveSearch.Enabled = true;
            btnDeleteSearch.Enabled = true;
            cboSaveSearch.Enabled = true;
            //EnableDisableButtons(true);
        }

        protected void cboOperator_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cboOperator = (DropDownList)sender;
            GridViewRow row = (GridViewRow)cboOperator.NamingContainer;
            EnableControls(row, false);
        }

        public void GetFromClipboard(string sFieldId, string sDatatype)
        { // call javascript function
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "pasteContent('" + sFieldId + "','" + sDatatype + "'); ", true);
            //Page.ClientScript.RegisterStartupScript(Page.GetType(), "pasteContent", "pasteContent()", true);
        }

        protected void btnInSelect_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string sRow = row.RowIndex.ToString();
            string sDatatype = row.Cells[4].Text;
            GetFromClipboard("MainContent_dgdSearch_txtValue_" + sRow, sDatatype);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            btnNew.Enabled = false;
            btnSubmit.Enabled = false;
            btnLoadSearch.Enabled = false;
            btnSaveSearch.Enabled = false;
            btnDeleteSearch.Enabled = false;
            cboSaveSearch.Enabled = false;
        }

        public DataTable GetCboData(string sCurrentField)
        {
            string sSQL;
            sSQL = "exec('select null as TEXT union select distinct [" + sCurrentField + "] as TEXT from " + Session["View"] + " order by TEXT')";
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
            // controls
            DropDownList cboValue = (DropDownList)row.FindControl("cboValue");
            CheckBoxList chkValue = (CheckBoxList)row.FindControl("chkValue");
            TextBox txtValue = (TextBox)row.FindControl("txtValue");
            ImageButton btnInSelect = (ImageButton)row.FindControl("btnInSelect");
            ImageButton btnCalFrom = (ImageButton)row.FindControl("btnCalFrom");
            ImageButton btnCalTo = (ImageButton)row.FindControl("btnCalTo");
            Label lblFrom = (Label)row.FindControl("lblFrom");
            Label lblTo = (Label)row.FindControl("lblTo");
            TextBox txtCalFrom = (TextBox)row.FindControl("txtCalFrom");
            TextBox txtCalTo = (TextBox)row.FindControl("txtCalTo");
            CheckBox chkSingleValue = (CheckBox)row.FindControl("chkSingleValue");
            DropDownList cboControltype = (DropDownList)row.FindControl("cboControltype");
            ImageButton btnClearValue = (ImageButton)row.FindControl("btnClearValue");

            // hide all controls
            cboValue.Visible = false;
            cboValue.DataSource = null;
            chkValue.Visible = false;
            chkValue.DataSource = null;
            txtValue.Visible = false;
            btnInSelect.Visible = false;
            btnCalFrom.Visible = false;
            btnCalTo.Visible = false;
            lblFrom.Visible = false;
            lblTo.Visible = false;
            txtCalFrom.Visible = false;
            txtCalTo.Visible = false;

            // populate operators
            DropDownList cboOperator = (DropDownList)row.FindControl("cboOperator");
            string sDatatype = (string)row.Cells[4].Text;

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
                    case "datetime":
                        cboOperator.Items.Add(new ListItem("<"));
                        cboOperator.Items.Add(new ListItem(">"));
                        cboOperator.Items.Add(new ListItem("ZWISCHEN", "BETWEEN"));
                        cboOperator.Items.Add(new ListItem("IST LEER", "IS NULL"));
                        cboOperator.Items.Add(new ListItem("IST NICHT LEER", "IS NOT NULL"));
                        cboOperator.SelectedValue = sSelectedOperator;
                        
                        // calendar only
                        cboControltype.Items.Add(new ListItem("Calendar"));
                        break;

                    case "int":
                    case "bigint":
                    case "float":
                    case "numeric":
                        cboOperator.Items.Add(new ListItem("<"));
                        cboOperator.Items.Add(new ListItem(">"));
                        cboOperator.Items.Add(new ListItem("ZWISCHEN", "BETWEEN"));
                        cboOperator.Items.Add(new ListItem("ENTHÄLT", "LIKE"));
                        cboOperator.Items.Add(new ListItem("ENTHÄLT NICHT", "NOT LIKE"));
                        cboOperator.Items.Add(new ListItem("IN"));
                        cboOperator.Items.Add(new ListItem("IST LEER", "IS NULL"));
                        cboOperator.Items.Add(new ListItem("IST NICHT LEER", "IS NOT NULL"));
                        cboOperator.SelectedValue = sSelectedOperator;

                        // user can choose between TextBox and DropDown
                        cboControltype.Items.Add(new ListItem("TextBox"));
                        cboControltype.Items.Add(new ListItem("DropDownList"));
                        break;

                    case "nvarchar":
                    case "char":
                    case "varchar":
                        cboOperator.Items.Add(new ListItem("ENTHÄLT", "LIKE"));
                        cboOperator.Items.Add(new ListItem("ENTHÄLT NICHT", "NOT LIKE"));
                        cboOperator.Items.Add(new ListItem("IN"));
                        cboOperator.Items.Add(new ListItem("IST LEER", "IS NULL"));
                        cboOperator.Items.Add(new ListItem("IST NICHT LEER", "IS NOT NULL"));

                        if (cboOperator.SelectedValue == "<" ||
                            cboOperator.SelectedValue == ">" ||
                            cboOperator.SelectedValue == "<>" ||
                            cboOperator.SelectedValue == "BETWEEN")
                            cboOperator.SelectedValue = "=";
                        else
                            cboOperator.SelectedValue = sSelectedOperator;

                        // user can choose between TextBox and DropDown
                        cboControltype.Items.Add(new ListItem("TextBox"));
                        cboControltype.Items.Add(new ListItem("DropDownList"));
                        break;

                    case "bit":
                        cboOperator.Items.Add(new ListItem("IST LEER", "IS NULL"));
                        cboOperator.Items.Add(new ListItem("IST NICHT LEER", "IS NOT NULL"));
                        cboOperator.SelectedValue = sSelectedOperator;

                        // checkbox only
                        cboControltype.Items.Add(new ListItem("TextBox"));
                        break;
                }
                cboControltype.SelectedValue = sSelectedControlType;
            }

            // get cell values
            string sCurrentField = (string)row.Cells[1].Text;
            string sOperator = ((DropDownList)row.Cells[2].FindControl("cboOperator")).SelectedValue;
            //string sValue = (string)row.Cells[3].Text;
            string sControltype = ((DropDownList)row.Cells[3].FindControl("cboControltype")).SelectedValue;
            CalendarExtender calFrom = (CalendarExtender)row.Cells[2].FindControl("calFrom");
            CalendarExtender calTo = (CalendarExtender)row.Cells[2].FindControl("calTo");
            

            switch (sControltype)
            {
                case "DropDownList":
                    switch (sOperator)
                    {
                        case "IN":
                            //txtValue.Visible = true;
                            //btnInSelect.Visible = true;
                            chkValue.Visible = true;
                            chkValue.DataSource = GetCboData(sCurrentField);
                            chkValue.DataTextField = "TEXT";
                            chkValue.DataValueField = "TEXT";
                            chkValue.DataBind();
                            break;

                        case "LIKE":
                        case "NOT LIKE":
                            txtValue.Visible = true;
                            break;

                        case "IS NULL":
                            break;

                        case "IS NOT NULL":
                            break;
                        
                        default:
                            cboValue.Visible = true;
                            cboValue.DataSource = GetCboData(sCurrentField);
                            cboValue.DataTextField = "TEXT";
                            cboValue.DataValueField = "TEXT";
                            cboValue.DataBind();
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
                    else
                    {
                        switch (sOperator)
                        {
                            case "IN":
                                txtValue.Visible = true;
                                btnInSelect.Visible = true;
                                break;

                            case "BETWEEN":
                                calFrom.Enabled = false;
                                calTo.Enabled = false;
                                txtCalFrom.Visible = true;
                                txtCalTo.Visible = true;
                                lblFrom.Visible = true;
                                lblFrom.Text = "Von:";
                                lblTo.Visible = true;
                                txtCalTo.Visible = true;
                                break;

                            case "IS NULL":
                                break;

                            case "IS NOT NULL":
                                break;

                            default:
                                txtValue.Visible = true;
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
                        case "BETWEEN":
                            string sDate = txtValue.Text;
                            int nSplitPos = sDate.IndexOf(",");

                            if (txtValue.Text.Length > 15)
                                txtCalFrom.Text = sDate.Substring(1, nSplitPos-2);

                            if (txtValue.Text.Length > 25)
                                txtCalTo.Text = txtValue.Text.Substring(nSplitPos+3, sDate.Length-nSplitPos-4);

                            calTo.Enabled = true;
                            lblFrom.Text = "Von:";
                            lblTo.Visible = true;
                            btnCalTo.Visible = true;
                            txtCalTo.Visible = true;
                        break;

                        case "IS NULL":
                            break;

                        case "IS NOT NULL":
                            break;

                        default:
                        lblFrom.Text = "Datum:";
                        txtCalFrom.Text = txtValue.Text.Replace("'", "");
                        break;
                    }
                    break;
            }
            //DataRowView dr = e.Row.DataItem as DataRowView;
            //cboValue.SelectedValue = dr["YourCOLName"].ToString();
        }

        // called after hitting the "Edit" button
        protected void dgdSearch_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    EnableControls(e.Row, true);
                }
            }
            else            
            {
                HashSet<string> DateCols = new HashSet<string>();
                HashSet<string> DateTimeCols = new HashSet<string>();
                foreach (GridViewRow row in dgdSearch.Rows)
                {
                    string sDatatype = row.Cells[4].Text;
                    string sColumnName = row.Cells[1].Text;

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
                   "(ID, Attribut, Operator, Wert, Datatype, UserId, Controltype, ValueCnt, ViewName, SearchName)" +
                   " select ID, Attribut, Operator, Wert, Datatype, UserId, Controltype, ValueCnt, '" + (String)Session["View"] + "', '" + sSearchName + "'" +
                   " from " + Session["FormTable"] + " where UserId='" + (String)Session["UserName"] + "'";

            SQLexecute(Server.HtmlDecode(sSQL));
        }

        private void DeleteSearch(string sSearchName)
        {

            string sSQL = "delete from V_Save_Search where SearchName = '" + sSearchName + "'" +
                                                   " and UserId = '" + (String)Session["UserName"] + "'" +
                                                   " and ViewName = '" + (String)Session["View"] + "'";
            SQLexecute(sSQL);
        }

        private void LoadSearch(string sSearchName)
        {
            // clear previous search
            string sSQL = "delete from [" + Session["FormTable"] + "] where UserId = '" + (String)Session["UserName"] + "'";
            SQLexecute(sSQL);

            // save new search
            sSQL = "insert into [" + Session["FormTable"] + "] " +
                   "(Attribut, Operator, Wert, Datatype, UserId, Controltype, ValueCnt)" +
                   " select Attribut, Operator, Wert, Datatype, UserId, Controltype, ValueCnt" +
                   " from V_Save_Search where UserId='" + (String)Session["UserName"] + "' and ViewName = '" + Session["View"] + "' and SearchName = '" + sSearchName + "'";
            //ShowMsg(Server.HtmlDecode(sSQL));
            SQLexecute(Server.HtmlDecode(sSQL));
            dgdSearch.DataBind();
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
                //chkRecursive.Checked = true;
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
        }

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
    }
}