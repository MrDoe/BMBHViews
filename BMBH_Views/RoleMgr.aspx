﻿<%@ Page Title="Views- und Rollenverwaltung" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RoleMgr.aspx.cs" Inherits="BMBHviews.RoleManager" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<asp:HiddenField ID="HiddenField1" runat="server" />

    <script type="text/javascript">
    function pageLoad() {
        var oInput = document.getElementById("<%=txtSearch.ClientID%>");
        var inputLen = oInput.value.length;

        // set cursor to end of txtSearch
        if (oInput) {
            oInput.focus();
            oInput.setSelectionRange(inputLen, inputLen);
        }
        // set focus for modal popup
        $find("MPE_ID").add_shown(setFocus);

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(onEndRequest);
    }

    function onEndRequest(sender, args) {
        if(args.get_error() != null)
            alert(args.get_error().message);
        args.set_errorHandled(true);
    }

    // set focus for modal popup textfield
    function setFocus() {
        $get("<%=txtRoleName.ClientID%>").focus();
    }
    
    // reload update panel
    function ReloadUpdPanel(sArgument) {
        var UpdatePanel = '<%=updViews.ClientID%>';

        if (UpdatePanel != null) 
            __doPostBack(UpdatePanel, sArgument);
    }

    function CancelEditView() {
    document.getElementById('MainContent_txtViewDefinition').value = '';
    __doPostBack('<%= btnCancel.UniqueID%>', 'EditView_Cancel');
        }

    function ConfirmEditView() {
        var hf = document.getElementById("<%= HiddenField1.ClientID%>");
        hf.value = btoa(encodeURIComponent(document.getElementById('MainContent_txtViewDefinition').innerHTML));
        __doPostBack('<%= btnConfirmEditView.UniqueID%>', 'EditView_OK');
    }
    </script>

<h4>Views- und Rollenverwaltung</h4>
<asp:Panel ID="pnlTop" runat="server" BorderColor="White" BorderWidth="3px">
&nbsp;Benutzerrolle:
<asp:DropDownList ID="cboRole" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="RoleName" DataValueField="RoleId" Height="25px" Width="220px">
</asp:DropDownList> &nbsp;
<asp:Button ID="btnAddRole" runat="server" CssClass="btn btn-default btn-small" OnClick="btnAddRole_Click" Text="Neue Rolle" />
<AjaxControlToolkit:ModalPopupExtender ID="MPE_Role" runat="server" TargetControlID="btnAddRole" PopupControlID="pnlAddRole" PopupDragHandleControlID="pnlAddRoleHeader" BackgroundCssClass="modalBackground" BehaviorID="MPE_ID"></AjaxControlToolkit:ModalPopupExtender>
<asp:Button ID="btnUpdateViews" runat="server" CssClass="btn btn-default btn-small" OnClick="btnUpdateViews_Click" Text="Views aktualisieren" />
<br />
<div style="padding:5px;">
Suche: <asp:TextBox ID="txtSearch" runat="server" onkeyup="ReloadUpdPanel(this.value)" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="SearchBox"></asp:TextBox>
</div>
</asp:Panel>
<asp:UpdatePanel ID="updViews" runat="server" ClientIDMode="Static" ChildrenAsTriggers="true" UpdateMode="Always">
<ContentTemplate>
    <asp:GridView ID="dgdViewPermissions" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" OnSelectedIndexChanged="dgdViewPermissions_SelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ViewName" HeaderText="View" ReadOnly="True" SortExpression="ViewName" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnEditView" runat="server" CssClass="btn btn-default btn-small" Text="Bearbeiten" OnClick="btnEditView_Click" OnClientClick="scroll(0,0);"/>
                    <asp:Button ID="btnDelView" runat="server" CssClass="btn btn-default btn-small" Text="Löschen" OnClick="btnDelView_Click" OnClientClick="return confirm('View wirklich löschen?');"/>
                </ItemTemplate>
            </asp:TemplateField>
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
            <asp:TemplateField HeaderText="Attributzähler">
                <ItemTemplate>
                    <asp:Button ID="btnValueCnt" runat="server" CssClass="btn btn-default btn-small" OnClick="btnValueCnt_Click" Text="Aktualisieren" ToolTip="Anzahl der Vorkommnisse pro Attribut neu berechnen" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Lookup-Cache">
                <ItemTemplate>
                    <asp:CheckBox ID="chkUseLookups" runat="server" Checked='<%# Eval("USE_LOOKUPS").ToString().Equals("True") %>' CssClass="chkChoice" AutoPostBack="True" Text=" " OnCheckedChanged="chkUseLookups_CheckedChanged" ToolTip="Lookup-Cache für DropDowns verwenden"/>
                    <asp:Button ID="btnUpdateLookups" runat="server" CssClass="btn btn-default btn-small" OnClick="btnUpdateLookups_Click" Text="Aktualisieren" ToolTip="Lookup-Cache aktualisieren" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Temp-Tabelle">
                <ItemTemplate>
                    <asp:CheckBox ID="chkUseTempTable" Checked='<%# Eval("USE_TEMPTABLE").ToString().Equals("True") %>' runat="server" CssClass="chkChoice" AutoPostBack="True" Text=" " OnCheckedChanged="chkUseTempTable_CheckedChanged" ToolTip="Temp-Tabelle für View verwenden"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Beschriftung">
                <ItemTemplate>
                    <asp:TextBox ID="txtCaption" runat="server" Text='<%# Bind("VIEW_CAPTION") %>' Width="200px" />
                    <asp:Button ID="btnOK" runat="server" CssClass="btn btn-default btn-small" OnClick="btnOK_Click" Text="OK" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Panel">
                <ItemTemplate>
                    <asp:DropDownList ID="cboPanel" runat="server" Height="21px" SelectedValue='<%# Bind("PANEL_NAME") %>' Width="130px" OnSelectedIndexChanged="cboPanel_SelectedIndexChanged" DataSourceId="SqlDataSource3" DataValueField="PanelId" DataTextField="PanelId">
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Sortierer">
                <ItemTemplate>
                    <asp:TextBox ID="txtSorter" runat="server" Text='<%# Bind("SORTER") %>' Width="50px" />
                    <asp:Button ID="btnOKSorter" runat="server" CssClass="btn btn-default btn-small" OnClick="btnOK_Sorter_Click" Text="OK" />
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

