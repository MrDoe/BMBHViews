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

namespace BMBH_View
{
    public partial class NCT_TBB_Search : System.Web.UI.Page
    {
        // constant definitions
        const string sView = "V_NCT_TBB_Gesamt";
        const string sFormTable = "Views_TBB_Search";
        const string sFormView = "V_NCT_TBB_SearchForm";
        const string sCurrentPage = "NCT-TBB-Search.aspx";
        const string sParentPage = "NCT-TBB.aspx";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session["UserName"] = Page.User.Identity.Name;
                Session["LastQuery"] = null;
                CreateTempTable();
            }
            else
            {

            }
        }

        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        private void CreateTempTable()
        {
            String strConnString = ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(strConnString);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            string sUser = (string)Session["UserName"];
            cmd.Parameters.Add("@UserId", SqlDbType.NVarChar).Value = sUser;
            cmd.CommandText = "delete from " + sFormTable + " where UserId = '" + sUser + "'"
                            + " insert into " + sFormTable
                            + " select Attribut, Operator, '', Datentyp, '" + sUser + "' from " + sFormView;
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
            CreateTempTable();
            dgdSearch.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string sSelect = "select * ";
            string sFrom = " from " + sView;
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
                            sWhere += sAttribute + " IN " + sValue;
                            break;

                        case "LIKE":
                            sWhere += sAttribute + " LIKE '%" + sValue + "%'";
                            break;

                        default:
                            switch (sDatatype)
                            {
                                case "int":
                                case "decimal":
                                    sWhere += sAttribute + sOperator + sValue;
                                    break;

                                default:
                                    sWhere += sAttribute + sOperator + "'" + sValue + "'";
                                    break;
                            }
                            break;
                    }
                }
            }

            sWhere += " order by InventarID";

            string sSQL = sSelect + sFrom + sWhere;

            //ShowMsg(Server.HtmlDecode(sSQL).ToString());

            Session["LastQuery"] = Server.HtmlDecode(sSQL);
            Server.Transfer(sParentPage, true);
        }

        public bool SetVisibility(string sDatatype, string sOperator, string sType)
        {
            switch(sType)
            {
                case "TXT":
                    switch (sDatatype)
                    {
                        case "char":
                        case "varchar":
                        case "nvarchar":
                            return false;

                        case "int":
                        case "datetime":
                            return true;
                    }
                break;

                case "CBO":
                    if (sOperator == "IN")
                        return false;
                    else
                    {
                        switch (sDatatype)
                        {
                            case "char":
                            case "varchar":
                            case "nvarchar":
                                return true;

                            case "int":
                            case "datetime":
                                return false;
                        }
                    }
                break;

                case "IMG":
                    if (sOperator == "IN")
                        return true;
                    else
                        return false;
                //break;

                case "CAL":
                    switch (sDatatype)
                    {
                        case "datetime":
                        case "date":
                            return true;
                        default:
                            return false;
                    }
                //break;
            }    
            return true;
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
            TextBox txtValue = ((TextBox)(row.Cells[3].FindControl("txtValue")));
            DropDownList cboValue = (DropDownList)(row.Cells[3].FindControl("cboValue"));

            if (cboValue.Visible)
                txtValue.Text = cboValue.SelectedValue;
        }

        protected void cboOperator_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList cboOperator = (DropDownList)sender;
            GridViewRow row = (GridViewRow)cboOperator.NamingContainer;
            DropDownList cboValue = (DropDownList)(row.Cells[3].FindControl("cboValue"));
            TextBox txtValue = ((TextBox)(row.Cells[3].FindControl("txtValue")));
            ImageButton btnInSelect = (ImageButton)(row.Cells[3].FindControl("btnInSelect"));
            string sDatatype = row.Cells[4].Text;

            cboValue.Visible = false;
            btnInSelect.Visible = false;
            txtValue.Visible = false;

            switch (sDatatype) // set visibilities according to data type
            {
                case "nvarchar":
                case "char":
                case "varchar":
                    if (cboOperator.SelectedValue == "LIKE" || cboOperator.SelectedValue == "IN")
                    {
                        txtValue.Visible = true;
                        txtValue.Text = cboValue.SelectedValue;
                        txtValue.Width = cboValue.Width;

                        if (cboOperator.SelectedValue == "IN")   
                            btnInSelect.Visible = true;
                    }
                    else
                    {
                        cboValue.Visible = true;
                    }
                    break;

                case "int":
                case "decimal":
                    txtValue.Visible = true;

                    if (cboOperator.SelectedValue == "IN")
                        btnInSelect.Visible = true;
                    break;
            }
        }

        public void GetFromClipboard(string sFieldId, string sDatatype)
        {
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "pasteContent('" + sFieldId + "','" + sDatatype + "')", true);
            //Page.ClientScript.RegisterStartupScript(Page.GetType(), "pasteContent", "pasteContent()", true);
        }

        protected void btnInSelect_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string sRow = row.RowIndex.ToString();
            string sDatatype = row.Cells[4].Text;
            GetFromClipboard("MainContent_dgdSearch_txtValue_" + sRow, sDatatype);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
        }

        protected void calFrom_SelectionChanged(object sender, EventArgs e)
        {
            Calendar calFrom = (Calendar)sender;
            GridViewRow row = (GridViewRow)calFrom.NamingContainer;
            TextBox txtValue = ((TextBox)(row.Cells[3].FindControl("txtValue")));
            txtValue.Text = calFrom.SelectedDate.ToString();
        }

        //private void gridControlInsert_KeyPress(object sender, KeyPressEventArgs e)
        //{
        //    if (Convert.ToInt32(e.KeyChar) == 22)
        //    {
        //        ////Catch CTRL + V (Paste)
        //        PasteData(Clipboard.GetText());
        //        e.Handle = true;
        //    }
        //}

        //private void PasteData(string pClipboard)
        //{
        //    List<List<string>> table = new List<List<string>>();

        //    string importText = pClipboard;

        //    importText = importText.Replace("\n", "");

        //    string[] lines = importText.Split('\r');
        //    for (int x = 0; x < lines.Length; x++)
        //    {
        //        if (string.IsNullOrEmpty(lines[x]))
        //        {
        //            break;
        //        }

        //        List<string> cellsList = new List<string>();
        //        string[] cells = lines[x].Split('\t');

        //        cellsList.AddRange(cells);

        //        table.Add(cellsList);
        //    }
        //    try
        //    {
        //        gridControlInsert.BeginUpdate();

        //        DataView dataView = (DataView)gridViewInsertMas.DataSource;

        //        for (int x = 0; x < table.Count; x++)
        //        {
        //            DataRow row = dataView.Table.NewRow();
        //            for (int y = 0; y < table[x].Count; y++)
        //            {
        //                row[y] = table[x][y];

        //            }
        //            dataView.Table.Rows.Add(row);
        //        }
        //        //string s = dataView.Table.Rows[0].ItemArray[0].ToString();
        //        //XtraMessageBox.Show(s,"Check",MessageBoxButtons.OK);  The messagebox shows well 

        //        gridControlInsertMas.DataSource = dataView;

        //    }
    }
}