<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NCT-TBB-Search.aspx.cs" Inherits="BMBH_View.NCT_TBB_Search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="Panel1" runat="server" BorderColor="White" BorderStyle="Solid" BorderWidth="5px" Width="466px">
    <asp:Button ID="btnNew" runat="server" CssClass="btn-pnl" Text="Neu" OnClick="btnNew_Click" />
    <div style="display:block;float:right;">
        <asp:Button ID="btnSubmit" runat="server" Text="Absenden" CssClass="btn-pnl" Width="74px" OnClick="btnSubmit_Click" />
    </div>    
</asp:Panel>
    <asp:GridView ID="dgdSearch" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" DataKeyNames="ID" DataSourceID="TBB_Search" OnRowEditing="dgdSearch_RowEditing" Width="464px">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID" Visible="False" />
            <asp:BoundField DataField="Attribut" HeaderText="Attribut" SortExpression="Attribut" ReadOnly="True" />
            <asp:TemplateField HeaderText="Operator">
                <EditItemTemplate>
                    <asp:DropDownList ID="cboOperator" runat="server" SelectedValue='<%# Bind("Operator") %>' AutoPostBack="True" OnSelectedIndexChanged="cboOperator_SelectedIndexChanged">
                        <asp:ListItem>=</asp:ListItem>
                        <asp:ListItem Value="LIKE">ENTHÄLT</asp:ListItem>
                        <asp:ListItem Value="&lt;"></asp:ListItem>
                        <asp:ListItem Value="&gt;"></asp:ListItem>
                        <asp:ListItem Value="IN"></asp:ListItem>     
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Operator") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Wert" SortExpression="Wert">
                <EditItemTemplate>
                    <asp:DropDownList ID="cboValue" runat="server" DataSourceID="dsCboValue" DataTextField="TEXT" DataValueField="TEXT" Visible='<%# SetVisibility(Eval("Datatype").ToString(), Eval("Operator").ToString(), "CBO") %>' SelectedValue='<%# Bind("Wert") %>' Width="350px" >
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="dsCboValue" runat="server" ConnectionString="<%$ ConnectionStrings:CLIN106_DATAConnectionString %>" SelectCommand="exec('select null as TEXT union select distinct ' + @CurrentField + ' as TEXT from V_NCT_TBB_GESAMT order by TEXT')">
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="Status" Name="CurrentField" SessionField="CurrentField" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Calendar ID="calFrom" runat="server" BackColor="#BFDFFF" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" DayNameFormat="FirstTwoLetters" ForeColor="#003366" OnSelectionChanged="calFrom_SelectionChanged" ShowGridLines="True" Visible='<%# SetVisibility(Eval("Datatype").ToString(), Eval("Operator").ToString(), "CAL") %>'>
                        <DayHeaderStyle BackColor="#93C9FF" ForeColor="#283742" />
                        <SelectedDayStyle BackColor="#96B8D3" />
                        <TitleStyle BackColor="#4985CD" Font-Bold="True" ForeColor="#EEF5FD" />
                    </asp:Calendar>
                    <asp:Panel ID="Panel2" runat="server" Width="375px">
                        <asp:TextBox ID="txtValue" runat="server" EnableViewState="False" Text='<%# Bind("Wert") %>' Visible='<%# SetVisibility(Eval("Datatype").ToString(), Eval("Operator").ToString(), "TXT") %>' Width="320px" Wrap="False"></asp:TextBox>
                        <asp:ImageButton ID="btnInSelect" runat="server" BackColor="#EAF5F8" BorderColor="#E2E2E2" BorderStyle="Outset" BorderWidth="2px" CssClass="btn-info" Height="22px" ImageUrl="~/Images/paste_16x16.gif" OnClick="btnInSelect_Click" ToolTip="Daten aus Zwischenablage einfügen" Visible='<%# SetVisibility(Eval("Datatype").ToString(), Eval("Operator").ToString(), "IMG") %>' />
                    </asp:Panel>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Wert") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
			<asp:BoundField DataField="Datatype" HeaderText="Datentyp" SortExpression="Datatype" ReadOnly="True" />
            <asp:BoundField DataField="UserId" HeaderText="UserId" SortExpression="UserId" Visible="False" />
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
    <asp:SqlDataSource ID="TBB_Search" runat="server" ConnectionString="<%$ ConnectionStrings:CLIN106_DATAConnectionString %>" SelectCommand="SELECT * FROM [Views_TBB_Search] WHERE ([UserId] = @UserId)" UpdateCommand="UPDATE [Views_TBB_Search] SET [Operator] = @Operator, [Wert] = @Wert WHERE [ID] = @ID" CancelSelectOnNullParameter="False" DeleteCommand="DELETE FROM [Views_TBB_Search] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Views_TBB_Search] ([Attribut], [Operator], [Wert], [Datatype], [UserId]) VALUES (@Attribut, @Operator, @Wert, @Datatype, @UserId)">
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
