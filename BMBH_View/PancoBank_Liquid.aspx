<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PancoBank_Liquid.aspx.cs" Inherits="BMBH_View.PancoBank_Liquid" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="Panel1" runat="server">
        <asp:Button ID="btnSearch" runat="server" PostBackUrl="~/PancoBank_Liquid_Search.aspx" Text="Suche" CssClass="btn-pnl" Height="27px" />
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
        <div style="display:block;float:right;">
        <asp:ImageButton ID="btnExcel" runat="server" BackColor="#EAF5F8" BorderStyle="Outset" BorderWidth="2px" CssClass="btn-info" Height="24px" ImageUrl="~/Images/Excel-icon.png" OnClick="btnExcel_Click" BorderColor="#E2E2E2" ToolTip="Excel-Export" />
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlGrid" runat="server" Height="900px" ScrollBars="Both" HorizontalAlign="Center" BorderColor="White" BorderStyle="Solid" BorderWidth="5px">
        <asp:GridView ID="dgdNCT" runat="server" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" BorderStyle="Solid" Font-Names="Arial" Font-Size="Small" PageSize="100" BorderColor="Black" BorderWidth="1px">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerSettings FirstPageText="Seite &amp;lt;&amp;lt;" Position="Top" Visible="False" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Left" BorderStyle="Dotted" BorderWidth="1px" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="PancoBank_Liquid_View_Sort" runat="server" ConnectionString="<%$ ConnectionStrings:CLIN106_DATAConnectionString %>" SelectCommand="select * from V_PancoBank_Liquid_Gesamt order by InventarID"></asp:SqlDataSource>
        <asp:SqlDataSource ID="PancoBank_Liquid_View" runat="server" ConnectionString="<%$ ConnectionStrings:CLIN106_DATAConnectionString %>" SelectCommand="SELECT * FROM [V_PancoBank_Liquid]"></asp:SqlDataSource>
    </asp:Panel>
    </asp:Content>

