<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PermissoesUsers.aspx.cs" Inherits="GwCentral.Admin.Users.PermissoesUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style>
        #tbGrdUsuarios tr:hover {
            background-color: #e3ebf338;
        }

        #tbGrdPermissoes tr:hover {
            background-color: #e3ebf338;
        }


        /*CHECKBOX*/
        input[type=checkbox].permissoes {
            display: block;
            margin: 0.1em;
            cursor: pointer;
            padding: 0.2em;
            opacity: 0;
            width: 40px;
            height: 19px;
            position: absolute;
        }

            input[type=checkbox].permissoes + label:before {
                content: "\2714";
                border: 0.1em solid #464953;
                border-radius: 0.2em;
                display: inline-block;
                width: 20px;
                height: 20px;
                font-size: small;
                margin-right: 0.2em;
                vertical-align: bottom;
                color: transparent;
                transition: .2s;
            }


            input[type=checkbox].permissoes:checked + label:before {
                background-color: #5c5c5d;
                border-color: #5c5c5d;
                color: #fff;
            }

            input[type=checkbox].permissoes:disabled + label:before {
                transform: scale(1);
                border-color: #aaa;
            }

            input[type=checkbox].permissoes:checked:disabled + label:before {
                transform: scale(1);
                background-color: #bfb;
                border-color: #bfb;
            }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.usuariosPermissoes %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FeaturedContent2" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="#">Usuários</a>
        </li>
        <li class="breadcrumb-item"><a href="#">Permissões</a>
        </li>
    </ol>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField runat="server" ID="hfIdPrefeitura" ClientIDMode="Static" />
    <asp:HiddenField runat="server" ID="hfCidade" ClientIDMode="Static" />

    <%--TELA DE INÍCIO--%>
    <div id="divPesquisa">

        <label style="margin-bottom: 0;"><%= Resources.Resource.usuario %>:</label>
        <br />
        <div class="col-md-9" style="padding-left: 0; padding-right: 0;">
            <div class="input-group">
                <input id="txtUsuario" style="border-color: #6B6F80;" type="text" onkeydown="FindUsers()" class="form-control" placeholder="<%= Resources.Resource.buscar %>..." />
                <div class="input-group-append">
                    <button class="input-group-text" style="background-color: #6B6F80; border: #6B6F80;" onkeydown="FindUsers()"><i class="ft-search" style="color: white;"></i></button>
                </div>
            </div>
            <%--            <span class="input-group-btn">
                <button type="button" class="btn btn-primary" onclick="FindUsers();"><i class="fas fa-search"></i></button>
            </span>--%>
        </div>

        <br />

        <div class="table-responsive">
            <label style="margin-bottom: 0;"><%= Resources.Resource.lista %> - <%= Resources.Resource.usuario %></label>
            <table id="tblGrdUsers" class="table table-bordered mb-0">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.usuario %></th>
                        <th><%= Resources.Resource.empresa %></th>
                        <th><%= Resources.Resource.municipio %></th>
                        <th></th>
                        <th style="display: none"></th>
                    </tr>
                </thead>
                <tbody id="tbGrdUsuarios">
                    <tr>
                        <td style='display: none'></td>
                        <td colspan="4"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div>

    <%--TELA DE PERMISSÕES--%>
    <div id="divPermissoes" style="display: none;">

        <div class="table-responsive">
            <table id="tblGrdPermissoes" class="table table-bordered mb-0">
                <thead>
                    <tr>
                        <th style="width: 1px;"></th>
                        <th><%= Resources.Resource.funcionalidades %></th>
                        <th><%= Resources.Resource.descricao %></th>
                    </tr>
                </thead>
                <tbody id="tbGrdPermissoes">
                    <tr>
                        <td colspan="3"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <%--        <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
        </div>--%>

        <div style="border-top: 1px solid #e9ecef; line-height: 3rem; margin-top: 3rem;">
            <div style="float: right;">
                <input type="button" class="btn btn-success" style="margin-top: 1rem;" data-idagendahorarios="" data-idagendasel="" data-planosel=""
                    data-hrinisel="" data-diasel="" data-origem="Salvar" value="<%= Resources.Resource.salvar %>" onclick="salvando(this)" id="btnSalvar" />

                <input id="btnCancelar" type="button" class="btn btn-danger mr-1" style="margin-top: 1rem;" value="<%= Resources.Resource.cancelar %>" onclick="salvando(this)" />
            </div>
        </div>

    </div>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


    <script>

        $(function () {

            getUsuarios();
        });

        function FindUsers() {

            var input, filter, table, tr, td, i;
            input = document.getElementById("txtUsuario");
            filter = input.value.toUpperCase();
            table = document.getElementById("tbGrdUsuarios");
            tr = table.getElementsByTagName("tr");

            for (i = 0; i < tr.length; i++) {

                td = tr[i].getElementsByTagName("td")[0];
                tdEmp = tr[i].getElementsByTagName("td")[1];
                tdPre = tr[i].getElementsByTagName("td")[2];
                if (td || tdPre || tdEmp) {

                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1 || tdPre.innerHTML.toUpperCase().indexOf(filter) > -1 || tdEmp.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {

                        tr[i].style.display = "none";

                    }
                }
            }
        }

        function getUsuarios() {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'PermissoesUsers.aspx/GetUsers',
                dataType: 'json',
                data: "{'prefeitura':'" + $("#hfCidade").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var i = 0;
                    $("#tbGrdUsuarios").empty();
                    if (data.d.length == 0) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td colspan='4'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbGrdUsuarios").append(newRow);
                        i++;
                    }
                    while (data.d[i]) {
                        var lst = data.d[i];
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td>" + lst.User + "</td><div class=\"btn-group\"></div></td>";
                        cols += "<td>" + lst.Empresa + "</td><div class=\"btn-group\"></div></td>";
                        cols += "<td>" + lst.Prefeitura + "</td><div class=\"btn-group\"></div></td>";
                        cols += "<td style='width: 1px;'><button type='button' data-toggle='tooltip' data-placement='bottom' title='<%= Resources.Resource.editar %>' class='btn btn-outline-secondary mr-1' onclick=\"CarregaPermissoes('" + lst.User + "')\"><i class='ft-edit-3'></i></button></td>";

                        newRow.append(cols);
                        $("#tbGrdUsuarios").append(newRow);
                        i++;
                    }

                    $("#divLoading").css("display", "none");
                },
                error: function (data) {
                    $("#divLoading").css("display", "none");
                }
            });
        }

        function CarregaPermissoes(usuario) {

            $("#divLoading").css("display", "block");
            $("#txtUsuario").val(usuario);
            $("#divPesquisa").css("display", "none");
            $("#divPermissoes").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'PermissoesUsers.aspx/getPermissoesUser',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "', 'Usuario':'" + usuario + "','Prefeitura':'" + $("#hfCidade").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var i = 0;
                    $("#tbGrdPermissoes").empty();
                    if (data.d.length == 0) {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td colspan='3' style='border-collapse: collapse; padding: 5px;text-align: left;width: 1px;'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbGrdPermissoes").append(newRow);
                        i++;
                    }
                    while (data.d[i]) {
                        var lst = data.d[i];
                        var newRow = $("<tr>");
                        var cols = "";
                        if (!lst.Funcionalidade.includes("cliente: ")) {
                            cols += "<td style='border-collapse: collapse; text-align: center; padding: 5px;'><input type='checkbox' class='permissoes' data-usuario='" + usuario + "' name=" + lst.Funcionalidade + " " + lst.Permissao + " data-role='" + lst.Funcionalidade + "' onchange='savePermissao(this)'/><label></label></td>";
                            cols += "<td style='border-collapse: collapse; padding: 5px;text-align: left;'>" + lst.Funcionalidade + "</td><div class=\"btn-group\"></div></td>";
                            cols += "<td style='border-collapse: collapse; padding: 5px;text-align: left;'>" + lst.Descricao + "</td><div class=\"btn-group\"></div></td>";
                            newRow.append(cols);
                            $("#tbGrdPermissoes").append(newRow);
                        }

                        i++;
                    }
                    $("#divLoading").css("display", "none");
                },
                error: function (data) {
                    $("#divLoading").css("display", "none");
                }
            });

        }

        function savePermissao(btn) {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'PermissoesUsers.aspx/SaveRoleUser',
                dataType: 'json',
                data: "{'user':'" + btn.dataset.usuario + "','role':'" + btn.dataset.role + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    $("#divLoading").css("display", "none");
                },
                error: function (data) {
                    $("#divLoad").css("display", "none");
                }
            });
        }

        function salvando(btn) {

            if (btn.value == "Salvar") {

                $("#divPermissoes").css("display", "none");
                $("#divPesquisa").css("display", "block");

                Swal.fire({
                    type: 'success',
                    title: 'Salvo!',
                    text: 'Salvo com sucesso.',
                })
            }
            else {

                $("#divPermissoes").css("display", "none");
                $("#divPesquisa").css("display", "block");
            }

            $("#txtUsuario").val("");
        }

        $(function () {

            $('[data-toggle="tooltip"]').tooltip()
        })

    </script>

</asp:Content>
