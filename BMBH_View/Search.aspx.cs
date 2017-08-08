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
            dsSearch.SelectCommand = "SELECT * FROM [" + Session["FormTable"] + "] WHERE ([UserId] = '" + (String)Session["UserName"] + "')";
            dsSearch.UpdateCommand = "UPDATE [" + Session["FormTable"] + "] SET [Operator] = @Operator, [Wert] = @Wert, [Controltype] = @Controltype WHERE [ID] = @ID";
            dsSearch.InsertCommand = "INSERT INTO [" + Session["FormTable"] + "] ([Attribut], [Operator], [Wert], [Datatype], [UserId]) VALUES (@Attribut, @Operator, @Wert, @Datatype, @UserId)";
            dsSearch.DeleteCommand = "DELETE FROM [" + Session["FormTable"] + "] WHERE [ID] = @ID";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session["UserName"] = Page.User.Identity.Name;
                Session["JumpedBack"] = false;

                //if (Session["LastQuery"] == null)
                ClearTempTable();

                Session["LastQuery"] = null;

                if (Session["Recursive"] != null)
                {
                    if(Session["Recursive"].ToString() == "False")
                        chkRecursive.Checked = false;

                    if (Session["Recursive"].ToString() == "True")
                    {
                        chkRecursive.Checked = true;
                        pnlSQLhistory.Visible = true;

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
        }

        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        private void ClearTempTable()
        {
            String sConnString = ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString;
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
            String sConnString = ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString;
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
                      .Replace("%", "*")
                      .Replace("<", " < ")
                      .Replace(">", " > ")
                      .Replace("BETWEEN", "ZWISCHEN");
            int nLastIndex = SQL.IndexOf("union") > 0 ? SQL.IndexOf("union")-1 : SQL.Length;
            SQL = SQL.Substring(0, nLastIndex);
            return SQL;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string sSelect = "select v.* ";
            string sFrom = " from [" + Session["View"] + "] v ";
            bool bRecursive = false;
            bool bAdditive = false;
            int nLastIteration = Session["Iteration"] == null? 0 : (int)(Session["Iteration"]) - 1;

            if (Session["Recursive"] != null)
                bRecursive = (Session["Recursive"].ToString() == "True");

            if (Session["Additive"] != null)
                bAdditive = (Session["Additive"].ToString() == "True");

            if (bRecursive) // recursive search
                if (nLastIteration > 0)
                    sFrom += " inner join V_Recursive_Temp t on v.ID=t.ID and t.GUID='" + Session["GUID"] + "' and t.ITERATION=" + nLastIteration.ToString();

            string sWhere = "";
            bool bIsFirst = true;

            foreach (GridViewRow row in dgdSearch.Rows)
            {
                string sAttribute = row.Cells[1].Text;
                string sValue = ((Label)row.Cells[3].FindControl("Label2")).Text;
                string sDatatype = row.Cells[4].Text;

                // get value from drop down list
                Label lb = (Label)row.Cells[2].FindControl("Label1");
                string sOperator = lb.Text;

                if (sValue != "")
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

                        default:
                            switch (sDatatype)
                            {
                                case "int":
                                case "bigint":
                                case "float":
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
                                        string sDate1 = sValue.Substring(0, nSeperator - 2);
                                        string sDate2 = sValue.Substring(nSeperator + 2, sValue.Length - nSeperator - 1);
                                        sValue = sDate1 + " AND " + sDate2;
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

            if ((bRecursive || bAdditive) && (bool)Session["JumpedBack"] == false) // save result to temporary table
            {
                string sInsert = "insert into V_Recursive_Temp (ID, GUID, ITERATION, SEARCHMODE) ";
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

                SQLexecute(sSQL2);
                SQLexecute("insert into V_Recursive_Log (GUID, Iteration, SQL) values ('" + Session["GUID"] + "'," + Session["Iteration"] + ",'" + EscapeSQL(sWhere) + "'),'" + sMode + "'");
                //txtHistory.Text = sSQL2;
                //ShowMsg(sSQL);
                Session["Iteration"] = (int)Session["Iteration"] + 1;
            }

            sSQL += " order by v.ID";
            //ShowMsg(sSQL);

            Session["LastQuery"] = sSQL;
            Response.Redirect(sParentPage, true);
        }

        private DataSet GetData(string query)
        {
            string conString = ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString;
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
                if (sOperator == "BETWEEN")
                {
                    if (txtCalFrom.Text.Length > 0 && txtCalTo.Text.Length > 0)
                        txtValue.Text = txtCalFrom.Text + "," + txtCalTo.Text;
                    else
                        txtValue.Text = "";
                }
                break;
            }
            
            btnNew.Enabled = true;
            btnSubmit.Enabled = true;
        }

        protected void cboOperator_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cboOperator = (DropDownList)sender;
            GridViewRow row = (GridViewRow)cboOperator.NamingContainer;
            EnableControls(row);
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
        }

        public DataTable GetCboData(string sCurrentField)
        {
            string sSQL;
            sSQL = "exec('select null as TEXT union select distinct [" + sCurrentField + "] as TEXT from " + Session["View"] + " order by TEXT')";
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString))
            using (var cmd = new SqlCommand(sSQL, conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                var dt = new DataTable();
                adapter.Fill(dt);
                conn.Close();
                return dt;
            }
        }

        public void EnableControls(GridViewRow row)
        {
            // controls
            DropDownList cboValue = (DropDownList)row.FindControl("cboValue");
            CheckBoxList chkValue = (CheckBoxList)row.FindControl("chkValue");
            TextBox txtValue = (TextBox)(row.FindControl("txtValue"));
            ImageButton btnInSelect = (ImageButton)(row.FindControl("btnInSelect"));
            ImageButton btnCalFrom = (ImageButton)(row.FindControl("btnCalFrom"));
            ImageButton btnCalTo = (ImageButton)(row.FindControl("btnCalTo"));
            Label lblFrom = (Label)(row.FindControl("lblFrom"));
            Label lblTo = (Label)(row.FindControl("lblTo"));
            TextBox txtCalFrom = (TextBox)(row.FindControl("txtCalFrom"));
            TextBox txtCalTo = (TextBox)(row.FindControl("txtCalTo"));

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

            // get cell values
            string sCurrentField = (string)row.Cells[1].Text;
            //string sOperator = (string)row.Cells[2].Text;
            string sOperator = ((DropDownList)row.Cells[2].FindControl("cboOperator")).SelectedValue;
            string sValue = (string)row.Cells[3].Text;
            string sDatatype = (string)row.Cells[4].Text;
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
                            txtValue.Visible = true;
                            break;

                        default:
                            cboValue.Visible = true;
                            cboValue.DataSource = GetCboData(sCurrentField);
                            cboValue.DataTextField = "TEXT";
                            cboValue.DataValueField = "TEXT";
                            cboValue.DataBind();
                            cboValue.SelectedValue = sValue;
                            break;
                    }
                    break;

                case "TextBox":
                    if (sOperator == "IN")
                    {
                        txtValue.Visible = true;
                        btnInSelect.Visible = true;
                    }
                    else if (sOperator == "BETWEEN")
                    {
                        calFrom.Enabled = false;
                        calTo.Enabled = false;
                        txtCalFrom.Visible = true;
                        txtCalTo.Visible = true;
                        lblFrom.Visible = true;
                        lblFrom.Text = "Von:";
                        lblTo.Visible = true;
                        txtCalTo.Visible = true;
                    }
                    else
                        txtValue.Visible = true;
                    break;

                case "Calendar":
                    btnCalFrom.Visible = true;
                    txtCalFrom.Visible = true;
                    lblFrom.Visible = true;
                    calFrom.Enabled = true;

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

                    if (txtValue.Text.Length > 0)
                        txtCalFrom.Text = txtValue.Text.Substring(1, 16);

                    if (sOperator == "BETWEEN")
                    {
                        if (txtValue.Text.Length == 38)
                            txtCalTo.Text = txtValue.Text.Substring(21, 16);

                        calTo.Enabled = true;
                        lblFrom.Text = "Von:";
                        lblTo.Visible = true;
                        btnCalTo.Visible = true;
                        txtCalTo.Visible = true;
                    }
                    else
                        lblFrom.Text = "Datum:";
                    break;
            }
            //DataRowView dr = e.Row.DataItem as DataRowView;
            //cboValue.SelectedValue = dr["YourCOLName"].ToString();
        }

        // called after hitting the "Edit" button
        protected void dgdSearch_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                    EnableControls(e.Row);
        }

        protected void cboControltype_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cboOperator = (DropDownList)sender;
            GridViewRow row = (GridViewRow)cboOperator.NamingContainer;
            EnableControls(row);
        }
        
        protected void chkAdditive_CheckedChanged(object sender, EventArgs e)
        {
            bool bChecked = ((CheckBox)sender).Checked;
            Session["Additive"] = bChecked;

            if (bChecked)
            {
                chkRecursive.Checked = false;
                Session["Recursive"] = false;

                if (Session["GUID"] == null)
                {
                    Session["GUID"] = Guid.NewGuid().ToString();
                    Session["Iteration"] = 1;
                }
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

                if (Session["GUID"] == null)
                {
                    Session["GUID"] = Guid.NewGuid().ToString();
                    Session["Iteration"] = 1;
                }
            }

            btnSubmit.Focus();
        }

        private void SaveSearch(string sSearchName)
        {
            // clear previous search
            string sSQL = "delete from V_Save_Search where SearchName = '" + sSearchName + "'";
            SQLexecute(sSQL);

            // save new search
            sSQL = "insert into V_Save_Search " +
                   "(ID, Attribut, Operator, Wert, Datatype, UserId, Controltype, ValueCnt, ViewName, SearchName)" +
                   " select ID, Attribut, Operator, Wert, Datatype, UserId, Controltype, ValueCnt, '" + Session["View"] + "', '" + sSearchName + "'" +
                   " from " + Session["FormTable"] + " where UserId='" + (String)Session["UserName"] + "'";
            //ShowMsg(Server.HtmlDecode(sSQL));
            SQLexecute(Server.HtmlDecode(sSQL));
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
            LoadSearch(cboSaveSearch.SelectedValue);
            btnSubmit.Focus();
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
                SQLexecute("delete from V_Recursive_Log where GUID = '" + Session["GUID"] + "' and Iteration > " + sIterationSelected);
                dgdHistory.DataBind();
            }
        }
    }
}