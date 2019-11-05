using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Web.UI;
using OfficeOpenXml;
using System.IO;
using System.Drawing;
using System.Text.RegularExpressions;

namespace BMBH_View
{
    public partial class MultipleSearch : System.Web.UI.Page
    {


        

        private string SetDataSource()
        {

           
            //Session["EditMode"] = true;
            if ((bool)Session["EditMode"] == true)
            {

                 return "SELECT * FROM [PatientSearch] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
            }
            else
            {
                string sBiobank = Session["OE"].ToString();
               

                if ((int)Session["SearchMode"] == 0) // Name, Vorname, Geburtsdatum
                {
                    if (sBiobank == "NCT-Gewebebank")
                        return "SELECT * FROM [V_PatientSearch_NVG] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                    else
                        return "SELECT * FROM [V_PatientSearch_NVG_PSD] WHERE [GUID] = '" + (string)Session["GUID"] +"' AND Biobank = '" + sBiobank + "'";
                    //return "SELECT p.ID, p.Name, p.Vorname, p.Geburtsdatum, m.UKH_PID AS ISH_PID, m.UKH_FID AS ISH_FID, m.BMBH_PID, p.Histo_Nr FROM [PatientSearch] as p LEFT JOIN [V_Patienten_MedV] as m ON p.Vorname = m.Vorname AND p.Geburtsdatum = m.Geburtsdatum AND p.Name = m.Name WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                }
                if ((int)Session["SearchMode"] == 1) // ISH_PID
                {
                    if (sBiobank == "NCT-Gewebebank")
                        return "SELECT * FROM [V_PatientSearch_IP] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                    else
                        return "SELECT * FROM [V_PatientSearch_IP_PSD] WHERE [GUID] = '" + (string)Session["GUID"] +"' AND Biobank = '" + sBiobank + "'";
                    //return "SELECT p.ID, m.Name, m.Vorname, m.Geburtsdatum, m.UKH_PID AS ISH_PID, m.UKH_FID AS ISH_FID, m.BMBH_PID, p.Histo_Nr FROM [PatientSearch] as p INNER JOIN [V_Patienten_MedV] as m ON  p.ISH_PID = m.UKH_PID WHERE [GUID] = '" + (string)Session["GUID"] + "'";
        
                }
                if ((int)Session["SearchMode"] == 2) // ISH_FID
                {
                    if (sBiobank == "NCT-Gewebebank")
                        return "SELECT * FROM [V_PatientSearch_IF] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                    else
                         return "SELECT * FROM [V_PatientSearch_IF_PSD] WHERE [GUID] = '" + (string)Session["GUID"] +"' AND Biobank = '" + sBiobank + "'";
                        //return "SELECT p.ID, m.Name, m.Vorname, m.Geburtsdatum, m.UKH_PID AS ISH_PID, m.UKH_FID AS ISH_FID, m.BMBH_PID, p.Histo_Nr FROM [PatientSearch] as p INNER JOIN [V_Patienten_MedV] as m ON  p.ISH_FID = m.UKH_FID WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                }
                if ((int)Session["SearchMode"] == 3) // BMBH_PID
                {    
                    
                    if (sBiobank == "NCT-Gewebebank")
                        return "SELECT * FROM [V_PatientSearch_BP] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                    else
                        return "SELECT * FROM [V_PatientSearch_BP_PSD] WHERE [GUID] = '" + (string)Session["GUID"] +"' AND Biobank = '" + sBiobank + "'";
                        //return "SELECT p.ID, m.Name, m.Vorname, m.Geburtsdatum, m.UKH_PID AS ISH_PID, m.UKH_FID AS ISH_FID, m.BMBH_PID, p.Histo_Nr FROM [PatientSearch] as p INNER JOIN [V_Patienten_MedV] as m ON p.BMBH_PID = m.BMBH_PID WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                }
                if ((int)Session["SearchMode"] == 5) // Histo_Nr
                {
                    return "SELECT * FROM [V_PatientSearch_HN] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                }
                return null;
            }
        }

        private int SQLexecute(string sSQL)
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
                return Convert.ToInt32(cmd.ExecuteScalar());
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
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }

        protected void btnClos_Click(object sender, System.EventArgs e)
        {
            MPE.Hide();
        }

        protected void GeneratePseudonym(object sender, System.EventArgs e)
        {
            Button btn = (Button)sender;

            GridViewRow gvr2 = (GridViewRow)btn.NamingContainer;

            Label lN = (Label)gvr2.FindControl("lblpLNameVal");
            string lNValue = lN.Text;

            Label sN = (Label)gvr2.FindControl("lblpSNameVal");
            string sNValue = sN.Text;

            Label gebD = (Label)gvr2.FindControl("lblPGebVal");
            string gebDValue = gebD.Text;

            Label psd = (Label)gvr2.FindControl("lblSBMBHVal");
            string pseudo = psd.Text;

            DropDownList txtSex = (DropDownList)gvr2.Cells[0].FindControl("ddPSexVal");
            string sex = txtSex.SelectedValue;

            TextBox txtPID = (TextBox)gvr2.Cells[0].FindControl("txtPPIDVal");
            string PID = txtPID.Text;

            GridViewRow gvr = dgdPatients.Rows[(int)Session["RowIndex"]];
            gvr.FindControl("btnPseudo").Visible = false;
            if (!String.Equals(pseudo, "?"))
            {

                Label name = (Label)gvr.FindControl("lblNameVal");
                name.Text = lNValue;

                Label surname = (Label)gvr.FindControl("lblPrenameVal");
                surname.Text = sNValue;

                Label bir = (Label)gvr.FindControl("lblBirthdateVal");
                bir.Text = gebDValue;

                Label lbBMBH = (Label)gvr.FindControl("lblBMBHPIDVal");
                lbBMBH.Text = pseudo;

                MPE.Hide();

            }
            else
            {
                Regex regex = new Regex(@"^\d*$");
                Match m = regex.Match(PID);

                if (m.Success || String.IsNullOrEmpty(PID))
                {

                    using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
                    using (var cmd = new SqlCommand("GetPseudonym", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 50).Value = lNValue;
                        cmd.Parameters.Add("@Vorname", SqlDbType.NVarChar, 50).Value = sNValue;
                        cmd.Parameters.Add("@GebDatum", SqlDbType.NVarChar, 10).Value = gebDValue;
                        cmd.Parameters.Add("@Geschl", SqlDbType.VarChar, 3).Value = sex;
                        cmd.Parameters.Add("@PID", SqlDbType.VarChar, 10).Value = PID;
                        cmd.Parameters.Add("@Pseudonym", SqlDbType.VarChar, 8).Direction = ParameterDirection.Output;

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        if (cmd.Parameters["@Pseudonym"].Value != System.DBNull.Value)
                        {
                            string retunvalue = (string)cmd.Parameters["@Pseudonym"].Value;

                            Label lbBMBH = (Label)gvr.FindControl("lblBMBHPIDVal");
                            lbBMBH.Text = retunvalue;

                            System.Diagnostics.Debug.Write(retunvalue);
                            MPE.Hide();

                        }

                        conn.Close();
                    }
                }
                else
                {
                    lblError.Visible = true;
                }    
            }
        }


        private void changeVisibilityGrid(GridViewRow row, bool edit)
        {
           
               
            ((Label)row.FindControl("lblNameVal")).Visible = !edit;
            ((TextBox)row.FindControl("txtNameVal")).Visible = edit;

            ((Label)row.FindControl("lblPrenameVal")).Visible = !edit;
            ((TextBox)row.FindControl("txtPrenameVal")).Visible = edit;

            ((Label)row.FindControl("lblBirthdateVal")).Visible = !edit;
            ((TextBox)row.FindControl("txtBirthdateVal")).Visible = edit;

            ((Label)row.FindControl("lblISHPIDVal")).Visible = !edit;
            ((TextBox)row.FindControl("txtISHPIDVal")).Visible = edit;

            ((Label)row.FindControl("lblISHFIDVal")).Visible = !edit;
            ((TextBox)row.FindControl("txtISHFIDVal")).Visible = edit;

            ((Label)row.FindControl("lblBMBHPIDVal")).Visible = !edit;
            ((TextBox)row.FindControl("txtBMBHPIDVal")).Visible = edit;

            ((Label)row.FindControl("lblHistoNrVal")).Visible = !edit;
            ((TextBox)row.FindControl("txtHistoNrVal")).Visible = edit;


        }


            protected void ShowSimilarPatients(object sender, System.EventArgs e)
        {
            Button btn = (Button)sender;

            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["RowIndex"] = gvr.RowIndex;

            Label name = (Label)gvr.Cells[0].FindControl("lblNameVal");
            string lNameVal = name.Text;

            Label surname = (Label)gvr.Cells[0].FindControl("lblPrenameVal");
            string sNameVal = surname.Text;

            Label bir = (Label)gvr.Cells[0].FindControl("lblBirthdateVal");
            string birVal = bir.Text;
           
            var dt = new DataTable();
            dt.Columns.Add("name");
            dt.Columns.Add("vorname");
            dt.Columns.Add("geb");
            dt.Columns.Add("geschlecht");
            dt.Columns.Add("PID");
            dt.Columns.Add("BMBH_PID");


            DataRow t = dt.NewRow();
            t["name"] = lNameVal;
            t["vorname"] = sNameVal;
            t["geb"] = birVal;
            t["geschlecht"] = "m";
            t["PID"] = "";
            t["BMBH_PID"] = "?";
            dt.Rows.Add(t);

            
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            using (var cmd = new SqlCommand("ReturnSimilarPatients", conn))
            using (var adapter = new SqlDataAdapter(cmd))
        
            {
                
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 255).Value = lNameVal;
                cmd.Parameters.Add("@Vorname", SqlDbType.NVarChar, 255).Value = sNameVal;
                cmd.Parameters.Add("@GebDatum", SqlDbType.VarChar, 10).Value = birVal;

                adapter.Fill(dt);
                dgdSimPatients.DataSource = dt;
                dgdSimPatients.DataBind();

            }

            MPE.Show();

        }


        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack) 
            {
                if (Session["init"] == null) // first page load
                {
                    //Timer1.Enabled = true;
                    Initialize();
                    Session["init"] = true;
                }

               if (Session["MainTable"] == null)
                    dgdPatients.DataSource = GetData();
                else
                    dgdPatients.DataSource = Session["MainTable"] as DataTable;
                dgdPatients.DataBind();
            }

            // handle header button clicks (from javascript)
            string sEventArg = this.Request["__EVENTARGUMENT"];
            if (sEventArg != null && sEventArg.Length > 0)
            {
                HandleHeaderButtons(sEventArg);
            }
        }

