<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DiagramView.aspx.cs" Inherits="BMBH_View.DiagramView" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
 <table style="font-family: Arial">
<tr>
    <td>
        <b>Diagrammtyp:</b>
        <asp:DropDownList ID="DropDownList1" AutoPostBack="true" runat="server"
            OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        </asp:DropDownList>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:CheckBox ID="chkShowValues" runat="server" AutoPostBack="True" CssClass="chkChoice" Font-Size="Small" OnCheckedChanged="chkShowValues_CheckedChanged" Text="Werte anzeigen" />
    </td>
</tr>
<tr>
    <td colspan="2">
        <asp:Chart ID="Chart1" runat="server" Width="1800px" Height="900px">
            <Titles>
                <asp:Title Text="Benutzerstatistik">
                </asp:Title>
            </Titles>
           <Series>
               <asp:Series Name="Series1" ChartArea="ChartArea1" ChartType="Area" BackGradientStyle="DiagonalLeft" BackSecondaryColor="LightCyan" Color="SteelBlue" XValueType="DateTime" YValueType="Int32" CustomProperties="LabelStyle=Top" Font="Microsoft Sans Serif, 9.75pt" LabelBorderColor="Transparent" LabelBorderDashStyle="NotSet" LabelBorderWidth="0">
                   <SmartLabelStyle AllowOutsidePlotArea="No" MovingDirection="Top" CalloutStyle="None" MaxMovingDistance="0" />
               </asp:Series>
           </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisX Title="Zeitpunkt" IntervalAutoMode="VariableCount">
                    </AxisX>
                    <AxisY Title="Anzahl">
                    </AxisY>
                </asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
    </td>
</tr>
</table>

</asp:Content>

