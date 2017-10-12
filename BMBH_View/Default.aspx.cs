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

        protected void HideShowPanels(String[] aUserPerm)
        {
            for (int i = 0; i < aUserPerm.Length; ++i)
            {
                String sUserPerm = aUserPerm[i].ToUpper();
                switch (sUserPerm)
                {
                    case "V_ANTRAGSBEARBEITUNG_NCT":
                        pnlTBB.Visible = true;
                        btnAntrag.Visible = true;
                        btnAntrag.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_TBB_GESAMT":
                        pnlTBB.Visible = true;
                        btnNCT_TBB_Gesamt.Visible = true;
                        btnNCT_TBB_Gesamt.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_TBB_COLOCARE":
                        pnlTBB.Visible = true;
                        btnNCT_TBB_ColoCare.Visible = true;
                        btnNCT_TBB_ColoCare.ToolTip = sUserPerm;
                        break;
                    case "V_PANCOBANK_LIQUID":
                        pnlPanco.Visible = true;
                        btnPancoBank_Liquid.Visible = true;
                        btnPancoBank_Liquid.ToolTip = sUserPerm;
                        break;
                    case "V_PANCOBANK_KRYO":
                        pnlPanco.Visible = true;
                        btnPancoBank_Kryo.Visible = true;
                        btnPancoBank_Kryo.ToolTip = sUserPerm;
                        break;
                    case "V_PANCOBANK_PARAFFIN":
                        pnlPanco.Visible = true;
                        btnPancoBank_Paraffin.Visible = true;
                        btnPancoBank_Paraffin.ToolTip = sUserPerm;
                        break;
                    case "V_PANCOBANK_BIOPAC":
                        pnlPanco.Visible = true;
                        btnPancoBank_BioPac.Visible = true;
                        btnPancoBank_BioPac.ToolTip = sUserPerm;
                        break;
                    case "V_THORAX_CASES":
                        pnlThorax.Visible = true;
                        btnThoraxCases.Visible = true;
                        btnThoraxCases.ToolTip = sUserPerm;
                        break;
                    case "V_THORAX_PROBEN":
                        pnlThorax.Visible = true;
                        btnThoraxSamples.Visible = true;
                        btnThoraxSamples.ToolTip = sUserPerm;
                        break;
                    case "V_THORAX_GESAMT":
                        pnlThorax.Visible = true;
                        btnThoraxGesamt.Visible = true;
                        btnThoraxGesamt.ToolTip = sUserPerm;
                        break;
                    case "V_DZIF_PRIMARY":
                        pnlDZIF.Visible = true;
                        btnDZIFprimary.Visible = true;
                        btnDZIFupload.Visible = true;
                        btnDZIFprimary.ToolTip = sUserPerm;
                        break;
                    case "V_DZIF_ALIQUOTS":
                        pnlDZIF.Visible = true;
                        btnDZIFaliquots.Visible = true;
                        btnDZIFupload.Visible = true;
                        btnDZIFaliquots.ToolTip = sUserPerm;
                        break;
                    case "V_DZIF_RELEASES":
                        pnlDZIF.Visible = true;
                        btnDZIFreleases.Visible = true;
                        btnDZIFupload.Visible = true;
                        btnDZIFreleases.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_SUPPORT":
                        pnlLiquid.Visible = true;
                        btnNCTLBBsupport.Visible = true;
                        btnNCTLBBsupport.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_LBB_PO_GEKKO":
                        pnlPraevonk.Visible = true;
                        btnGEKKO.Visible = true;
                        btnGEKKO.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_LBB_PO_DARIO":
                        pnlPraevonk.Visible = true;
                        btnDARIO.Visible = true;
                        btnDARIO.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_COLOCARE":
                        pnlPraevonk.Visible = true;
                        btnColoCare.Visible = true;
                        btnColoCare.ToolTip = sUserPerm;
                        break;
                    case "V_NEXUS_EINGAENGE":
                        pnlPatho.Visible = true;
                        btnNexusEingaenge.Visible = true;
                        btnNexusEingaenge.ToolTip = sUserPerm;
                        break;
                    case "V_NEXUS_PATIENTEN":
                        pnlPatho.Visible = true;
                        btnNexusPatienten.Visible = true;
                        btnNexusPatienten.ToolTip = sUserPerm;
                        break;
                    case "V_NEXUS_PATIENTEN_GESAMT":
                        pnlPatho.Visible = true;
                        btnNexusPatientenGesamt.Visible = true;
                        btnNexusPatientenGesamt.ToolTip = sUserPerm;
                        break;
                    case "V_NEXUS_PATIENTEN_THORAX":
                        pnlPatho.Visible = true;
                        btnNexusPatientenThorax.Visible = true;
                        btnNexusPatientenThorax.ToolTip = sUserPerm;
                        break;
                    case "V_WIDERRUF_KOMPLETT":
                        pnlPatho.Visible = true;
                        btnWiderrufKomplett.Visible = true;
                        btnWiderrufKomplett.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_TBB_NEXUS":
                        pnlTBB.Visible = true;
                        btnTBBNexus.Visible = true;
                        btnTBBNexus.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_SFB1118_PRO_PROJEKT":
                        pnlTBB.Visible = true;
                        btnSFB1118.Visible = true;
                        btnSFB1118.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_SFB_1118_ANTIKOERPER":
                        pnlTBB.Visible = true;
                        btnSFB1118_AK.Visible = true;
                        btnSFB1118_AK.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_DIENSTLEISTUNGEN_PRO_JAHR":
                        pnlTBB.Visible = true;
                        btnDLJahr.Visible = true;
                        btnDLJahr.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_SCHNITTE_PRO_JAHR":
                        pnlTBB.Visible = true;
                        btnSchnitteJahr.Visible = true;
                        btnSchnitteJahr.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_SCHNITTE_PRO_MONAT":
                        pnlTBB.Visible = true;
                        btnSchnitteMonat.Visible = true;
                        btnSchnitteMonat.ToolTip = sUserPerm;
                        break;
                    case "V_STATISTIK_SCHNITTE_PRO_PROJEKT":
                        pnlTBB.Visible = true;
                        btnSchnitteProjekt.Visible = true;
                        btnSchnitteProjekt.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_LBB_PROBASE":
                        pnlLiquid.Visible = true;
                        btnProbase.Visible = true;
                        btnProbase.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_LBB_MELANOM":
                        pnlLiquid.Visible = true;
                        btnMelanom.Visible = true;
                        btnMelanom.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_LBB_HIPO":
                        pnlLiquid.Visible = true;
                        btnHIPO.Visible = true;
                        btnHIPO.ToolTip = sUserPerm;
                        break;
                    case "V_NCT_LBB_SPORTUNDKREBS":
                        pnlLiquid.Visible = true;
                        btnSportUndKrebs.Visible = true;
                        btnSportUndKrebs.ToolTip = sUserPerm;
                        break;
                    case "V_DZIF_INFEKTIOLOGIE":
                        pnlDZIF.Visible = true;
                        btnInfect.Visible = true;
                        btnInfect.ToolTip = sUserPerm;
                        break;
                    case "V_STARLIMS_USER_LOGGED_IN":
                        pnlSTARLIMS.Visible = true;
                        btnDiagram.Visible = true;
                        btnActiveUsers.Visible = true;
                        btnActiveUsers.ToolTip = sUserPerm;
                        break;
                    case "V_STARLIMS_USER_STATISTICS":
                        pnlSTARLIMS.Visible = true;
                        btnDiagram.Visible = true;
                        btnUserStats.Visible = true;
                        btnUserStats.ToolTip = sUserPerm;
                        break;
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

            if (Session["GUID"] != null)
            {
                SQLexecute("delete from V_Recursive_Temp where GUID='" + Session["GUID"] + "'");
                SQLexecute("delete from V_Recursive_Log where GUID='" + Session["GUID"] + "'");
            }

            Session["GUID"] = null;

            Session["Recursive"] = null;

            if (Session["UserName"] == null)
                Session["UserName"] = Page.User.Identity.Name;

            String[] aUserPerm = GetUserPermissions();
            HideShowPanels(aUserPerm);
        }

        protected void btnDZIFupload_Click(object sender, EventArgs e)
        {
            //RestClient restClient = new RestClient("https://dzif-www.helmholtz-muenchen.de:8443/FileUploadService/rest/upload");
            //restClient.Authenticator = new RestSharp.Authenticators.HttpBasicAuthenticator("DZIF-HD", "-*Ab&Y/9qF");

            //RestRequest restRequest = new RestRequest();
            //restRequest.Method = Method.POST;

            ////restRequest.AlwaysMultipartFormData = true;
            //restRequest.AddHeader("content-type", "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW");
            //restRequest.AddHeader("accept", "text/html");
            //restRequest.AddHeader("cache-control", "no-cache");

            //// add files to upload (works with compatible verbs)
            //restRequest.AddFile("files", "Z:\\temp\\DZIF_HD_TX_Stammproben.csv");
            //restRequest.AddFile("files", "Z:\\temp\\DZIF_HD_TX_Aliquote.csv");

            //// execute the request
            //IRestResponse response = restClient.Execute(restRequest);
            
            //var content = response.Content; // raw content as string
            //ShowMsg(content);

            var client = new RestClient("https://dzif-www.helmholtz-muenchen.de:8443/FileUploadService/rest/upload");
            var request = new RestRequest(Method.POST);
            request.AddFile("files", "Z:\\temp\\DZIF_HD_TX_Stammproben.csv");
            request.AddFile("files", "Z:\\temp\\DZIF_HD_TX_Aliquote.csv");
            request.AddHeader("cache-control", "no-cache");
            request.AddHeader("authorization", "Basic RFpJRi1IRDotKkFiJlkvOXFG");
            request.AddHeader("content-type", "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW");
            request.AddHeader("accept", "text/html");
            request.AddParameter("multipart/form-data", ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);

            var content = response.Content; // raw content as string
            ShowMsg(content);
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