using OfficeOpenXml;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace BMBHviews
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
                    return sBiobank == "NCT-Gewebebank"
                        ? "SELECT * FROM [V_PatientSearch_NVG] WHERE [GUID] = '" + (string)Session["GUID"] + "'"
                        : "SELECT * FROM [V_PatientSearch_NVG_PSD] WHERE [GUID] = '" + (string)Session["GUID"] + "' AND Biobank = '" + sBiobank + "'";
                    //return "SELECT p.ID, p.Name, p.Vorname, p.Geburtsdatum, m.UKH_PID AS ISH_PID, m.UKH_FID AS ISH_FID, m.BMBH_PID, p.Histo_Nr FROM [PatientSearch] as p LEFT JOIN [V_Patienten_MedV] as m ON p.Vorname = m.Vorname AND p.Geburtsdatum = m.Geburtsdatum AND p.Name = m.Name WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                }
                return (int)Session["SearchMode"] == 1
                    ? sBiobank == "NCT-Gewebebank"
                        ? "SELECT * FROM [V_PatientSearch_IP] WHERE [GUID] = '" + (string)Session["GUID"] + "'"
                        : "SELECT * FROM [V_PatientSearch_IP_PSD] WHERE [GUID] = '" + (string)Session["GUID"] + "' AND Biobank = '" + sBiobank + "'"
                    : (int)Session["SearchMode"] == 2
                    ? sBiobank == "NCT-Gewebebank"
                        ? "SELECT * FROM [V_PatientSearch_IF] WHERE [GUID] = '" + (string)Session["GUID"] + "'"
                        : "SELECT * FROM [V_PatientSearch_IF_PSD] WHERE [GUID] = '" + (string)Session["GUID"] + "' AND Biobank = '" + sBiobank + "'"
                    : (int)Session["SearchMode"] == 3
                    ? sBiobank == "NCT-Gewebebank"
                        ? "SELECT * FROM [V_PatientSearch_BP] WHERE [GUID] = '" + (string)Session["GUID"] + "'"
                        : "SELECT * FROM [V_PatientSearch_BP_PSD] WHERE [GUID] = '" + (string)Session["GUID"] + "' AND Biobank = '" + sBiobank + "'"
                    : (int)Session["SearchMode"] == 5 ? "SELECT * FROM [V_PatientSearch_HN] WHERE [GUID] = '" + (string)Session["GUID"] + "'" : null;
            }
        }

        private static int SQLexecute(string sSQL)
        {
            string sConnString = ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sConnString);
            SqlCommand cmd = new SqlCommand
            {
                CommandType = CommandType.Text,
                CommandText = sSQL,
                Connection = con
            };
            try
            {
                con.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
            catch (Exception)
            {
                throw;
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

        protected void BtnClos_Click(object sender, EventArgs e)
        {
            MPE.Hide();
        }

        protected void GeneratePseudonym(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            Session["PSDMode"] = false;

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
            if (!string.Equals(pseudo, "?"))
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

                if (m.Success || string.IsNullOrEmpty(PID))
                {

                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
                    using (SqlCommand cmd = new SqlCommand("GetPseudonym", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 50).Value = lNValue;
                        cmd.Parameters.Add("@Vorname", SqlDbType.NVarChar, 50).Value = sNValue;
                        cmd.Parameters.Add("@GebDatum", SqlDbType.NVarChar, 10).Value = gebDValue;
                        cmd.Parameters.Add("@Geschl", SqlDbType.VarChar, 3).Value = sex;
                        cmd.Parameters.Add("@PID", SqlDbType.VarChar, 10).Value = PID;
                        cmd.Parameters.Add("@Pseudonym", SqlDbType.VarChar, 8).Direction = ParameterDirection.Output;

                        conn.Open();
                        _ = cmd.ExecuteNonQuery();

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

        protected void ShowSimilarPatients(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            Button btn = (Button)sender;

            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            Session["RowIndex"] = gvr.RowIndex;

            Label name = (Label)gvr.Cells[0].FindControl("lblNameVal");
            string lNameVal = name.Text;

            Label surname = (Label)gvr.Cells[0].FindControl("lblPrenameVal");
            string sNameVal = surname.Text;

            Label bir = (Label)gvr.Cells[0].FindControl("lblBirthdateVal");
            string birVal = bir.Text;

            DataTable dt = new DataTable();
            _ = dt.Columns.Add("name");
            _ = dt.Columns.Add("vorname");
            _ = dt.Columns.Add("geb");
            _ = dt.Columns.Add("geschlecht");
            _ = dt.Columns.Add("PID");
            _ = dt.Columns.Add("BMBH_PID");

            DataRow t = dt.NewRow();
            t["name"] = lNameVal;
            t["vorname"] = sNameVal;
            t["geb"] = birVal;
            t["geschlecht"] = "m";
            t["PID"] = "";
            t["BMBH_PID"] = "?";
            dt.Rows.Add(t);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand("ReturnSimilarPatients", conn))
            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 255).Value = lNameVal;
                cmd.Parameters.Add("@Vorname", SqlDbType.NVarChar, 255).Value = sNameVal;
                cmd.Parameters.Add("@GebDatum", SqlDbType.VarChar, 10).Value = birVal;

                _ = adapter.Fill(dt);
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
                    Initialize(4);
                    Session["init"] = true;
                }

                dgdPatients.DataSource = Session["MainTable"] == null ? GetData() : (object)(Session["MainTable"] as DataTable);

                dgdPatients.DataBind();
            }

            // handle header button clicks (from javascript)
            string sEventArg = Request["__EVENTARGUMENT"];
            if (sEventArg != null && sEventArg.Length > 0)
            {
                btnSearch.Visible = true;
                HandleClipboardData(sEventArg);
            }
        }

        public DataTable GetData()
        {
            string sSQL = SetDataSource();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BMBHViewsConnectionString"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(sSQL, conn))
            using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
            {
                cmd.CommandTimeout = 900;
                DataTable dt = new DataTable();
                _ = adapter.Fill(dt);
                Session["MainTable"] = dt;
                return dt;
            }
        }

        protected void HandleClipboardData(string sEventArg)
        {
            switch (sEventArg) // column name
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

                // SearchMode = 4 -> default mode before searching

                case "Histo_Nr":
                    Session["SearchMode"] = 5;
                    break;
            }

            string sValues = HiddenInputBox.Value;
            string[] aValues = sValues.Split(new string[] { "," }, StringSplitOptions.None);
            int nLength = aValues.Length;
            int[] aIDs = new int[nLength];

            for (int i = 0; i < nLength; ++i)
            {
                if (sEventArg == "Geburtsdatum")
                {
                    string geb = aValues[i];

                    if (DateTime.TryParse(geb, out DateTime temp))
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
                    aValues[i] = ReplaceUmlaute(name);
                }
            }

            if (Session["InitialInsert"] == null) // first column inserted
            {
                if (Session["GUID"] == null)
                {
                    Session["GUID"] = Guid.NewGuid().ToString();
                }
                else
                {
                    _ = SQLexecute("delete from PatientSearch where GUID = '" + Session["GUID"] + "'");
                }

                _ = SQLexecute("insert into PatientSearch (GUID) VALUES ('" + Session["GUID"] + "');");

                for (int i = 0; i < nLength; ++i)
                {
                    int nID = SQLexecute("insert into PatientSearch (" + sEventArg + ", GUID) VALUES ('" + aValues[i] + "', '" + Session["GUID"] + "'); select scope_identity();");
                    aIDs[i] = nID;
                }
                Session["IDs"] = aIDs;
                Session["InitialInsert"] = true;
            }
            else // do update on existing columns
            {
                int[] aID = Session["IDs"] as int[];
                for (int i = 0; i < nLength; ++i)
                {
                    if (i < aID.Length)
                    {
                        _ = SQLexecute("update PatientSearch set " + sEventArg + "='" + aValues[i] + "' where ID = " + aID[i].ToString());
                    }
                }
            }

            // update gridview 
            BindData();
        }

        protected void Initialize(int? searchMode)
        {
            if (Session["GUID"] == null)
            {
                Session["GUID"] = Guid.NewGuid().ToString();
            }
            else
            {
                // delete all entries and insert dummy data row
                _ = SQLexecute("delete from PatientSearch where GUID = '" + Session["GUID"] + "'");
                _ = SQLexecute("insert into PatientSearch (Name, GUID) VALUES ('','" + Session["GUID"] + "')");
            }

            Session["RowIndex"] = 0;
            Session["InitialInsert"] = null;
            Session["EditMode"] = true;
            Session["SearchMode"] = searchMode;

            if (searchMode == 4)
            {
                Session["PSDMode"] = false;
                dgdPatients.Columns[10].Visible = false;
                btnSearch.Visible = true;
            }
            else if (searchMode == 6)
            {
                Session["PSDMode"] = true;
                dgdPatients.Columns[10].Visible = true;
                btnSearch.Visible = false;
            }

            btnExcel.Visible = false;

            BindData();

            if (Session["OE"].ToString() != "NCT-Gewebebank")
            {
                dgdPatients.Columns[8].Visible = false;
                dgdPatients.Columns[9].Visible = false;
            }
        }

        protected void BtnNew_Click(object sender, EventArgs e)
        {
            if (rbSearch.Checked == true)
            {
                Initialize(4);
            }
            else
            {
                Initialize(6);
            }
        }

        protected void NameChanged(object sender, EventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            TextBox btn = (TextBox)sender;
            string id = btn.ID;
            GridViewRow gvr2 = (GridViewRow)btn.NamingContainer;

            SetSessionMode(btn, id, gvr2);
        }

        private void SetSessionMode(TextBox tBox, string id, GridViewRow gvr2)
        {
            bool show = string.IsNullOrEmpty(tBox.Text);
            switch (id)
            {
                case "txtNameVal":
                case "txtPrenameVal":
                case "txtBirthdateVal":
                    string lName = ((TextBox)gvr2.FindControl("txtNameVal")).Text;
                    string pName = ((TextBox)gvr2.FindControl("txtPrenameVal")).Text;
                    string bir = ((TextBox)gvr2.FindControl("txtBirthdateVal")).Text;

                    show = string.IsNullOrEmpty(lName) && string.IsNullOrEmpty(pName) && string.IsNullOrEmpty(bir);
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

        private static string ReplaceUmlaute(string inputString)
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

        private bool SaveInput()
        {
            if (Session["GUID"] == null)
            {
                Session["GUID"] = Guid.NewGuid().ToString();
            }
            else
            {
                _ = SQLexecute("delete from PatientSearch where GUID = '" + Session["GUID"] + "'");
            }

            GridViewRow gvr = dgdPatients.Rows[0];

            string lName = ((TextBox)gvr.FindControl("txtNameVal")).Text;
            string pName = ((TextBox)gvr.FindControl("txtPrenameVal")).Text;
            string geb = ((TextBox)gvr.FindControl("txtBirthdateVal")).Text;
            string ISHPID = ((TextBox)gvr.FindControl("txtISHPIDVal")).Text;
            string ISHFID = ((TextBox)gvr.FindControl("txtISHFIDVal")).Text;
            string BMBHPID = ((TextBox)gvr.FindControl("txtBMBHPIDVal")).Text;

            if (!string.IsNullOrEmpty(lName))
            {
                lName = ReplaceUmlaute(lName);
            }

            if (!string.IsNullOrEmpty(pName))
            {
                pName = ReplaceUmlaute(pName);
            }

            if ((int)Session["SearchMode"] == 0)
            {
                if (string.IsNullOrEmpty(lName) || string.IsNullOrEmpty(pName) || string.IsNullOrEmpty(geb))
                {
                    ShowMsg("Bitte geben Sie Nachname, Vorname und Geburtsdatum ein!");
                    return false;
                }
            }

            if (!string.IsNullOrEmpty(geb))
            {
                if (DateTime.TryParse(geb, out DateTime temp))
                {
                    string newFormat = temp.ToString("yyyy-MM-dd");
                    System.Diagnostics.Debug.Write(lName);
                    System.Diagnostics.Debug.Write(pName);
                    System.Diagnostics.Debug.Write(geb);

                    _ = SQLexecute("insert into PatientSearch (Name, Vorname, Geburtsdatum,ISH_PID, ISH_FID, BMBH_PID, GUID) VALUES ('" + lName + "', '" + pName + "', '" + newFormat + "', '" + ISHPID + "','" + ISHFID + "','" + BMBHPID + "', '" + Session["GUID"] + "'); select scope_identity();");
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
                _ = SQLexecute("insert into PatientSearch (Name, Vorname, ISH_PID, ISH_FID, BMBH_PID, GUID) VALUES ('" + lName + "', '" + pName + "', '" + ISHPID + "','" + ISHFID + "','" + BMBHPID + "', '" + Session["GUID"] + "'); select scope_identity();");
                return true;
            }
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            Session["PSDMode"] = false;

            if (Session["InitialInsert"] == null)
            {
                if (SaveInput())
                {
                    btnSearch.Visible = false;
                    btnExcel.Visible = true;
                    Session["EditMode"] = false;
                    Session["SearchMode"] = int.Parse(HiddenSearchMode.Value);
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
                _ = SQLexecute("delete from PatientSearch where GUID = '" + Session["GUID"] + "'");

                if (dgdPatients.Rows.Count == 0)
                {
                    ShowMsg("Die Suche lieferte leider kein Ergebnis.");
                    BtnNew_Click(null, null);
                }
            }
        }

        protected void DgdSimPatients_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (sender == null)
            {
                throw new ArgumentNullException(nameof(sender));
            }

            if (e == null)
            {
                throw new ArgumentNullException(nameof(e));
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Button activeButton = (Button)e.Row.FindControl("btnPseudonym");

                Label lbBMBH = (Label)e.Row.FindControl("lblSBMBHVal");
                string psd = lbBMBH.Text;

                if (string.Equals(psd, "?"))
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

        protected void DgdPatients_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e == null)
            {
                throw new ArgumentNullException(nameof(e));
            }

            if (e.Row.RowIndex == 0)
            {
                if (Session["SearchMode"] != null)
                {
                    ((TextBox)e.Row.FindControl("btnName")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnPrename")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnBirthdate")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnISHPID")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnISHFID")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnBMBHPID")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnHistoNr")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtNameVal")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtPrenameVal")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtBirthdateVal")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtISHPIDVal")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtISHFIDVal")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtBMBHPIDVal")).Visible = false;
                    ((Button)e.Row.FindControl("btnPseudo")).Visible = (bool)Session["PSDMode"];

                    if ((bool)Session["EditMode"] == true) // view only
                    {
                        switch ((int)Session["SearchMode"])
                        {
                            case 0: // Name, Vorname, Geburtsdatum
                                ((TextBox)e.Row.FindControl("btnName")).Visible = true;
                                ((TextBox)e.Row.FindControl("btnPrename")).Visible = true;
                                ((TextBox)e.Row.FindControl("btnBirthdate")).Visible = true;
                                break;
                            case 1: // ISH_PID
                                ((TextBox)e.Row.FindControl("btnISHPID")).Visible = true;
                                break;
                            case 2: // ISH_FID
                                ((TextBox)e.Row.FindControl("btnISHFID")).Visible = true;
                                break;
                            case 3: // BMBH_PID
                                ((TextBox)e.Row.FindControl("btnBMBHPID")).Visible = true;
                                break;
                            case 4: // before first insert: show all fields
                                ((TextBox)e.Row.FindControl("btnName")).Visible = true;
                                ((TextBox)e.Row.FindControl("btnPrename")).Visible = true;
                                ((TextBox)e.Row.FindControl("btnBirthdate")).Visible = true;
                                ((TextBox)e.Row.FindControl("btnISHPID")).Visible = true;
                                ((TextBox)e.Row.FindControl("btnISHFID")).Visible = true;
                                ((TextBox)e.Row.FindControl("btnBMBHPID")).Visible = true;
                                ((TextBox)e.Row.FindControl("btnHistoNr")).Visible = true;
                                break;
                            case 5: // Histo_Nr
                                ((TextBox)e.Row.FindControl("btnHistoNr")).Visible = true;
                                break;
                            case 6: // pseudonymization
                                ((TextBox)e.Row.FindControl("txtNameVal")).Visible = true;
                                ((TextBox)e.Row.FindControl("txtPrenameVal")).Visible = true;
                                ((TextBox)e.Row.FindControl("txtBirthdateVal")).Visible = true;
                                ((TextBox)e.Row.FindControl("txtISHPIDVal")).Visible = true;
                                ((TextBox)e.Row.FindControl("txtISHFIDVal")).Visible = true;
                                ((TextBox)e.Row.FindControl("txtBMBHPIDVal")).Visible = true;
                                break;
                        }
                    }
                }
            }
            else
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    // hide all textboxes
                    ((TextBox)e.Row.FindControl("btnName")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnPrename")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnBirthdate")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnISHPID")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnISHFID")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnBMBHPID")).Visible = false;
                    ((TextBox)e.Row.FindControl("btnHistoNr")).Visible = false;
                    ((Button)e.Row.FindControl("btnPseudo")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtNameVal")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtPrenameVal")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtBirthdateVal")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtISHPIDVal")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtISHFIDVal")).Visible = false;
                    ((TextBox)e.Row.FindControl("txtBMBHPIDVal")).Visible = false;
                }
            }
        }

        protected void DsPatientSearch_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            if (e == null)
            {
                throw new ArgumentNullException(nameof(e));
            }

            e.Command.CommandTimeout = 900;
        }

        protected void BtnExcel_Click(object sender, EventArgs e)
        {
            DataTable dt = ((DataTable)Session["MainTable"]).DefaultView.ToTable();
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            ExcelPackage excel = new ExcelPackage();
            ExcelWorksheet workSheet = excel.Workbook.Worksheets.Add("Exportierte Daten");
            int totalCols = dt.Columns.Count;
            int totalRows = dt.Rows.Count;

            // add columns
            int col_w = 1;
            for (int col = 0; col < totalCols; ++col)
            {
                string sColName = dt.Columns[col].ColumnName;

                if (Session["OE"].ToString() != "NCT-Gewebebank" && (sColName == "Histo_Nr" || sColName == "Status" || sColName == "Biobank"))
                {
                    continue;
                }

                if (sColName != "GUID" && sColName != "ID")
                {
                    workSheet.Cells[1, col_w].Value = sColName;
                    ++col_w;
                }
            }

            // insert rows
            col_w = 1;
            for (int row = 0; row < totalRows; ++row)
            {
                for (int col = 0; col < totalCols; ++col)
                {
                    string sColName = dt.Columns[col].ColumnName;

                    if (Session["OE"].ToString() != "NCT-Gewebebank" && (sColName == "Histo_Nr" || sColName == "Status" || sColName == "Biobank"))
                    {
                        continue;
                    }

                    if (sColName != "GUID" && sColName != "ID")
                    {
                        workSheet.Cells[row + 2, col_w].Value = dt.Rows[row][col];

                        if (sColName == "Geburtsdatum")
                        {
                            workSheet.Cells[row + 2, col_w].Style.Numberformat.Format = "dd.mm.yyyy";
                        }

                        ++col_w;
                    }
                }
                col_w = 1;
            }

            using (MemoryStream memoryStream = new MemoryStream())
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

        protected void rb_CheckedChanged(object sender, EventArgs e)
        {
            if (rbPseudo.Checked == true)
            {
                Session["PSDMode"] = true;
                Initialize(6);
            }
            if (rbSearch.Checked == true)
            {
                Session["PSDMode"] = false;
                Initialize(4);
            }
        }
    }
}