<%@ Page Title="Benutzerverwaltung" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RoleMgr.aspx.cs" Inherits="BMBH_View.UserMan" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h4>Rollenverwaltung</h4>
<asp:Panel ID="pnlTop" runat="server" BorderColor="White" BorderWidth="3px" Font-Names="Verdana">
&nbsp;Benutzerrolle:
<asp:DropDownList ID="cboRole" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="RoleName" DataValueField="RoleId" Font-Names="Verdana" Height="25px" Width="220px">
</asp:DropDownList> &nbsp;
<asp:Button ID="btnUpdateViews" runat="server" CssClass="btn btn-default btn-small" OnClick="btnUpdateViews_Click" Text="Views aktualisieren" Width="131px" />
</asp:Panel>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="EXEC GetAllRoles"></asp:SqlDataSource>
    <asp:GridView ID="dgdViewPermissions" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ViewName" HeaderText="View" ReadOnly="True" SortExpression="ViewName" />
            <asp:TemplateField HeaderText="Freigabe" SortExpression="Permission">
                <ItemTemplate>
                    <asp:CheckBox ID="chkPermission" runat="server" Checked='<%# Eval("Permission").ToString().Equals("1") %>' AutoPostBack="True" OnCheckedChanged="chkPermission_CheckedChanged" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Suchtabelle">
                <ItemTemplate>
                    <asp:Button ID="btnShowView" runat="server" CssClass="btn btn-default btn-small" OnClick="btnShowView_Click" Text="Anzeigen" ToolTip="Suchformular öffnen"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnClearTemp" runat="server" CssClass="btn btn-default btn-small" OnClick="btnClearTemp_Click" Text="Neu erstellen" ToolTip="Temp-Tabelle neu erstellen" />
                </ItemTemplate>
            </asp:TemplateField>        
            <asp:TemplateField HeaderText="Attributzähler">
                <ItemTemplate>
                    <asp:Button ID="btnValueCnt" runat="server" CssClass="btn btn-default btn-small" OnClick="btnValueCnt_Click" Text="Aktualisieren" ToolTip="Attributanzahlen neu berechnen" />
                </ItemTemplate>
            </asp:TemplateField>        
            <asp:TemplateField HeaderText="Beschriftung">
                <ItemTemplate>
                    <asp:TextBox ID="txtCaption" runat="server" Text='<%# Bind("VIEW_CAPTION") %>' Width="200px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Panel">
                <ItemTemplate>
                    <asp:DropDownList ID="cboPanel" runat="server" AutoPostBack="True" Height="21px" SelectedValue='<%# Bind("PANEL_NAME") %>' Width="121px" OnSelectedIndexChanged="cboPanel_SelectedIndexChanged" DataSourceId="SqlDataSource3" DataValueField="PanelId" DataTextField="PanelId">
                    </asp:DropDownList>
                    <asp:Button ID="btnOK" runat="server" CssClass="btn btn-default btn-small" OnClick="btnOK_Click" Text="OK" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Bearbeiten">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Button ID="btnEditView" runat="server" CssClass="btn btn-default btn-small" Text="Bearbeiten" OnClick="btnEditView_Click"/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#F7F6F3" />
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
<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="EXEC GetPermittedViewsByRole @RoleId">
<SelectParameters>
    <asp:ControlParameter ControlID="cboRole" Name="RoleId" PropertyName="SelectedValue" />
</SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="select '' as PanelId union select PanelID from Panels">
</asp:SqlDataSource>
<asp:Panel ID="pnlEditView" runat="server" CssClass="modalPopupLarge modalPopup" align="center" style="display:none" TabIndex="0">
    <asp:Panel ID="pnlEditViewHeader" runat="server" CssClass="modalHeaderLarge modalHeader" HorizontalAlign="center" TabIndex="0">
        View bearbeiten <asp:Button ID="btnCancel" runat="server" CssClass="modalHeaderButtonLarge modalHeaderButton" Text=" x " TabIndex="99" OnClick="btnCancel_Click" ClientIDMode="Static" OnClientClick="__doPostBack('<%= btnCancel.UniqueID%>', 'EditView_Cancel');" />
    </asp:Panel>
    View-Definition:<br />
    <asp:TextBox ID="txtViewDefinition" TextMode="MultiLine" Width="998px" Height="710px" runat="server"></asp:TextBox>
    <%--<ajaxToolkit:HtmlEditorExtender ID="Editor" TargetControlID="txtViewDefinition" runat="server" />--%>
    <asp:Button ID="btnConfirmEditView" runat="server" Text="Übernehmen" CssClass="btn btn-default btn-small" style="position:relative; left:910px; top:8px; padding:5px;" TabIndex="4" OnClick="btnConfirmEditView_Click"/>
</asp:Panel>
<asp:LinkButton ID="lnkFake" runat="server"></asp:LinkButton>
<AjaxControlToolkit:ModalPopupExtender ID="MPE" runat="server" TargetControlID="lnkFake" PopupControlID="pnlEditView" PopupDragHandleControlID="pnlEditViewHeader" BackgroundCssClass="modalBackground"></AjaxControlToolkit:ModalPopupExtender>
</asp:Content>
