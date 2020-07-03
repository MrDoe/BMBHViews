<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SysConf.aspx.cs" Inherits="BMBHviews.SysConf" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Systemkonfiguration</h4>
    <asp:GridView ID="dgdSysConf" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ORIGREC" DataSourceID="SqlDataSource1" ForeColor="#333333" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/error_16x16.gif" EditImageUrl="~/Images/table_(edit)_16x16.gif" SelectImageUrl="~/Images/right_16x16.gif" ShowEditButton="True" UpdateImageUrl="~/Images/save_16x16.gif" />
            <asp:BoundField DataField="ORIGREC" HeaderText="ORIGREC" InsertVisible="False" ReadOnly="True" SortExpression="ORIGREC" Visible="False" />
            <asp:BoundField DataField="OPTION_NAME" HeaderText="Option Name" SortExpression="OPTION_NAME" />
            <asp:BoundField DataField="OPTION_VALUE" HeaderText="Option Value" SortExpression="OPTION_VALUE" />
        </Columns>
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

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" DeleteCommand="DELETE FROM [SysConfig] WHERE [ORIGREC] = @ORIGREC" InsertCommand="INSERT INTO [SysConfig] ([OPTION_NAME], [OPTION_VALUE]) VALUES (@OPTION_NAME, @OPTION_VALUE)" SelectCommand="SELECT * FROM [SysConfig]" UpdateCommand="UPDATE [SysConfig] SET [OPTION_NAME] = @OPTION_NAME, [OPTION_VALUE] = @OPTION_VALUE WHERE [ORIGREC] = @ORIGREC">
        <DeleteParameters>
            <asp:Parameter Name="ORIGREC" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="OPTION_NAME" Type="String" />
            <asp:Parameter Name="OPTION_VALUE" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="OPTION_NAME" Type="String" />
            <asp:Parameter Name="OPTION_VALUE" Type="String" />
            <asp:Parameter Name="ORIGREC" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
<p>
    &nbsp;</p>
    <p>
    <asp:Button ID="btnSendEmail" runat="server" OnClick="btnSendEmail_Click" Text="Test-E-Mail verschicken" />
</p>
</asp:Content>
