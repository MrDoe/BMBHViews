<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MultipleSearch.aspx.cs" Inherits="BMBH_View.MultipleSearch" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Patientensuche/De- und Pseudonymisierung</h2>
    <p><font size="2">Benutzungshinweise: Jeweils eine Spalte mit den Quelldaten in Excel markieren und in die Zwischenablage kopieren. Anschließend in der folgenden Tabelle  den zugehörigen Spaltentitel anklicken. Wenn alle Daten in der Tabelle sind, auf &quot;Suche starten&quot; klicken.</font></p>
    <asp:Button ID="btnSearch" Visible="false" runat="server" CssClass="btn btn-default btn-small" Text="Suche starten" Width="92px" OnClick="btnSearch_Click" />
    <asp:Button ID="btnNew" runat="server" CssClass="btn btn-default btn-small" Text="Neue Suche" OnClick="btnNew_Click" />
    <asp:Button ID="btnExcel" Visible="false" runat="server" CssClass="btn btn-default btn-small" OnClick="btnExcel_Click" Text="Excel-Export" />

    <div style="display: block; float: right; position: relative; top: 5px;">
        <asp:HiddenField ID="hfTarget" runat="server" />
        <AjaxControlToolkit:ModalPopupExtender ID="MPE" runat="server" TargetControlID="hfTarget" PopupControlID="pnlList" PopupDragHandleControlID="pnlListHeader" BackgroundCssClass="modalBackground" BehaviorID="MPE_ID"></AjaxControlToolkit:ModalPopupExtender>

    </div>
    <br />
    <br>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Timer ID="Timer1" runat="server" OnTick="TimerTick" Interval="10" Enabled="false">
            </asp:Timer>
            <asp:GridView ID="dgdPatients" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="ID" OnRowDataBound="dgdPatients_RowDataBound" Width="769px">
                <AlternatingRowStyle BackColor="#E7EEFA" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" Visible="false" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                    <asp:TemplateField HeaderText="Name" SortExpression="Name">
                        <HeaderTemplate>
                            <asp:Button ID="btnName" runat="server" CssClass="btn btn-default btn-small btn-header" ClientIDMode="Static" OnClientClick="pasteToGrid('Name');" Text="Name" />
                            <asp:Label ID="lblName" runat="server" Visible="false" Text="Name" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblNameVal" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                            <asp:TextBox ID="txtNameVal" runat="server" onchange="javascript: Changed( this );" Text='<%# Bind("Name") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Vorname" SortExpression="Vorname">
                        <HeaderTemplate>
                            <asp:Button ID="btnPrename" runat="server" CssClass="btn btn-default btn-small btn-header" Text="Vorname" ClientIDMode="Static" OnClientClick="pasteToGrid('Vorname');" />
                            <asp:Label ID="lblPrename" runat="server" Visible="false" Text="Vorname" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrenameVal" runat="server" Text='<%# Bind("Vorname") %>'></asp:Label>
                            <asp:TextBox ID="txtPrenameVal" runat="server" onchange="javascript: Changed( this );" Text='<%# Bind("Vorname") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Geburtsdatum" SortExpression="Geburtsdatum">
                        <HeaderTemplate>
                            <asp:Button ID="btnBirthdate" runat="server" CssClass="btn btn-default btn-small btn-header" Text="Geburtsdatum" Width="95px" ClientIDMode="Static" OnClientClick="pasteToGrid('Geburtsdatum');" />
                            <asp:Label ID="lblBirthdate" runat="server" Visible="false" Text="Geburtsdatum" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblBirthdateVal" runat="server" Text='<%# Bind("Geburtsdatum", "{0:dd.MM.yyyy}") %>'></asp:Label>
                            <asp:TextBox ID="txtBirthdateVal" runat="server" onchange="javascript: Changed( this );" Text='<%# Bind("Geburtsdatum", "{0:dd.MM.yyyy}") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ISH_PID" SortExpression="ISH_PID">
                        <HeaderTemplate>
                            <asp:Button ID="btnISHPID" runat="server" CssClass="btn btn-default btn-small btn-header" Text="ISH_PID" Width="69px" ClientIDMode="Static" OnClientClick="pasteToGrid('ISH_PID');" />
                            <asp:Label ID="lblISHPID" runat="server" Visible="false" Text="ISH-PID" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblISHPIDVal" runat="server" Text='<%# Bind("ISH_PID") %>'></asp:Label>
                            <asp:TextBox ID="txtISHPIDVal" runat="server" onchange="javascript: Changed( this );" Text='<%# Bind("ISH_PID") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ISH_FID" SortExpression="ISH_FID">
                        <HeaderTemplate>
                            <asp:Button ID="btnISHFID" runat="server" CssClass="btn btn-default btn-small btn-header" Text="ISH_FID" Width="66px" ClientIDMode="Static" OnClientClick="pasteToGrid('ISH_FID');" />
                            <asp:Label ID="lblISHFID" runat="server" Visible="false" Text="ISH-FID" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblISHFIDVal" runat="server" Text='<%# Bind("ISH_FID") %>'></asp:Label>
                            <asp:TextBox ID="txtISHFIDVal" runat="server" onchange="javascript: Changed( this );" Text='<%# Bind("ISH_FID") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="BMBH_PID" SortExpression="BMBH_PID">
                        <HeaderTemplate>
                            <asp:Button ID="btnBMBHPID" runat="server" CssClass="btn btn-default btn-small btn-header" Text="BMBH-PID" Width="87px" ClientIDMode="Static" OnClientClick="pasteToGrid('BMBH_PID');" />
                            <asp:Label ID="lblBMBHPID" runat="server" Visible="false" Text="BMBH-PID" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblBMBHPIDVal" runat="server" Text='<%# Bind("BMBH_PID") %>'></asp:Label>
                            <asp:TextBox ID="txtBMBHPIDVal" runat="server" onchange="javascript: Changed( this );" Text='<%# Bind("BMBH_PID") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="GUID" HeaderText="GUID" SortExpression="GUID" Visible="False" />
                    <asp:TemplateField HeaderText="Histo_Nr">
                        <HeaderTemplate>
                            <asp:Button ID="btnHistoNr" runat="server" CssClass="btn btn-default btn-small btn-header" Text="Histo_Nr" Width="87px" ClientIDMode="Static" OnClientClick="pasteToGrid('Histo_Nr');" />
                            <asp:Label ID="lblHistoNr" runat="server" Text="Histo_Nr" Visible="False"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblHistoNrVal" runat="server" Text='<%# Bind("Histo_Nr") %>'></asp:Label>
                            <asp:TextBox ID="txtHistoNrVal" runat="server" AutoPostBack="true" OnTextChanged="nameChanged" Text='<%# Bind("Histo_Nr") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Einwilligungsstatus" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Pseudonym">
                        <ItemTemplate>
                            <asp:Button ID="btnPseudo" runat="server" Text='Generieren' OnClick="ShowSimilarPatients"></asp:Button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
                <EmptyDataRowStyle BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
                <FooterStyle BackColor="White" ForeColor="#000066" />
                <HeaderStyle BackColor="#006291" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                <RowStyle BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" ForeColor="#000066" />
                <SelectedRowStyle BackColor="#669999" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#00547E" />
            </asp:GridView>

        </ContentTemplate>

    </asp:UpdatePanel>


    <asp:Panel ID="pnlList" runat="server" CssClass="modalPopup" align="center" Style="background-color: white; width: 700px; height: 300px; top: 0px; left: 0px;" TabIndex="0">
        <asp:Panel ID="pnlListHeader" runat="server" CssClass="modalHeader" Style="width: 712px;" HorizontalAlign="center" TabIndex="0">
            Pseudonymisierung
            <asp:Button ID="btnClose" runat="server" Text=" x " TabIndex="99" CssClass="modalHeaderButton" Style="left: 690px;" OnClick="btnClos_Click" />
        </asp:Panel>
        Ähnliche Patienten:&nbsp;<br />
        <br />
        <asp:Label ID="lblInfo" runat="server">Bitte ISH-Prüfziffer ohne Punkt an die ISH-PID hängen</asp:Label>
        <br />
        <br />
        <div class="panel panel-default" style="line-height: normal;">
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <asp:Label ForeColor="Red" Visible="False" ID="lblError" runat="server">Bitte überprüfen Sie die ISH-PID. Es dürfen nur Zahlen eingetragen werden.</asp:Label>
                    <br />
                    <asp:GridView ID="dgdSimPatients" runat="server" AutoGenerateColumns="False" Height="133px" Width="700px" OnRowDataBound="dgdSimPatients_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="pLName" SortExpression="pLName">
                                <HeaderTemplate>
                                    <asp:Label ID="lblpLName" runat="server" Text="Name" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblpLNameVal" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="pSName" SortExpression="pSName">
                                <HeaderTemplate>
                                    <asp:Label ID="lblpSName" runat="server" Text="Vorname" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblpSNameVal" runat="server" Text='<%# Bind("vorname") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="pGeb" SortExpression="pGeb">
                                <HeaderTemplate>
                                    <asp:Label ID="lblPGeb" runat="server" Text="Geburtsdatum" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblPGebVal" runat="server" Text='<%# Bind("geb", "{0:dd.MM.yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="pSex" SortExpression="pSex">
                                <HeaderTemplate>
                                    <asp:Label ID="lblPSex" runat="server" Text="Geschlecht" />
                                </HeaderTemplate>
                                <ItemTemplate>

                                    <asp:DropDownList ID="ddPSexVal" Width="50px" SelectedValue='<%# Bind("geschlecht") %>' Visible="false" runat="server">
                                        <asp:ListItem Value="m"> m </asp:ListItem>
                                        <asp:ListItem Value="w"> w </asp:ListItem>
                                        <asp:ListItem Value="s"> s </asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:Label ID="lblPSexVal" Width="50px" runat="server" Text='<%# Bind("geschlecht") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="pPID" SortExpression="pPID" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                                <HeaderTemplate>
                                    <asp:Label ID="lblPPID" runat="server" Text="ISH-PID" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:TextBox ID="txtPPIDVal" Width="100px" Visible="false" runat="server" Text='<%# Bind("PID") %>'></asp:TextBox>
                                    <asp:Label ID="lblPPIDVal" Width="100px" runat="server" Text='<%# Bind("PID") %>'></asp:Label>
                                    <br />
                                    <!--<asp:regularexpressionvalidator id="regular1" controltovalidate="txtPPIDVal" runat="server" errormessage="Prüfziffer ohne Punkt" validationexpression="^\d*$"></asp:regularexpressionvalidator>-->

                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="SBMBH" SortExpression="SBMBH">
                                <HeaderTemplate>
                                    <asp:Label ID="lblSBMBH" runat="server" Text="BMBH_PID" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblSBMBHVal" runat="server" Text='<%# Bind("BMBH_PID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pseudonym">
                                <ItemTemplate>
                                    <asp:Button ID="btnPseudonym" runat="server" Text='Generieren' OnClick="GeneratePseudonym"></asp:Button>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

    </asp:Panel>

    <asp:SqlDataSource ID="dsPatientSearch" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>" SelectCommand="SELECT * FROM [PatientSearch] WHERE [GUID] = @GUID" OnSelecting="dsPatientSearch_Selecting">
        <SelectParameters>
            <asp:SessionParameter Name="GUID" SessionField="GUID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenInputBox" runat="server" />
    <asp:HiddenField ID="HiddenSearchMode" runat="server" />

    <script>
        function Changed(lnk) {
            var row = lnk.parentNode.parentNode;
            var text = lnk.value;
            var id = lnk.id;

            var show = text === "";


    if (id.indexOf("txtPrenameVal") > -1 || id.indexOf("txtNameVal") > -1 || id.indexOf("txtBirthdateVal") > -1) {
        var lName = row.cells[0].getElementsByTagName("input")[0].value;
        var pName = row.cells[1].getElementsByTagName("input")[0].value;
        var bir = row.cells[2].getElementsByTagName("input")[0].value;
        show = lName === "" && pName === "" && bir === "";

        row.cells[3].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
        row.cells[4].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
        row.cells[5].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';

        document.getElementById('<%= HiddenSearchMode.ClientID %>').value = show ? 4 : 0;

     } else if (id.indexOf("txtISHPIDVal") > -1) {
         row.cells[0].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[1].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[2].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[4].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[5].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';

         document.getElementById('<%= HiddenSearchMode.ClientID %>').value = show ? 4 : 1;

     } else if (id.indexOf("txtISHFIDVal") > -1) {
         row.cells[0].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[1].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[2].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[3].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[5].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';

         document.getElementById('<%= HiddenSearchMode.ClientID %>').value = show ? 4 : 2;

     } else if (id.indexOf("txtBMBHPIDVal") > -1) {
         row.cells[0].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[1].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[2].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[3].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';
         row.cells[4].getElementsByTagName("input")[0].style.display = show ? 'inline' : 'none';

         document.getElementById('<%= HiddenSearchMode.ClientID %>').value = show ? 4 : 3;
     } else {
         document.getElementById('<%= HiddenSearchMode.ClientID %>').value = show ? 4 : 5;
            }

        }
    </script>
</asp:Content>
