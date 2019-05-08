<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Config.aspx.cs" Inherits="BMBH_View.Config" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Systemkonfiguration</h3>
        <asp:Table ID="Table1" runat="server" Height="180px" Width="416px" CssClass="table" HorizontalAlign="Left">
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">
                    <asp:ImageButton ID="btnSysConf" runat="server" AlternateText="SysConf" BorderColor="#EEEEEE" BorderStyle="Outset" BorderWidth="1px" Height="100px" ImageUrl="~/images/starlims_pc.png" ToolTip="Systemkonfiguration" OnClick="btnSysConf_Click"/>
                    System-konfiguration
                </asp:TableCell>
                <asp:TableCell runat="server">
                    <asp:ImageButton ID="btnUserConf" runat="server" AlternateText="UserConf" BorderColor="#EEEEEE" BorderStyle="Outset" BorderWidth="1px" Height="100px" ImageUrl="~/images/patienten.png" ToolTip="Benutzerkonfiguration" OnClick="btnUserConf_Click"/>
                    Benutzer- und Rollenverwaltung   
                </asp:TableCell>                
                <asp:TableCell runat="server">
                    <asp:ImageButton ID="btnPanelConf" runat="server" AlternateText="PanelConf" BorderColor="#EEEEEE" BorderStyle="Outset" BorderWidth="1px" Height="100px" ImageUrl="~/images/colored_panel.png" ToolTip="Panel-Konfiguration" OnClick="btnPanelConf_Click"/>
                    Panel-Konfiguration
                </asp:TableCell>                
                <asp:TableCell runat="server">
                    <asp:ImageButton ID="btnDocConf" runat="server" AlternateText="DocConf" BorderColor="#EEEEEE" BorderStyle="Outset" BorderWidth="1px" Height="100px" ImageUrl="~/images/document.png" ToolTip="Dokumentenverwaltung" OnClick="btnDocConf_Click"/>
                    Dokumenten-verwaltung
                </asp:TableCell>                
                <asp:TableCell runat="server">
                    <asp:ImageButton ID="btnDiagConf" runat="server" AlternateText="DiagConf" BorderColor="#EEEEEE" BorderStyle="Outset" BorderWidth="1px" Height="100px" ImageUrl="~/images/chart_100_100.png" ToolTip="Diagramme und Berichte" OnClick="btnDiagConf_Click"/>
                    Diagramme und Berichte
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Content>