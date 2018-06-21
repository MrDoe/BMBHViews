<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MultipleSearch.aspx.cs" Inherits="BMBH_View.MultipleSearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default btn-small" Text="Suche starten" Width="92px" OnClick="btnSearch_Click" />
    <asp:Button ID="btnNew" runat="server" CssClass="btn btn-default btn-small" Text="Neue Suche" OnClick="btnNew_Click" />
    <asp:Button ID="btnExcel" runat="server" CssClass="btn btn-default btn-small" OnClick="btnExcel_Click" Text="Excel-Export" />
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
    <asp:Timer ID="Timer1" runat="server" OnTick="TimerTick" Interval="10" Enabled="false">
    </asp:Timer>    
    <asp:GridView ID="dgdPatients" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="ID" OnRowDataBound="dgdPatients_RowDataBound" Width="769px" >
        <AlternatingRowStyle BackColor="#E7EEFA" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="false" />
            <asp:TemplateField HeaderText="Name" SortExpression="Name">
                <HeaderTemplate>
                    <asp:Button ID="btnName" runat="server" CssClass="btn btn-default btn-small btn-header" ClientIDMode="Static" OnClientClick="pasteToGrid('Name');" Text="Name" />
                    <asp:Label ID="lblName" runat="server" Visible="false" Text="Name" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblNameVal" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Vorname" SortExpression="Vorname">
                <HeaderTemplate>
                    <asp:Button ID="btnPrename" runat="server" CssClass="btn btn-default btn-small btn-header" Text="Vorname" ClientIDMode="Static" OnClientClick="pasteToGrid('Vorname');" />
                    <asp:Label ID="lblPrename" runat="server" Visible="false" Text="Vorname" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblPrenameVal" runat="server" Text='<%# Bind("Vorname") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Geburtsdatum" SortExpression="Geburtsdatum">
                <HeaderTemplate>
                    <asp:Button ID="btnBirthdate" runat="server" CssClass="btn btn-default btn-small btn-header" Text="Geburtsdatum" Width="95px" ClientIDMode="Static" OnClientClick="pasteToGrid('Geburtsdatum');" />
                    <asp:Label ID="lblBirthdate" runat="server" Visible="false" Text="Geburtsdatum" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblBirthdateVal" runat="server" Text='<%# Bind("Geburtsdatum", "{0:dd.MM.yyyy}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ISH_PID" SortExpression="ISH_PID">
                <HeaderTemplate>
                    <asp:Button ID="btnISHPID" runat="server" CssClass="btn btn-default btn-small btn-header" Text="ISH_PID" Width="69px" ClientIDMode="Static" OnClientClick="pasteToGrid('ISH_PID');" />
                    <asp:Label ID="lblISHPID" runat="server" Visible="false" Text="ISH-PID" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblISHPIDVal" runat="server" Text='<%# Bind("ISH_PID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ISH_FID" SortExpression="ISH_FID">
                <HeaderTemplate>
                    <asp:Button ID="btnISHFID" runat="server" CssClass="btn btn-default btn-small btn-header" Text="ISH_FID" Width="66px" ClientIDMode="Static" OnClientClick="pasteToGrid('ISH_FID');" />
                    <asp:Label ID="lblISHFID" runat="server" Visible="false" Text="ISH-FID" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblISHFIDVal" runat="server" Text='<%# Bind("ISH_FID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="BMBH_PID" SortExpression="BMBH_PID">
                <HeaderTemplate>
                    <asp:Button ID="btnBMBHPID" runat="server" CssClass="btn btn-default btn-small btn-header" Text="BMBH-PID" Width="87px" ClientIDMode="Static" OnClientClick="pasteToGrid('BMBH_PID');" />
                    <asp:Label ID="lblBMBHPID" runat="server" Visible="false" Text="BMBH-PID" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblBMBHPIDVal" runat="server" Text='<%# Bind("BMBH_PID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="GUID" HeaderText="GUID" SortExpression="GUID" Visible="False" />
            <asp:TemplateField HeaderText="Histo_Nr">
                <HeaderTemplate>
                    <asp:Button ID="btnHistoNr" runat="server" CssClass="btn btn-default btn-small btn-header" Text="Histo_Nr" Width="87px" ClientIDMode="Static" OnClientClick="pasteToGrid('Histo_Nr');"/>
                    <asp:Label ID="lblHistoNr" runat="server" Text="Histo_Nr" Visible="False"></asp:Label>
                </HeaderTemplate>
               <ItemTemplate>
                    <asp:Label ID="lblHistoNrVal" runat="server" Text='<%# Bind("Histo_Nr") %>'></asp:Label>
                </ItemTemplate>
             </asp:TemplateField>
            <asp:BoundField DataField="Status" HeaderText="Einwilligungsstatus" ReadOnly="True" />
        </Columns>
        <EditRowStyle BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
        <EmptyDataRowStyle BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <HeaderStyle BackColor="#006291" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <RowStyle BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" ForeColor="#000066" />
        <SelectedRowStyle BackColor="#669999" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#007DBB" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#00547E" />
    </asp:GridView>
</ContentTemplate>
</asp:UpdatePanel>
    <asp:SqlDataSource ID="dsPatientSearch" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand = "SELECT * FROM [PatientSearch] WHERE [GUID] = @GUID" OnSelecting="dsPatientSearch_Selecting">
        <SelectParameters>
            <asp:SessionParameter Name="GUID" SessionField="GUID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenInputBox" runat="server" />
    </asp:Content>
