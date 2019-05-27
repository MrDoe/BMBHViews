<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Docs.aspx.cs" Inherits="BMBH_View.Documents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
    function ReloadGrid() {
        document.getElementById("<%=btnHiddenSubmit.ClientID %>").click();
	}
</script>
<h4>Dokumentenverwaltung</h4>
<asp:UpdatePanel ID="updatePanelAttachments" runat="server" ChildrenAsTriggers="true"> 
	<ContentTemplate>
        Benutzerrolle:&nbsp;&nbsp;<asp:DropDownList ID="cboRole" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="RoleName" DataValueField="RoleId" OnSelectedIndexChanged="cboRole_SelectedIndexChanged">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="SELECT * FROM [Roles]"></asp:SqlDataSource>
        <br />&nbsp;
    <asp:GridView ID="dgdDocs" runat="server" AllowSorting="True" CellPadding="4" DataKeyNames="DocID" DataSourceID="SqlDataSource1" ForeColor="#333333" AutoGenerateColumns="False" OnRowDeleting="dgdDocs_RowDeleting">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/error_16x16.gif" EditImageUrl="~/Images/table_(edit)_16x16.gif" SelectImageUrl="~/Images/right_16x16.gif" ShowEditButton="True" UpdateImageUrl="~/Images/save_16x16.gif"/>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:UpdatePanel ID="updatePanel_Button" runat="server">
                    <ContentTemplate>
                        <asp:ImageButton ID="btnView" runat="server" CausesValidation="false" CssClass="btn-xs" ImageUrl="~/Images/view_16x16.gif" OnClick="btnView_Click" ClientIDMode="AutoID" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger  ControlID="btnView"/>
                    </Triggers>
              </asp:UpdatePanel>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DocID" HeaderText="DocID" InsertVisible="False" ReadOnly="True" SortExpression="DocID" />
            <asp:TemplateField HeaderText="Freigegeben?">
                <EditItemTemplate>
                    <asp:CheckBox ID="chkPermission" runat="server" Checked='<%# Bind("Permission") %>' OnCheckedChanged="chkPermission_CheckedChanged"/>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkPermission" runat="server" Checked='<%# Bind("Permission") %>' Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ShortName" HeaderText="Kurzname" SortExpression="ShortName" />
            <asp:BoundField DataField="Description" HeaderText="Beschreibung" SortExpression="Description" />
            <asp:BoundField DataField="FilePath" HeaderText="DateiPfad" ReadOnly="True" SortExpression="FilePath" />
            <asp:BoundField DataField="FileName" HeaderText="Dateiname" ReadOnly="True" SortExpression="FileName" />
            <asp:BoundField DataField="FileType" HeaderText="Dateityp" ReadOnly="True" SortExpression="FileType" />
            <asp:BoundField DataField="Version" HeaderText="Version" />
            <asp:BoundField DataField="Timestamp" HeaderText="Zeitstempel" ReadOnly="True" SortExpression="Timestamp" />
            <asp:TemplateField HeaderText="Panel">
                <EditItemTemplate>
                    <asp:DropDownList ID="cboPanel_rw" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="PanelID" DataValueField="PanelID" SelectedValue='<%# Bind("PanelID") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand=" select NULL as PanelID union SELECT [PanelID] FROM [PANELS]"></asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="cboPanel" runat="server" DataSourceID="SqlDataSource1" DataTextField="PanelID" DataValueField="PanelID" Enabled="False" SelectedValue='<%# Bind("PanelID") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="select NULL as PanelID union SELECT [PanelID] FROM [PANELS]"></asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Sorter" HeaderText="Sorter" SortExpression="Sorter" />
            <asp:TemplateField ShowHeader="False">
            <ItemTemplate>
                <asp:ImageButton ID="btnDeleteDoc" runat="server" ImageUrl="~/Images/delete_field.gif" ToolTip="Dokument löschen"
                        CommandName="Delete" OnClientClick="return confirm('Eintrag wirklich löschen?');"
                        AlternateText="DeleteDocument" />
            </ItemTemplate>
            </asp:TemplateField>  
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" 
                       DeleteCommand="DELETE FROM [Documents] WHERE [DocID] = @DocID" 
                       SelectCommand="SELECT d.DocId,rd.Permission,d.FileName,d.FilePath,d.FileType,d.ShortName,d.Description,d.Timestamp,d.PanelId,d.Sorter,d.Version
                                      FROM [BMBH_Views].[dbo].[Documents] d 
                                      JOIN [BMBH_Views].[dbo].[RoleDocs] rd on rd.DocId = d.DocID
                                      WHERE rd.RoleId = @RoleId" 
                       UpdateCommand="UPDATE [Documents] SET [Description] = @Description, 
                                                             [ShortName] = @ShortName, 
                                                             [PanelId] = @PanelId,
                                                             [Sorter] = @Sorter,
                                                             [Version] = @Version
                                      WHERE [DocID] = @DocID">
        <DeleteParameters>
            <asp:Parameter Name="DocID" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboRole" Name="RoleId" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="ShortName" Type="String" />
            <asp:Parameter Name="DocID" Type="Int32" />
            <asp:Parameter Name="PanelID" Type="String" />
            <asp:Parameter Name="Sorter" Type="Int16" />
        </UpdateParameters>
    </asp:SqlDataSource>
    Datei hochladen:<ajaxToolkit:AjaxFileUpload ID="AjaxFileUpload1" runat="server" AllowedFileTypes="pdf,doc,docx,xls,xlsx" AutoStartUpload="True" ClearFileListAfterUpload="True" OnUploadComplete="AjaxFileUpload1_UploadComplete" OnClientUploadComplete="ReloadGrid" />
    <asp:button id="btnHiddenSubmit" runat="server" onclick="ReloadGrid" style="display:none" />
</ContentTemplate>
<Triggers>
        <asp:PostBackTrigger ControlID="btnHiddenSubmit" />
</Triggers>
</asp:UpdatePanel>
</asp:Content>
