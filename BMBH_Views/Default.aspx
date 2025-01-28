<%@ Page Title="BMBH Views" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BMBHviews._Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/> 
<asp:HiddenField ID="width" runat="server" />
<asp:HiddenField ID="height" runat="server" />
<div class="jumbotron" style="height: 200px">
    <img src="Images/bmbh_views2_550.png"/>
</div>
<div style="position:relative;top:-10px">
    <asp:Panel ID="pnlContainer" runat="server"></asp:Panel>
</div>
</asp:Content>