<%--Edit view window--%>
<asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
<AjaxControlToolkit:ModalPopupExtender ID="MPE_EditView" runat="server" TargetControlID="lnkDummy" PopupControlID="pnlEditView" PopupDragHandleControlID="pnlEditViewHeader" BackgroundCssClass="modalBackground" BehaviorID="MPE_ID2"></AjaxControlToolkit:ModalPopupExtender>
<asp:Panel ID="pnlEditView" runat="server" CssClass="modalPopupLarge modalPopup" align="center" style="display:none" TabIndex="0">
    <asp:Panel ID="pnlEditViewHeader" runat="server" CssClass="modalHeaderLarge modalHeader" HorizontalAlign="center" TabIndex="0">
        View bearbeiten <asp:Button ID="btnCancel" runat="server" CssClass="modalHeaderButtonLarge modalHeaderButton" Text=" x " TabIndex="99" OnClick="btnCancel_Click" ClientIDMode="Static" OnClientClick="CancelEditView();" />
    </asp:Panel>
    View-Definition:<br />
    <div id="txtViewDefinition" runat="server" contenteditable="true" class="txtViewDefinition"></div>
    <asp:Button ID="btnConfirmEditView" runat="server" Text="Übernehmen" CssClass="btn btn-default btn-small" style="position:relative; left:910px; top:8px; padding:5px;" TabIndex="4" OnClick="btnConfirmEditView_Click" ClientIDMode="Static" OnClientClick="ConfirmEditView();"/>
</asp:Panel>
</ContentTemplate>
</asp:UpdatePanel>

<%--Data sources--%>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="EXEC GetAllRoles"></asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>">
<SelectParameters>
    <asp:ControlParameter ControlID="cboRole" Name="RoleId" PropertyName="SelectedValue" DefaultValue="Administrator" />
</SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="select '' as PanelId union select PanelID from Panels">
</asp:SqlDataSource>

<%--Add user role window--%>
<asp:Panel ID="pnlAddRole" runat="server" CssClass="modalPopup" align="center" style="display:none" TabIndex="0" Height="100">
<asp:Panel ID="pnlAddRoleHeader" runat="server" CssClass="modalHeader" HorizontalAlign="center" TabIndex="0">
    Neue Benutzerrolle anlegen <asp:Button ID="btnCancel2" runat="server" CssClass="modalHeaderButton" Text=" x " TabIndex="99" OnClick="btnCancel_Click" ClientIDMode="Static" OnClientClick="__doPostBack('<%= btnCancel2.UniqueID%>', 'PostFromNew_Cancel');" />
</asp:Panel>
    Benutzerrolle:&nbsp;<asp:TextBox ID="txtRoleName" runat="server" TabIndex="0" ClientIDMode="Static" /> <br /><br />
    <asp:Button ID="btnAddNewRole" runat="server" Text="Übernehmen" CssClass="btn btn-default btn-small" style="left:405px;padding:5px;" TabIndex="4" ClientIDMode="Static" OnClientClick="__doPostBack('<%= btnAddNewRole.UniqueID%>', 'PostFromNew_Send');"/>
</asp:Panel>

</asp:Content>
