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

namespace BMBH_View
{
    public partial class MultipleSearch : System.Web.UI.Page
    {
        private string SetDataSource()
        {
            if ((bool)Session["EditMode"] == true)
            {
                return "SELECT * FROM [PatientSearch] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
            }
            else
            {
                if ((int)Session["SearchMode"] == 0) // Name, Vorname, Geburtsdatum
                    return "SELECT * FROM [V_PatientSearch_NVG] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                if ((int)Session["SearchMode"] == 1) // ISH_PID
                    return "SELECT * FROM [V_PatientSearch_IP] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                if ((int)Session["SearchMode"] == 2) // ISH_FID
                    return "SELECT * FROM [V_PatientSearch_IF] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                if ((int)Session["SearchMode"] == 3) // BMBH_PID
                    return "SELECT * FROM [V_PatientSearch_BP] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
                if ((int)Session["SearchMode"] == 5) // Histo_Nr
                    return "SELECT * FROM [V_PatientSearch_HN] WHERE [GUID] = '" + (string)Session["GUID"] + "'";
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                if (Session["init"] == null) // first page load
                {
                    Timer1.Enabled = true;
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
            }
            else // do update on existing columns
            {
                int[] aID = Session["IDs"] as int[];
                for (var i = 0; i < nLength; ++i)
                    SQLexecute("update PatientSearch set " + sEventArg + "='" + aValues[i] + "' where ID = " + aID[i].ToString());
            }

            // update gridview 
            dgdPatients.DataSource = GetData();
            dgdPatients.DataBind();
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

            Session["InitialInsert"] = null;
            Session["EditMode"] = true;
            Session["SearchMode"] = 4; // show all buttons

            dgdPatients.DataSource = GetData();
            dgdPatients.DataBind();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            Initialize();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Session["EditMode"] = false;
            dgdPatients.DataSource = GetData();
            dgdPatients.DataBind();
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
        }

        protected void dsPatientSearch_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 240;
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