        public DataTable GetData()
        {
            string sSQL = SetDataSource();
            using (var conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            using (var cmd = new SqlCommand(sSQL, conn))
            using (var adapter = new SqlDataAdapter(cmd))
            {
                cmd.CommandTimeout = 900;
                var dt = new DataTable();
                adapter.Fill(dt);
                Session["MainTable"] = dt;
                return dt;
            }
        }

        protected void TimerTick(object sender, EventArgs e)
        {
            this.Initialize();
            Timer1.Enabled = false;
        }

        protected void HandleHeaderButtons(string sEventArg)
        {
            switch (sEventArg)
            {
                case "Name":
                case "Vorname":
                case "Geburtsdatum":
                    Session["SearchMode"] = 0;
                    break;

                case "ISH_PID":
                    Session["SearchMode"] = 1;
                    break;

                case "ISH_FID":
                    Session["SearchMode"] = 2;
                    break;

                case "BMBH_PID":
                    Session["SearchMode"] = 3;
                    break;

                case "Histo_Nr":
                    Session["SearchMode"] = 5;
                    break;
            }

            string sValues = HiddenInputBox.Value;
            string[] aValues = sValues.Split(new string[] { "," }, StringSplitOptions.None);
            int nLength = aValues.Length;
            int[] aIDs = new int[nLength];

            for (var i = 0; i < nLength; ++i)
            {

                
                if (sEventArg == "Geburtsdatum")
                {
                    string geb = aValues[i];
                    
                    DateTime temp;
                    if (DateTime.TryParse(geb, out temp))
                    {
                        string newFormat = temp.ToString("yyyy-MM-dd");
                        aValues[i] = newFormat;
                    }
                    else
                    {
                        ShowMsg("Bitte das Datum im Format dd.MM.yyyy angeben");
                        return;
                    }
                }

                if (sEventArg == "Name" || sEventArg == "Vorname")
                {
                    string name = aValues[i];
                    aValues[i] = replaceUmlaute(name);

                }


            }


            if (Session["InitialInsert"] == null) // first column inserted
            {
                if (Session["GUID"] == null)
                    Session["GUID"] = Guid.NewGuid().ToString();
                else
                    SQLexecute("delete from PatientSearch where GUID = '" + Session["GUID"] + "'");

                for (var i = 0; i < nLength; ++i)
                {

                    var nID = SQLexecute("insert into PatientSearch (" + sEventArg + ", GUID) VALUES ('" + aValues[i] + "', '" + Session["GUID"] + "');" +
                                            "select scope_identity();");
                    aIDs[i] = nID;
                }
                Session["IDs"] = aIDs;
                Session["InitialInsert"] = true;

                //if ((int)Session["SearchMode"] != 0)
                    //Session["EditMode"] = false;
            }
            else // do update on existing columns
            {
                int[] aID = Session["IDs"] as int[];
                for (var i = 0; i < nLength; ++i)
                    SQLexecute("update PatientSearch set " + sEventArg + "='" + aValues[i] + "' where ID = " + aID[i].ToString());
            }

            // update gridview 
            BindData();
        }

        protected void Initialize()
        {
           
            if (Session["GUID"] == null)
                Session["GUID"] = Guid.NewGuid().ToString();
            else
            {
                // delete all entries and insert dummy data row
                SQLexecute("delete from PatientSearch where GUID = '" + Session["GUID"] + "'");
                SQLexecute("insert into PatientSearch (Name, GUID) VALUES ('','" + Session["GUID"] + "')");
            }

            Session["RowIndex"] = 0;
            Session["InitialInsert"] = null;
            Session["EditMode"] = true;
            Session["SearchMode"] = 4; // show all buttons

            BindData();

            dgdPatients.Columns[10].Visible = false;
            if (Session["OE"].ToString() != "NCT-Gewebebank")
            {
                dgdPatients.Columns[8].Visible = false;
                dgdPatients.Columns[9].Visible = false;
            }
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            Initialize();
            btnSearch.Visible = true;
            btnExcel.Visible = false;

        }

        protected void nameChanged(object sender, EventArgs e)
        {
            TextBox btn = (TextBox)sender;
            string id = btn.ID;
            GridViewRow gvr2 = (GridViewRow)btn.NamingContainer;

            setSessionMode(btn, id, gvr2);
        }

        private void setSessionMode (TextBox tBox,string id, GridViewRow gvr2)
        {

            bool show = String.IsNullOrEmpty(tBox.Text);
            switch (id)
            {
                case "txtNameVal":
                case "txtPrenameVal":
                case "txtBirthdateVal":
                    string lName = ((TextBox)gvr2.FindControl("txtNameVal")).Text ;
                    string pName = ((TextBox)gvr2.FindControl("txtPrenameVal")).Text;
                    string bir = ((TextBox)gvr2.FindControl("txtBirthdateVal")).Text;

                    show = String.IsNullOrEmpty(lName) && String.IsNullOrEmpty(pName) && String.IsNullOrEmpty(bir);
                    Session["SearchMode"] = show ? 4 : 0;

                    ((TextBox)gvr2.FindControl("txtISHPIDVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtISHFIDVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtBMBHPIDVal")).Visible = show;

                   
                    break;

                case "txtISHPIDVal":

                    
                    Session["SearchMode"] = show ? 4 : 1;

                    ((TextBox)gvr2.FindControl("txtNameVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtPrenameVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtBirthdateVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtISHFIDVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtBMBHPIDVal")).Visible = show;
                    
                    break;

                case "txtISHFIDVal":
                    ((TextBox)gvr2.FindControl("txtNameVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtPrenameVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtBirthdateVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtISHPIDVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtBMBHPIDVal")).Visible = show;
                    Session["SearchMode"] = show ? 4 : 2;
                    break;

                case "txtBMBHPIDVal":
                    ((TextBox)gvr2.FindControl("txtNameVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtPrenameVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtBirthdateVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtISHPIDVal")).Visible = show;
                    ((TextBox)gvr2.FindControl("txtISHFIDVal")).Visible = show;
                    Session["SearchMode"] = show ? 4 : 3;
                    break;

                case "txtHistoNrVal":
                    Session["SearchMode"] = show ? 4 : 5;
                    break;
            }
           
        }

        private string replaceUmlaute(string inputString)
        {
            inputString = inputString.Replace("ä", "ae");
            inputString = inputString.Replace("Ä", "Ae");
            inputString = inputString.Replace("ö", "oe");
            inputString = inputString.Replace("Ö", "Oe");
            inputString = inputString.Replace("ü", "ue");
            inputString = inputString.Replace("Ü", "Ue");
            inputString = inputString.Replace("ß", "ss");
            return inputString;
        }

        private bool saveInput()
        {

            if (Session["GUID"] == null)
                Session["GUID"] = Guid.NewGuid().ToString();
            else
                SQLexecute("delete from PatientSearch where GUID = '" + Session["GUID"] + "'");

            GridViewRow gvr = dgdPatients.Rows[0];

            string lName = ((TextBox)gvr.FindControl("txtNameVal")).Text;
            string pName = ((TextBox)gvr.FindControl("txtPrenameVal")).Text;
            string geb = ((TextBox)gvr.FindControl("txtBirthdateVal")).Text;
            string ISHPID = ((TextBox)gvr.FindControl("txtISHPIDVal")).Text;
            string ISHFID = ((TextBox)gvr.FindControl("txtISHFIDVal")).Text;
            string BMBHPID = ((TextBox)gvr.FindControl("txtBMBHPIDVal")).Text;

            if (!String.IsNullOrEmpty(lName)) lName = replaceUmlaute(lName);
            if (!String.IsNullOrEmpty(pName)) pName = replaceUmlaute(pName);


            if ((int)Session["SearchMode"] == 0)
            {
                if (string.IsNullOrEmpty(lName) || string.IsNullOrEmpty(pName) || string.IsNullOrEmpty(geb))
                {
                    ShowMsg("Bitte geben Sie Nachname, Vorname und Geburtsdatum ein!");
                    return false;
                }
            }


            if (!String.IsNullOrEmpty(geb))
            {
                DateTime temp;
                if (DateTime.TryParse(geb, out temp))
                {
                    string newFormat = temp.ToString("yyyy-MM-dd");
                    System.Diagnostics.Debug.Write(lName);
                    System.Diagnostics.Debug.Write(pName);
                    System.Diagnostics.Debug.Write(geb);

                    var nID = SQLexecute("insert into PatientSearch (Name, Vorname, Geburtsdatum,ISH_PID, ISH_FID, BMBH_PID, GUID) VALUES ('" + lName + "', '" + pName + "', '" + newFormat + "', '" + ISHPID + "','" + ISHFID + "','" + BMBHPID + "', '" + Session["GUID"] + "');" +
                                                 "select scope_identity();");
                    return true;
                }
                else
                {
                    ShowMsg("Bitte das Datum im Format dd.MM.yyyy angeben");
                    return false;

                }
            }
            else
            {
                var nID = SQLexecute("insert into PatientSearch (Name, Vorname, ISH_PID, ISH_FID, BMBH_PID, GUID) VALUES ('" + lName + "', '" + pName + "', '" + ISHPID + "','" + ISHFID + "','" + BMBHPID + "', '" + Session["GUID"] + "');" +
                                                 "select scope_identity();");
                return true;
            }
            
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {


            if (Session["InitialInsert"] == null)
            {
                if (saveInput())
                {
                    btnSearch.Visible = false;
                    btnExcel.Visible = true;
                    Session["EditMode"] = false;
                    Session["SearchMode"] = Int32.Parse(HiddenSearchMode.Value);
                    dgdPatients.Columns[10].Visible = true;
                    BindData();
                    
                }
            }
            else
            {
                btnSearch.Visible = false;
                btnExcel.Visible = true;
                dgdPatients.Columns[10].Visible = true;
                Session["EditMode"] = false;
                BindData();
            }
 
        }

        private void BindData()
        {
            dgdPatients.DataSource = GetData();
            dgdPatients.DataBind();

            if ((bool)Session["EditMode"] == false)
            {
                SQLexecute("delete from PatientSearch where GUID = '" + Session["GUID"] + "'");

                if (dgdPatients.Rows.Count == 0)
                {
                    ShowMsg("Die Suche lieferte leider kein Ergebnis.");
                    btnNew_Click(null, null);
                }
            }
        }


        protected void dgdSimPatients_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                Button activeButton = (Button)e.Row.FindControl("btnPseudonym");
                
                Label lbBMBH = (Label)e.Row.FindControl("lblSBMBHVal");
                string psd = lbBMBH.Text;

                if (String.Equals(psd, "?"))
                {
                    DropDownList txtSex = (DropDownList)e.Row.FindControl("ddPSexVal");
                    txtSex.Visible = true;
                    Label lblSex = (Label)e.Row.FindControl("lblPSexVal");
                    lblSex.Visible = false;

                    TextBox txtPID = (TextBox)e.Row.FindControl("txtPPIDVal");
                    txtPID.Visible = true;
                    Label lblPID = (Label)e.Row.FindControl("lblPPIDVal");
                    lblPID.Visible = false;

                    activeButton.Text = "Generieren";
                }
                else
                {
                    activeButton.Text = "Übernehmen";
                }
            }
        }

