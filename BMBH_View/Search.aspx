<%@ Page Title="BMBH-Views - Suchformular" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="BMBH_View.NCT_TBB_Search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/> 
    <asp:Panel ID="Panel1" runat="server" BorderColor="White" BorderStyle="Solid" BorderWidth="5px" Width="466px">
    <asp:Button ID="btnNew" runat="server" CssClass="btn-pnl" Text="Neu" OnClick="btnNew_Click" />
    <div style="display:block;float:right;">
        <asp:Button ID="btnSubmit" runat="server" Text="Absenden" CssClass="btn-pnl" Width="74px" OnClick="btnSubmit_Click" />
    </div>    
</asp:Panel>
    <asp:GridView ID="dgdSearch" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" DataKeyNames="ID" OnRowEditing="dgdSearch_RowEditing" Width="464px" OnRowDataBound="dgdSearch_RowDataBound" DataSourceID="dsSearch">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID" Visible="False" />
            <asp:BoundField DataField="Attribut" HeaderText="Attribut" SortExpression="Attribut" ReadOnly="True" />
            <asp:TemplateField HeaderText="Operator">
                <EditItemTemplate>
                    <asp:DropDownList ID="cboOperator" runat="server" SelectedValue='<%# Bind("Operator") %>' AutoPostBack="True" OnSelectedIndexChanged="cboOperator_SelectedIndexChanged">
                        <asp:ListItem>=</asp:ListItem>
                        <asp:ListItem Value="LIKE">ENTHÄLT</asp:ListItem>
                        <asp:ListItem Value="IN"></asp:ListItem>
                        <asp:ListItem Value="&lt;"></asp:ListItem>
                        <asp:ListItem Value="&gt;"></asp:ListItem>
                        <asp:ListItem Value="BETWEEN">ZWISCHEN</asp:ListItem>     
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Operator") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Wert" SortExpression="Wert">
                <EditItemTemplate>
                    <asp:DropDownList ID="cboValue" runat="server" Width="350px" >
                    </asp:DropDownList>
                    <asp:Calendar ID="calFrom" runat="server" BackColor="#BFDFFF" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" DayNameFormat="FirstTwoLetters" Font-Size="9pt" ForeColor="#003366" OnSelectionChanged="calFrom_SelectionChanged" ShowGridLines="True" CssClass="inlineBlock">
                        <DayHeaderStyle BackColor="#93C9FF" ForeColor="#283742" />
                        <SelectedDayStyle BackColor="#96B8D3" />
                        <TitleStyle BackColor="#4985CD" Font-Bold="True" ForeColor="#EEF5FD" />
                    </asp:Calendar>
                    <asp:Calendar ID="calTo" runat="server" BackColor="#BFDFFF" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" DayNameFormat="FirstTwoLetters" Font-Size="9pt" ForeColor="#003366" OnSelectionChanged="calTo_SelectionChanged" ShowGridLines="True" CssClass="inlineBlock">
                        <DayHeaderStyle BackColor="#93C9FF" ForeColor="#283742" />
                        <SelectedDayStyle BackColor="#96B8D3" />
                        <TitleStyle BackColor="#4985CD" Font-Bold="True" ForeColor="#EEF5FD" />
                    </asp:Calendar>
                    <asp:CheckBoxList ID="chkList" runat="server" OnSelectedIndexChanged="chkList_SelectedIndexChanged">
                    </asp:CheckBoxList>
                    <asp:Panel ID="Panel2" runat="server" Width="375px">
                        <asp:TextBox ID="txtValue" runat="server" EnableViewState="False" Text='<%# Bind("Wert") %>' Width="400px" Wrap="False"></asp:TextBox>
                        <asp:ImageButton ID="btnInSelect" runat="server" BackColor="#EAF5F8" BorderColor="#E2E2E2" BorderStyle="Outset" BorderWidth="2px" CssClass="btn-info" Height="22px" ImageUrl="~/Images/paste_16x16.gif" OnClick="btnInSelect_Click" ToolTip="Daten aus Zwischenablage einfügen" />
                    </asp:Panel>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Wert") %>'></asp:Label>
                </ItemTemplate>
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
            </asp:TemplateField>
   			<asp:templatefield>
				<edititemtemplate>
					<asp:Button ID="btnOK" runat="server" CssClass="btn-xs" commandname="Update" Text="OK" OnClick="btnOK_Click" />
				</edititemtemplate>
			    <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" CssClass="btn-xs" commandname="Edit" Text="Ändern" OnClick="btnEdit_Click"/>
                </ItemTemplate>
			</asp:templatefield>
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
    <asp:SqlDataSource ID="dsSearch" runat="server" ConnectionString="<%$ ConnectionStrings:CLIN106_DATAConnectionString %>" >
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
    <br />
</asp:Content>
