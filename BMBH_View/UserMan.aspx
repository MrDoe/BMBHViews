<%@ Page Title="Benutzerverwaltung" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserMan.aspx.cs" Inherits="BMBH_View.UserMan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlTop" runat="server" BorderColor="White" BorderWidth="3px" Font-Names="Verdana">
    &nbsp;Benutzer:
    <asp:DropDownList ID="cboUser" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="name" Font-Names="Verdana" Height="25px" Width="220px">
    </asp:DropDownList>
</asp:Panel>
    <asp:GridView ID="dgdViewPermissions" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ViewName" HeaderText="ViewName" ReadOnly="True" SortExpression="ViewName" />
            <asp:TemplateField HeaderText="Permission" SortExpression="Permission">
                <ItemTemplate>
                    <asp:CheckBox ID="chkPermission" runat="server" Checked='<%# Bind("Permission") %>' AutoPostBack="True" OnCheckedChanged="chkPermission_CheckedChanged" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnShowView" runat="server" CssClass="btn btn-default btn-small" OnClick="btnShowView_Click" Text="Anzeigen" ToolTip="Suchformular öffnen"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnClearTemp" runat="server" CssClass="btn btn-default btn-small" OnClick="btnClearTemp_Click" Text="Neu erstellen" ToolTip="Temp-Tabelle neu erstellen" />
                </ItemTemplate>
            </asp:TemplateField>        </Columns>
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
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CLIN106_DATAConnectionString2 %>" SelectCommand="select name from sys.server_principals where type_desc = 'WINDOWS_LOGIN' and name LIKE 'KHD\%' order by name"></asp:SqlDataSource>
<br />
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CLIN106_DATAConnectionString2 %>" SelectCommand="EXEC GetPermittedViewsChecked @User">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboUser" Name="User" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Content>
