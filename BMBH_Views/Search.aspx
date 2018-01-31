<%@ Page Title="BMBH-Views - Suchformular" Language="C#" Debug="true" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="BMBH_View.Search" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<asp:HiddenField ID="width" runat="server" />
<asp:HiddenField ID="height" runat="server" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/> 

<asp:Panel ID="pnlTop" runat="server" BorderColor="White" BorderStyle="Solid" BorderWidth="5px" Width="99%" style="top:3px; position:relative">
    <asp:Button ID="btnSubmit" runat="server" Text="Absenden" CssClass="btn btn-default btn-small" Width="70px" OnClick="btnSubmit_Click" Font-Bold="False" />

    &nbsp;&nbsp; Gespeicherte Suche:&nbsp;<div style="float:right;position:relative;left:auto">
        <asp:Button ID="btnNew" runat="server" CssClass="btn btn-default btn-small" Font-Bold="False" OnClick="btnNew_Click" style="margin-left:26px" Text="Neue Suche" Width="80px" />
    </div>
    <div style="float:right;position:relative;left:auto;top:3px;margin-right:30px">
        <div style="float:left;position:relative;top:3px;left:auto">
            <asp:CheckBox ID="chkRecursive" runat="server" AutoPostBack="True" OnCheckedChanged="chkRecursive_CheckedChanged" />
            <ajaxToolkit:ToggleButtonExtender ID="ToggleEx" runat="server" CheckedImageAlternateText="An" CheckedImageUrl="~/Images/on16.png" ImageHeight="16" ImageWidth="24" TargetControlID="chkRecursive" UncheckedImageAlternateText="Aus" UncheckedImageUrl="~/Images/off16.png" />
        </div>
        <div style="float:left;position:relative;left:20px">
            <asp:Label ID="lblRecursive" runat="server" Text="Rekursive Suche"></asp:Label>
        </div>
    </div>
    <div style="float:right;position:relative;left:auto;top:3px;margin-right:30px">
        <div style="float:left;position:relative;top:3px">
            <asp:CheckBox ID="chkAdditive" runat="server" AutoPostBack="True" OnCheckedChanged="chkAdditive_CheckedChanged" />
            <ajaxToolkit:ToggleButtonExtender ID="ToggleButtonExtender1" runat="server" CheckedImageAlternateText="An" CheckedImageUrl="~/Images/on16.png" ImageHeight="16" ImageWidth="24" TargetControlID="chkAdditive" UncheckedImageAlternateText="Aus" UncheckedImageUrl="~/Images/off16.png" />
        </div>
        <div style="float:left;position:relative;left:20px">
            <asp:Label ID="lblAdditive" runat="server" Text="Additive Suche"></asp:Label>
        </div>
    </div>
    <asp:DropDownList ID="cboSaveSearch" runat="server" DataSourceID="SqlDataSource1" DataTextField="SearchName" DataValueField="SearchName">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="select distinct SearchName from V_Save_Search where UserId = @User and ViewName = @View">
        <SelectParameters>
            <asp:SessionParameter Name="User" SessionField="UserName" />
            <asp:SessionParameter Name="View" SessionField="View" />
        </SelectParameters>
    </asp:SqlDataSource>
    &nbsp;<asp:Button ID="btnLoadSearch" runat="server" CssClass="btn btn-default btn-small" Font-Bold="False" Text="Laden" Width="57px" OnClick="btnLoadSearch_Click" />
    &nbsp;<asp:Button ID="btnSaveSearch" runat="server" CssClass="btn btn-default btn-small" Font-Bold="False" ClientIDMode="Static" OnClientClick="InputBox('PostfromSave');" Text="Speichern" Width="68px" />
    &nbsp;<asp:Button ID="btnDeleteSearch" runat="server" CssClass="btn btn-default btn-small" Font-Bold="False" ClientIDMode="Static" OnClientClick="DeleteSearch('PostfromDelete');" Text="Löschen" Width="68px" />
