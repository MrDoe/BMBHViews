<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NCT-TBB.aspx.cs" Inherits="BMBH_View.NCT_TBB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Button ID="btnExcel" runat="server" OnClick="btnExcel_Click" Text="Excel-Export" />
    <asp:Panel ID="Panel1" runat="server" Height="1024px" ScrollBars="Both" Width="1280px">
        <asp:GridView ID="dgdNCT" runat="server" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server"></asp:SqlDataSource>
    </asp:Panel>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CLIN106_DATAConnectionString %>" SelectCommand="SELECT * FROM [V_NCT_TBB_GESAMT]"></asp:SqlDataSource>
</asp:Content>
