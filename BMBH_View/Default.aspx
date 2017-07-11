<%@ Page Title="BMBH Views" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BMBH_View._Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>BMBH-Views</h1>
        <p class="lead">Datenexplorationstool der BioMaterialBank Heidelberg</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Gewebebank des NCT</h2>
            <p>
                Probenkollektive der Gewebebank des NCT:</p>
            <p>
                <asp:Button ID="btnNCT_TBB_Gesamt" runat="server" CssClass="btn btn-default" OnClick="btnNCT_TBB_Gesamt_Click" Text="NCT-TBB_Gesamt »" Width="163px" />
                <asp:Button ID="btnNCT_TBB_ColoCare" runat="server" CssClass="btn btn-default" OnClick="btnNCT_TBB_ColoCare_Click" Text="NCT-TBB_ColoCare »" Width="163px" />
            </p>
        </div>
        <div class="col-md-4">
            <h2>Pathologisches Institut</h2>
            <p>
                Informationen aus dem Pathologiesystem Nexus:</p>
            <p>
                <asp:Button ID="btnNexusEingaenge" runat="server" CssClass="btn btn-default" OnClick="btnNexusEingaenge_Click" Text="Nexus_Eingaenge »" Width="163px" />
                <asp:Button ID="btnNexusPatienten" runat="server" CssClass="btn btn-default" OnClick="btnNexusPatienten_Click" Text="Nexus_Patienten »" Width="163px" />
            </p>
            <p>
                <asp:Button ID="btnNexusPatientenGesamt" runat="server" CssClass="btn btn-default" OnClick="btnNexusPatientenGesamt_Click" Text="Nexus_Patienten_Gesamt »" Width="211px" />
                <asp:Button ID="btnNexusPatientenThorax" runat="server" CssClass="btn btn-default" OnClick="btnNexusPatientenThorax_Click" Text="Nexus_Patienten_Thorax »" Width="205px" />
            </p>
            <p>
                <asp:Button ID="btnWiderrufKomplett" runat="server" CssClass="btn btn-default" OnClick="btnWiderrufKomplett_Click" Text="Widerruf_Komplett »" Width="163px" />
            </p>
        </div>
        <div class="col-md-4">
            <h2>NCT-Liquidbank</h2>
            <p>
                Probenkollektive der Liquidbank des NCT.</p>
            <p>
                <asp:Button ID="btnDKTKliquid" runat="server" CssClass="btn btn-default" OnClick="btnDKTKliquid_Click" Text="DKTK_Liquid »" Width="142px" />
                <asp:Button ID="btnNCTLBBsupport" runat="server" CssClass="btn btn-default" OnClick="btnNCTLBBsupport_Click" Text="SUPPORT »" Width="142px" />
            </p>
        </div>
        <div class="col-md-4">
            <h2>DZIF</h2>
            <p>
                Probenkollektive des Deutschen Zentrums für Infektionsforschung</p>
            <p>
                <asp:Button ID="btnDZIFprimary" runat="server" CssClass="btn btn-default" OnClick="btnDZIFprimary_Click" Text="DZIF_Primary »" Width="142px" />
                <asp:Button ID="btnDZIFaliquots" runat="server" CssClass="btn btn-default" OnClick="btnDZIFaliquots_Click" Text="DZIF_Aliquots »" Width="141px" />
                <asp:Button ID="btnDZIFreleases" runat="server" CssClass="btn btn-default" OnClick="btnDZIFreleases_Click" Text="DZIF_Releases »" Width="151px" />
            </p>
        </div>
        <div class="col-md-4">
            <h2>Präventive Onkologie</h2>
            <p>
                <asp:Button ID="btnGEKKO" runat="server" CssClass="btn btn-default" OnClick="btnGEKKO_Click" Text="GEKKO »" Width="142px" />
                <asp:Button ID="btnDARIO" runat="server" CssClass="btn btn-default" OnClick="btnDARIO_Click" Text="DARIO »" Width="142px" />
                <asp:Button ID="btnColoCare" runat="server" CssClass="btn btn-default" OnClick="btnColoCare_Click" Text="ColoCare »" Width="142px" />
            </p>
        </div>
        <div class="col-md-4">
            <h2>PancoBank/EPZ</h2>
            <p>
                Probenkollektive der PancoBank am Europäischen Pankreaszentrum:</p>
            <p>
                &nbsp;<asp:Button ID="btnPancoBank_Liquid" runat="server" CssClass="btn btn-default" OnClick="btnPancoBank_Liquid_Click" Text="PancoBank_Liquid »" Width="166px" />
                <asp:Button ID="btnPancoBank_BioPac" runat="server" CssClass="btn btn-default" OnClick="btnPancoBank_BioPac_Click" Text="PancoBank_BioPac »" Width="166px" />
            </p>
            <p>
                <asp:Button ID="btnPancoBank_Paraffin" runat="server" CssClass="btn btn-default" OnClick="btnPancoBank_Paraffin_Click" Text="PancoBank_Paraffin »" Width="166px" />
                <asp:Button ID="btnPancoBank_Kryo" runat="server" CssClass="btn btn-default" OnClick="btnPancoBank_Kryo_Click" Text="PancoBank_Kryo »" Width="166px" />
            </p>
        </div>
        <div class="col-md-4">
            <h2>Lungenbiobank der Thoraxklinik</h2>
    <p>Patienten- und Probenkollektive der Lungenbiobank an der Thoraxklinik</p>
    <p>
        <asp:Button ID="btnThoraxCases" runat="server" CssClass="btn btn-default" OnClick="btnThoraxCases_Click" Text="Fälle_Thorax »" Width="131px" />
    </p>
    </div>
    </div>
</asp:Content>
