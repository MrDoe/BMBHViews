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
    public partial class _Default : Page
    {
        private void ShowMsg(string message)
        {
            Response.Write("<script>alert(\"" + message + "\");</script>");
        }
        
        private void ShowDataSet(DataSet ds)
        {
            StringWriter sw = new StringWriter();
            ds.WriteXml(sw);
            ShowMsg("DataSet: " + sw.ToString());
        }

        private string[] StringArray(DataSet ds)
        {
            int nRows = ds.Tables[0].Rows.Count;
            string[] stringArray = new string[nRows];

            for (int row = 0; row < nRows; ++row)
                stringArray[row] = ds.Tables[0].Rows[row][0].ToString();

            return stringArray;
        }

        public String[] GetUserPermissions()
        {
            string sUser = (string)Session["UserName"];
            DataSet ds = new DataSet("Permissions");

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CLIN106_DataConnectionString"].ConnectionString))
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

        protected void HideShowPanels(String[] aUserPerm)
        {
            pnlTBB.Height = 310;
            pnlPatho.Height = 310;
            pnlLiquid.Height = 210;
            pnlDZIF.Height = 210;
            pnlPraevonk.Height = 210;
            pnlPanco.Height = 210;
            pnlThorax.Height = 210;

            for (int i = 0; i < aUserPerm.Length; ++i)
            {
                String sUserPerm = aUserPerm[i].ToUpper();
                switch (sUserPerm)
                {
                    case "V_NCT_TBB_GESAMT":
                        pnlTBB.Enabled = true;
                        btnNCT_TBB_Gesamt.Visible = true;
                        btnNCT_TBB_Gesamt.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_TBB_COLOCARE":
                        pnlTBB.Enabled = true;
                        btnNCT_TBB_ColoCare.Visible = true;
                        btnNCT_TBB_ColoCare.ToolTip = sUserPerm;
                        break;
                    case "V_PANCOBANK_LIQUID":
                        pnlPanco.Enabled = true;
                        btnPancoBank_Liquid.Visible = true;
                        btnPancoBank_Liquid.ToolTip = sUserPerm;
                        break;
                    case "V_PANCOBANK_KRYO":
                        pnlPanco.Enabled = true;
                        btnPancoBank_Kryo.Visible = true;
                        btnPancoBank_Kryo.ToolTip = sUserPerm;
                        break;
                    case "V_PANCOBANK_PARAFFIN":
                        pnlPanco.Enabled = true;
                        btnPancoBank_Paraffin.Visible = true;
                        btnPancoBank_Paraffin.ToolTip = sUserPerm;
                        break;
                    case "V_PANCOBANK_BIOPAC":
                        pnlPanco.Enabled = true;
                        btnPancoBank_BioPac.Visible = true;
                        btnPancoBank_BioPac.ToolTip = sUserPerm;
                        break;
                    case "V_THORAX_CASES":
                        pnlThorax.Enabled = true;
                        btnThoraxCases.Visible = true;
                        btnThoraxCases.ToolTip = sUserPerm;
                        break;
                    case "V_THORAX_PROBEN":
                        pnlThorax.Enabled = true;
                        btnThoraxSamples.Visible = true;
                        btnThoraxSamples.ToolTip = sUserPerm;
                        break;
                    case "V_DZIF_PRIMARY":
                        pnlDZIF.Enabled = true;
                        btnDZIFprimary.Visible = true;
                        btnDZIFupload.Visible = true;
                        btnDZIFprimary.ToolTip = sUserPerm;
                        break;
                    case "V_DZIF_ALIQUOTS":
                        pnlDZIF.Enabled = true;
                        btnDZIFaliquots.Visible = true;
                        btnDZIFupload.Visible = true;
                        btnDZIFaliquots.ToolTip = sUserPerm;
                        break;
                    case "V_DZIF_RELEASES":
                        pnlDZIF.Enabled = true;
                        btnDZIFreleases.Visible = true;
                        btnDZIFupload.Visible = true;
                        btnDZIFreleases.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_DKTK_LIQUID":
                        pnlLiquid.Enabled = true;
                        btnDKTKliquid.Visible = true;
                        btnDKTKliquid.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_SUPPORT":
                        pnlLiquid.Enabled = true;
                        btnNCTLBBsupport.Visible = true;
                        btnNCTLBBsupport.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_LBB_PO_GEKKO":
                        pnlPraevonk.Enabled = true;
                        btnGEKKO.Visible = true;
                        btnGEKKO.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_LBB_PO_DARIO":
                        pnlPraevonk.Enabled = true;
                        btnDARIO.Visible = true;
                        btnDARIO.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_COLOCARE":
                        pnlPraevonk.Enabled = true;
                        btnColoCare.Visible = true;
                        btnColoCare.ToolTip = sUserPerm;
                        break;
                    case "V_NEXUS_EINGAENGE":
                        pnlPatho.Enabled = true;
                        btnNexusEingaenge.Visible = true;
                        btnNexusEingaenge.ToolTip = sUserPerm;
                        break;
                    case "V_NEXUS_PATIENTEN":
                        pnlPatho.Enabled = true;
                        btnNexusPatienten.Visible = true;
                        btnNexusPatienten.ToolTip = sUserPerm;
                        break;
                    case "V_NEXUS_PATIENTEN_GESAMT":
                        pnlPatho.Enabled = true;
                        btnNexusPatientenGesamt.Visible = true;
                        btnNexusPatientenGesamt.ToolTip = sUserPerm;
                        break;
                    case "V_NEXUS_PATIENTEN_THORAX":
                        pnlPatho.Enabled = true;
                        btnNexusPatientenThorax.Visible = true;
                        btnNexusPatientenThorax.ToolTip = sUserPerm;
                        break;
                    case "V_WIDERRUF_KOMPLETT":
                        pnlPatho.Visible = true;
                        btnWiderrufKomplett.Visible = true;
                        btnWiderrufKomplett.ToolTip = sUserPerm;
                        break;
                    case "V_TBB_NEXUS":
                        pnlPatho.Visible = true;
                        btnTBBNexus.Visible = true;
                        btnTBBNexus.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_SFB1118_PRO_PROJEKT":
                        pnlPatho.Visible = true;
                        btnSFB1118.Visible = true;
                        btnSFB1118.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_SFB_1118_ANTIKOERPER":
                        pnlPatho.Visible = true;
                        btnSFB1118_AK.Visible = true;
                        btnSFB1118_AK.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_DIENSTLEISTUNGEN_PRO_JAHR":
                        pnlPatho.Visible = true;
                        btnDLJahr.Visible = true;
                        btnDLJahr.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_SCHNITTE_PRO_JAHR":
                        pnlPatho.Visible = true;
                        btnSchnitteJahr.Visible = true;
                        btnSchnitteJahr.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_SCHNITTE_PRO_MONAT":
                        pnlPatho.Visible = true;
                        btnSchnitteMonat.Visible = true;
                        btnSchnitteMonat.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_SCHNITTE_PRO_PROJEKT":
                        pnlPatho.Visible = true;
                        btnSchnitteProjekt.Visible = true;
                        btnSchnitteProjekt.ToolTip = sUserPerm;
                        break;
                }
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

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["LastQuery"] = null;

            if (Session["GUID"] != null)
            {
                SQLexecute("delete from V_Recursive_Temp where GUID='" + Session["GUID"] + "'");
                SQLexecute("delete from V_Recursive_Log where GUID='" + Session["GUID"] + "'");
            }

            Session["GUID"] = null;

            Session["Recursive"] = null;
            Session["UserName"] = Page.User.Identity.Name;

            String[] aUserPerm = GetUserPermissions();
            HideShowPanels(aUserPerm);
        }

        protected void btnDZIFupload_Click(object sender, EventArgs e)
        {
            var client = new RestClient("https://dzif-www.helmholtz-muenchen.de/FileUploadService/rest/upload");
            client.Authenticator = new RestSharp.Authenticators.HttpBasicAuthenticator("DZIF-HD", "-*Ab&Y/9qF");

            var request = new RestRequest("resource/{id}", Method.POST);
            //request.AddParameter("name", "value"); // adds to POST or URL querystring based on Method
            //request.AddUrlSegment("id", "123");  // replaces matching token in request.Resource

            // easily add HTTP Headers
            request.AddHeader("header", "value");

            // add files to upload (works with compatible verbs)
            request.AddFile("DZIF_HD_TX_Stammproben.csv", "Z:\\temp\\DZIF_HD_TX_Stammproben.csv");
            request.AddFile("DZIF_HD_TX_Aliquote.csv", "Z:\\temp\\DZIF_HD_TX_Aliquote.csv");

            // execute the request
            IRestResponse response = client.Execute(request);
            var content = response.Content; // raw content as string
            ShowMsg(content);

            // or automatically deserialize result
            // return content type is sniffed but can be explicitly set via RestClient.AddHandler();
            //RestResponse<Person> response2 = client.Execute<Person>(request);
            //var name = response2.Data.Name;

            // easy async support
            //client.ExecuteAsync(request, response => {
            //    Console.WriteLine(response.Content);
            //});

            // async with deserialization
            //var asyncHandle = client.ExecuteAsync<Person>(request, response => {
            //    Console.WriteLine(response.Data.Name);
            //});

            // abort the request on demand
            //asyncHandle.Abort();
        }

        protected void btnGeneric_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            Session["View"] = btn.ToolTip;
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Search.aspx");

        }
    }
}