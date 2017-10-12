<%@ Page Title="BMBH Views" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BMBH_View._Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/> 
<asp:HiddenField ID="width" runat="server" />
<asp:HiddenField ID="height" runat="server" />
<div class="jumbotron" style="height: 217px">
    <img src="Images/bmbh_views2_550.png"/>
</div>
<div style="position:relative;top:-10px">
        <asp:Panel ID="pnlTBB" runat="server" BorderWidth="3px" BackColor="#FFF0E6" BorderColor="#FFFFFF" CssClass="inlineBlock" Visible="false">
        <h2>Gewebebank des NCT</h2>
        <p>Anträge:</p>
            <asp:Button ID="btnAntrag" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Antragsbearbeitung »" Width="163px" Visible="False" />
        <p>Probenkollektive:</p>
            <asp:Button ID="btnNCT_TBB_Gesamt" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="NCT-TBB_Gesamt »" Width="163px" Visible="False" />
            <asp:Button ID="btnNCT_TBB_ColoCare" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="NCT-TBB_ColoCare »" Width="163px" Visible="False" />
            <asp:Button ID="btnTBBNexus" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="TBB_Nexus »" Width="163px" Visible="False" />
            <p>Dienstleistungen:</p>
                <asp:Button ID="btnDLJahr" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Dienstleistungen/Jahr »" Visible="False" Width="160px" />
                <asp:Button ID="btnSchnitteJahr" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Schnitte/Jahr »" Visible="False" Width="160px" />
                <asp:Button ID="btnSchnitteMonat" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Schnitte/Monat »" Visible="False" Width="160px" />
                <asp:Button ID="btnSchnitteProjekt" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Schnitte/Projekt »" Visible="False" Width="160px" />
                <asp:Button ID="btnSFB1118" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="SFB1118_pro_Projekt »" Width="160px" Visible="False" />
                <asp:Button ID="btnSFB1118_AK" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="SFB1118_Antikörper »" Visible="False" Width="160px" />
        </asp:Panel>
        <asp:Panel ID="pnlPatho" runat="server" BackColor="#E4EDFB" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
            <h2>Pathologisches Institut</h2>
            <p>
                Informationen aus dem Pathologiesystem Nexus und ISH.med:</p>
            <p>
                <asp:Button ID="btnNexusEingaenge" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Nexus_Eingaenge »" Width="163px" Visible="False" />
                <asp:Button ID="btnNexusPatientenGesamt" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Nexus_Patienten_Gesamt »" Width="205px" Visible="False" />
                <asp:Button ID="btnNexusPatienten" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Nexus_Patienten »" Width="163px" Visible="False" />
                <asp:Button ID="btnNexusPatientenThorax" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Nexus_Patienten_Thorax »" Width="205px" Visible="False" />
                <asp:Button ID="btnWiderrufKomplett" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Widerruf_Komplett »" Width="163px" Visible="False" />
            </p>
        </asp:Panel>
        <asp:Panel ID="pnlLiquid" runat="server" BackColor="#E4FFE4" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
            <h2>NCT-Liquidbank</h2>
            <p>
                Probenkollektive der Liquidbank des NCT:</p>
            <p>
                <asp:Button ID="btnProbase" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Probase »" Visible="False" Width="142px" />
                <asp:Button ID="btnMelanom" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Melanom »" Visible="False" Width="142px" />
                <asp:Button ID="btnHIPO" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="POP-HIPO »" Visible="False" Width="142px" />
                <asp:Button ID="btnSportUndKrebs" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Sport + Krebs »" Visible="False" Width="142px" />
                <asp:Button ID="btnNCTLBBsupport" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="SUPPORT »" Visible="False" Width="142px" />
            </p>
        </asp:Panel>
        <asp:Panel ID="pnlDZIF" runat="server" BackColor="#EAFFFF" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
            <h2>DZIF</h2>
            <p>
                Probenkollektive des Deutschen Zentrums für Infektionsforschung:</p>
            <p>
                <asp:Button ID="btnDZIFprimary" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="DZIF_Primary »" Width="124px" Visible="False" />
                <asp:Button ID="btnDZIFaliquots" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="DZIF_Aliquots »" Width="120px" Visible="False" />
                <asp:Button ID="btnDZIFreleases" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="DZIF_Releases »" Width="130px" Visible="False" />
                <asp:Button ID="btnInfect" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Infektiologie »" Visible="False" Width="124px" />
            </p>
            <p>
                <asp:Button ID="btnDZIFupload" runat="server" BackColor="#E8FFCC" BorderColor="#33CC33" BorderStyle="Outset" BorderWidth="1px" CssClass="btn btn-default" Height="34px" OnClick="btnDZIFupload_Click" Text="Upload ins ZBR »" Visible="False" Width="124px" />
            </p>
        </asp:Panel>
        <asp:Panel ID="pnlPraevonk" runat="server" BackColor="#E2FBF7" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
            <h2>Präventive Onkologie</h2>
            <p>
                Studienkollektive der Abteilung Präventive Onkologie am NCT:</p>
            <p>
                <asp:Button ID="btnGEKKO" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="GEKKO »" Width="142px" Visible="False" />
                <asp:Button ID="btnDARIO" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="DARIO »" Width="142px" Visible="False" />
                <asp:Button ID="btnColoCare" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="ColoCare »" Width="142px" Visible="False" />
            </p>
        </asp:Panel>
        <asp:Panel ID="pnlPanco" runat="server" BackColor="#FFF1D7" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
            <h2>PancoBank/EPZ</h2>
            <p>
                Probenkollektive der PancoBank am Europäischen Pankreaszentrum:</p>
            <p>
                <asp:Button ID="btnPancoBank_Liquid" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="PancoBank_Liquid »" Width="166px" Visible="False" />
                <asp:Button ID="btnPancoBank_BioPac" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="PancoBank_BioPac »" Width="166px" Visible="False" />
                <asp:Button ID="btnPancoBank_Paraffin" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="PancoBank_Paraffin »" Width="166px" Visible="False" />
                <asp:Button ID="btnPancoBank_Kryo" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="PancoBank_Kryo »" Width="166px" Visible="False" />
            </p>
        </asp:Panel>
        <asp:Panel ID="pnlThorax" runat="server" BackColor="#FCF6FF" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
            <h2>Lungenbiobank der Thoraxklinik</h2>
            <p>
                Patienten- und Probenkollektive der Lungenbiobank an der Thoraxklinik:</p>
            <p>
                <asp:Button ID="btnThoraxCases" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Fälle_Thorax »" Width="131px" Visible="False" />
                <asp:Button ID="btnThoraxSamples" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Proben_Thorax »" Width="131px" Visible="False" />
                <asp:Button ID="btnThoraxGesamt" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Thorax_Gesamt »" Width="131px" Visible="False" />
            </p>
        </asp:Panel>
        <asp:Panel ID="pnlSTARLIMS" runat="server" BackColor="#FFFED5" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
            <h2>STARLIMS</h2>
            <p>
                Administrationstabellen und Statistiken von STARLIMS</p>
            <p>
                <asp:Button ID="btnActiveUsers" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Aktive Benutzer »" Width="131px" Visible="False" />
                <asp:Button ID="btnUserStats" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Benutzerstatistik »" Width="131px" Visible="False" />
                <asp:Button ID="btnDiagram" runat="server" BackColor="#DDFFFF" BorderColor="#CCFFFF" BorderStyle="Outset" BorderWidth="1px" CssClass="btn btn-default" Height="34px" OnClick="btnDiagram_Click" Text="Diagramm »" Width="124px" Visible="False" />
            </p>
        </asp:Panel>
</div>
</asp:Content>
