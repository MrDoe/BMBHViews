﻿<%@ Page Title="BMBH_Views - Suchformular" Language="C#" Debug="true" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="BMBHviews.Search" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<asp:HiddenField ID="width" runat="server" />
<asp:HiddenField ID="height" runat="server" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/> 
<h4>Suche in <%:Session["View"]%> </h4>
<asp:Panel ID="pnlTop" runat="server" BorderColor="White" BorderStyle="Solid" BorderWidth="5px" Width="99%" style="top:3px; position:relative">
    <asp:Button ID="btnSubmit" runat="server" Text="Absenden" CssClass="btn btn-default btn-small" Width="70px" OnClick="btnSubmit_Click" Font-Bold="False" />
    <asp:Button ID="btnNew" runat="server" CssClass="btn btn-default btn-small" Font-Bold="False" OnClick="btnNew_Click" Text="Neue Suche" Width="80px" />
    <asp:Button ID="btnUpdateValues" runat="server" Text="Werte aktualisieren" CssClass="btn btn-default btn-small" Width="120px" OnClick="btnUpdateValues_Click" Font-Bold="False" ToolTip="Alle Wertelisten aktualisieren" />
    &nbsp;&nbsp; Gespeicherte Suche:&nbsp;<div style="float:right;position:relative;left:auto">
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
    <asp:DropDownList ID="cboSaveSearch" runat="server" DataSourceID="SqlDataSource1" DataTextField="SearchName" DataValueField="SearchName" CssClass="DropDown"></asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="select distinct SearchName from V_Save_Search where UserId = @User and ViewName = @View">
        <SelectParameters>
            <asp:SessionParameter Name="User" SessionField="UserName" />
            <asp:SessionParameter Name="View" SessionField="View" />
        </SelectParameters>
    </asp:SqlDataSource>
    &nbsp;<asp:Button ID="btnLoadSearch" runat="server" CssClass="btn btn-default btn-small" Font-Bold="False" Text="Laden" Width="57px" OnClick="btnLoadSearch_Click" />
    &nbsp;<asp:Button ID="btnSaveSearch" runat="server" CssClass="btn btn-default btn-small" Font-Bold="False" Text="Speichern" Width="68px" />
    <ajaxToolkit:ModalPopupExtender ID="MPE_SaveSearch" runat="server" TargetControlID="btnSaveSearch" PopupControlID="pnlSaveSearch" PopupDragHandleControlID="pnlSaveSearchHeader" BackgroundCssClass="modalBackground" BehaviorID="MPE_ID"></ajaxToolkit:ModalPopupExtender>
    &nbsp;<asp:Button ID="btnDeleteSearch" runat="server" CssClass="btn btn-default btn-small" Font-Bold="False" ClientIDMode="Static" OnClientClick="DeleteSearch('PostfromDelete');" Text="Löschen" Width="68px" />
    &nbsp;<asp:CheckBox ID="chkExpertMode" runat="server" AutoPostBack="True" OnCheckedChanged="chkExpertMode_CheckedChanged" Text="Expertenmodus" CssClass="chkChoice"/>
