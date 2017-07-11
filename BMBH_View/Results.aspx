<%@ Page Title="BMBH-Views - Tabellenansicht" Language="C#" EnableEventValidation="false" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="BMBH_View.NCT_TBB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/> 
    <asp:Panel ID="Panel1" runat="server">
        <asp:Button ID="btnSearch" runat="server" PostBackUrl="~/Search.aspx" Text="Suche" CssClass="btn-pnl" Height="27px" />
        &nbsp;
        <asp:ImageButton ID="btnPrevPage" runat="server" BackColor="#EAF5F8" BorderColor="#E2E2E2" BorderStyle="Outset" BorderWidth="2px" CssClass="btn-info" Height="24px" ImageUrl="~/Images/NavigateBackwards_6270.png" OnClick="btnPrevPage_Click" ToolTip="Vorherige Seite" />
        &nbsp;<asp:ImageButton ID="btnNextPage" runat="server" BackColor="#EAF5F8" BorderColor="#E2E2E2" BorderStyle="Outset" BorderWidth="2px" CssClass="btn-info" Height="24px" ImageUrl="~/Images/NavigateForward_6271.png" OnClick="btnNextPage_Click" ToolTip="Nächste Seite" />
        &nbsp;Seite&nbsp;
        <asp:TextBox ID="txtPage" runat="server" Width="44px">1</asp:TextBox>
        &nbsp; von &nbsp;
        <asp:TextBox ID="txtMaxPage" runat="server" ReadOnly="True" Width="53px">100</asp:TextBox>
        &nbsp;&nbsp; Einträge pro Seite:&nbsp;
        <asp:TextBox ID="txtRowPerPage" runat="server" Width="46px">100</asp:TextBox>
        &nbsp;<asp:Button ID="btnRefresh" runat="server" CssClass="btn-pnl" OnClick="btnRefresh_Click" Text="OK" Height="25px" />
        &nbsp; # Datensätze:
        <asp:TextBox ID="txtTotalRows" runat="server" Width="63px"></asp:TextBox>
        <div style="display:block;float:right">
        <asp:ImageButton ID="btnExcel" runat="server" BackColor="#EAF5F8" BorderStyle="Outset" BorderWidth="2px" CssClass="btn-info" Height="24px" ImageUrl="~/Images/Excel-icon.png" OnClick="btnExcel_Click" BorderColor="#E2E2E2" ToolTip="Excel-Export" />
        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        </div>
        <asp:Panel ID="pnlGrid" runat="server" BorderColor="White" BorderStyle="Solid" BorderWidth="5px" Height="900px" HorizontalAlign="Center" ScrollBars="Both">
            <asp:GridView ID="dgdNCT" runat="server" AllowPaging="True" AllowSorting="True" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" Font-Names="Arial" Font-Size="Small" ForeColor="#333333" PageSize="100">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerSettings FirstPageText="Seite &amp;lt;&amp;lt;" Position="Top" Visible="False" />
                <PagerStyle BackColor="#284775" BorderStyle="Dotted" BorderWidth="1px" ForeColor="White" HorizontalAlign="Left" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
        </asp:Panel>
    </asp:Panel>
    </asp:Content>
