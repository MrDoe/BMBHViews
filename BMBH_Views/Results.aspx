<%@ Page Title="BMBH-Views - Tabellenansicht" Language="C#" EnableEventValidation="false" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Results.aspx.cs" Inherits="BMBH_View.Results" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/> 
<h4>Suche in <%:Session["View"]%> </h4>
    <asp:Panel ID="pnlMain" runat="server" EnableViewState="False" Width="100%" style="top:4px; position:relative" >
        <asp:Button ID="btnSearch" runat="server" Text="Suche" CssClass="btn btn-default btn-small" EnableViewState="False" OnClick="btnSearch_Click" style="left:0px; position:relative; top:-2px; height:24px; width:60px" TabIndex="999" UseSubmitBehavior="False"/>
        &nbsp;<asp:ImageButton ID="btnPrevPage" runat="server" BackColor="#EAF5F8" BorderColor="#E2E2E2" BorderStyle="Outset" BorderWidth="1px" CssClass="btn-info" Height="24px" ImageUrl="~/Images/NavigateBackwards_6270.png" OnClick="btnPrevPage_Click" ToolTip="Vorherige Seite" style="left: 1px; top: 5px" TabIndex="3" AutoPostBack="true" />
        &nbsp;<asp:ImageButton ID="btnNextPage" runat="server" BackColor="#EAF5F8" BorderColor="#E2E2E2" BorderStyle="Outset" BorderWidth="1px" CssClass="btn-info" Height="24px" ImageUrl="~/Images/NavigateForward_6271.png" OnClick="btnNextPage_Click" ToolTip="Nächste Seite" style="left: 1px; top: 5px" TabIndex="4" AutoPostBack="true"/>
        &nbsp;Seite&nbsp;
        <asp:TextBox ID="txtPage" runat="server" Width="44px" TabIndex="4">1</asp:TextBox>
        &nbsp;von &nbsp;
        <asp:TextBox ID="txtMaxPage" runat="server" ReadOnly="True" Width="53px" TabIndex="5">1</asp:TextBox>
        &nbsp;&nbsp; Einträge pro Seite:&nbsp;
        <asp:TextBox ID="txtRowPerPage" runat="server" Width="46px" TabIndex="6" OnTextChanged="txtRowPerPage_TextChanged">30</asp:TextBox>
        &nbsp;<asp:Button ID="btnRefresh" runat="server" CssClass="btn btn-default btn-small" OnClick="btnRefresh_Click" Text="OK" UseSubmitBehavior="True" style="position:relative; top:-2px; height:24px" TabIndex="2"/>
        &nbsp; # Datensätze:
        <asp:TextBox ID="txtTotalRows" runat="server" Width="63px" TabIndex="8"></asp:TextBox>

        <div style="display:block;float:right">
            <asp:ImageButton ID="btnList" runat="server" BackColor="#EAF5F8" BorderStyle="Outset" BorderWidth="1px" CssClass="btn-info" Height="24px" ImageUrl="~/Images/script_(add)_32.png" BorderColor="#E2E2E2" ToolTip="Als STARLIMS-Liste speichern" style="left:-14px; top:5px;" TabIndex="9" AutoPostBack="true"/>
            <AjaxControlToolkit:ModalPopupExtender ID="MPE" runat="server" TargetControlID="btnList" PopupControlID="pnlList" PopupDragHandleControlID="pnlListHeader" BackgroundCssClass="modalBackground" BehaviorID="MPE_ID"></AjaxControlToolkit:ModalPopupExtender>
            <asp:ImageButton ID="btnExcel" runat="server" BackColor="#EAF5F8" BorderStyle="Outset" BorderWidth="1px" CssClass="btn-info" Height="24px" ImageUrl="~/Images/Excel-icon.png" OnClick="btnExcel_Click" BorderColor="#E2E2E2" ToolTip="Excel-Export" style="left:-14px; top:5px;" EnableViewState="False" TabIndex="10"/>
        </div>

        <asp:Panel ID="pnlGrid" runat="server" BorderColor="White" BorderStyle="Solid" BorderWidth="5px" Height="100%" HorizontalAlign="Center" ScrollBars="Both" Wrap="True" Width="100%">
            <asp:GridView ID="dgdNCT" runat="server" AllowPaging="True" AllowSorting="True" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" Font-Names="Arial" Font-Size="8pt" ForeColor="#333333" PageSize="30" Height="100%" TabIndex="7" Width="100%" OnSorting="dgdNCT_Sorting" ViewStateMode="Inherit" OnRowDataBound="dgdNCT_RowDataBound">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="False" ForeColor="White" />
                <PagerSettings FirstPageText="Seite &amp;lt;&amp;lt;" Position="Top" Visible="False" />
                <PagerStyle BackColor="#284775" BorderStyle="Dotted" BorderWidth="1px" ForeColor="White" HorizontalAlign="Left" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            </asp:GridView>
        </asp:Panel>
    </asp:Panel>

