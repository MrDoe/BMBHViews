using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BMBH_View
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["LastQuery"] = null;
        }

        protected void btnNCT_TBB_Gesamt_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_NCT_TBB_GESAMT";
            Session["FormTable"] = "V_NCT_TBB_GESAMT_Search";
            Session["FormView"] = "V_NCT_TBB_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnPancoBank_Liquid_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_PANCOBANK_LIQUID";
            Session["FormTable"] = "V_PancoBank_Liquid_Search";
            Session["FormView"] = "V_PancoBank_Liquid_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnPancoBank_Kryo_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_PANCOBANK_KRYO";
            Session["FormTable"] = "V_PANCOBANK_KRYO_Search";
            Session["FormView"] = "V_PANCOBANK_KRYO_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnPancoBank_Paraffin_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_PANCOBANK_PARAFFIN";
            Session["FormTable"] = "V_PANCOBANK_PARAFFIN_Search";
            Session["FormView"] = "V_PANCOBANK_PARAFFIN_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnPancoBank_BioPac_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_PANCOBANK_BIOPAC";
            Session["FormTable"] = "V_PANCOBANK_BIOPAC_Search";
            Session["FormView"] = "V_PANCOBANK_BIOPAC_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnThoraxCases_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_THORAX_CASES";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnDZIFprimary_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_DZIF_PRIMARY";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnDZIFaliquots_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_DZIF_ALIQUOTS";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnDZIFreleases_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_DZIF_RELEASES";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnDKTKliquid_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_NCT_DKTK_LIQUID";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnNCTLBBsupport_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_NCT_SUPPORT";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnGEKKO_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_NCT_LBB_PO_GEKKO";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnDARIO_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_NCT_LBB_PO_DARIO";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnColoCare_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_NCT_COLOCARE";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnNCT_TBB_ColoCare_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_NCT_TBB_COLOCARE";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnNexusEingaenge_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_Nexus_Eingaenge";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnNexusPatienten_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_Nexus_Patienten";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnNexusPatientenGesamt_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_Nexus_Patienten_Gesamt";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnNexusPatientenThorax_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_Nexus_Patienten_Thorax";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }

        protected void btnWiderrufKomplett_Click(object sender, EventArgs e)
        {
            Session["View"] = "V_Widerruf_Komplett";
            Session["FormTable"] = Session["View"] + "_Search";
            Session["FormView"] = Session["View"] + "_SearchForm";
            Response.Redirect("Results.aspx");
        }
    }
}