        private void setVisibilityOfHeaderButtons(bool show)
        {
            for (int i = 0; i <= dgdSimPatients.Rows.Count - 1; i++)
            {
                GridViewRow gvr = dgdSimPatients.Rows[i];
                if (gvr.RowType == DataControlRowType.Header)
                {
                    ((Button)gvr.FindControl("btnName")).Visible = show;
                    ((Label)gvr.FindControl("lblName")).Visible = !show;
                    ((Button)gvr.FindControl("btnPrename")).Visible = show;
                    ((Label)gvr.FindControl("lblPrename")).Visible = !show;
                    ((Button)gvr.FindControl("btnBirthdate")).Visible = show;
                    ((Label)gvr.FindControl("lblBirthdate")).Visible = !show;
                    ((Button)gvr.FindControl("btnISHPID")).Visible = show;
                    ((Label)gvr.FindControl("lblISHPID")).Visible = !show;
                    ((Button)gvr.FindControl("btnISHFID")).Visible = show;
                    ((Label)gvr.FindControl("lblISHFID")).Visible = !show;
                    ((Button)gvr.FindControl("btnBMBHPID")).Visible = show;
                    ((Label)gvr.FindControl("lblBMBHPID")).Visible = !show;
                    ((Button)gvr.FindControl("btnHistoNr")).Visible = show;
                    ((Label)gvr.FindControl("lblHistoNr")).Visible = !show;
                }
            }
        }