<asp:Panel ID="pnlList" runat="server" CssClass="modalPopup" align="center" style="display:none" TabIndex="0">
<asp:Panel ID="pnlListHeader" runat="server" CssClass="modalHeader" HorizontalAlign="center" TabIndex="0">
    Suchergebnis als STARLIMS-Liste speichern <asp:Button ID="btnCancel" runat="server" CssClass="modalHeaderButton" Text=" x " TabIndex="99" OnClick="btnCancel_Click" ClientIDMode="Static" OnClientClick="__doPostBack('<%= btnCancel.UniqueID%>', 'PostFromList_Cancel');" />
</asp:Panel>
    Name der Liste:&nbsp;<asp:TextBox ID="txtListName" runat="server" TabIndex="1" ClientIDMode="Static"/> <br /><br />
    <div class="panel panel-default" style="line-height:normal;">
    <div class="panel-heading" style="padding:5px;">Liste an STARLIMS-Benutzer senden</div>
    <div class="panel-body" style="line-height:30px">
    <div style="float:left; position:relative; width:50px;">
    Biobank:
    Benutzername:
    </div>
    <div style="float:right; position:relative; left:-250px; width:100px;">
    <asp:DropDownList ID="cboDept" runat="server" DataSourceID="SqlDataSource2" DataTextField="DEPT" DataValueField="DEPT" OnSelectedIndexChanged="cboDept_SelectedIndexChanged" AutoPostBack="true" ClientIDMode="static" AppendDataBoundItems="true" onchange="return DeptChange();" TabIndex="2"></asp:DropDownList><br />
    <asp:DropDownList ID="cboSLuser" runat="server" DataSourceID="SqlDataSource1" DataTextField="USER" DataValueField="USRNAM" TabIndex="3"></asp:DropDownList>
    </div>
    </div></div>
    <asp:Button ID="btnSendList" runat="server" Text="Liste anlegen & senden" CssClass="btn btn-default btn-small" style="padding:5px;" TabIndex="4" ClientIDMode="Static" OnClientClick="__doPostBack('<%= btnSendList.UniqueID%>', 'PostFromList_Send');"/>
</asp:Panel>

<script type="text/javascript">
function pageLoad() {
    $find("MPE_ID").add_shown(onModalPopupShown);
}
function onModalPopupShown() {
    document.getElementById("txtListName").focus();
}
</script>

<asp:HiddenField ID="width" runat="server" />
<asp:HiddenField ID="height" runat="server" />

<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="select USRNAM + ' - ' + FULLNAME as 'USER',USRNAM
from V_STARLIMS_USERS
where DEPTLIST LIKE '%' + @UserDept + '%'
order by USRNAM">
    <SelectParameters>
        <asp:SessionParameter Name="UserDept" SessionField="UserDept" DefaultValue="None" />
    </SelectParameters>
    </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="select DEPT from V_STARLIMS_DEPT"></asp:SqlDataSource>

<%--<script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
<script src="Scripts/ScrollableGridViewPlugin_ASP.NetAJAXmin.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#<%=dgdNCT.ClientID %>').Scrollable({
            ScrollHeight: 500,
            IsInUpdatePanel: false
        });

    });
</script>--%>
</asp:Content>
