<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Monitoramento.aspx.cs" Inherits="GwCentral.MonitoramentoCentral.Monitoramento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">

    <title><%= Resources.Resource.monitoramentoTempoReal %></title>

    <style>
        .loading {
            position: absolute;
            background: #fff;
            width: 150px;
            height: 150px;
            border-radius: 100%;
            border: 10px solid #00acff;
            z-index: 10;
            padding-top: 52px;
            font-size: large;
            color: #00a7f7;
        }

            .loading:after {
                content: '';
                background: trasparent;
                width: 140%;
                height: 140%;
                position: absolute;
                border-radius: 100%;
                top: -20%;
                left: -20%;
                opacity: 1.7;
                box-shadow: rgb(0, 172, 255) -4px -5px 3px -3px;
                animation: rotate 2s infinite linear;
            }

        @keyframes rotate {
            0% {
                transform: rotateZ(0deg);
            }

            100% {
                transform: rotateZ(360deg);
            }
        }

        .not-display {
            display: inline !important;
        }
    </style>

    <script src="../../assets/sweetalert-dev.js"></script>
    <link href="../../assets/sweetalert.css" rel="stylesheet" />
    <script src="eneter-messaging-6.0.1.js"></script>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:HiddenField ID="hdfIdEqp" runat="server" ClientIDMode="Static" />
    <div id="divLoading" style="z-index: 99; display: none;">
        <div style="background-color: rgba(0,0,0,.4); position: absolute; z-index: 99; width: 100%; height: 100%; transition: background-color .1s; top: 45px;">
            <div style="background-color: #fff; width: 300px; height: 300px; text-align: center; z-index: 10; padding-left: 75px; padding-top: 52px; border-radius: 10px; position: absolute; margin: auto; top: 0; right: 0; bottom: 0; left: 0;">
                <div class="loading"><%= Resources.Resource.aguarde %> ...</div>
                <div style="font-size: large; color: #00a7f7; font-size: x-large; color: #00a7f7; margin-top: 192px; margin-left: -60px;"><%= Resources.Resource.carregando %> ...</div>
            </div>
        </div>
    </div>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <img src="../Images/TempoReal.png" />
            <%= Resources.Resource.monitoramentoTempoReal %> - <%= Resources.Resource.controlador %> 
            <button id="btnObterDados" type="button" class="btn btn-success" onclick="ObterDados();"><%= Resources.Resource.obterDados %></button>
            <b style="font-size:medium; padding-left:10px"><%= Resources.Resource.falhas %>: </b> <span id="lblFalhas" style="font-size:medium;">Sem comunicação</span> 
        </div>
        <div class="panel-body">

            <table class="table table-bordered table-hover">
                <tr class="text-muted">
                    <td>Id <%= Resources.Resource.controlador %>:<span id="spnIdEqp">XX</span></td>
                    <td><%= Resources.Resource.relogio %> <%= Resources.Resource.controlador %>: <span id="spnRelogio">XX</span></td>
                    <td><%= Resources.Resource.plano %>: <span id="spnPlanoCorrente">XX</span></td>                    
                    <td><%= Resources.Resource.modoOperacional %>: <span id="spnModoOperacional">XX</span></td>
                    <td><%= Resources.Resource.programacao %>: <span id="spnProgramacao">XX</span></td>
                    <td>
                        <button type="button" class="btn btn-danger" onclick="ResetEqp()">
                            <%= Resources.Resource.reiniciar %>
                            <img src="../Images/Emergency_Off_Button.png" /></button></td>
                    <td>
                        <button type="button" class="btn btn-primary" onclick="LoadImposicaoPlanos()"><%= Resources.Resource.imposicaoPlano %></button></td>
                </tr>
            </table>

            <table id="tblGrupos" class="table table-responsive table-striped">
                <tbody id="tbGrupos">
                    <tr id="trInfoAnel1" class="text-muted" style="border: 1px solid #d4d4d4; height: 40px; display: none;">
                        <td style="width: 150px;"><%= Resources.Resource.anel %>: 1</td>
                        <td style="width: 150px;"><%= Resources.Resource.tipo %>: <span id="spnTipoPlanoCorrenteAnel1">XX</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.estagioAtual %>:<span id="spnEstagioAnel1">XX</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.tempoNoEstagio %>:<span id="spnTmEstagioRestanteAnel1">00</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.tempoEstagio %>:<span id="spnTmEstagioAnel1">00</span></td>
                        <td style="width: 150px;" id="tdTmCicloAnel1"><%= Resources.Resource.tempoCiclo %>:<span id="spnTmCicloAnel1">00</span></td>
                        <td style="width: 150px;" id="tdTmNoCicloAnel1"><%= Resources.Resource.tempoNoCiclo %>:<span id="spnTmNoCicloAnel1">00</span></td>
                        <td style="width: 150px;" id="tdAtrasoCicloAnel1"><%= Resources.Resource.atrasoCiclo %>:<span id="spnAtrasoCicloAnel1">00</span></td>
                        <td>
                            <button type="button" class="btn btn-danger" onclick="ResetAnelEqp(1);">
                                <%= Resources.Resource.reiniciar %> <%= Resources.Resource.anel %>
                                <img src="../Images/Emergency_Off_Button.png" /></button></td>
                    </tr>
                    <tr id="trGruposAnel1"></tr>
                    <tr id="trInfoAnel2" class="text-muted" style="border: 1px solid #d4d4d4; height: 40px; display: none;">
                        <td style="width: 150px;"><%= Resources.Resource.anel %>: 2</td>
                        <td style="width: 150px;"><%= Resources.Resource.tipo %>: <span id="spnTipoPlanoCorrenteAnel2">XX</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.estagioAtual %>:<span id="spnEstagioAnel2">XX</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.tempoNoEstagio %>:<span id="spnTmEstagioRestanteAnel2">00</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.tempoEstagio %>:<span id="spnTmEstagioAnel2">00</span></td>
                        <td style="width: 150px;" id="tdTmCicloAnel2"><%= Resources.Resource.tempoCiclo %>:<span id="spnTmCicloAnel2">00</span></td>
                        <td style="width: 150px;" id="tdTmNoCicloAnel2"><%= Resources.Resource.tempoNoCiclo %>:<span id="spnTmNoCicloAnel2">00</span></td>
                        <td style="width: 150px;" id="tdAtrasoCicloAnel2"><%= Resources.Resource.atrasoCiclo %>:<span id="spnAtrasoCicloAnel2">00</span></td>
                        <td>
                            <button type="button" class="btn btn-danger" onclick="ResetAnelEqp(2);">
                                <%= Resources.Resource.reiniciar %> <%= Resources.Resource.anel %>
                                <img src="../Images/Emergency_Off_Button.png" /></button></td>
                    </tr>
                    <tr id="trGruposAnel2"></tr>
                    <tr id="trInfoAnel3" class="text-muted" style="border: 1px solid #d4d4d4; height: 40px; display: none;">
                        <td style="width: 150px;"><%= Resources.Resource.anel %>: 3</td>
                        <td style="width: 150px;"><%= Resources.Resource.tipo %>: <span id="spnTipoPlanoCorrenteAnel3">XX</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.estagioAtual %>:<span id="spnEstagioAnel3">XX</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.tempoNoEstagio %>:<span id="spnTmEstagioRestanteAnel3">00</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.tempoEstagio %>:<span id="spnTmEstagioAnel3">00</span></td>
                        <td style="width: 150px;" id="tdTmCicloAnel3"><%= Resources.Resource.tempoCiclo %>:<span id="spnTmCicloAnel3">00</span></td>
                        <td style="width: 150px;" id="tdTmNoCicloAnel3"><%= Resources.Resource.tempoNoCiclo %>:<span id="spnTmNoCicloAnel3">00</span></td>
                        <td style="width: 150px;" id="tdAtrasoCicloAnel3"><%= Resources.Resource.atrasoCiclo %>:<span id="spnAtrasoCicloAnel3">00</span></td>
                        <td>
                            <button type="button" class="btn btn-danger" onclick="ResetAnelEqp(3);">
                                <%= Resources.Resource.reiniciar %> <%= Resources.Resource.anel %>
                                <img src="../Images/Emergency_Off_Button.png" /></button></td>
                    </tr>
                    <tr id="trGruposAnel3"></tr>
                    <tr id="trInfoAnel4" class="text-muted" style="border: 1px solid #d4d4d4; height: 40px; display: none;">
                        <td style="width: 150px;"><%= Resources.Resource.anel %>: 4</td>
                        <td style="width: 150px;"><%= Resources.Resource.tipo %>: <span id="spnTipoPlanoCorrenteAnel4">XX</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.estagioAtual %>:<span id="spnEstagioAnel4">XX</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.tempoNoEstagio %>:<span id="spnTmEstagioRestanteAnel4">00</span></td>
                        <td style="width: 150px;"><%= Resources.Resource.tempoEstagio %>:<span id="spnTmEstagioAnel4">00</span></td>
                        <td style="width: 150px;" id="tdTmCicloAnel4"><%= Resources.Resource.tempoCiclo %>:<span id="spnTmCicloAnel4">00</span></td>
                        <td style="width: 150px;" id="tdTmNoCicloAnel4"><%= Resources.Resource.tempoNoCiclo %>:<span id="spnTmNoCicloAnel4">00</span></td>
                        <td style="width: 150px;" id="tdAtrasoCicloAnel4"><%= Resources.Resource.atrasoCiclo %>:<span id="spnAtrasoCicloAnel4">00</span></td>
                        <td>
                            <button type="button" class="btn btn-danger" onclick="ResetAnelEqp(4);">
                                <%= Resources.Resource.reiniciar %> <%= Resources.Resource.anel %>
                                <img src="../Images/Emergency_Off_Button.png" /></button></td>
                    </tr>
                    <tr id="trGruposAnel4"></tr>
                </tbody>
            </table>
        </div>
    </div>

    <div id="modalImposicao" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">
                        <span class="glyphicon glyphicon-list-alt"></span>
                        <%= Resources.Resource.imposicaoPlano %></h4>
                </div>
                <div class="modal-body">
                    <%= Resources.Resource.minutos %>:
                    <p style="border-bottom: 1px solid #d4d4d4; height: 40px;">
                        <input id="txtTempoImposicao" type="number" class="form-control" value="1" min="1" />
                    </p>
                    <hr/>
                    <div id="divScrool" style="height: 250px; overflow: auto;">
                        <table id="tblPlanos" class="table table-bordered table-striped table-hover" style="font-size: 11px;">
                            <caption class="text-muted">* <%= Resources.Resource.plano %></caption>
                            <thead>
                                <tr>
                                    <th><%= Resources.Resource.plano %></th>
                                    <th><%= Resources.Resource.tipo %></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="tbPlanos"></tbody>
                            <tfoot id="tfPlanos">
                                <tr>
                                    <td colspan="3"><%= Resources.Resource.naoHaRegistros %></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                </div>
            </div>
        </div>
    </div>

    <script src="Monitoramento.js"></script>
</asp:Content>
