<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PancoBank_Liquid_Search.aspx.cs" Inherits="BMBH_View.PancoBank_Liquid_Search" %>
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
                    <asp:DropDownList ID="cboValue" runat="server" DataSourceID="dsCboValue" DataTextField="TEXT" DataValueField="TEXT" Visible='<%# !SetVisibility(Eval("Datatype").ToString()) %>' SelectedValue='<%# Bind("Wert") %>' Width="350px" >
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="dsCboValue" runat="server" ConnectionString="<%$ ConnectionStrings:CLIN106_DATAConnectionString %>" SelectCommand="exec('select null as TEXT union select distinct ' + @CurrentField + ' as TEXT from V_PANCOBANK_LIQUID order by TEXT')">
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="Status" Name="CurrentField" SessionField="CurrentField" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:TextBox ID="txtValue" runat="server" Text='<%# Bind("Wert") %>' Visible='<%# SetVisibility(Eval("Datatype").ToString()) %>' EnableViewState="False" Width="350px" Wrap="False"></asp:TextBox>
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
                    <asp:Button ID="btnEdit" runat="server" CssClass="btn-xs" commandname="Edit" Text="Ändern" OnClick="btnEdit_Click" />
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
    <asp:SqlDataSource ID="TBB_Search" runat="server" ConnectionString="<%$ ConnectionStrings:CLIN106_DATAConnectionString %>" SelectCommand="SELECT * FROM [Views_PancoBank_Liquid_Search] WHERE ([UserId] = @UserId)" UpdateCommand="UPDATE [Views_PancoBank_Liquid_Search] SET [Operator] = @Operator, [Wert] = @Wert WHERE [ID] = @ID" CancelSelectOnNullParameter="False" DeleteCommand="DELETE FROM [Views_PancoBank_Liquid_Search] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Views_PancoBank_Liquid_Search] ([Attribut], [Operator], [Wert], [Datatype], [UserId]) VALUES (@Attribut, @Operator, @Wert, @Datatype, @UserId)">
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
