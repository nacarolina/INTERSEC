<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DefaultBeta.aspx.cs" Inherits="GwCentral.Admin.CityHall.DefaultBeta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        @media (max-width: 3044px) {
            .proporcaoPesquisa {
                max-width: 67% !important;
                flex: 60% !important;
            }

            #pesquisaCliente {
                width: 80%;
            }
        }

        @media (max-width: 1023px) {
            .lblLogoEmpresa {
                flex: 0 0 44% !important;
            }

            .divFileUpload {
                margin-left: 15px;
            }
        }

        #tbClientes tr:hover {
            background-color: #e3ebf338;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.cadastroCliente %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <div id="divTelaInicio">
        <label style="margin-bottom: 0;"><%= Resources.Resource.nome %>:</label>
        <br />
        <div class="row">
            <div class="col-6 col-md-4 proporcaoPesquisa">
                <div class="input-group" id="pesquisaCliente">
                    <input id="txtNomeCliente" style="border-color: #6B6F80;" type="text" onkeydown="" class="form-control" placeholder="<%= Resources.Resource.buscar %>..." />
                    <div class="input-group-append">
                        <button class="input-group-text" style="background-color: #6B6F80; border: #6B6F80;" onkeydown=""><i class="ft-search" style="color: white;"></i></button>
                    </div>
                </div>
            </div>

            <div class="col-6 col-md-4 proporcaoDivBtn">
                <div class="proporcaoAddUsuario">
                    <button type="button" class="input-group-text" onclick="trocarTelas(this)" value="adicionar" data-toggle='tooltip' data-placement='left' title="Adicionar Usuário" style="background-color: #6b6f80; border: #6b6f80; color: white; height: 100%; float: right;"><i class="ft-user-plus"></i></button>
                </div>
            </div>
        </div>

        <br />

        <div class="table-responsive">
            <label style="margin-bottom: 0;"><%= Resources.Resource.listaClientes %></label>
            <table id="tblClientes" class="table table-bordered mb-0">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.cliente %></th>
                        <th><%= Resources.Resource.endereco %></th>
                        <th><%= Resources.Resource.site %></th>
                        <th><%= Resources.Resource.telefone %></th>
                        <th><%= Resources.Resource.email %></th>
                        <th><%= Resources.Resource.responsavel %></th>
                        <th><%= Resources.Resource.portaReset %></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbClientes">
                    <tr>
                        <td colspan="8"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <%--CADASTRAR CLIENTE--%>
    <div class="form form-horizontal" id="divCadCliente" style="display: none;">
        <div class="form-body">
            <h4 class="form-section" style="border-bottom: 1px solid #e9ecef; line-height: 3rem; margin-bottom: 2rem;">
                <i class="ft-user-plus"></i>
                <%= Resources.Resource.cadastrar %> <%= Resources.Resource.cliente %>
            </h4>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.nome %>:</label>
                        <div class="col-md-9">
                            <input id="txtCliente" type="text" class="form-control" onblur="verificarNome();" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.site %>:</label>
                        <div class="col-md-9">
                            <input id="txtSite" type="text" class="form-control" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.email %>:</label>
                        <div class="col-md-9">
                            <input id="txtEmailClienteCad" type="text" class="form-control" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.endereco %>:</label>
                        <div class="col-md-9">
                            <input id="txtEndereco" type="text" class="form-control" autocomplete="new-password" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.portaReset %>:</label>
                        <div class="col-md-9">
                            <input id="txtPortaReset" type="password" class="form-control" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.telefone %>:</label>
                        <div class="col-md-9">
                            <input id="txtTelefone" type="text" class="form-control" />
                        </div>
                    </div>
                </div>

                <%--ADICIONAR IMAGEM--%>
                <div class="col-md-6" style="min-width: -webkit-fill-available;">
                    <div class="form-group row">
                        <label class="col-md-3 label-control lblLogoEmpresa" style="padding-right: 32px; max-width: fit-content; flex: 0 0 38%;"><%= Resources.Resource.logoEmpresa %>:</label>
                        <div class="col-md-9 custom-file divFileUpload" style="max-width: fit-content;">
                            <input id="ftLogoEmpresa" type="file" class="custom-file-input" />
                            <label class="custom-file-label" for="ftLogoEmpresa">Escolher arquivo</label>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="form-actions right" id="divSalvarAlteracoes" style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 1rem; display: none;">
            <div style="float: right; margin-top: 1rem;">
                <button type="button" class="btn btn-success" id="btnSalvarAlteracoes" onclick="salvarNovoUsuario()"><%= Resources.Resource.salvar %></button>
                <button type="button" class="btn btn-danger mr-1" onclick="trocarTelas(this)" value="fechar"><%= Resources.Resource.fechar %></button>
            </div>
        </div>

    </div>

    <%--USUÁRIO RESPONSÁVEL PELO NOVO CADASTRO--%>
    <div class="form form-horizontal" id="divUsuarioInformado" style="display: none; margin-top: 35px;">
        <div class="form-body">
            <h4 class="form-section" style="border-bottom: 1px solid #e9ecef; line-height: 3rem; margin-bottom: 2rem;">
                <i class="ft-user"></i>
                <%= Resources.Resource.loginUsuarioResponsavel %>
            </h4>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.usuario %>:</label>
                        <div class="col-md-9">
                            <input id="txtUserName" type="text" class="form-control" onblur="verificarNome();" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.empresa %>:</label>
                        <div class="col-md-9">
                            <input id="txtEmpresa" type="text" class="form-control" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.email %>:</label>
                        <div class="col-md-9">
                            <input id="txtEmailUsuarioLog" type="text" class="form-control" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.senha %>:</label>
                        <div class="col-md-9">
                            <input id="txtPassword" type="password" class="form-control" autocomplete="new-password" />
                            <div class="form-control-position" style="margin-right: 10px;" data-toggle="tooltip" data-placement="left" title="● A senha deve incluir no mínimo 4 caracteres, sendo um deles caractere alfanumérico. (Exemplo: @ ! # $ % &).">
                                <i class="ft-info" style="margin-right: 21px; color: #30B6D7;"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.digiteSenhaNovamente %>:</label>
                        <div class="col-md-9">
                            <input id="txtConfirmPassword" type="password" class="form-control" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.perguntaSecreta %>:</label>
                        <div class="col-md-9">
                            <input id="txtPasswordQuestion" type="text" class="form-control" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.resposta %> <%= Resources.Resource.perguntaSecreta %>:</label>
                        <div class="col-md-9">
                            <input id="txtPasswordAnswer" type="text" class="form-control" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.prefeitura %>: </label>
                        <div class="col-md-9">
                            <select class="form-control Select" id="slePrefeiturasCad"></select>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="form-actions right" style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 1rem;">
            <div style="float: right; margin-top: 1rem;">
                <button type="button" class="btn btn-success" id="btnSalvar" onclick="salvarNovoUsuario()"><%= Resources.Resource.salvar %></button>
                <button type="button" class="btn btn-danger mr-1" onclick="trocarTelas(this)" value="fechar"><%= Resources.Resource.fechar %></button>
            </div>
        </div>

    </div>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


    <script>
        $(function () {

            carregarClientes();
        });

        function carregarClientes() {

            $.ajax({
                type: 'POST',
                url: 'DefaultBeta.aspx/carregarClientes',
                dataType: 'json',
                data: "{}",
                async: false,
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var i = 0;
                    $("#tbClientes").empty();
                    if (data.d.length == 0) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td colspan='8'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbClientes").append(newRow);
                        i++;
                    }

                    while (data.d[i]) {
                        var lst = data.d[i];
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td>" + lst.cliente + "</td>";
                        cols += "<td>" + lst.endereco + "</td>";
                        cols += "<td>" + lst.site + "</td>";
                        cols += "<td>" + lst.telefone + "</td>";
                        cols += "<td>" + lst.email + "</td>";
                        cols += "<td>" + lst.responsavel + "</td>";
                        cols += "<td>" + lst.portaReset + "</td>";

                        cols += "<td style='width: 1px;'><button type='button' value='editar' data-toggle='tooltip' data-placement='left' title='<%= Resources.Resource.editar %>' class='btn btn-icon btn-info mr-1' onclick='trocarTelas(this)' " +
                            " data-cliente='" + lst.cliente + "' data-endereco='" + lst.endereco + "' data-site='" + lst.site + "' data-telefone='" + lst.telefone + "' data-email='" + lst.email + "' data-responsavel='" + lst.responsavel + "' data-portareset='" + lst.portaReset + "'><i class='ft-edit-3'></i></button></td>";

                        newRow.append(cols);
                        $("#tbClientes").append(newRow);
                        i++;
                    }
                }
            });
        }

        function salvarNovoCliente() {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'DefaultBeta.aspx/salvarNovoCliente',
                dataType: 'json',
                data: "{'nomeCliente':'" + $("#txtCliente").val() + "','site':'" + $("#txtSite").val() + "','emailClienteCad':'" + $("#txtEmailClienteCad").val() + "','endereco':'" + $("#txtEndereco").val() + "', " +
                    " 'portaReset':'" + $("#txtPortaReset").val() + "','telefone':'" + $("#txtTelefone").val() + "','logoEmpresa':'" + $("#ftLogoEmpresa").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d != "sucesso") {

                        Swal.fire({

                            type: 'error',
                            title: 'ERRO!',
                            text: (data.d.replace("ATENÇÃO:", "")),
                        })
                    }
                    else {

                        Swal.fire({
                            type: 'success',
                            title: 'Salvo!',
                            text: 'Salvo com sucesso.',
                        })

                        $("#divCadUsuario").css("display", "none");
                        $("#divPesquisa").css("display", "block");

                        carregarUsuarios();
                    }

                    $("#divLoading").css("display", "none");
                },
                error: function (data) {
                    $("#divLoading").css("display", "none");
                }
            });
        }

        function trocarTelas(status) {

            if (status.value == "adicionar") {

                $("#divTelaInicio").css("display", "none");
                $("#divCadCliente").css("display", "block");
                $("#divUsuarioInformado").css("display", "block");
            }
            if (status.value == "fechar") {

                $("#divTelaInicio").css("display", "block");
                $("#divCadCliente").css("display", "none");
                $("#divSalvarAlteracoes").css("display", "none");
                $("#divUsuarioInformado").css("display", "none");

                $("#txtCliente").val("");
                $("#txtSite").val("");
                $("#txtEmailClienteCad").val("");
                $("#txtEndereco").val("");
                $("#txtPortaReset").val("");
                $("#txtTelefone").val("");
            }
            if (status.value == "editar") {

                $("#divTelaInicio").css("display", "none");
                $("#divCadCliente").css("display", "block");
                $("#divSalvarAlteracoes").css("display", "block");
                $("#divUsuarioInformado").css("display", "none");

                $("#txtCliente").val($(status).data("cliente"));
                $("#txtSite").val($(status).data("site"));
                $("#txtEmailClienteCad").val($(status).data("email"));
                $("#txtEndereco").val($(status).data("endereco"));
                $("#txtPortaReset").val($(status).data("portareset"));
                $("#txtTelefone").val($(status).data("telefone"));

                document.getElementById("btnSalvarAlteracoes").innerHTML = "Salvar Alteração";
            }
        }

        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
    </script>
</asp:Content>