</asp:Panel>
    <asp:Table ID= "Table1" runat="server">
        <asp:TableRow>
            <asp:TableCell>
    <asp:GridView ID="dgdSearch" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" DataKeyNames="ID" OnRowEditing="dgdSearch_RowEditing" Width="50%" OnRowDataBound="dgdSearch_RowDataBound" OnRowCommand="dgdSearch_RowCommand" DataSourceID="dsSearch" Font-Names="Arial" Font-Size="Small">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" Width="50%" Height="10px" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID" Visible="False" />
            <asp:BoundField DataField="Attribut" HeaderText="Attribut" SortExpression="Attribut" ReadOnly="True" />
            <asp:TemplateField HeaderText="Operator" ItemStyle-Width="10%">
                <EditItemTemplate>
                    <asp:DropDownList ID="cboOperator" runat="server" SelectedValue='<%# Bind("Operator") %>' AutoPostBack="True" OnSelectedIndexChanged="cboOperator_SelectedIndexChanged">
                        <asp:ListItem>=</asp:ListItem>
                        <asp:ListItem Value="&lt;&gt;"></asp:ListItem>
                        <asp:ListItem Value="LIKE">ENTHÄLT</asp:ListItem>
                        <asp:ListItem Value="NOT LIKE">ENTHÄLT NICHT</asp:ListItem>
                        <asp:ListItem Value="IN"></asp:ListItem>
                        <asp:ListItem Value="&lt;"></asp:ListItem>
                        <asp:ListItem Value="&gt;"></asp:ListItem>
                        <asp:ListItem Value="BETWEEN">ZWISCHEN</asp:ListItem>
                        <asp:ListItem Value="IS NULL">IST LEER</asp:ListItem>
                        <asp:ListItem Value="IS NOT NULL">IST NICHT LEER</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Operator") %>'></asp:Label>
                </ItemTemplate>
                <ControlStyle Width="110px" /> <ItemStyle Width="10%"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Wert" SortExpression="Wert" ItemStyle-Width="40%">
                <EditItemTemplate>
                    <asp:Panel ID="Panel2" runat="server" Width="375px">
                    <div style="float:left; width:50px; position:relative; top:1px">
                        <asp:Label ID="lblFrom" runat="server" Text="Von:" BorderWidth="2px" BorderColor="Transparent" />
                        <asp:Label ID="lblTo" runat="server" Text="Bis:" BorderWidth="2px" BorderColor="Transparent"/>
                    </div>
                    <div style="float:right; position:relative; width:180px; left:-20px">
                        <asp:TextBox ID="txtCalFrom" runat="server" width="150px" Visible="False"/>
                        <asp:ImageButton ID="btnCalFrom" runat="server" ImageUrl="~/Images/table_16x16.gif" AlternateText="Kalender anzeigen" /><br />
                        <ajaxToolkit:CalendarExtender ID="calFrom" runat="server" TargetControlID="txtCalFrom" PopupButtonID="btnCalFrom" TodaysDateFormat="dd.MM.yyyy HH:mm" Format="dd.MM.yyyy HH:mm"/>
                        <asp:TextBox ID="txtCalTo" runat="server" width="150px" Visible="False"/>
                        <asp:ImageButton ID="btnCalTo" runat="server" ImageUrl="~/Images/table_16x16.gif" AlternateText="Kalender anzeigen" /><br />
                        <ajaxToolkit:CalendarExtender ID="calTo" runat="server" TargetControlID="txtCalTo" PopupButtonID="btnCalTo" TodaysDateFormat="dd.MM.yyyy HH:mm" Format="dd.MM.yyyy HH:mm"/>
                    </div>
                    <div style="float:left; position:relative; top:-20px">
                        <asp:DropDownList ID="cboValue" runat="server" Width="248px">
                        </asp:DropDownList>
                        <asp:TextBox ID="txtValue" runat="server" Text='<%# Bind("Wert") %>' Width="220px" Wrap="False" OnTextChanged="txtValue_TextChanged"></asp:TextBox>
                        <asp:ImageButton ID="btnInSelect" runat="server" BackColor="#EAF5F8" BorderColor="#E2E2E2" BorderStyle="Outset" BorderWidth="2px" CssClass="btn-info" Height="22px" ImageUrl="~/Images/paste_16x16.gif" OnClick="btnInSelect_Click" ToolTip="Daten aus Zwischenablage einfügen" style="left: 1px; top: 5px"  />
                    </div>
                        <br />
                    </asp:Panel>
                    <asp:CheckBoxList ID="chkValue" runat="server" CellPadding="1" CellSpacing="1" CssClass="chkChoice" Font-Bold="False" Font-Italic="False" Font-Names="Arial" Width="169px">
                    </asp:CheckBoxList>
                    <div style="float:left; position:relative">
                    <asp:CheckBox ID="chkSingleValue" runat="server" CssClass="chkSingle" Text="Auswahl (Ja):" Visible="false" style="width:160px" OnCheckedChanged="chkSingleValue_CheckedChanged"/>
                    <asp:ImageButton ID="btnClearValue" runat="server" ImageUrl="~/Images/delete_field.gif" BackColor="#EAF5F8" BorderColor="#E5E5E5" BorderStyle="Outset" BorderWidth="2px" CssClass="btn-info" Height="22px" AlternateText="Löschen" OnClick="btnClearValue_Click" Visible="false" ToolTip="Wert löschen" style="width:22px;top:-11px"/>
                    </div>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Wert") %>' Style="word-wrap: normal; word-break: break-all;"></asp:Label>
                </ItemTemplate>
                <ControlStyle Width="250px" />
                <ItemStyle Width="250px" Wrap="true"></ItemStyle>
            </asp:TemplateField>
			<asp:BoundField DataField="Datatype" HeaderText="Datentyp" SortExpression="Datatype" ReadOnly="True" />
            <asp:BoundField DataField="UserId" HeaderText="UserId" SortExpression="UserId" Visible="False" />
   			<asp:TemplateField HeaderText="Control Type">
                <EditItemTemplate>
                    <asp:DropDownList ID="cboControltype" runat="server" SelectedValue='<%# Bind("Controltype") %>' AutoPostBack="True" Height="17px" Width="148px" OnSelectedIndexChanged="cboControltype_SelectedIndexChanged">
                        <asp:ListItem>TextBox</asp:ListItem>
                        <asp:ListItem>DropDownList</asp:ListItem>
                        <asp:ListItem>Calendar</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Controltype") %>'></asp:Label>
                </ItemTemplate>
                <ControlStyle Width="120px" />
            </asp:TemplateField>
   			<asp:templatefield>
                <ItemStyle Width="60px"></ItemStyle>
				<edititemtemplate>
					<asp:Button ID="btnOK" runat="server" CssClass="btn btn-default btn-small" commandname="Update" Text="OK" OnClick="btnOK_Click" />
				</edititemtemplate>
			    <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-default btn-small" commandname="Edit" Text="Ändern" OnClick="btnEdit_Click"/>
                </ItemTemplate>
			</asp:templatefield>
        </Columns>
        <EditRowStyle BackColor="#C7D2DD" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Height="10px" />
        <SelectedRowStyle BackColor="#C7D2DD" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
        </asp:TableCell>
        <asp:TableCell>
        <div style="position:absolute; top:81px;">
        <asp:Panel ID="pnlSQLhistory" runat="server" BorderWidth="10px" BorderColor="White" Visible="false">
            Suchhistorie:<br />
            <asp:GridView ID="dgdHistory" runat="server" CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="Horizontal" AutoGenerateColumns="false">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
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
            <Columns>
            <asp:BoundField DataField="Iteration" HeaderText="Iteration" ReadOnly="True" />
            <asp:BoundField DataField="SearchMode" HeaderText="Suchtyp" ReadOnly="True" />
            <asp:BoundField DataField="Suchkriterium" HeaderText="Suchkriterium" ReadOnly="True" />
            <asp:templatefield>
            <ItemStyle Width="60px"></ItemStyle>
			<ItemTemplate>
                <asp:Button ID="btnJumpBack" runat="server" CssClass="btn btn-default btn-small" Text="Zurückspringen" OnClick="btnJumpBack_Click"/>
            </ItemTemplate>
			</asp:templatefield>
            </Columns>
        </asp:GridView>
        </asp:Panel>
        </div>
        <%--<asp:TextBox ID="txtHistory" runat="server" TextMode="MultiLine" Wrap="true" Width="300" Height="500"></asp:TextBox>--%>
        </asp:TableCell>
    </asp:TableRow>
    </asp:Table>

    <asp:SqlDataSource ID="dsSearch" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" >
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Attribut" Type="String" />
            <asp:Parameter Name="Operator" Type="String" />
            <asp:Parameter Name="Wert" Type="String" />
            <asp:Parameter Name="Datatype" Type="String" />
            <asp:Parameter Name="UserId" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="UserId" SessionField="UserName" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Operator" Type="String" />
            <asp:Parameter Name="Wert" Type="String" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:HiddenField ID="HiddenInputBox" runat="server" />

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="select Iteration, SQL as 'Suchkriterium', SearchMode from V_Recursive_Log where GUID = @GUID order by Iteration DESC">
        <SelectParameters>
            <asp:SessionParameter Name="GUID" SessionField="GUID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
