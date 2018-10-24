<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Panels.aspx.cs" Inherits="BMBH_View.Panels" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Panel-Konfiguration</h4>
    <asp:GridView ID="dgdPanels" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="PanelID" DataSourceID="SqlDataSource1" ForeColor="#333333" OnRowDataBound="dgdPanels_RowDataBound">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/error_16x16.gif" EditImageUrl="~/Images/table_(edit)_16x16.gif" SelectImageUrl="~/Images/right_16x16.gif" ShowEditButton="True" UpdateImageUrl="~/Images/save_16x16.gif" />
            <asp:BoundField DataField="PanelID" HeaderText="PanelID" ReadOnly="True" SortExpression="PanelID" />
            <asp:BoundField DataField="Heading" HeaderText="Heading" SortExpression="Caption" />
            <asp:BoundField DataField="SubHeading" HeaderText="SubHeading" SortExpression="SubHeading" />
            <asp:TemplateField HeaderText="Backcolor" SortExpression="Backcolor">
                <EditItemTemplate>
                    <asp:TextBox ID="txtBackColor" runat="server" Text='<%# Bind("Backcolor") %>' class="color {hash:true}"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblBackColor" runat="server" Text='<%# Bind("Backcolor") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Textcolor" SortExpression="Textcolor">
                <EditItemTemplate>
                    <asp:TextBox ID="txtTextColor" runat="server" Text='<%# Bind("Textcolor") %>' class="color {hash:true}"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblTextColor" runat="server" Text='<%# Bind("Textcolor") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Bordercolor" SortExpression="Bordercolor">
                <EditItemTemplate>
                    <asp:TextBox ID="txtBorderColor" runat="server" Text='<%# Bind("Bordercolor") %>' class="color {hash:true}"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblBorderColor" runat="server" Text='<%# Bind("Bordercolor") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Height" HeaderText="Height" SortExpression="Height" />
            <asp:BoundField DataField="Width" HeaderText="Width" SortExpression="Width" />
            <asp:BoundField DataField="Sorter" HeaderText="Sorter" SortExpression="Sorter" />
            <asp:TemplateField HeaderText="Zeige Patientensuche?" SortExpression="ShowPatientSearch">
                <EditItemTemplate>
                    <asp:CheckBox ID="chkEditPatSearch" runat="server" Checked='<%# Bind("ShowPatientSearch") %>' CssClass="chkChoice" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkPatSearch" runat="server" Checked='<%# Bind("ShowPatientSearch") %>' CssClass="chkChoice" Enabled="false"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
            <ItemTemplate>
            <asp:ImageButton ID="btnDeletePanel" runat="server" ImageUrl="~/Images/delete_field.gif" ToolTip="Panel löschen"
                    CommandName="Delete" OnClientClick="return confirm('Eintrag wirklich löschen?');"
                    AlternateText="DeletePanel" />               
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

<div style="position:relative; left:8px; top:8px;">
    <asp:ImageButton ID="btnNew" runat="server" AlternateText="Neues Panel" ImageUrl="~/Images/database_field_(add)_16x16.gif" ToolTip="Neues Panel anlegen" />
    <ajaxToolkit:ModalPopupExtender ID="MPE_Panel" runat="server" TargetControlID="btnNew" PopupControlID="pnlNewPanel" PopupDragHandleControlID="pnlNewPanelHeader" BackgroundCssClass="modalBackground" BehaviorID="MPE_ID"></ajaxToolkit:ModalPopupExtender>
</div>

<asp:Panel ID="pnlNewPanel" runat="server" CssClass="modalPopup" align="center" style="display:none" TabIndex="0" Height="100">
<asp:Panel ID="pnlNewPanelHeader" runat="server" CssClass="modalHeader" HorizontalAlign="center" TabIndex="0">
    Neues Panel anlegen <asp:Button ID="btnCancel" runat="server" CssClass="modalHeaderButton" Text=" x " TabIndex="99" OnClick="btnCancel_Click" ClientIDMode="Static" OnClientClick="__doPostBack('<%= btnCancel.UniqueID%>', 'PostFromNew_Cancel');" />
</asp:Panel>
    Panel-ID:&nbsp;<asp:TextBox ID="txtPanelId" runat="server" TabIndex="0" ClientIDMode="Static" /> <br /><br />
    <asp:Button ID="btnAddPanel" runat="server" Text="Übernehmen" CssClass="btn btn-default btn-small" style="left:405px;padding:5px;" TabIndex="4" ClientIDMode="Static" OnClientClick="__doPostBack('<%= btnAddPanel.UniqueID%>', 'PostFromNew_Send');"/>
</asp:Panel>

<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" DeleteCommand="DELETE FROM [PANELS] WHERE [PanelID] = @original_PanelID" InsertCommand="INSERT INTO [PANELS] ([PanelID], [Heading], [SubHeading], [Backcolor], [Textcolor], [Bordercolor], [Height], [Width], [Sorter], [ShowPatientSearch]) VALUES (@PanelID, @Heading, @SubHeading, @Backcolor, @Textcolor, @Bordercolor, @Height, @Width, @Sorter, @ShowPatientSearch)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [PANELS] ORDER BY [Sorter]" UpdateCommand="UPDATE [PANELS] SET [Heading] = @Heading, [SubHeading] = @SubHeading, [Backcolor] = @Backcolor, [Textcolor] = @Textcolor, [Bordercolor] = @Bordercolor, [Height] = @Height, [Width] = @Width, [Sorter] = @Sorter, [ShowPatientSearch] = @ShowPatientSearch WHERE [PanelID] = @original_PanelID">
<DeleteParameters>
    <asp:Parameter Name="original_PanelID" Type="String" />
</DeleteParameters>
<InsertParameters>
    <asp:Parameter Name="PanelID" Type="String" />
    <asp:Parameter Name="Heading" Type="String" />
    <asp:Parameter Name="SubHeading" Type="String" />
    <asp:Parameter Name="Backcolor" Type="String" />
    <asp:Parameter Name="Textcolor" Type="String" />
    <asp:Parameter Name="Bordercolor" Type="String" />
    <asp:Parameter Name="Height" Type="Int32" />
    <asp:Parameter Name="Width" Type="Int32" />
    <asp:Parameter Name="Sorter" Type="Int32" />
    <asp:Parameter Name="ShowPatientSearch" Type="Boolean" />
</InsertParameters>
<UpdateParameters>
    <asp:Parameter Name="Heading" Type="String" />
    <asp:Parameter Name="SubHeading" Type="String" />
    <asp:Parameter Name="Backcolor" Type="String" />
    <asp:Parameter Name="Textcolor" Type="String" />
    <asp:Parameter Name="Bordercolor" Type="String" />
    <asp:Parameter Name="Height" Type="Int32" />
    <asp:Parameter Name="Width" Type="Int32" />
    <asp:Parameter Name="Sorter" Type="Int32" />
    <asp:Parameter Name="ShowPatientSearch" Type="Boolean" />
    <asp:Parameter Name="original_PanelID" Type="String" />
</UpdateParameters>
</asp:SqlDataSource>
</asp:Content>
