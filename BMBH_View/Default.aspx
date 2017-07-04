<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BMBH_View._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>BMBH-Views</h1>
        <p class="lead">Datenexplorationstool der BioMaterialBank Heidelberg</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Gewebebank des NCT</h2>
            <p>
                Probenkollektive der Gewebebank des NCT:</p>
            <p>
                <a class="btn btn-default" href="NCT-TBB.aspx">NCT-TBB_Gesamt &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>NCT-Liquidbank</h2>
            <p>
                Probenkollektive der Liquidbank des NCT.</p>
            <p>
                <a class="btn btn-default" href="Probase.aspx">Probase &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>PancoBank/EPZ</h2>
            <p>
                Probenkollektive der PancoBank am Europäischen Pankreaszentrum:</p>
            <p>
                <a class="btn btn-default" href="PancoBank_Liquid.aspx">PancoBank_Liquid &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
