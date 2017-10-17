<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DiagramView.aspx.cs" Inherits="BMBH_View.DiagramView" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Benutzerstatistik</h4>
       
    
        
        <asp:Panel ID="Panel1" runat="server" BackColor="#F8FCFC" BorderStyle="Outset" BorderWidth="1px" Width="400px" style="float:left; position:relative; padding:10px;">
            <b>Diagrammtyp:</b>
            <asp:DropDownList ID="DropDownList1" AutoPostBack="true" runat="server"
            OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:CheckBox ID="chkShowValues" runat="server" AutoPostBack="True" CssClass="chkChoice" Font-Size="Small" OnCheckedChanged="chkShowValues_CheckedChanged" Text="Werte anzeigen" /><br />
            <asp:Panel ID="Panel2" runat="server" BackColor="#F8FCFC" Width="270px" style="float:left; position:relative;">
            <b>Zeitspanne</b><br />
            <div style="float:left; width:40px; position:relative; top:1px">
                <asp:Label ID="lblFrom" runat="server" Text="Von:" BorderWidth="2px" BorderColor="Transparent" />
                <asp:Label ID="lblTo" runat="server" Text="Bis:" BorderWidth="2px" BorderColor="Transparent"/>
            </div>
            <div style="float:right; position:relative; width:200px;">
                <asp:TextBox ID="txtCalFrom" runat="server" AutoPostBack="True" OnTextChanged="txtCalFrom_TextChanged"></asp:TextBox>
                <asp:ImageButton ID="btnCalFrom" runat="server" AlternateText="Kalender anzeigen" ImageUrl="~/Images/table_16x16.gif" />
                <ajaxToolkit:CalendarExtender ID="calFrom" runat="server" Format="dd.MM.yyyy HH:mm" PopupButtonID="btnCalFrom" TargetControlID="txtCalFrom" TodaysDateFormat="dd.MM.yyyy HH:mm" />
                <asp:TextBox ID="txtCalTo" runat="server" AutoPostBack="True" OnTextChanged="txtCalTo_TextChanged"></asp:TextBox>
                <asp:ImageButton ID="btnCalTo" runat="server" ImageUrl="~/Images/table_16x16.gif" AlternateText="Kalender anzeigen" /><br />
                <ajaxToolkit:CalendarExtender ID="calTo" runat="server" Format="dd.MM.yyyy HH:mm" PopupButtonID="btnCalTo" TargetControlID="txtCalTo" TodaysDateFormat="dd.MM.yyyy HH:mm" />
            </div>
        </asp:Panel>
        </asp:Panel>
        <asp:Chart ID="Chart1" runat="server" Width="1800px" Height="850px">
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
</asp:Content>

