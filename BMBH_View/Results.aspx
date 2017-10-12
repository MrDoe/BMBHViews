<%@ Page Title="BMBH-Views - Tabellenansicht" Language="C#" EnableEventValidation="false" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="BMBH_View.Results" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/> 
<asp:HiddenField ID="width" runat="server" />
<asp:HiddenField ID="height" runat="server" />
    <asp:Panel ID="pnlMain" runat="server" EnableViewState="False" Height="1000px" Width="100%" style="top:4px; position:relative" >
        <asp:Button ID="btnSearch" runat="server" Text="Suche" CssClass="btn btn-default btn-small" EnableViewState="False" style="left:0px; position:relative; top:-2px; height:24px; width:60px" TabIndex="999" OnClick="btnSearch_Click" UseSubmitBehavior="False"/>
        &nbsp;
        <asp:ImageButton ID="btnPrevPage" runat="server" EnableViewState="False" BackColor="#EAF5F8" BorderColor="#E2E2E2" BorderStyle="Outset" BorderWidth="1px" CssClass="btn-info" Height="24px" ImageUrl="~/Images/NavigateBackwards_6270.png" OnClick="btnPrevPage_Click" ToolTip="Vorherige Seite" style="left: 1px; top: 5px" TabIndex="3" />
        &nbsp;<asp:ImageButton ID="btnNextPage" runat="server" EnableViewState="False" BackColor="#EAF5F8" BorderColor="#E2E2E2" BorderStyle="Outset" BorderWidth="1px" CssClass="btn-info" Height="24px" ImageUrl="~/Images/NavigateForward_6271.png" OnClick="btnNextPage_Click" ToolTip="Nächste Seite" style="left: 1px; top: 5px" TabIndex="4" />
        &nbsp;Seite&nbsp;
        <asp:TextBox ID="txtPage" runat="server" Width="44px" TabIndex="4">1</asp:TextBox>
        &nbsp;von &nbsp;
        <asp:TextBox ID="txtMaxPage" runat="server" ReadOnly="True" Width="53px" TabIndex="5">1</asp:TextBox>
        &nbsp;&nbsp; Einträge pro Seite:&nbsp;
        <asp:TextBox ID="txtRowPerPage" runat="server" Width="46px" TabIndex="6">30</asp:TextBox>
        &nbsp;<asp:Button ID="btnRefresh" runat="server" CssClass="btn btn-default btn-small" OnClick="btnRefresh_Click" Text="OK" UseSubmitBehavior="True" style="position:relative; top:-2px; height:24px" TabIndex="2"/>
        &nbsp; # Datensätze:
        <asp:TextBox ID="txtTotalRows" runat="server" Width="63px" TabIndex="8"></asp:TextBox>
        <div style="display:block;float:right">
        <asp:ImageButton ID="btnExcel" runat="server" BackColor="#EAF5F8" BorderStyle="Outset" BorderWidth="1px" CssClass="btn-info" Height="24px" ImageUrl="~/Images/Excel-icon.png" OnClick="btnExcel_Click" BorderColor="#E2E2E2" ToolTip="Excel-Export" style="left:-14px; top:5px;" EnableViewState="False" TabIndex="9"/>
        </div>
        <asp:Panel ID="pnlGrid" runat="server" BorderColor="White" BorderStyle="Solid" BorderWidth="5px" Height="100%" HorizontalAlign="Center" ScrollBars="Both" Wrap="True" EnableViewState="False" Width="100%">
            <asp:GridView ID="dgdNCT" runat="server" AllowPaging="True" AllowSorting="True" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" Font-Names="Arial" Font-Size="8pt" ForeColor="#333333" PageSize="30" Height="100%" TabIndex="7" Width="100%" OnSorting="dgdNCT_Sorting">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="False" ForeColor="White" />
                <PagerSettings FirstPageText="Seite &amp;lt;&amp;lt;" Position="Top" Visible="False" />
                <PagerStyle BackColor="#284775" BorderStyle="Dotted" BorderWidth="1px" ForeColor="White" HorizontalAlign="Left" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            </asp:GridView>
        </asp:Panel>
    </asp:Panel>
    </asp:Content>
