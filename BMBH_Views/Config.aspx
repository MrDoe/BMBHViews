<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Config.aspx.cs" Inherits="BMBH_View.Config" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Systemkonfiguration</h3>
        <asp:Table ID="Table1" runat="server" Height="180px" Width="416px" CssClass="table" HorizontalAlign="Left">
            <asp:TableRow runat="server">
                <asp:TableCell runat="server">
                    <asp:ImageButton ID="btnUserConf" runat="server" AlternateText="UserConf" BorderColor="#EEEEEE" BorderStyle="Outset" BorderWidth="1px" Height="100px" ImageUrl="/images/patienten.png" ToolTip="Benuterkonfiguration" OnClick="btnUserConf_Click"/>
                    Benutzerverwaltung   
                </asp:TableCell>                
                <asp:TableCell runat="server">
                    <asp:ImageButton ID="btnPanelConf" runat="server" AlternateText="PanelConf" BorderColor="#EEEEEE" BorderStyle="Outset" BorderWidth="1px" Height="100px" ImageUrl="/images/colored_panel.png" ToolTip="Panel-Konfiguration" OnClick="btnPanelConf_Click"/>
                    Panel-Konfiguration
                </asp:TableCell>                
                <asp:TableCell runat="server">
                    <asp:ImageButton ID="btnDiagConf" runat="server" AlternateText="DiagConf" BorderColor="#EEEEEE" BorderStyle="Outset" BorderWidth="1px" Height="100px" ImageUrl="/images/chart_100_100.png" ToolTip="Diagramme und Berichte" OnClick="btnDiagConf_Click"/>
                    Diagramme und Berichte
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Content>