</asp:Panel>

    <asp:UpdatePanel runat="server" ID="updSearch">
    <ContentTemplate>
    <asp:Table ID= "Table1" runat="server">
        <asp:TableRow>
            <asp:TableCell BorderStyle="None">
    <div style="box-shadow: 1px 2px 8px rgba(0,0,0,0.25);"> 
    <asp:GridView ID="dgdSearch" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" DataKeyNames="ID" OnRowEditing="dgdSearch_RowEditing" OnRowDataBound="dgdSearch_RowDataBound" OnRowCommand="dgdSearch_RowCommand" OnRowCreated="dgdSearch_RowCreated" DataSourceID="dsSearch" Font-Names="Arial" Font-Size="Small">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" Width="50%" Height="10px" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID" ControlStyle-Width="0px" HeaderStyle-Width="0px" ItemStyle-Width="0px" ShowHeader="False" />
  			<asp:Templatefield>
                <ItemStyle Width="45px"></ItemStyle>
			    <ItemTemplate>
                    <asp:Button ID="btnBracket1" runat="server" CssClass="btn btn-default btn-small" Text="(" OnClick="btnBracket1_Click" />
                </ItemTemplate>
			</asp:Templatefield>
            <asp:BoundField DataField="Attribut" HeaderText="Attribut" SortExpression="Attribut" ReadOnly="True" />
            <asp:TemplateField HeaderText="Operator" ItemStyle-Width="10%">
                <EditItemTemplate>
                    <asp:DropDownList ID="cboOperator" runat="server" SelectedValue='<%# Bind("Operator") %>' AutoPostBack="True" OnSelectedIndexChanged="cboOperator_SelectedIndexChanged" CssClass="DropDown">
                        <asp:ListItem>=</asp:ListItem>
                        <asp:ListItem Value="&lt;&gt;"></asp:ListItem>
                        <asp:ListItem>ENTHÄLT</asp:ListItem>
                        <asp:ListItem>ENTHÄLT NICHT</asp:ListItem>
                        <asp:ListItem>IN</asp:ListItem>
                        <asp:ListItem Value="&lt;"></asp:ListItem>
                        <asp:ListItem Value="&gt;"></asp:ListItem>
                        <asp:ListItem>ZWISCHEN</asp:ListItem>
                        <asp:ListItem>IST LEER</asp:ListItem>
                        <asp:ListItem>IST NICHT LEER</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                        <asp:Label ID="lblOperator" runat="server" Text='<%# Bind("Operator") %>'></asp:Label>
                </ItemTemplate>
                <ControlStyle Width="110px" /> <ItemStyle Width="10%"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Wert" SortExpression="Wert" ItemStyle-Width="40%">
                <EditItemTemplate>
                    <div>
                        <div class="block" style="position:relative; top:-4px; padding-top:5px;">
                            <asp:Label ID="lblFrom" runat="server" Text="Von:" CssClass="lblValue" />
                            <asp:TextBox ID="txtCalFrom" runat="server" CssClass="txtValue" Visible="False"/>
                            <asp:ImageButton ID="btnCalFrom" runat="server" ImageUrl="~/Images/table_16x16.gif" CssClass="imagebutton" Width="24" AlternateText="Kalender anzeigen" /><br />
                            <ajaxToolkit:CalendarExtender ID="calFrom" runat="server" TargetControlID="txtCalFrom" PopupButtonID="btnCalFrom" TodaysDateFormat="dd.MM.yyyy HH:mm" Format="dd.MM.yyyy HH:mm"/>
                        </div>
                        <div class="block" style="padding-bottom:5px;">
                            <asp:Label ID="lblTo" runat="server" Text="Bis:" CssClass="lblValue" />
                            <asp:TextBox ID="txtCalTo" runat="server" CssClass="txtValue" Visible="False"/>
                            <asp:ImageButton ID="btnCalTo" runat="server" ImageUrl="~/Images/table_16x16.gif" CssClass="imagebutton" Width="24" AlternateText="Kalender anzeigen"/>
                            <ajaxToolkit:CalendarExtender ID="calTo" runat="server" TargetControlID="txtCalTo" PopupButtonID="btnCalTo" TodaysDateFormat="dd.MM.yyyy HH:mm" Format="dd.MM.yyyy HH:mm"/>
                        </div>
                    </div>
                    <div style="float:left; position:relative; top:-20px">
                        <div style="position:relative; top:6px;">
                            <asp:DropDownList ID="cboValue" runat="server" CssClass="DropDown"></asp:DropDownList>
                        </div>
                        <asp:Label ID="lblInsertValues" runat="server" Text="Werte hier einfügen:"></asp:Label>
                        <asp:TextBox ID="txtValue" runat="server" Text='<%# Bind("Wert") %>' Width="220px" Wrap="False" OnTextChanged="txtValue_TextChanged" CssClass="txtValue2"></asp:TextBox>
                    </div>
                    <asp:CheckBoxList ID="chkValue" runat="server" CellPadding="1" CellSpacing="1" CssClass="chkChoice" Font-Bold="False" Font-Italic="False" Font-Names="Arial" Width="169px">
                    </asp:CheckBoxList>
                    <div style="float:left; position:relative">
                    <asp:CheckBox ID="chkSingleValue" runat="server" CssClass="chkSingle" Text="Auswahl (Ja):" Visible="false" style="width:160px" OnCheckedChanged="chkSingleValue_CheckedChanged"/>
                    <asp:ImageButton ID="btnClearValue" runat="server" ImageUrl="~/Images/delete_field.gif" BackColor="#EAF5F8" BorderColor="#E5E5E5" BorderStyle="Outset" BorderWidth="2px" CssClass="btn-info" Height="22px" AlternateText="Löschen" OnClick="btnClearValue_Click" Visible="false" ToolTip="Wert löschen" style="width:22px;top:-11px"/>
                    </div>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblValue" runat="server" Text='<%# Bind("Wert") %>' Style="word-wrap: normal; word-break: break-all;"></asp:Label>
                </ItemTemplate>
                <ControlStyle Width="250px" />
                <ItemStyle Width="250px" Wrap="true"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Logik">
                <EditItemTemplate>
                    <asp:DropDownList ID="cboLogic" runat="server" SelectedValue='<%# Bind("Logic") %>' AutoPostBack="True" CssClass="DropDown">
                        <asp:ListItem></asp:ListItem>
                        <asp:ListItem>UND</asp:ListItem>
                        <asp:ListItem>ODER</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                        <asp:Label ID="lblLogic" runat="server" Text='<%# Bind("Logic") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
			<asp:BoundField DataField="Datatype" HeaderText="Datentyp" SortExpression="Datatype" ReadOnly="True" />
            <asp:BoundField DataField="UserId" HeaderText="UserId" SortExpression="UserId" Visible="False" />
   			<asp:TemplateField HeaderText="Kontrollelement" >
                <EditItemTemplate>
                    <asp:DropDownList ID="cboControltype" runat="server" SelectedValue='<%# Bind("Controltype") %>' AutoPostBack="True" Height="17px" Width="148px" OnSelectedIndexChanged="cboControltype_SelectedIndexChanged" CssClass="DropDown">
                        <asp:ListItem>TextBox</asp:ListItem>
                        <asp:ListItem>DropDownList</asp:ListItem>
                        <asp:ListItem>Calendar</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Controltype") %>' Width="80px"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
   			<asp:Templatefield>
                <ItemStyle Width="90px"></ItemStyle>
				<edititemtemplate>
					<asp:Button ID="btnOK" runat="server" CssClass="btn btn-default btn-small" commandname="Update" Text="OK" OnClick="btnOK_Click" />
					<asp:Button ID="btnCopyRow" runat="server" CssClass="btn btn-default btn-small" Text="Zeile kopieren" OnClick="btnCopyRow_Click" />
				</edititemtemplate>
			    <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-default btn-small" commandname="Edit" Text="Ändern" />
                </ItemTemplate>
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
			</asp:Templatefield>
   			<asp:Templatefield>
                <ItemStyle Width="45px"></ItemStyle>
			    <ItemTemplate>
                    <asp:Button ID="btnUp" runat="server" CssClass="btn btn-default btn-small" style="padding-left:3px; padding-top:1px; width:16px; height:16px; font-size:6pt;" Text="▲" OnClick="btnUp_Click"/>
                    <asp:Button ID="btnDown" runat="server" CssClass="btn btn-default btn-small" style="padding-left:3px; padding-top:1px; width:16px; height:16px; font-size:6pt;" Text="▼" OnClick="btnDown_Click"/>
                </ItemTemplate>
			</asp:Templatefield>
            <asp:BoundField DataField="Sorter" SortExpression="Sorter" ReadOnly="True" />
  			<asp:Templatefield>
                <ItemStyle Width="45px"></ItemStyle>
			    <ItemTemplate>
                    <asp:Button ID="btnBracket2" runat="server" CssClass="btn btn-default btn-small" Text=")" OnClick="btnBracket2_Click" />
                </ItemTemplate>
			</asp:Templatefield>
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
    </div>
    </asp:TableCell>

    <asp:TableCell BorderStyle="None">
    <div style="position:absolute; top:125px;">
        <asp:Panel ID="pnlSQLeditor" runat="server" Visible="false">
            SQL-Abfrageeditor:<br />
            <asp:TextBox ID="txtSQLselect" runat="server" Width="600px" style="box-shadow: 1px 1px 8px rgba(0,0,0,0.3); background-color:rgb(93, 123, 157); color:white;" ReadOnly="true"/>
            <asp:TextBox ID="txtSQLwhere" runat="server" Width="600px" Height="500px" TextMode="MultiLine"/>
        </asp:Panel>
        <asp:Panel ID="pnlSQLhistory" runat="server" BorderWidth="10px" BorderColor="transparent" Visible="false">
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
        </asp:TableCell></asp:TableRow></asp:Table>
    </ContentTemplate>
    </asp:UpdatePanel>

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

