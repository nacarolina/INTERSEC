<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Scoot.ConfiguracoesScoot.ConfiguracoesScoot" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        @media (max-width: 3044px) {
            .proporcaoSle {
                width: 40% !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoSle {
                width: 100% !important;
                padding-right: 0 !important;
            }
        }

        @media (max-width: 1023px) {
            .divSle {
                padding-right: 0 !important;
            }
        }

        @media (max-width: 1440px) {
            .proporcaoSelect {
                min-width: fit-content;
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoInput {
                max-width: 67% !important;
                flex: 60% !important;
                padding-right: 15px;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoInput {
                max-width: 100% !important;
                flex: 100% !important;
                padding-right: 15px !important;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoSle {
                width: 50% !important;
            }
        }

        @media (max-width: 1023px) {
            .proporcaoSle {
                width: 100% !important;
                padding-right: 0 !important;
            }
        }

        @media (max-width: 3044px) {
            .containerFull {
                max-width: 100% !important;
            }
        }

        /*Cards Laços*/
        .container {
            width: 800px;
            /*height: 250px;*/
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            box-sizing: border-box;
            display: grid;
            grid-template-columns: repeat( auto-fit, minmax(250px, 1fr) );
            grid-template-rows: 1fr;
            grid-gap: 15px;
            margin: 0px !important;
        }

        .items {
            border-radius: 5px;
            grid-template-rows: 2fr 1fr;
            grid-gap: 10px;
            /*cursor: pointer;*/
            border: 1px solid #BABFC7;
            transition: all 0.1s;
        }

        .icon-wrapper, .project-name {
            display: flex;
            align-items: center;
            justify-content: center;
        }

            .icon-wrapper i {
                font-size: 100px;
                color: $sec;
                transform: translateY(0px);
                transition: all 0.5s;
            }

        .icon-wrapper {
            align-self: end;
        }

        .project-name {
            align-self: start;
        }

            .project-name p {
                font-size: 18px;
                font-weight: bold;
                letter-spacing: 2px;
                color: $sec;
                transform: translateY(0px);
                transition: all 0.5s;
            }

        .items:hover {
            border: 2px solid #6b6f80;
        }

            .items:hover project-name p {
                transform: translateY(-10px);
            }

            .items:hover icon-wrapper i {
                transform: translateY(5px);
            }

        #tbDetector1 tr:hover {
            background-color: #e3ebf338;
        }

        #tbDetector2 tr:hover {
            background-color: #e3ebf338;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.configuracoesScoot %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hfUsuarioLogado" ClientIDMode="Static" runat="server" />

    <div>

        <div class="row" style="padding-right: 15px; padding-left: 15px; margin-bottom: 15px">
            <div class="col-6 col-md-4 proporcaoSelect proporcaoInput proporcaoSle" style="float: left; padding-left: 0;">
                <div class="col-md-9 divSle" id="col3" style="padding-left: 0;">
                    <label style="margin-bottom: 0;"><%= Resources.Resource.controlador %>: </label>
                    <select id="sleControlador" class="form-control proporcaoSle" onchange="carregarEstagiosCadastrados()"></select>
                </div>
            </div>
        </div>


        <div class="row">
            <%-- Tabela #1 --%>
            <div class="col-md-6">
                <div class="table-responsive">
                    <table class="table table-bordered mb-0" id="tblDetector1" style="margin-top: 2rem;">
                        <thead>
                            <tr>
                                <th style="text-align: center; width: 8rem;">Detector</th>
                                <th style="text-align: center; width: 15rem;">Anel</th>
                                <th style="text-align: center; width: 15rem;">Estágio</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="tbDetector1">
                            <tr>
                                <%-- Detector 1 --%>
                                <td style="text-align-last: center; padding-top: 15px;">1</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector1" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector1" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector1" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="1" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 2 --%>
                                <td style="text-align-last: center; padding-top: 15px;">2</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector2" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector2" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector2" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="2" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 3 --%>
                                <td style="text-align-last: center; padding-top: 15px;">3</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector3" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector3" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector3" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="3" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 4 --%>
                                <td style="text-align-last: center; padding-top: 15px;">4</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector4" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector4" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector4" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="4" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 5 --%>
                                <td style="text-align-last: center; padding-top: 15px;">5</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector5" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector5" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector5" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="5" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 6 --%>
                                <td style="text-align-last: center; padding-top: 15px;">6</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector6" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector6" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector6" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="6" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 7 --%>
                                <td style="text-align-last: center; padding-top: 15px;">7</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector7" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector7" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector7" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="7" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 8 --%>
                                <td style="text-align-last: center; padding-top: 15px;">8</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector8" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector8" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector8" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="8" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <%-- Tabela #2 --%>
            <div class="col-md-6">
                <div class="table-responsive">
                    <table class="table table-bordered mb-0" id="tblDetector2" style="margin-top: 2rem;">
                        <thead>
                            <tr>
                                <th style="text-align: center; width: 8rem;">Detector</th>
                                <th style="text-align: center; width: 15rem;">Anel</th>
                                <th style="text-align: center; width: 15rem;">Estágio</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="tbDetector2">
                            <tr>
                                <%-- Detector 9 --%>
                                <td style="text-align-last: center; padding-top: 15px;">9</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector9" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector9" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector9" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="9" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 10 --%>
                                <td style="text-align-last: center; padding-top: 15px;">10</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector10" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector10" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector10" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="10" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 11 --%>
                                <td style="text-align-last: center; padding-top: 15px;">11</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector11" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector11" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector11" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="11" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 12 --%>
                                <td style="text-align-last: center; padding-top: 15px;">12</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector12" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector12" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector12" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="12" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 13 --%>
                                <td style="text-align-last: center; padding-top: 15px;">13</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector13" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector13" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector13" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="13" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 14 --%>
                                <td style="text-align-last: center; padding-top: 15px;">14</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector14" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector14" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector14" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="14" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 15 --%>
                                <td style="text-align-last: center; padding-top: 15px;">15</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector15" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector15" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector15" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="15" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <%-- Detector 16 --%>
                                <td style="text-align-last: center; padding-top: 15px;">16</td>
                                <td style="padding: 5px !important;">
                                    <select id="sleAnelDetector16" class="form-control proporcaoSle" onchange="carregarEstagios(this,true)"
                                        style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="padding: 5px !important;">
                                    <select id="sleEstagioDetector16" class="form-control proporcaoSle" onchange="validarEstagioSelecionado(this)"
                                        onclick="verificarSelects()" data-cadastrado="false" style="width: 100% !important;">
                                    </select>
                                </td>
                                <td style="text-align-last: center; width: 1px; padding: 5px;">
                                    <button type="button" id="btnExcluirDetector16" class="btn btn-danger btn-xs" onclick="excluirDetector(this)"
                                        value="16" style="cursor: pointer; font-size: medium; margin-right: 0!important;" disabled>
                                        <i class="ft-trash-2"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%--<div class="row">
            <div class="container containerFull">
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 1</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel1" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio1" class="form-control" onchange=""></select>
                    </div>
                </div>
            </div>
        </div>--%>

        <%--<div class="row">
            <div class="container containerFull">
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 1</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel1" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio1" class="form-control" onchange=""></select>
                    </div>
                </div>

                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 2</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel2" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio2" class="form-control" onchange=""></select>
                    </div>
                </div>

                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 3</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel3" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio3" class="form-control" onchange=""></select>
                    </div>
                </div>

                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 4</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel4" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio4" class="form-control" onchange=""></select>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 1rem;">
            <div class="container containerFull">
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 5</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel5" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio5" class="form-control" onchange=""></select>
                    </div>
                </div>
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 6</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel6" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio6" class="form-control" onchange=""></select>
                    </div>
                </div>
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 7</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel7" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio7" class="form-control" onchange=""></select>
                    </div>
                </div>
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 8</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel8" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio8" class="form-control" onchange=""></select>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 1rem;">
            <div class="container containerFull">
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 9</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel9" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio9" class="form-control" onchange=""></select>
                    </div>
                </div>
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 10</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel10" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio10" class="form-control" onchange=""></select>
                    </div>
                </div>
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 11</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel11" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio11" class="form-control" onchange=""></select>
                    </div>
                </div>
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 12</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel12" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio12" class="form-control" onchange=""></select>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 1rem;">
            <div class="container containerFull">
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 13</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel13" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio13" class="form-control" onchange=""></select>
                    </div>
                </div>
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 14</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel14" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio14" class="form-control" onchange=""></select>
                    </div>
                </div>
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 15</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel15" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio15" class="form-control" onchange=""></select>
                    </div>
                </div>
                <div class="items">
                    <div class="project-name">
                        <p style="margin-bottom: 0; border-bottom: 4px solid #7b7f8e;">Laço 16</p>
                    </div>
                    <div style="margin-right: 1rem; margin-left: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.anel %>: </label>
                        <select style="cursor: pointer;" id="sleAnel16" class="form-control" onchange=""></select>
                    </div>
                    <div style="margin: 1rem;">
                        <label style="margin-bottom: 0;"><%= Resources.Resource.estagio %>: </label>
                        <select style="cursor: pointer;" id="sleEstagio16" class="form-control" onchange=""></select>
                    </div>
                </div>
            </div>
        </div>--%>

        <div class="form-actions right" style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 1rem;">
            <div style="float: right; margin-top: 1rem;">
                <button type="button" class="btn btn-success btn-min-width mr-1 mb-1" id="btnSalvarLacos" style="margin-bottom: 0 !important;" onclick="salvarLacos()"><%= Resources.Resource.salvar %></button>
            </div>
        </div>

    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>
        $(function () {

            loadResourcesLocales();
            carregarSleControlador();
            document.getElementById('btnSalvarLacos').disabled = true;
        });

        function carregarSleControlador() {

            $("#divLoading").css("display", "block");
            $.ajax({
                url: 'Default.aspx/loadControladores',
                data: "{}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    $("#sleControlador").empty();
                    $("#sleControlador").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                    $.each(data.d, function () {
                        $("#sleControlador").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });

                    $("#divLoading").css("display", "none");
                }
            });
        }

        function carregarEstagiosCadastrados() {

            $("#divLoading").css("display", "block");
            $.ajax({
                url: 'Default.aspx/carregarAneis',
                data: "{'controlador':'" + $("#sleControlador").val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    for (var i = 1; i <= 16; i++) {

                        $("#sleAnelDetector" + i).empty();
                        $("#sleAnelDetector" + i).append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                        $.each(data.d, function () {
                            $("#sleAnelDetector" + i).append($("<option></option>").val(this['Text']).html(this['Text']));
                        });
                    }

                    for (var i = 1; i <= 16; i++) {

                        $("#sleEstagioDetector" + i).empty();
                    }

                    document.getElementById('btnSalvarLacos').disabled = true;

                    $.ajax({
                        type: 'POST',
                        url: 'Default.aspx/carregarEstagiosCadastrados',
                        dataType: 'json',
                        data: "{'controlador':'" + $("#sleControlador").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            for (var i = 1; i <= 16; i++) {

                                $("#sleEstagioDetector" + i)[0].dataset.cadastrado = "false";
                                document.getElementById('btnExcluirDetector' + i).disabled = true;
                            }

                            for (var i = 0; i < data.d.length; i++) {

                                var lst = data.d[i];

                                $("#divLoading").css("display", "none");
                                $("#sleAnelDetector" + lst.detector).val(lst.anel);
                                carregarEstagios($("#sleAnelDetector" + lst.detector)[0], false);
                                $("#sleEstagioDetector" + lst.detector).val(lst.estagio);
                                document.getElementById('btnExcluirDetector' + lst.detector).disabled = true;

                                if ($("#sleEstagioDetector" + lst.detector).val() != "") {

                                    document.getElementById('btnExcluirDetector' + lst.detector).disabled = false;
                                }
                            }

                            verificarSelects();
                            $("#divLoading").css("display", "none");
                        },
                        error: function (data) {

                            $("#divLoading").css("display", "none");
                        }
                    });
                }
            });
        }

        function carregarEstagios(select, exibirLoad) {

            if (exibirLoad) {

                $("#divLoading").css("display", "block");
            }

            var id = select.id;
            var idFormatado = id.replace("Anel", "Estagio");
            $.ajax({
                url: 'Default.aspx/carregarEstagios',
                data: "{'anel':'" + select.value + "'}",
                dataType: "json",
                type: "POST",
                async: false,
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d.length != 0) {

                        $("#" + idFormatado + "").empty();
                        $("#" + idFormatado + "").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));

                        $.each(data.d, function () {
                            $("#" + idFormatado + "").append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    }
                    else {
                        $("#" + idFormatado + "").empty();
                    }

                    if (exibirLoad) {

                        $("#divLoading").css("display", "none");
                    }
                }
            });
        }

        //#region VALIDAÇÕES ANEL/ESTÁGIO
        var erroEstagio = false;
        function validarEstagioSelecionado(select) {

            var idEstagio = select.id; //id
            var estagioEscolhido = select.value; //valor
            var idAnel = idEstagio.replace("Estagio", "Anel"); //id
            var anelEscolhido = $("#" + idAnel + "").val(); //valor

            var detector = idEstagio.replace("sleEstagioDetector", "");
            var erro = false;
            for (var i = 1; i <= 16; i++) {

                if (erro) {
                    return;
                }

                if (detector != i) {

                    var anel = $("#sleAnelDetector" + i).val(); //valor
                    var estagio = $("#sleEstagioDetector" + i).val(); //valor

                    if (anelEscolhido == anel && estagioEscolhido == estagio) {

                        $("#sleAnelDetector" + i).addClass("is-invalid");
                        $("#sleEstagioDetector" + i).addClass("is-invalid");

                        $("#sleAnelDetector" + detector).addClass("is-invalid");
                        $("#sleEstagioDetector" + detector).addClass("is-invalid");

                        document.getElementById('btnSalvarLacos').disabled = true;

                        Swal.fire({

                            type: 'error',
                            title: getResourceItem("erroTipoAlert"),
                            text: getResourceItem("estagioEmUso"),
                        })

                        erroEstagio = true;
                        erro = true;
                        return;
                    }
                    else {

                        $("#sleAnelDetector" + i).removeClass("is-invalid");
                        $("#sleEstagioDetector" + i).removeClass("is-invalid");

                        $("#sleAnelDetector" + detector).removeClass("is-invalid");
                        $("#sleEstagioDetector" + detector).removeClass("is-invalid");

                        document.getElementById('btnSalvarLacos').disabled = false;
                    }
                }
            }

            if (erro) {

                return;
            }
        }

        function verificarSelects() {

            var temSelectSelecionado = false;

            if (erroEstagio == false) {
                for (var i = 1; i <= 16; i++) {

                    var anel = $("#sleAnelDetector" + i).val();
                    var estagio = $("#sleEstagioDetector" + i).val();

                    if (anel != "" && anel != null && estagio != "" && estagio != null) {
                        temSelectSelecionado = true;
                    }
                }

                if (temSelectSelecionado) {

                    document.getElementById('btnSalvarLacos').disabled = false;
                    return;
                }
                else {

                    document.getElementById('btnSalvarLacos').disabled = true;
                }
            }
        }
        //#endregion

        function salvarLacos() {

            for (var i = 1; i <= 16; i++) {

                var controlador = $("#sleControlador").val();
                var detector = i;
                var anel = $("#sleAnelDetector" + i).val();
                var estagio = $("#sleEstagioDetector" + i).val();
                var usuarioLogado = $("#hfUsuarioLogado").val();

                if (anel != "" && estagio != "") {

                    $.ajax({
                        type: 'POST',
                        url: 'Default.aspx/salvarLacos',
                        dataType: 'json',
                        data: "{'controlador':'" + controlador + "','detector':'" + detector + "','anel':'" + anel + "', " +
                            " 'estagio':'" + estagio + "','usuarioLogado':'" + usuarioLogado + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                        },
                        error: function (data) {

                            $("#divLoading").css("display", "none");
                        }
                    });
                }
            }

            Swal.fire({
                type: 'success',
                title: getResourceItem("salvoTipoAlert"),
                text: getResourceItem("salvoComSucesso"),
            })
        }

        function excluirDetector(btn) {

            var controlador = $("#sleControlador").val();
            var usuarioLogado = $("#hfUsuarioLogado").val();

            if (controlador == "") {

                Swal.fire({

                    type: 'error',
                    title: getResourceItem("erroTipoAlert"),
                    text: getResourceItem("controladorNaoSelecionado"),
                })
                return;
            }

            Swal.fire({
                title: getResourceItem("confirmarExclusaoTipoAlert"),
                text: getResourceItem("esseDetectorSeraExcluido"),
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("simExcluir")
            }).then((result) => {
                if (result.value) {

                    $("#divLoading").css("display", "block");
                    $.ajax({
                        type: 'POST',
                        url: 'Default.aspx/excluirDetector',
                        dataType: 'json',
                        data: "{'controlador':'" + controlador + "','detector':'" + btn.value + "','usuarioLogado':'" + usuarioLogado + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            carregarEstagiosCadastrados();

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("excluido"),
                                text: getResourceItem("excluidoSucesso"),
                            });
                        },
                        error: function (data) {

                            $("#divLoading").css("display", "none");
                        }
                    });

                    $("#divLoading").css("display", "none");
                }
            });
        }

        //RESOURSE/TRADUÇÃO------------------------------------------------------------------------------------------------------------------------------

        var globalResources;        function loadResourcesLocales() {            $.ajax({                type: "POST",                contentType: "application/json; charset=utf-8",                url: 'Default.aspx/requestResource',                dataType: "json",                success: function (data) {                    globalResources = JSON.parse(data.d);                }            });        }        function getResourceItem(name) {            if (globalResources != undefined) {                for (var i = 0; i < globalResources.resource.length; i++) {                    if (globalResources.resource[i].name === name) {                        return globalResources.resource[i].value;                    }                }            }        }

        //CÓDIGO COMENTADO------------------------------------------------------------------------------------------------------------------------------

        <%--function carregarAneis() {

            $("#divLoading").css("display", "block");
            $.ajax({
                url: 'Default.aspx/carregarAneis',
                data: "{'controlador':'" + $("#sleControlador").val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    for (var i = 1; i <= 16; i++) {

                        $("#sleAnelDetector" + i).empty();
                        $("#sleAnelDetector" + i).append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>'));
                        $.each(data.d, function () {
                            $("#sleAnelDetector" + i).append($("<option></option>").val(this['Text']).html(this['Text']));
                        });
                    }

                    for (var i = 1; i <= 16; i++) {

                        $("#sleEstagioDetector" + i).empty();
                    }
                    document.getElementById('btnSalvarLacos').disabled = true;
                    //$("#divLoading").css("display", "none");
                    carregarEstagiosCadastrados();
                }
            });
        }--%>

        //$("#sleEstagioDetector" + lst.detector)[0].dataset.cadastrado = "true"; //Atribui valor ao data
    </script>
</asp:Content>
