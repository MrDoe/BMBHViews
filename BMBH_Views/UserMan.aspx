<%@ Page Title="Benutzerverwaltung" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserMan.aspx.cs" Inherits="BMBH_View.UserMan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="pnlTop" runat="server" BorderColor="White" BorderWidth="3px" Font-Names="Verdana">
    &nbsp;Benutzer:
    <asp:DropDownList ID="cboUser" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="name" Font-Names="Verdana" Height="25px" Width="220px">
    </asp:DropDownList>
        &nbsp;
        <asp:Button ID="btnChangeToUser" runat="server" CssClass="btn btn-default btn-small" OnClick="btnChangeToUser_Click" Text="Zu Benutzer wechseln" Width="145px" />
</asp:Panel>
    <asp:GridView ID="dgdViewPermissions" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ViewName" HeaderText="View" ReadOnly="True" SortExpression="ViewName" />
            <asp:TemplateField HeaderText="Freigabe" SortExpression="Permission">
                <ItemTemplate>
                    <asp:CheckBox ID="chkPermission" runat="server" Checked='<%# Bind("Permission") %>' AutoPostBack="True" OnCheckedChanged="chkPermission_CheckedChanged" />
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
                    <asp:Button ID="btnOK" runat="server" CssClass="btn btn-default btn-small" OnClick="btnOK_Click" Text="OK" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Panel">
                <ItemTemplate>
                    <asp:DropDownList ID="cboPanel" runat="server" AutoPostBack="True" Height="21px" SelectedValue='<%# Bind("PANEL_NAME") %>' Width="121px" OnSelectedIndexChanged="cboPanel_SelectedIndexChanged">
                        <asp:ListItem></asp:ListItem>
                        <asp:ListItem>pnlDZIF</asp:ListItem>
                        <asp:ListItem>pnlTBB</asp:ListItem>
                        <asp:ListItem>pnlTBB_Projekte</asp:ListItem>
                        <asp:ListItem>pnlPatho</asp:ListItem>
                        <asp:ListItem>pnlThorax</asp:ListItem>
                        <asp:ListItem>pnlLiquid</asp:ListItem>
                        <asp:ListItem>pnlPanco</asp:ListItem>
                        <asp:ListItem>pnlPraevOnk</asp:ListItem>
                        <asp:ListItem>pnlMedV</asp:ListItem>
                        <asp:ListItem>pnlSTARLIMS</asp:ListItem>
                        <asp:ListItem>pnlGyn</asp:ListItem>
                        <asp:ListItem>pnlPubs</asp:ListItem>
                        <asp:ListItem>pnlGBA</asp:ListItem>
                        <%--add more panels here--%>
                    </asp:DropDownList>
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
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="select name from sys.server_principals where type_desc = 'WINDOWS_LOGIN' and name NOT LIKE 'NT%' order by name"></asp:SqlDataSource>
<br />
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="EXEC GetPermittedViewsChecked @User">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboUser" Name="User" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Content>