<asp:Panel ID="pnlSaveSearch" runat="server" CssClass="modalPopup" align="center" style="display:none" TabIndex="0" Height="100">
<asp:Panel ID="pnlSaveSearchHeader" runat="server" CssClass="modalHeader" HorizontalAlign="center" TabIndex="0">
    Suchmaske speichern: <asp:Button ID="btnCancel" runat="server" CssClass="modalHeaderButton" Text=" x " TabIndex="99" OnClick="btnCancel_Click" ClientIDMode="Static" OnClientClick="__doPostBack('<%= btnCancel.UniqueID%>', 'PostFromCancel');" />
</asp:Panel>
    Name der Suchmaske:&nbsp;<asp:TextBox ID="txtSearchName" runat="server" TabIndex="0" ClientIDMode="Static" /> <br /><br />
    <asp:Button ID="btnOK" runat="server" Text="Übernehmen" CssClass="btn btn-default btn-small" style="left:405px;padding:5px;" TabIndex="4" ClientIDMode="Static" OnClientClick="__doPostBack('<%= btnOK.UniqueID%>', 'PostFromSave');"/>
</asp:Panel>

<%--set focus on textfield--%>
<script type="text/javascript">
function pageLoad() {
    $find("MPE_ID").add_shown(onModalPopupShown);
}
function onModalPopupShown() {
    $get("<%=txtSearchName.ClientID%>").focus();
}
</script>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    </asp:UpdatePanel>

</asp:Content>