        protected void dgdPatients_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            

            if (e.Row.RowType == DataControlRowType.Header)
            {
                if (Session["SearchMode"] != null)
                {
                    if ((bool)Session["EditMode"] == false) // view only
                    {
                        ((Button)e.Row.FindControl("btnName")).Visible = false;
                        ((Label)e.Row.FindControl("lblName")).Visible = true;
                        ((Button)e.Row.FindControl("btnPrename")).Visible = false;
                        ((Label)e.Row.FindControl("lblPrename")).Visible = true;
                        ((Button)e.Row.FindControl("btnBirthdate")).Visible = false;
                        ((Label)e.Row.FindControl("lblBirthdate")).Visible = true;
                        ((Button)e.Row.FindControl("btnISHPID")).Visible = false;
                        ((Label)e.Row.FindControl("lblISHPID")).Visible = true;
                        ((Button)e.Row.FindControl("btnISHFID")).Visible = false;
                        ((Label)e.Row.FindControl("lblISHFID")).Visible = true;
                        ((Button)e.Row.FindControl("btnBMBHPID")).Visible = false;
                        ((Label)e.Row.FindControl("lblBMBHPID")).Visible = true;
                        ((Button)e.Row.FindControl("btnHistoNr")).Visible = false;
                        ((Label)e.Row.FindControl("lblHistoNr")).Visible = true;  
                    }
                    else
                    {
                        
                        switch ((int)Session["SearchMode"])
                        {
                            case 0: // Name, Vorname, Geburtsdatum
                                ((Button)e.Row.FindControl("btnName")).Visible = true;
                                ((Label)e.Row.FindControl("lblName")).Visible = false;
                                ((Button)e.Row.FindControl("btnPrename")).Visible = true;
                                ((Label)e.Row.FindControl("lblPrename")).Visible = false;
                                ((Button)e.Row.FindControl("btnBirthdate")).Visible = true;
                                ((Label)e.Row.FindControl("lblBirthdate")).Visible = false;
                                ((Button)e.Row.FindControl("btnISHPID")).Visible = false;
                                ((Label)e.Row.FindControl("lblISHPID")).Visible = true;
                                ((Button)e.Row.FindControl("btnISHFID")).Visible = false;
                                ((Label)e.Row.FindControl("lblISHFID")).Visible = true;
                                ((Button)e.Row.FindControl("btnBMBHPID")).Visible = false;
                                ((Label)e.Row.FindControl("lblBMBHPID")).Visible = true;
                                ((Button)e.Row.FindControl("btnHistoNr")).Visible = false;
                                ((Label)e.Row.FindControl("lblHistoNr")).Visible = true;
                                break;
                            case 1: // ISH_PID
                                ((Button)e.Row.FindControl("btnISHPID")).Visible = true;
                                ((Label)e.Row.FindControl("lblISHPID")).Visible = false;
                                ((Button)e.Row.FindControl("btnName")).Visible = false;
                                ((Label)e.Row.FindControl("lblName")).Visible = true;
                                ((Button)e.Row.FindControl("btnPrename")).Visible = false;
                                ((Label)e.Row.FindControl("lblPrename")).Visible = true;
                                ((Button)e.Row.FindControl("btnBirthdate")).Visible = false;
                                ((Label)e.Row.FindControl("lblBirthdate")).Visible = true;
                                ((Button)e.Row.FindControl("btnISHFID")).Visible = false;
                                ((Label)e.Row.FindControl("lblISHFID")).Visible = true;
                                ((Button)e.Row.FindControl("btnBMBHPID")).Visible = false;
                                ((Label)e.Row.FindControl("lblBMBHPID")).Visible = true;
                                ((Button)e.Row.FindControl("btnHistoNr")).Visible = false;
                                ((Label)e.Row.FindControl("lblHistoNr")).Visible = true;
                                break;
                            case 2: // ISH_FID
                                ((Button)e.Row.FindControl("btnISHFID")).Visible = true;
                                ((Label)e.Row.FindControl("lblISHFID")).Visible = false;
                                ((Button)e.Row.FindControl("btnName")).Visible = false;
                                ((Label)e.Row.FindControl("lblName")).Visible = true;
                                ((Button)e.Row.FindControl("btnPrename")).Visible = false;
                                ((Label)e.Row.FindControl("lblPrename")).Visible = true;
                                ((Button)e.Row.FindControl("btnBirthdate")).Visible = false;
                                ((Label)e.Row.FindControl("lblBirthdate")).Visible = true;
                                ((Button)e.Row.FindControl("btnISHPID")).Visible = false;
                                ((Label)e.Row.FindControl("lblISHPID")).Visible = true;
                                ((Button)e.Row.FindControl("btnBMBHPID")).Visible = false;
                                ((Label)e.Row.FindControl("lblBMBHPID")).Visible = true;
                                ((Button)e.Row.FindControl("btnHistoNr")).Visible = false;
                                ((Label)e.Row.FindControl("lblHistoNr")).Visible = true;
                                break;
                            case 3: // BMBH_PID
                                ((Button)e.Row.FindControl("btnBMBHPID")).Visible = true;
                                ((Label)e.Row.FindControl("lblBMBHPID")).Visible = false;
                                ((Button)e.Row.FindControl("btnISHPID")).Visible = false;
                                ((Label)e.Row.FindControl("lblISHPID")).Visible = true;
                                ((Button)e.Row.FindControl("btnISHFID")).Visible = false;
                                ((Label)e.Row.FindControl("lblISHFID")).Visible = true;
                                ((Button)e.Row.FindControl("btnName")).Visible = false;
                                ((Label)e.Row.FindControl("lblName")).Visible = true;
                                ((Button)e.Row.FindControl("btnPrename")).Visible = false;
                                ((Label)e.Row.FindControl("lblPrename")).Visible = true;
                                ((Button)e.Row.FindControl("btnBirthdate")).Visible = false;
                                ((Label)e.Row.FindControl("lblBirthdate")).Visible = true;
                                ((Button)e.Row.FindControl("btnISHFID")).Visible = false;
                                ((Label)e.Row.FindControl("lblISHFID")).Visible = true;
                                ((Button)e.Row.FindControl("btnHistoNr")).Visible = false;
                                ((Label)e.Row.FindControl("lblHistoNr")).Visible = true;
                                break;
                            case 4: // before insert - show all buttons
                                ((Button)e.Row.FindControl("btnName")).Visible = true;
                                ((Label)e.Row.FindControl("lblName")).Visible = false;
                                ((Button)e.Row.FindControl("btnPrename")).Visible = true;
                                ((Label)e.Row.FindControl("lblPrename")).Visible = false;
                                ((Button)e.Row.FindControl("btnBirthdate")).Visible = true;
                                ((Label)e.Row.FindControl("lblBirthdate")).Visible = false;
                                ((Button)e.Row.FindControl("btnISHPID")).Visible = true;
                                ((Label)e.Row.FindControl("lblISHPID")).Visible = false;
                                ((Button)e.Row.FindControl("btnISHFID")).Visible = true;
                                ((Label)e.Row.FindControl("lblISHFID")).Visible = false;
                                ((Button)e.Row.FindControl("btnBMBHPID")).Visible = true;
                                ((Label)e.Row.FindControl("lblBMBHPID")).Visible = false;
                                ((Button)e.Row.FindControl("btnHistoNr")).Visible = true;
                                ((Label)e.Row.FindControl("lblHistoNr")).Visible = false;
                                break;
                            case 5: // Histo_Nr
                                ((Button)e.Row.FindControl("btnBMBHPID")).Visible = false;
                                ((Label)e.Row.FindControl("lblBMBHPID")).Visible = true;
                                ((Button)e.Row.FindControl("btnISHPID")).Visible = false;
                                ((Label)e.Row.FindControl("lblISHPID")).Visible = true;
                                ((Button)e.Row.FindControl("btnISHFID")).Visible = false;
                                ((Label)e.Row.FindControl("lblISHFID")).Visible = true;
                                ((Button)e.Row.FindControl("btnName")).Visible = false;
                                ((Label)e.Row.FindControl("lblName")).Visible = true;
                                ((Button)e.Row.FindControl("btnPrename")).Visible = false;
                                ((Label)e.Row.FindControl("lblPrename")).Visible = true;
                                ((Button)e.Row.FindControl("btnBirthdate")).Visible = false;
                                ((Label)e.Row.FindControl("lblBirthdate")).Visible = true;
                                ((Button)e.Row.FindControl("btnISHFID")).Visible = false;
                                ((Label)e.Row.FindControl("lblISHFID")).Visible = true;
                                ((Button)e.Row.FindControl("btnHistoNr")).Visible = true;
                                ((Label)e.Row.FindControl("lblHistoNr")).Visible = false;
                                break;
                        }
                    }
                }
            }
            else
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {


                    if ((bool)Session["EditMode"] == true) // view only
                    {

                        if(Session["InitialInsert"] != null)
                        {
                            changeVisibilityGrid(e.Row, false);
                        }
                        else
                        {
                            changeVisibilityGrid(e.Row, true);
                        }
                        
                    }
                    else
                    {
                        changeVisibilityGrid(e.Row, false);
                        Button activeButton = (Button)e.Row.FindControl("btnPseudo");
                        Label lbBMBH = (Label)e.Row.FindControl("lblBMBHPIDVal");
                        string psd = lbBMBH.Text;

                        Label lbBirthday = (Label)e.Row.FindControl("lblBirthdateVal");
                        string bir = lbBirthday.Text;

                        Label lbName = (Label)e.Row.FindControl("lblNameVal");
                        string name = lbName.Text;

                        Label lbSurename = (Label)e.Row.FindControl("lblPrenameVal");
                        string surename = lbSurename.Text;



                        bool show = string.IsNullOrEmpty(psd);

                        if (show && !string.IsNullOrEmpty(bir) && !string.IsNullOrEmpty(name) && !string.IsNullOrEmpty(surename))
                        {
                            activeButton.Visible = true;
                        }
                        else
                        { 
                            activeButton.Visible = false;
                        }
                    }
                        
                }

            }
        }

        protected void dsPatientSearch_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 900;
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            DataTable dt = ((DataTable)Session["MainTable"]).DefaultView.ToTable();
            ExcelPackage excel = new ExcelPackage();
            var workSheet = excel.Workbook.Worksheets.Add("Exportierte Daten");
            var totalCols = dt.Columns.Count;
            var totalRows = dt.Rows.Count;

            // add columns
            int col_w = 1;
            for (var col = 0; col < totalCols; ++col)
            {
                string sColName = dt.Columns[col].ColumnName;

                if (Session["OE"].ToString() != "NCT-Gewebebank" && (sColName == "Histo_Nr" || sColName == "Status" || sColName == "Biobank"))
                    continue;

                if (sColName != "GUID" && sColName != "ID")
                {
                    workSheet.Cells[1, col_w].Value = sColName;
                    ++col_w;
                }
            }

            // insert rows
            col_w = 1;
            for (var row = 0; row < totalRows; ++row)
            {
                for (var col = 0; col < totalCols; ++col)
                {
                    string sColName = dt.Columns[col].ColumnName;

                    if (Session["OE"].ToString() != "NCT-Gewebebank" && (sColName == "Histo_Nr" || sColName == "Status" || sColName == "Biobank"))
                        continue;

                    if (sColName != "GUID" && sColName != "ID")
                    {
                        workSheet.Cells[row + 2, col_w].Value = dt.Rows[row][col];

                        if (sColName == "Geburtsdatum")
                            workSheet.Cells[row + 2, col_w].Style.Numberformat.Format = "dd.mm.yyyy";

                        ++col_w;
                    }
                }
                col_w = 1;
            }

            using (var memoryStream = new MemoryStream())
            {
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                string sFileName = "PatientSearch_" + DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss") + ".xlsx";
                Response.AddHeader("content-disposition", "attachment;  filename=" + sFileName);
                excel.SaveAs(memoryStream);
                memoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();
            }
        }
    }
}