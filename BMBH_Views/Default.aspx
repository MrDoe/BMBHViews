<%@ Page Title="BMBH Views" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BMBH_View._Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/> 
<asp:HiddenField ID="width" runat="server" />
<asp:HiddenField ID="height" runat="server" />
<div class="jumbotron" style="height: 217px">
    <img src="Images/bmbh_views2_550.png"/>
</div>
<div style="position:relative;top:-10px">

<asp:Panel ID="pnlTBBmain" runat="server" BorderWidth="3px" BackColor="#FFF0E6" BorderColor="#FFFFFF" CssClass="inlineBlock" Visible="false">
    <h2>Gewebebank des NCT</h2>  
    <asp:Panel ID="pnlTBB" runat="server" BorderWidth="0px" BackColor="#FFF0E6" BorderColor="#FFFFFF" Visible="false">
    <p>Probenkollektive:</p>
    </asp:Panel>
    <asp:Panel ID="pnlTBB_Projekte" runat="server" BorderWidth="0px" BackColor="#FFF0E6" BorderColor="#FFFFFF" Visible="false">
        <p>Projektanträge & Dienstleistungen:</p>
    </asp:Panel>
</asp:Panel>

<asp:Panel ID="pnlPatho" runat="server" BackColor="#E4EDFB" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
    <h2>Pathologisches Institut</h2>
    <p>
        Informationen aus dem Pathologiesystem Nexus und ISH.med:</p>
</asp:Panel>

<asp:Panel ID="pnlLiquid" runat="server" BackColor="#E4FFE4" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
    <h2>NCT-Liquidbank</h2>
    <p> Probenkollektive der Liquidbank des NCT:</p>
</asp:Panel>

<asp:Panel ID="pnlMedV" runat="server" BackColor="#FFF2FC" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
    <h2>Medizinische Klinik V</h2>
    <p>Patienten- und Probenkollektive der Medizinischen Klinik V:</p>
</asp:Panel>

<asp:Panel ID="pnlPraevonk" runat="server" BackColor="#E2FBF7" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
    <h2>Präventive Onkologie</h2>
    <p>
        Studienkollektive der Abteilung Präventive Onkologie am NCT:</p>
</asp:Panel>

<asp:Panel ID="pnlPanco" runat="server" BackColor="#FFF1D7" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
    <h2>PancoBank/EPZ</h2>
    <p>
        Probenkollektive der PancoBank am Europäischen Pankreaszentrum:</p>
</asp:Panel>

<asp:Panel ID="pnlDZIF" runat="server" BackColor="#EAFFFF" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
    <h2>DZIF</h2>
    <p>Probenkollektive des Deutschen Zentrums für Infektionsforschung:</p>
    <p>
        <asp:Button ID="btnDZIFupload" runat="server" BackColor="#E8FFCC" BorderColor="#33CC33" BorderStyle="Outset" BorderWidth="1px" CssClass="btn btn-default" Height="34px" OnClick="btnDZIFupload_Click" Text="Upload ins ZBR »" Visible="True" Width="170px" />
    </p>
</asp:Panel>

<asp:Panel ID="pnlThorax" runat="server" BackColor="#FCF6FF" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
    <h2>Lungenbiobank der Thoraxklinik</h2>
    <p>
        Patienten- und Probenkollektive der Lungenbiobank an der Thoraxklinik:</p>
</asp:Panel>

<asp:Panel ID="pnlSTARLIMS" runat="server" BackColor="#FFFED5" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
    <h2>STARLIMS</h2>
    <p>Administrationstabellen und Statistiken von STARLIMS</p>
    <p>
        <asp:Button ID="btnDiagram" runat="server" BackColor="#DDFFFF" BorderColor="#BBEEEE" BorderStyle="Outset" BorderWidth="1px" CssClass="btn btn-default" Height="34px" OnClick="btnDiagram_Click" Text="Diagramm »" Width="170px" Visible="True" />
    </p>
</asp:Panel>

<asp:Panel ID="pnlGyn" runat="server" BackColor="#E8E8FF" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
    <h2>Frauenklinik</h2>
    <p>Probenkollektive der Frauenklinik</p>
</asp:Panel>

<asp:Panel ID="pnlPubs" runat="server" BackColor="#E8E8FF" BorderColor="#FFFFFF" BorderWidth="3px" CssClass="inlineBlock" Visible="false">
    <h2>Publications</h2>
    <p>Microsoft Example Database</p>
</asp:Panel>

</div>
</asp:Content>
