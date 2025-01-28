<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MultipleSearch.aspx.cs" Inherits="BMBHviews.MultipleSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Patientensuche und Pseudonymisierung</h2>
    <p>Benutzungshinweise: Jeweils eine Spalte mit den Quelldaten in Excel markieren und in die Zwischenablage kopieren. Anschließend die Daten in der folgenden Tabelle unter der jeweiligen Spalte einfügen. Wenn alle Daten in der Tabelle sind, auf &quot;Suche starten&quot; klicken.</p>
    <div style="display: block; float: right; position: relative; top: 5px;">
        <asp:HiddenField ID="hfTarget" runat="server" />
        <AjaxControlToolkit:ModalPopupExtender ID="MPE" runat="server" TargetControlID="hfTarget" PopupControlID="pnlList" PopupDragHandleControlID="pnlListHeader" BackgroundCssClass="modalBackground" BehaviorID="MPE_ID"></AjaxControlToolkit:ModalPopupExtender>
    </div>
    <asp:Panel ID="Panel1" runat="server">
        <asp:Label ID="Label1" runat="server" CssClass="me-2 font-weight-bold" Text="Modus:"></asp:Label>
        <asp:RadioButton ID="rbSearch" runat="server" Checked="True" Text="Suchen" CssClass="my-2" GroupName="Mode" OnCheckedChanged="rb_CheckedChanged" AutoPostBack="True"/>
        <asp:RadioButton ID="rbPseudo" runat="server" Text="Pseudonymisieren" CssClass="my-2" GroupName="Mode" OnCheckedChanged="rb_CheckedChanged" AutoPostBack="True"/>
        <asp:Button ID="btnNew" runat="server" CssClass="btn btn-default btn-small" OnClick="BtnNew_Click" Text="Neu" />
        <asp:Button ID="btnSearch" Visible="false" runat="server" CssClass="btn btn-default btn-small" Text="Suche starten" Width="92px" OnClick="BtnSearch_Click" />
        <asp:Button ID="btnExcel" Visible="false" runat="server" CssClass="btn btn-default btn-small" OnClick="BtnExcel_Click" Text="Excel-Export" />
    </asp:Panel>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="dgdPatients" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="ID" OnRowDataBound="DgdPatients_RowDataBound" Width="769px">
                <AlternatingRowStyle BackColor="#E7EEFA" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" Visible="false" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                    <asp:TemplateField HeaderText="Name" SortExpression="Name">
                        <HeaderTemplate>
                            <asp:Label ID="lblName" runat="server" Visible="true" Text="Name" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblNameVal" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                            <asp:TextBox ID="txtNameVal" runat="server" Visible="false" onchange="javascript: Changed( this );" Text='<%# Bind("Name") %>'></asp:TextBox>
                            <asp:TextBox ID="btnName" runat="server" Font-Size="Smaller" TextMode="MultiLine" onchange="pasteToGrid('Name', this);" ClientIDMode="Static" placeholder="Spalte hier einfügen..."></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Vorname" SortExpression="Vorname">
                        <HeaderTemplate>
                            <asp:Label ID="lblPrename" runat="server" Text="Vorname" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPrenameVal" runat="server" Text='<%# Bind("Vorname") %>'></asp:Label>
                            <asp:TextBox ID="txtPrenameVal" runat="server" Visible="false" onchange="javascript: Changed( this );" Text='<%# Bind("Vorname") %>'></asp:TextBox>
                            <asp:TextBox ID="btnPrename" runat="server" Font-Size="Smaller" TextMode="MultiLine" onchange="pasteToGrid('Vorname', this);" ClientIDMode="Static" placeholder="Spalte hier einfügen..."></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Geburtsdatum" SortExpression="Geburtsdatum">
                        <HeaderTemplate>
                            <asp:Label ID="lblBirthdate" runat="server" Text="Geburtsdatum" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblBirthdateVal" runat="server" Text='<%# Bind("Geburtsdatum", "{0:dd.MM.yyyy}") %>'></asp:Label>
                            <asp:TextBox ID="txtBirthdateVal" runat="server" Visible="false" onchange="javascript: Changed( this );" Text='<%# Bind("Geburtsdatum", "{0:dd.MM.yyyy}") %>'></asp:TextBox>
                            <asp:TextBox ID="btnBirthdate" runat="server" Font-Size="Smaller" TextMode="MultiLine" onchange="pasteToGrid('Geburtsdatum', this);" ClientIDMode="Static" placeholder="Spalte hier einfügen..."></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ISH_PID" SortExpression="ISH_PID">
                        <HeaderTemplate>
                            <asp:Label ID="lblISHPID" runat="server" Text="ISH-PID" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblISHPIDVal" runat="server" Text='<%# Bind("ISH_PID") %>'></asp:Label>
                            <asp:TextBox ID="txtISHPIDVal" runat="server" Visible="false" onchange="javascript: Changed( this );" Text='<%# Bind("ISH_PID") %>'></asp:TextBox>
                            <asp:TextBox ID="btnISHPID" runat="server" Font-Size="Smaller" TextMode="MultiLine" onchange="pasteToGrid('ISH_PID', this);" ClientIDMode="Static" placeholder="Spalte hier einfügen..."></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ISH_FID" SortExpression="ISH_FID">
                        <HeaderTemplate>
                            <asp:Label ID="lblISHFID" runat="server" Text="ISH-FID" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblISHFIDVal" runat="server" Text='<%# Bind("ISH_FID") %>'></asp:Label>
                            <asp:TextBox ID="txtISHFIDVal" runat="server" Visible="false" onchange="javascript: Changed( this );" Text='<%# Bind("ISH_FID") %>'></asp:TextBox>
                            <asp:TextBox ID="btnISHFID" runat="server" Font-Size="Smaller" TextMode="MultiLine" onchange="pasteToGrid('ISH_FID', this);" ClientIDMode="Static" placeholder="Spalte hier einfügen..."></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="BMBH_PID" SortExpression="BMBH_PID">
                        <HeaderTemplate>
                            <asp:Label ID="lblBMBHPID" runat="server" Text="BMBH-PID" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblBMBHPIDVal" runat="server" Text='<%# Bind("BMBH_PID") %>'></asp:Label>
                            <asp:TextBox ID="txtBMBHPIDVal" runat="server" Visible="false" onchange="javascript: Changed( this );" Text='<%# Bind("BMBH_PID") %>'></asp:TextBox>
                            <asp:TextBox ID="btnBMBHPID" runat="server" Font-Size="Smaller" TextMode="MultiLine" onchange="pasteToGrid('BMBH_PID', this);" ClientIDMode="Static" placeholder="Spalte hier einfügen..."></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="GUID" HeaderText="GUID" SortExpression="GUID" Visible="False" />
                    <asp:TemplateField HeaderText="Histo_Nr">
                        <HeaderTemplate>
                            <asp:Label ID="lblHistoNr" runat="server" Text="Histo_Nr"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblHistoNrVal" runat="server" Text='<%# Bind("Histo_Nr") %>'></asp:Label>
                            <%--<asp:TextBox ID="txtHistoNrVal" runat="server" AutoPostBack="true" Visible="false" OnTextChanged="NameChanged" Text='<%# Bind("Histo_Nr") %>'></asp:TextBox>--%>
                            <asp:TextBox ID="btnHistoNr" runat="server" Font-Size="Smaller" TextMode="MultiLine" onchange="pasteToGrid('Histo_Nr', this);" ClientIDMode="Static" placeholder="Spalte hier einfügen..."></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Einwilligungsstatus" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Pseudonym">
                        <ItemTemplate>
                            <asp:Button ID="btnPseudo" runat="server" CssClass="btn btn-default btn-small" Text="Generieren" OnClick="ShowSimilarPatients"></asp:Button>
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
            <asp:Button ID="btnClose" runat="server" Text=" x " TabIndex="99" CssClass="modalHeaderButton" Style="left: 690px;" OnClick="BtnClos_Click" />
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
                    <asp:GridView ID="dgdSimPatients" runat="server" AutoGenerateColumns="False" Height="133px" Width="700px" OnRowDataBound="DgdSimPatients_RowDataBound">
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

    <asp:SqlDataSource ID="dsPatientSearch" runat="server" ConnectionString="<%$ ConnectionStrings:BMBHViewsConnectionString %>"
        SelectCommand="SELECT * FROM [PatientSearch] WHERE [GUID] = @GUID" OnSelecting="DsPatientSearch_Selecting">
        <SelectParameters>
            <asp:SessionParameter Name="GUID" SessionField="GUID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenInputBox" runat="server" ClientIDMode="Static" />
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
