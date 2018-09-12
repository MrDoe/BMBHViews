﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserMgr.aspx.cs" Inherits="BMBH_View.RoleMan" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Button ID="btnRoleMgr" runat="server" OnClick="btnRoleMgr_Click" Text="Rollenverwaltung" Width="142px" CssClass="btn btn-default btn-small" />
    <asp:Button ID="btnNewUser" runat="server" Text="Neuer Benutzer" CssClass="btn btn-default btn-small" />
    <AjaxControlToolkit:ModalPopupExtender ID="MPE_User" runat="server" TargetControlID="btnNewUser" PopupControlID="pnlNewUser" PopupDragHandleControlID="pnlNewUserHeader" BackgroundCssClass="modalBackground" BehaviorID="MPE_ID"></AjaxControlToolkit:ModalPopupExtender>
    <asp:GridView ID="dgdUsers" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" DataSourceID="SqlDataSource1">
    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    <Columns>
        <asp:BoundField DataField="UserId" HeaderText="Benutzername" />
        <asp:TemplateField HeaderText="Benutzerrolle">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("RoleId") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:DropDownList ID="cboRole" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="RoleName" DataValueField="RoleId" SelectedValue='<%# Bind("RoleId") %>' OnSelectedIndexChanged="cboRole_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="Exec GetAllRoles"></asp:SqlDataSource>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:Button ID="btnChangeToUser" runat="server" CssClass="btn btn-default btn-small" OnClick="btnChangeToUser_Click" Text="Zu Benutzer wechseln" Width="145px" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemTemplate>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:CheckBox ID="chkPatientSearch" runat="server" AutoPostBack="True" Checked='<%# Eval("AllowPatientSearch").ToString().Equals("Y") %>' CssClass="chkChoice" OnCheckedChanged="chkPatientSearch_CheckedChanged" Text="Patientensuche erlaubt" />
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="SELECT * FROM [UserRoles]"></asp:SqlDataSource>

<asp:Panel ID="pnlNewUser" runat="server" CssClass="modalPopup" align="center" style="display:none" TabIndex="0" Height="100">
<asp:Panel ID="pnlNewUserHeader" runat="server" CssClass="modalHeader" HorizontalAlign="center" TabIndex="0">
    Neuen Benutzer anlegen <asp:Button ID="btnCancel" runat="server" CssClass="modalHeaderButton" Text=" x " TabIndex="99" OnClick="btnCancel_Click" ClientIDMode="Static" OnClientClick="__doPostBack('<%= btnCancel.UniqueID%>', 'PostFromNew_Cancel');" />
</asp:Panel>
    Benutzername:&nbsp;<asp:TextBox ID="txtUserName" runat="server" TabIndex="0" ClientIDMode="Static" /> <br /><br />
    <asp:Button ID="btnAddNewUser" runat="server" Text="Übernehmen" CssClass="btn btn-default btn-small" style="left:405px;padding:5px;" TabIndex="4" ClientIDMode="Static" OnClientClick="__doPostBack('<%= btnAddNewUser.UniqueID%>', 'PostFromNew_Send');"/>
</asp:Panel>

<script type="text/javascript">
function pageLoad() {
    $find("MPE_ID").add_shown(onModalPopupShown);
}
function onModalPopupShown() {
    $get("<%=txtUserName.ClientID%>").focus();
}
</script>

</asp:Content>
