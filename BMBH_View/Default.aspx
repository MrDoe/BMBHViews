<%@ Page Title="BMBH Views" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BMBH_View._Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/> 
<asp:HiddenField ID="width" runat="server" />
<asp:HiddenField ID="height" runat="server" />
<div class="jumbotron" style="height: 240px">
    <h1>BMBH-Views</h1>
    <p class="lead">Datenexplorationstool der BioMaterialBank Heidelberg</p>
</div>
<table style="width:100%;">
    <tr>
        <td style="width: 439px; height: 300px">
        <asp:Panel ID="pnlTBB" runat="server" BorderWidth="5px" Height="320px" Width="455px" BackColor="#FFF9F9" BorderColor="#FFF9F9">
        <h2>Gewebebank des NCT</h2>
        <p>
            Probenkollektive:</p>
        <p>
            <asp:Button ID="btnNCT_TBB_Gesamt" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="NCT-TBB_Gesamt »" Width="163px" Visible="False" />
            <asp:Button ID="btnNCT_TBB_ColoCare" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="NCT-TBB_ColoCare »" Width="163px" Visible="False" />
            <asp:Button ID="btnTBBNexus" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="TBB_Nexus »" Width="163px" Visible="False" />
        </p>
            Dienstleistungen:
            <p>
                <asp:Button ID="btnDLJahr" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Dienstleistungen/Jahr »" Visible="False" Width="184px" />
                <asp:Button ID="btnSchnitteJahr" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Schnitte/Jahr »" Visible="False" Width="184px" />
                <asp:Button ID="btnSchnitteMonat" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Schnitte/Monat »" Visible="False" Width="184px" />
                <asp:Button ID="btnSchnitteProjekt" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Schnitte/Projekt »" Visible="False" Width="184px" />
                <asp:Button ID="btnSFB1118" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="SFB1118_pro_Projekt »" Width="184px" Visible="False" />
                <asp:Button ID="btnSFB1118_AK" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="SFB1118_Antikörper »" Visible="False" Width="184px" />
            </p>
        </asp:Panel>
        </td>

        <td>
        <asp:Panel ID="pnlPatho" runat="server" Height="320px" Width="465px" BackColor="#F4FAFF" BorderColor="#F4FAFF" BorderWidth="5px">
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
        </td>
    </tr>
    <tr>
        <td>
        <asp:Panel ID="pnlLiquid" runat="server" BackColor="#F4FFF4" BorderColor="#F4FFF4" BorderWidth="5px" Width="455px" Height="200px">
            <h2>NCT-Liquidbank</h2>
            <p>
                Probenkollektive der Liquidbank des NCT:</p>
            <p>
                <asp:Button ID="btnDKTKliquid" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="DKTK_Liquid »" Width="142px" Visible="False" />
                <asp:Button ID="btnNCTLBBsupport" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="SUPPORT »" Width="142px" Visible="False" />
            </p>
        </asp:Panel>
        </td>

        <td>
        <asp:Panel ID="pnlDZIF" runat="server" BackColor="#F4FFFF" BorderColor="#F4FFFF" BorderWidth="5px" Width="465px" Height="200px">
            <h2>DZIF</h2>
            <p>
                Probenkollektive des Deutschen Zentrums für Infektionsforschung:</p>
            <p>
                <asp:Button ID="btnDZIFprimary" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="DZIF_Primary »" Width="142px" Visible="False" />
                <asp:Button ID="btnDZIFaliquots" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="DZIF_Aliquots »" Width="141px" Visible="False" />
                <asp:Button ID="btnDZIFreleases" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="DZIF_Releases »" Width="151px" Visible="False" /><br />
                <asp:Button ID="btnDZIFupload" runat="server" BackColor="#E8FFCC" BorderColor="#33CC33" BorderStyle="Outset" BorderWidth="1px" CssClass="btn btn-default" OnClick="btnDZIFupload_Click" Text="Upload ins ZBR »" Width="142px" Height="34px" Visible="False" />
            </p>
        </asp:Panel>
        </td>
    </tr>
    <tr>
        <td>
        <asp:Panel ID="pnlPraevonk" runat="server" BackColor="#FFFFF2" BorderColor="#FFFFF2" BorderWidth="5px" Height="200px" Width="456px">
            <h2>Präventive Onkologie</h2>
            <p>
                Studienkollektive der Abteilung Präventive Onkologie am NCT:</p>
            <p>
                <asp:Button ID="btnGEKKO" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="GEKKO »" Width="142px" Visible="False" />
                <asp:Button ID="btnDARIO" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="DARIO »" Width="142px" Visible="False" />
                <asp:Button ID="btnColoCare" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="ColoCare »" Width="142px" Visible="False" />
            </p>
        </asp:Panel>
        </td>

        <td>
        <asp:Panel ID="pnlPanco" runat="server" BackColor="#FFFCF4" BorderColor="#FFFCF4" BorderWidth="5px" Height="200px" Width="465px">
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
        </td>
    <tr>
        <td>
        <asp:Panel ID="pnlThorax" runat="server" BackColor="#FCF9FF" BorderColor="#FCF9FF" BorderWidth="5px" Width="456px" Height="200px">
            <h2>Lungenbiobank der Thoraxklinik</h2>
            <p>
                Patienten- und Probenkollektive der Lungenbiobank an der Thoraxklinik:</p>
            <p>
                <asp:Button ID="btnThoraxCases" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Fälle_Thorax »" Width="131px" Visible="False" />
                <asp:Button ID="btnThoraxSamples" runat="server" CssClass="btn btn-default" OnClick="btnGeneric_Click" Text="Proben_Thorax »" Width="131px" Visible="False" />
            </p>
        </asp:Panel>
        </td>
    </tr>
    </table>
</asp:Content>
