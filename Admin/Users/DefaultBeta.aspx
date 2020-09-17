<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DefaultBeta.aspx.cs" Inherits="GwCentral.Admin.Users.DefaultBeta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style>
        @media (max-width: 3044px) {
            .espacamento {
                margin-bottom: 28px;
            }
        }

        /*BOTÃO ADD USUÁRIO MOBILE*/
        @media (max-width: 1023px) {
            .proporcaoAddUsuario {
                margin-top: 28px;
                margin-bottom: 0px;
                float: right;
            }
        }

        /*BOTÃO ADD USUÁRIO MOBILE*/
        @media (max-width: 1023px) {
            .proporcaoDivBtn {
                max-width: 100% !important;
                flex: 100% !important;
            }
        }

        /*SELECT PREFEITURA MOBILE*/
        @media (max-width: 1023px) {
            .proporcaoSelect {
                min-width: -webkit-fill-available;
            }

            .Select {
                width: 100% !important;
            }
        }

        /*SELECT PREFEITURA DESKTOP*/
        @media (max-width: 3044px) {
            .proporcaoSelect {
                max-width: 67% !important;
                flex: 60% !important;
            }
            /*AQUI VAI O ID DO COMPONENTE*/
            #slePrefeituras {
                width: 55%;
            }
        }

        @media (max-width: 1440px) {
            .espacamento {
                margin-bottom: 20px;
            }
        }

        #tbUsuarios tr:hover {
            background-color: #e3ebf338;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.cadastros %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FeaturedContent2" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="#">Usuários</a>
        </li>
        <li class="breadcrumb-item"><a href="#">Cadastros</a>
        </li>
    </ol>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField runat="server" ID="hfCidade" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfusuarioLogado" ClientIDMode="Static" />

    <div id="divPesquisa">
        <%--PESQUISA--%>
        <div>
            <label style="margin-bottom: 0;"><%= Resources.Resource.prefeitura %>:</label>
            <br />
            <div class="row espacamento" style="padding-left: 0; padding-right: 0;">
                <div class="col-6 col-md-4 proporcaoSelect">
                    <select class="form-control Select" id="slePrefeituras" onchange="carregarUsuarios();"></select>
                </div>
                <div class="col-6 col-md-4 proporcaoDivBtn">
                    <div class="proporcaoAddUsuario">
                        <button type="button" class="input-group-text" onclick="addUsuario();" data-toggle="tooltip" data-placement="left" title="Adicionar Usuário" style="background-color: #6b6f80; border: #6b6f80; color: white; height: 100%; float: right;"><i class="ft-user-plus"></i></button>
                    </div>
                </div>
            </div>
        </div>

        <%--TBL USUÁRIOS--%>
        <div class="table-responsive">
            <label style="margin-bottom: 0;"><%= Resources.Resource.lista %> - <%= Resources.Resource.usuario %></label>
            <table id="tblUsuarios" class="table table-bordered mb-0">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.usuario %></th>
                        <th><%= Resources.Resource.email %></th>
                        <th></th>
                        <th></th>
                        <th style="display: none"></th>
                    </tr>
                </thead>
                <tbody id="tbUsuarios">
                    <tr>
                        <td style='display: none'></td>
                        <td colspan="4"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <%--ADICIONAR USUÁRIO--%>
    <div class="form form-horizontal" id="divCadUsuario" style="display: none;">
        <div class="form-body">
            <h4 class="form-section" style="border-bottom: 1px solid #e9ecef; line-height: 3rem; margin-bottom: 2rem;">
                <i class="ft-user-plus"></i>
                <%= Resources.Resource.cadastrar %> <%= Resources.Resource.usuario %>
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
                        <label class="col-md-3 label-control">Email:</label>
                        <div class="col-md-9">
                            <input id="txtEmail" type="text" class="form-control" />
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
                <button type="button" class="btn btn-danger mr-1" onclick="fecharTelaCadUsuario()"><%= Resources.Resource.fechar %></button>
            </div>
        </div>

    </div>

    <%--REDEFINIR SENHA--%>
    <div class="form form-horizontal" id="divAlterarSenha" style="display: none;">
        <div>
            <h4 class="form-section" style="border-bottom: 1px solid #e9ecef; line-height: 3rem; margin-bottom: 2rem;">
                <i class="ft-user-plus"></i>
                <%= Resources.Resource.editar %> <%= Resources.Resource.usuario %>
            </h4>

            <div class="row">
                <div class="col-md-6 espacamento">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.usuario %>: </label>
                        <div class="col-md-9">
                            <input type="text" id="txtUser" class="form-control" disabled="true" />
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.novaSenha %>:</label>
                        <div class="col-md-9">
                            <input type="password" id="txtNovaSenha" class="form-control" />
                            <div class="form-control-position" style="margin-right: 10px;" data-toggle="tooltip" data-placement="left" title="● A senha deve incluir no mínimo 4 caracteres, sendo um deles caractere alfanumérico. (Exemplo: @ ! # $ % &).">
                                <i class="ft-info" style="margin-right: 21px; color: #30B6D7;"></i>
                            </div>
                            <%--                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ControlToValidate="txtNovaSenha" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>" SetFocusOnError="True" Style="font-size: small"></asp:RequiredFieldValidator>--%>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group row">
                        <label class="col-md-3 label-control"><%= Resources.Resource.confirmarNovaSenha %>: </label>
                        <div class="col-md-9">
                            <input type="password" id="txtConfirmaSenha" onblur="verificarConfirmarSenha();" class="form-control" />
                            <div class="invalid-feedback" id="divConfirmarSenha" style="display: none;">
                                Senha inválida!
                            </div>
                            <%--                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" runat="server" ControlToValidate="txtConfirmaSenha" ErrorMessage="<%$ Resources:Resource, campoObrigatorio %>" SetFocusOnError="True" Style="font-size: small"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtNovaSenha" ControlToValidate="txtConfirmaSenha" ErrorMessage="<%$ Resources:Resource, senhaInvalida %>" ForeColor="Red" Style="font-size: small"></asp:CompareValidator>--%>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-actions right" style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 1rem;">
                <div style="float: right; margin-top: 1rem;">
                    <button id="btnSalvarSenhaAlterada" class="btn btn-success" onclick="editarSenhaUsuario();"><%= Resources.Resource.salvar %> </button>
                    <button type="button" class="btn btn-danger mr-1" onclick="fecharTelaCadUsuario();"><%= Resources.Resource.fechar %> </button>
                </div>
            </div>
        </div>

    </div>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


    <script>
        $(function () {

            $.ajax({
                type: 'POST',
                url: 'DefaultBeta.aspx/carregarPrefeitura',
                dataType: 'json',
                data: "{}",
                async: false,
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {

                        $("#slePrefeituras").empty();
                        $("#slePrefeituras").append("<option value=''>─ Selecione ─</option>");
                        var i = 0;
                        while (data.d[i]) {

                            var lst = data.d[i];
                            $("#slePrefeituras").append("<option value=" + lst.prefeitura + ">" + lst.prefeitura + "</option>");
                            i++;
                        }
                    }

                    if (data.d != "") {

                        $("#slePrefeiturasCad").empty();
                        $("#slePrefeiturasCad").append("<option value=''>─ Selecione ─</option>");
                        var i = 0;
                        while (data.d[i]) {

                            var lst = data.d[i];
                            $("#slePrefeiturasCad").append("<option value=" + lst.prefeitura + ">" + lst.prefeitura + "</option>");
                            i++;
                        }
                    }
                }
            });

            carregarUsuarios();
        });

        function carregarUsuarios() {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'DefaultBeta.aspx/carregarUsuarios',
                dataType: 'json',
                data: "{'prefeitura':'" + $("#slePrefeituras").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var i = 0;
                    $("#tbUsuarios").empty();
                    if (data.d.length == 0) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td colspan='4'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbUsuarios").append(newRow);
                        i++;
                    }
                    while (data.d[i]) {
                        var lst = data.d[i];
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td>" + lst.usuarios + "</td>";
                        cols += "<td>" + lst.email + "</td>";

                        cols += "<td style='width: 1px;'><button type='button' data-toggle='tooltip' data-placement='bottom' title='<%= Resources.Resource.editar %>' class='btn btn-icon btn-info mr-1' onclick='informacoesUsuario(this)' data-usuarios='" + lst.usuarios + "' data-email='" + lst.email + "'> <i class='ft-edit-3'></i></button></td>";
                        cols += "<td style='width: 1px;'><button type='button' data-toggle='tooltip' data-placement='bottom' title='<%= Resources.Resource.excluir %>' class='btn btn-icon btn-danger mr-1' onclick='excluirUsuario(this)' data-usuarios='" + lst.usuarios + "'> <i class='ft-trash-2'></i></button></td>";

                        newRow.append(cols);
                        $("#tbUsuarios").append(newRow);
                        i++;
                    }

                    $("#divLoading").css("display", "none");
                },
                error: function (data) {
                    $("#divLoading").css("display", "none");
                }
            });
        }

        function salvarNovoUsuario() {

            if (document.getElementById("btnSalvar").innerHTML == "Salvar") {

                $("#divLoading").css("display", "block");

                $.ajax({
                    type: 'POST',
                    url: 'DefaultBeta.aspx/salvarUsuario',
                    dataType: 'json',
                    data: "{'nomeUsuario':'" + $("#txtUserName").val() + "','nomeEmpresa':'" + $("#txtEmpresa").val() + "','email':'" + $("#txtEmail").val() + "','senha':'" + $("#txtPassword").val() + "', " +
                        " 'confimarSenha':'" + $("#txtConfirmPassword").val() + "','perguntaSecreta':'" + $("#txtPasswordQuestion").val() + "','confirmarPerguntaSecreta':'" + $("#txtPasswordAnswer").val() + "','prefeituraCad':'" + $("#slePrefeiturasCad option:selected").text() + "'}",
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
        }

        function excluirUsuario(object) {

            Swal.fire({
                title: 'Realmente deseja excluir?',
                text: "Este usuário será excluído permanentemente!",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: 'Cancelar',
                confirmButtonText: 'Sim, excluir!'
            }).then((result) => {
                if (result.value) {

                    $.ajax({
                        type: 'POST',
                        url: 'DefaultBeta.aspx/excluirUsuario',
                        dataType: 'json',
                        data: "{'usuario':'" + object.dataset.usuarios + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire(

                                'Excluído!',
                                'Usuário excluído com sucesso.',
                                'success'
                            )

                            carregarUsuarios();
                        }
                    });
                }
            });
        }

        function editarSenhaUsuario() {

            if ($("#txtNovaSenha").val() != $("#txtConfirmaSenha").val()) {

                $("#txtConfirmaSenha").addClass("is-invalid");
                $("#divConfirmarSenha").css("display", "block");
                return;
            }

            $.ajax({
                type: 'POST',
                url: 'DefaultBeta.aspx/editarSenhaUsuario',
                dataType: 'json',
                data: "{'usuario':'" + $("#txtUser").val() + "', 'novaSenha':'" + $("#txtNovaSenha").val() + "', 'usuarioLogado':'" + $("#hfusuarioLogado").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    Swal.fire(

                        'Alterado!',
                        'Senha alterada com sucesso.',
                        'success'
                    )

                    carregarUsuarios();
                }
            });
        }

        function informacoesUsuario(object) {

            $("#divPesquisa").css("display", "none");
            $("#divAlterarSenha").css("display", "block");

            $("#txtConfirmaSenha").removeClass("is-invalid");
            $("#divConfirmarSenha").css("display", "none");

            $("#txtUser").val($(object).data("usuarios"));

            document.getElementById("btnSalvar").innerHTML = "Salvar Alteração";
        }

        function verificarConfirmarSenha() {

            if ($("#txtConfirmaSenha").val() == $("#txtNovaSenha").val()) {

                $("#txtConfirmaSenha").removeClass("is-invalid");
                $("#divConfirmarSenha").css("display", "none");
            }

            //if ($("#txtConfirmaSenha").val() == "") {

            //    $("#txtConfirmaSenha").addClass("is-invalid");
            //    $("#divConfirmarSenha").css("display", "block");
            //}

            if ($("#txtConfirmaSenha").val() != $("#txtNovaSenha").val()) {

                $("#txtConfirmaSenha").addClass("is-invalid");
                $("#divConfirmarSenha").css("display", "block");
            }
        }

        function addUsuario() {

            document.getElementById("btnSalvar").innerHTML = "Salvar";

            $("#divPesquisa").css("display", "none");
            $("#divCadUsuario").css("display", "block");

            $("#txtUserName").val("");
            $("#txtEmpresa").val("");
            $("#txtEmail").val("");
            $("#txtPassword").val("");
            $("#txtConfirmPassword").val("");
            $("#txtPasswordQuestion").val("");
            $("#txtPasswordAnswer").val(""); 
            $("#slePrefeiturasCad").val("");
        }

        function fecharTelaCadUsuario() {

            $("#divCadUsuario").css("display", "none");
            $("#divPesquisa").css("display", "block");
            $("#divAlterarSenha").css("display", "none");

            $("#txtFind").val("");
        }

        $(function () {

            $('[data-toggle="tooltip"]').tooltip()
        })
    </script>

</asp:Content>
