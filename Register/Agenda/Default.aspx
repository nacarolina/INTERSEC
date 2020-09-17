<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Register.Agenda.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />--%>
    <%--<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />--%>
    <%--<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />--%>

    <style>
        /*CHECKBOX*/
        input[type=checkbox] {
            display: block;
            margin: 0.2em;
            cursor: pointer;
            padding: 0.2em;
        }

        input[type=checkbox] {
            opacity: 0;
            width: 20px;
            height: 20px;
            position: absolute;
        }

            input[type=checkbox] + label:before {
                content: "\2714";
                border: 0.1em solid #464953;
                border-radius: 0.2em;
                display: inline-block;
                width: 20px;
                height: 20px;
                padding-left: 0.2em;
                padding-bottom: 0.5em;
                margin-right: 0.2em;
                vertical-align: bottom;
                color: transparent;
                transition: .2s;
            }


            input[type=checkbox]:checked + label:before {
                background-color: #464953;
                border-color: #464953;
                color: #fff;
            }

            input[type=checkbox]:disabled + label:before {
                transform: scale(1);
                border-color: #aaa;
            }

            input[type=checkbox]:checked:disabled + label:before {
                transform: scale(1);
                background-color: #bfb;
                border-color: #bfb;
            }

        /*AJUSTA A TBL DIAS SEMANA QUANDO A TELA É REDUZIDA*/
        @media (max-width: 3044px) {
            .proporcao {
                display: flex;
            }
        }

        @media (max-width: 1440px) {
            .proporcao {
                display: table;
            }
        }

        /*AJUSTA OS CAMPOS 'NOME AGENDA E PLANOS' QUANDO A TELA É REDUZIDA*/
        @media (max-width: 1440px) {
            .proporcaoDiv {
                width: max-content;
            }
        }

        @media (max-width: 1440px) {
            .SwitcheryTblEspecial {
                min-width: fit-content;
            }
        }

        /*AJUSTA TELA INICIAL QUANDO A TELA É REDUZIDA/SELECT - BOTOES*/
        @media (max-width: 1440px) {
            .proporcaoSelect {
                min-width: fit-content;
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }
        }

        @media (max-width: 1440px) {
            .proporcaoNovoAgendamento {
                min-width: fit-content;
                flex: 0 0 100% !important;
                max-width: 100% !important;
                margin-top: 10px;
                padding-right: 15px !important;
            }

            #novoAgendamento {
                width: 100% !important;
            }
        }

        @media (max-width: 1440px) {
            .proporcaoValidarAgenda {
                min-width: fit-content;
                flex: 0 0 100% !important;
                max-width: 100% !important;
                margin-top: 5px;
                margin-bottom: 15px;
                padding-left: 15px !important;
            }

            #validarAgenda {
                width: 100% !important;
            }
        }

        @media (max-width: 1440px) {
            .proporcaoSwitcheryAgruparDias {
                min-width: fit-content;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoSwit {
                float: right;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoRow {
                display: flex !important;
            }
        }

        #tbAgendaHorarios tr:hover {
            background-color: #e3ebf338;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="Server">
    <%= Resources.Resource.agenda %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FeaturedContent2" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="index.html">Cadastros</a>
        </li>
        <li class="breadcrumb-item"><a href="#">Agenda</a>
        </li>
    </ol>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:HiddenField ID="hfUser" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfIdPrefeitura" ClientIDMode="Static" runat="server" />

    <%-- TELA PRINCIPAL --%>
    <div id="dvPesquisa">
        <div class="row proporcaoRow">
            <div class="col-6 col-md-4 proporcaoSelect">
                <select id="sleAgendaPesq" class="form-control " onchange="GetAgendaHorarios()"></select>
            </div>

            <div class="col-6 col-md-4 proporcaoNovoAgendamento proporcaoNovoAgendamentoFullSize" style="max-width: fit-content; padding-right: 0;">
                <input id="novoAgendamento" type="button" class="btn btn-success btn-min-width mr-1 mb-1" style="margin-bottom: 0px !important;" value="<%= Resources.Resource.novo %> <%= Resources.Resource.agendamento %>" align="left" onclick="NovaAgendaHorarios()" />
            </div>
            <div class="col-6 col-md-4 proporcaoValidarAgenda proporcaoValidarAgendaFullSize" style="max-width: fit-content; padding-left: 0;">
                <input id="validarAgenda" type="button" class="btn btn-warning btn-min-width mr-1 mb-1" style="margin-bottom: 0px !important;" value="<%= Resources.Resource.validar %> <%= Resources.Resource.agenda %>" onclick="ValidarAgendaHorarios(this)" id="btnValidarAgenda" />
            </div>

            <div class="col-6 col-md-4 proporcaoSwitcheryAgruparDias"  style="max-width: 32%;">
                <div id="swit" class="proporcaoSwit" onclick="GetAgendaHorarios()">
                    <input type="checkbox" class="switchery " data-color="success" data-switchery="true" id="chkAgruparDias" checked="" />
                    <label class="card-title ml-1"><%= Resources.Resource.agrupar %> <%= Resources.Resource.dias %></label>
                </div>
            </div>
        </div>

        <br />

        <div id="tblPlanos" class="table-responsive">
            <table class="table table-bordered mb-0">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.planos %></th>
                        <th><%= Resources.Resource.hora %> <%= Resources.Resource.inicial %></th>
                        <th><%= Resources.Resource.hora %> <%= Resources.Resource.final %></th>
                        <th><%= Resources.Resource.dias %></th>
                        <%--<th></th>--%>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbAgendaHorarios">
                    <tr>
                        <td colspan="6"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>
        </div>



    </div>

        <%--MODAL POUPUP--%>
        <div class="modal fade" id="mpCadAgenda" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="border-bottom: 1px solid #e9ecef;">
                        <h4 class="modal-title"><%= Resources.Resource.cadastrar %> <%= Resources.Resource.agenda %></h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <div class="modal-body">
                        <div>
                            <label style="margin-bottom: 0px;"><%= Resources.Resource.nome %> <%= Resources.Resource.agenda %>:</label>
                            <table class="table table-bordered" style="width: 100%">
                                <tr>
                                    <td>
                                        <input type="text" id="txtAgenda" class="form-control" />
                                        <a style="display: none; cursor: pointer;" id="lnkCancelarAlteracao" onclick="CancelarAlteracaoAgenda()"><%= Resources.Resource.cancelar %></a>
                                    </td>
                                    <td style="width: 1px;">
                                        <input type="button" class="btn btn-success" data-idagenda="" data-origem="Salvar" value="<%= Resources.Resource.salvar %>" onclick="SalvarAgenda()" id="btnSalvarAgenda" />
                                    </td>
                                </tr>
                            </table>

                            <br />
                            <%--CARREGA AGENDAS--%>
                            <div>
                                <label style="margin-bottom: 0px;"><%= Resources.Resource.nome %>:</label>
                                <table class="table table-bordered">
                                    <tbody id="tbCadAgenda">
                                        <tr>
                                            <td colspan="2"><%= Resources.Resource.naoHaRegistros %></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                    <%--                <div class="modal-footer" style="border-top: 1px solid #e9ecef;">
                    <input type="button" class="btn btn-danger" value="<%= Resources.Resource.fechar %>" onclick="FecharCadAgenda()" />
                </div>--%>
                </div>
            </div>
        </div>


    <%-- TELA NOVO AGENDAMENTO --%>
    <div id="dvCad" style="display: none;">
        <h4 class="form-section" style="border-bottom: 1px solid #e9ecef; line-height: 3rem; margin-bottom: 2rem;">
            <i class="ft-plus"></i>
            <%= Resources.Resource.cadastrar %> <%= Resources.Resource.agenda %> <%= Resources.Resource.horarios %>
        </h4>

        <div id="dvCadastro" class="row proporcaoDiv">
            <div class="col-6 col-md-4">
                <%= Resources.Resource.nome %> <%= Resources.Resource.agenda %>:
                                        <select id="sleAgendaCad" class="form-control"></select>
            </div>

            <div class="col-6 col-md-4" style="max-width: min-content; padding-top: 25px;">
                <img src="../../Images/add.png" data-toggle="tooltip" data-placement="bottom" title="Cadastro e alteração de Agenda" onclick="NovaAgenda();" style="cursor: pointer; height: 21px;" />
            </div>

            <div class="col-6 col-md-4">
                <%= Resources.Resource.planos %>:
                    <select id="slePlanos" class="form-control">
                        <option value="PLANO APAGADO"><%= Resources.Resource.plano %> <%= Resources.Resource.apagado %></option>
                        <option value="PLANO AMARELO INTERMITENTE"><%= Resources.Resource.plano %> <%= Resources.Resource.amareloIntermitente %></option>
                        <option value="PLANO 1"><%= Resources.Resource.plano %> 1</option>
                        <option value="PLANO 2"><%= Resources.Resource.plano %> 2</option>
                        <option value="PLANO 3"><%= Resources.Resource.plano %> 3</option>
                        <option value="PLANO 4"><%= Resources.Resource.plano %> 4</option>
                        <option value="PLANO 5"><%= Resources.Resource.plano %> 5</option>
                        <option value="PLANO 6"><%= Resources.Resource.plano %> 6</option>
                        <option value="PLANO 7"><%= Resources.Resource.plano %> 7</option>
                        <option value="PLANO 8"><%= Resources.Resource.plano %> 8</option>
                        <option value="PLANO 9"><%= Resources.Resource.plano %> 9</option>
                        <option value="PLANO 10"><%= Resources.Resource.plano %> 10</option>
                        <option value="PLANO 11"><%= Resources.Resource.plano %> 11</option>
                        <option value="PLANO 12"><%= Resources.Resource.plano %> 12</option>
                        <option value="PLANO 13"><%= Resources.Resource.plano %> 13</option>
                        <option value="PLANO 14"><%= Resources.Resource.plano %> 14</option>
                        <option value="PLANO 15"><%= Resources.Resource.plano %> 15</option>
                        <option value="PLANO 16"><%= Resources.Resource.plano %> 16</option>
                        <option value="PLANO 17"><%= Resources.Resource.plano %> 17</option>
                        <option value="PLANO 18"><%= Resources.Resource.plano %> 18</option>
                        <option value="PLANO 19"><%= Resources.Resource.plano %> 19</option>
                        <option value="PLANO 20"><%= Resources.Resource.plano %> 20</option>
                        <option value="PLANO 21"><%= Resources.Resource.plano %> 21</option>
                        <option value="PLANO 22"><%= Resources.Resource.plano %> 22</option>
                        <option value="PLANO 23"><%= Resources.Resource.plano %> 23</option>
                        <option value="PLANO 24"><%= Resources.Resource.plano %> 24</option>
                        <option value="PLANO 25"><%= Resources.Resource.plano %> 25</option>
                        <option value="PLANO 26"><%= Resources.Resource.plano %> 26</option>
                        <option value="PLANO 27"><%= Resources.Resource.plano %> 27</option>
                        <option value="PLANO 28"><%= Resources.Resource.plano %> 28</option>
                        <option value="PLANO 29"><%= Resources.Resource.plano %> 29</option>
                        <option value="PLANO 30"><%= Resources.Resource.plano %> 30</option>
                    </select>
            </div>

            <div class="col-6 col-md-4" style="max-width: min-content; padding-top: 25px;">
                <img src="../../Images/add.png" data-toggle="tooltip" data-placement="bottom" title="Acrescentar Plano" onclick="AddPlano();" style="cursor: pointer; height: 21px;" />
            </div>
        </div>

        <div class="row " style="margin-top: 17px;" onclick="ViewTabelaEspecial()">
            <div class="col-6 col-md-4 SwitcheryTblEspecial">
                <input class="switchery" type="checkbox" id="chkTblEspecial" data-color="success" data-switchery="true" unchecked="true" />
                <label class="card-title ml-1"><%= Resources.Resource.tabela %> <%= Resources.Resource.especial %></label>
            </div>
        </div>

        <%--TABELA ESPECIAL--%>

        <label id="tituloTabelaEspecial" style="margin-bottom: 0px; display: none;"><%= Resources.Resource.tabela %> <%= Resources.Resource.especial %>:</label>
        <table id="tblTabelaEspecial" style="display: none; width: 100%" class="table table-bordered">
            <tr>
                <td style="padding-left: 11px;"><%= Resources.Resource.data %> <%= Resources.Resource.hora %> <%= Resources.Resource.inicial %>:
                        <div class="position-relative has-icon-left">
                            <input type="text" class="form-control" maxlength="19" onblur="ValidaDataHora(this)" onkeypress="DataHora(event,this)" placeholder="00/00/0000 00:00:00" id="txtTblEspecialHrIni" />
                            <div class="form-control-position" id="icoRelogioTblEspecialHrIni">
                                <i class="ft-clock"></i>
                            </div>
                        </div>
                </td>

                <td style="padding-left: 11px;"><%= Resources.Resource.data %> <%= Resources.Resource.hora %> <%= Resources.Resource.final %>:
                        <div class="position-relative has-icon-left">
                            <input type="text" class="form-control" maxlength="19" onblur="ValidaDataHora(this)" onkeypress="DataHora(event,this)" placeholder="00/00/0000 00:00:00" id="txtTblEspecialHrFim" />
                            <div class="form-control-position" id="icoRelogioTblEspecialHrFinal">
                                <i class="ft-clock"></i>
                            </div>
                        </div>
                </td>
            </tr>
        </table>

        <%--NOVO AGENDAMENTO--%>
        <label id="tituloDiasSemana" style="margin-bottom: 0px;"><%= Resources.Resource.dias %>/<%= Resources.Resource.semana %>:</label>
        <table id="tblDiasSemana" class="table table-bordered" style="width: 100%">
            <tr>
                <td style="width: 50%; padding-left: 11px;">
                    <div class="proporcao">
                        <div>
                            <input type="checkbox" id="chkTodoDia" value="TodoDia" onclick="GetDiasSemana(this)" />
                            <label><%= Resources.Resource.todosOsDias%> &nbsp</label>
                        </div>

                        <div>
                            <input type="checkbox" id="chkSegSab" value="SegSab" onclick="GetDiasSemana(this)" />
                            <label><%= Resources.Resource.segunda %> - <%= Resources.Resource.sabado %> &nbsp</label>
                        </div>

                        <div>
                            <input type="checkbox" id="chkSegSex" value="SegSex" onclick="GetDiasSemana(this)" />
                            <label><%= Resources.Resource.segunda %> - <%= Resources.Resource.sexta %> &nbsp</label>
                        </div>

                        <div>
                            <input type="checkbox" id="chkSabDom"  value="SabDom" onclick="GetDiasSemana(this)" />
                            <label><%= Resources.Resource.sabado %> - <%= Resources.Resource.domingo %> &nbsp</label>
                        </div>
                    </div>
                </td>

                <td style="width: 50%; padding-left: 11px; padding-right: 43px;">
                    <div class="proporcao">
                        <div>
                            <input type="checkbox" id="chkSegunda" value="Segunda" />
                            <label><%= Resources.Resource.segunda %> &nbsp</label>
                        </div>

                        <div>
                            <input type="checkbox" id="chkTerca" value="Terca" />
                            <label><%= Resources.Resource.terca %> &nbsp</label>
                        </div>

                        <div>
                            <input type="checkbox" id="chkQuarta" value="Quarta" />
                            <label><%= Resources.Resource.quarta %> &nbsp</label>
                        </div>

                        <div>
                            <input type="checkbox" id="chkQuinta" value="Quinta" />
                            <label><%= Resources.Resource.quinta %> &nbsp</label>
                        </div>

                        <div>
                            <input type="checkbox" id="chkSexta" value="Sexta" />
                            <label><%= Resources.Resource.sexta %> &nbsp</label>
                        </div>

                        <div>
                            <input type="checkbox" id="chkSabado" value="Sabado" />
                            <label><%= Resources.Resource.sabado %> &nbsp</label>
                        </div>

                        <div>
                            <input type="checkbox" id="chkDomingo" value="Domingo" />
                            <label><%= Resources.Resource.domingo %> &nbsp</label>
                        </div>
                    </div>
                </td>
            </tr>
        </table>

        <%--            <br />--%>
        <%--            <tr>
                <td style="padding-left: 0px; border-right: hidden; border-left: hidden; border-bottom: hidden;">
                    <input type="text" class="form-control" onkeypress="Hora(event,this)" onblur="validaHora(this)" maxlength="8" id="txtHrIni" />
                </td>
            </tr>--%>
        <div class="col-md-6">
            <div class="form-group">

                <label style="margin-bottom: 0px;" id="lblTimeInicial" for="timesheetinput5"><%= Resources.Resource.hora %> <%= Resources.Resource.inicial %>:</label>
                <div class="position-relative has-icon-left">
                    <input type="text" class="form-control" placeholder="00:00:00" onkeypress="Hora(event,this)" onblur="validaHora(this)" maxlength="8" id="txtHrIni" style="width: 150px;" />
                    <%--                        <input type="time" id="txtHrIni" class="form-control" onkeypress="Hora(event,this)" onblur="validaHora(this)" name="starttime" style="width: 150px;" />--%>
                    <div class="form-control-position" id="icoRelogio">
                        <i class="ft-clock"></i>
                    </div>
                </div>
            </div>
        </div>

        <div style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 3rem;">
            <div style="float: right;">
                <input type="button" class="btn btn-success" style="margin-top: 1rem;" data-idagendahorarios="" data-idagendasel="" data-planosel=""
                    data-hrinisel="" data-diasel="" data-origem="Salvar" value="<%= Resources.Resource.salvar %>" onclick="SalvarAgendaHorarios(this)" id="btnSalvar" />
                <input type="button" class="btn btn-danger mr-1" style="margin-top: 1rem;" value="<%= Resources.Resource.cancelar %>" onclick="FecharCadAgendaHorarios()" />
            </div>
        </div>

    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <%--    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>--%>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <%--        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <script src="Agenda.js"></script>

</asp:Content>

