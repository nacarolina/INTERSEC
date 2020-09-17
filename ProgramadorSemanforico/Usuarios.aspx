<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="GwCentral.ProgramadorSemanforico.Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css" />
    <link href="../bootstrap-fileinput-master/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <script src="../assets/sweetalert-dev.js"></script>
    <link href="../assets/sweetalert.css" rel="stylesheet" />
    <style>
        .form-group input[type="checkbox"] {
            display: none;
        }

            .form-group input[type="checkbox"] + .btn-group > label span {
                width: 20px;
            }

                .form-group input[type="checkbox"] + .btn-group > label span:first-child {
                    display: none;
                }

                .form-group input[type="checkbox"] + .btn-group > label span:last-child {
                    display: inline-block;
                }

            .form-group input[type="checkbox"]:checked + .btn-group > label span:first-child {
                display: inline-block;
            }

            .form-group input[type="checkbox"]:checked + .btn-group > label span:last-child {
                display: none;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hfIdPrefeitura" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfIdiomaUpload" ClientIDMode="Static" runat="server" />
    <h2 id="titleCad" style="margin-bottom: 15px; border-bottom: 1px solid #D8D8D8; padding: 5px; margin-left: 10px; width: 800px;">
        <%= Resources.Resource.usuario %>
    </h2>
    <hr />
  <%--  <h4><%= Resources.Resource.novo %> <%= Resources.Resource.usuario %> (<%= Resources.Resource.programadorSemaforico %>)<br />
    </h4>
    <input id="input-pt-br" name="inputptbr[]" type="file" class="file-loading" />
    <br />--%>

    <div id="dvUsuario">
        <h4><%= Resources.Resource.novaLicenca %><br />
        </h4>
        <table class="table table-bordered table-striped table-hover" style="width: 100%">
            <thead>
                <tr>
                    <th><%= Resources.Resource.usuario %></th>
                    <th>Email</th>
                    <th><%= Resources.Resource.telefone %></th>
                    <th><%= Resources.Resource.empresa %></th>
                    <th><%= Resources.Resource.municipio %></th>
                    <th><%= Resources.Resource.versao %></th>
                    <th><%= Resources.Resource.ultimoAcesso %></th>
                    <th><%= Resources.Resource.chave %></th>
                    <th><%= Resources.Resource.ativo %></th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="tbLicenca">
                <tr>
                    <td colspan="13"><%= Resources.Resource.naoHaRegistros %></td>
                </tr>
            </tbody>
        </table>

        <br />
        <h4><%= Resources.Resource.usuario %><br />
        </h4>
        <table class="table table-bordered table-striped table-hover" style="width: 100%">
            <thead>
                <tr>
                    <th><%= Resources.Resource.usuario %></th>
                    <th>Email</th>
                    <th><%= Resources.Resource.telefone %></th>
                    <th><%= Resources.Resource.empresa %></th>
                    <th><%= Resources.Resource.municipio %></th>
                    <th><%= Resources.Resource.versao %></th>
                    <th><%= Resources.Resource.ultimoAcesso %></th>
                    <th><%= Resources.Resource.chave %></th>
                    <th><%= Resources.Resource.ativo %></th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="tbUsuarioAtivo">
                <tr>
                    <td colspan="14"><%= Resources.Resource.naoHaRegistros %></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="modal fade" id="mpDispositivos" role="dialog">
        <div class="modal-dialog" style="width: 40%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%= Resources.Resource.dispositivos %> </h4>
                </div>
                <div class="modal-body">
                    <div>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th><%= Resources.Resource.dispositivos %></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="tbDispositivos"></tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" value="<%= Resources.Resource.cancelar %>" class="btn btn-danger" style="width: 100px" onclick="fecharDispo()" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="mpSenha" role="dialog">
        <div class="modal-dialog" style="width: 30%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%= Resources.Resource.alterar %> <%= Resources.Resource.senha %></h4>
                </div>
                <div class="modal-body">
                    <div>
                        <table class="table table-bordered" style="width: 100%">
                            <tr>
                                <td><%= Resources.Resource.usuario %>:
                                        <input type="text" id="txtUsuario" class="form-control" style="width: 100%" />
                                </td>
                            </tr>
                            <tr>
                                <td>Email:
                                        <input type="text" id="txtEmail" class="form-control" style="width: 100%" />
                                </td>
                            </tr>
                            <tr>
                                <td><%= Resources.Resource.senha %>:
                                    <input type="text" id="txtSenha" class="form-control" style="width: 50%" />
                                </td>
                            </tr>
                        </table>
                        <br />
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" value="<%= Resources.Resource.salvar %>" class="btn btn-success" style="width: 100px" onclick="SalvarSenha()" />
                    <input type="button" value="<%= Resources.Resource.cancelar %>" class="btn btn-danger" style="width: 100px" onclick="Cancelar()" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="mpRegraAcesso" role="dialog">
        <div class="modal-dialog" style="width: 30%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"><%= Resources.Resource.regraAcesso %></h4>
                </div>
                <div class="modal-body">
                    <div>
                        <table class="table table-bordered" style="width: 100%">
                            <tr>
                                <td><%= Resources.Resource.usuario %>:
                                     <input type="text" id="lblUsuarioRegra" class="form-control" disabled="disabled" />
                                    <input type="checkbox" style="display: none;" id="chkAtivo" />
                                </td>
                            </tr>
                            <tr>
                                <td><%= Resources.Resource.prefeitura %>:
                                    <select id="slePrefeitura" class="form-control"></select>
                                </td>
                            </tr>
                            <tr>
                                <td><%= Resources.Resource.usuariosPermissoes %>:
                                    <p></p>
                                    <p>
                                        <input type="checkbox" id="chkApaga_Logs_Falha_Restabelecimento" value="Apaga_Logs_Falha_Restabelecimento" onchange="changeChkRoles(this)" />
                                        <b><%= Resources.Resource.apagaLogsFalhaRestabelecimento %></b>
                                    </p>
                                    <p>
                                        <input type="checkbox" id="chkApaga_Logs_Operacao" value="Apaga_Logs_Operacao" onchange="changeChkRoles(this)" />
                                        <b><%= Resources.Resource.apagaLogsOperacao %></b>
                                    </p>
                                    <p>
                                        <input type="checkbox" id="chkCriar_Login" value="Criar_Login" onchange="changeChkRoles(this)" />
                                        <b><%= Resources.Resource.criar %> login</b>
                                    </p>
                                    <p>
                                        <input type="checkbox" id="chkEnvia_Programacao_Para_O_Equipamento" value="Envia_Programacao_Para_O_Equipamento" onchange="changeChkRoles(this)" />
                                        <b><%= Resources.Resource.enviaProgramacaoEqp %></b>
                                    </p>
                                    <p>
                                        <input type="checkbox" id="chkExcluir_Login" value="Excluir_Login" onchange="changeChkRoles(this)" />
                                        <b><%= Resources.Resource.excluir %> login</b>
                                    </p>
                                    <p>
                                        <input type="checkbox" id="chkManipula_Roles" value="Manipula_Roles" onchange="changeChkRoles(this)" />
                                        <b><%= Resources.Resource.manipula %> - <%= Resources.Resource.regraAcesso %></b>
                                    </p>
                                    <p>
                                        <input type="checkbox" id="chkExcluir_Programacao" value="Excluir_Programacao" onchange="changeChkRoles(this)" />
                                        <b><%= Resources.Resource.excluir %> <%= Resources.Resource.programacao %></b>
                                    </p>
                                    <p>
                                        <input type="checkbox" id="chkAlterar_IP_Do_Equipamento" value="Alterar_IP_Do_Equipamento" onchange="changeChkRoles(this)" />
                                        <b><%= Resources.Resource.alterar %> IP <%= Resources.Resource.controlador %></b>
                                    </p>
                                </td>
                            </tr>
                        </table>
                        <br />
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" value="<%= Resources.Resource.salvar %>" class="btn btn-success" style="width: 100px" onclick="SalvarRegra()" />
                    <input type="button" value="<%= Resources.Resource.cancelar %>" class="btn btn-danger" style="width: 100px" onclick="CancelarRegra()" />
                </div>
            </div>
        </div>
    </div>

    <%--<div class="modal fade" id="mpNovoUsuario" role="dialog">
        <div class="modal-dialog" style="width: 80%">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Novo Usuário para Autenticação Offline</h4>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <label class="control-label margin-t-10 margin-b-10">Selecione os Arquivos</label>
                        <input id="input-pt-br" name="inputptbr[]" type="file" class="file-loading" />
                        <br />
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" value="Salvar" class="btn btn-success" style="width: 100px" onclick="GetKeyCode()" />
                    <input type="button" value="Cancelar" class="btn btn-danger" style="width: 100px" onclick="CancelarNovoUsuario()" />
                </div>
            </div>
        </div>
    </div>--%>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <script src="../Scripts/fileinput.js"></script>

    <script src="../bootstrap-fileinput-master/js/locales/pt-BR.js"></script>
    <script src="../bootstrap-fileinput-master/js/locales/LANG.js"></script>
    <script src="../bootstrap-fileinput-master/js/locales/es.js"></script>

    <script type="text/javascript">
        $("#input-pt-br").fileinput({
            language: $("#hfIdiomaUpload").val(),
            uploadUrl: "Usuarios.aspx",
            maxFilePreviewSize: 10240,
            allowedFileExtensions: ["register"],
            uploadAsync: true,
            elErrorContainer: '#kv-error-1'
        }).on('filebatchpreupload', function (event, data, id, index) {
            $('#kv-success-1').html('<h4>Upload Status</h4><ul></ul>').hide();
        }).on('fileuploaded', function (event, data, id, index) {
            var fname = data.files[index].name,
                out = '<li>' + 'Uploaded file # ' + (index + 1) + ' - ' +
                    fname + ' successfully.' + '</li>';
            $('#kv-success-1 ul').append(out);
            $('#kv-success-1').fadeIn('slow');
        });

        $(function () {
            loadMunicipio();
            GetUsuariosInativos();
            GetUsuariosAtivos();
            getPrefeitura();
        });

        function getPrefeitura() {
            $.ajax({
                url: 'Usuarios.aspx/getPrefeituras',
                data: "{}",
                dataType: "json",
                async: false,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#slePrefeitura").empty();
                    $("#slePrefeitura").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>...'));
                    $.each(data.d, function () {
                        $("#slePrefeitura").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });
        }

        function GetUsuariosInativos() {
            $.ajax({
                type: 'POST',
                url: 'Usuarios.aspx/GetUsuariosInativos',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbLicenca").empty();
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + lst.Nome + "</td>";
                            cols += "<td>" + lst.Email + "</td>";
                            cols += "<td>" + lst.Telefone + "</td>";
                            cols += "<td>" + lst.Empresa + "</td>";
                            cols += "<td>" + lst.Municipio + "</td>";
                            cols += "<td>" + lst.VersaoProgramador + "</td>";
                            cols += "<td>" + lst.UltimaConexao + "</td>";
                            cols += "<td>" + lst.Chave + "</td>";

                            cols += '<td><input type="checkbox" onchange="chkAtivoInativo(this)"  data-idprefeitura="" data-ativo="False" data-usuario="' + lst.Nome + '" data-email="' + lst.Email + '"></td>';

                            //cols += '<td><button type="button" class="btn btn-primary" onclick="AlterarSenha(this)" data-usuario="' + lst.Nome + '" data-email="' + lst.Email + '">Alterar Senha</button></td>';
                            cols += '<td><button type="button" class="btn btn-success" onclick="RegraAcesso(this)" data-idprefeitura="" data-origem="licensa" data-ativo="' + lst.Ativo + '" data-usuario="' + lst.Nome + '" data-email="' + lst.Email + '"><%= Resources.Resource.permissao %></button></td>';
                            //cols += "<td> <div class=\"btn-group\">" +
                            //	" <button type=\"button\" style=\"width:125px;\"  class=\"btn btn-danger dropdown-toggle\" data-toggle=\"dropdown\">" +
                            //	"Excluir <span class=\"caret\"></span></button>" +
                            //	"<ul class=\"dropdown-menu\" role=\"menu\">" +
                            //	"<li><a href=\"#\"onclick='ExcluirUsuario(this)' data-nome='" + lst.Nome + "' data-email='" + lst.Email + "'>Sim</a></li>" +
                            //	"</ul>" +
                            //	"</div></td>";
                            newRow.append(cols);
                            $("#tbLicenca").append(newRow);
                        }
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='12'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbLicenca").append(newRow);
                    }
                },
                error: function (data) {
                }
            });
        }


        function GetUsuariosAtivos() {
            $.ajax({
                type: 'POST',
                url: 'Usuarios.aspx/GetUsuariosAtivos',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbUsuarioAtivo").empty();
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + lst.Nome + "</td>";
                            cols += "<td>" + lst.Email + "</td>";
                            cols += "<td>" + lst.Telefone + "</td>";
                            cols += "<td>" + lst.Empresa + "</td>";
                            cols += "<td>" + lst.Municipio + "</td>";
                            cols += "<td>" + lst.VersaoProgramador + "</td>";
                            cols += "<td>" + lst.UltimaConexao + "</td>";
                            cols += "<td>" + lst.Chave + "</td>";

                            if (lst.Ativo == "True")
                                cols += '<td><input type="checkbox" checked onchange="chkAtivoInativo(this)" data-ativo="true"  data-idprefeitura="' + lst.idPrefeitura + '" data-usuario="' + lst.Nome + '" data-email="' + lst.Email + '"></td>';
                            else
                                cols += '<td><input type="checkbox" onchange="chkAtivoInativo(this)" data-ativo="false"  data-idprefeitura="' + lst.idPrefeitura + '" data-usuario="' + lst.Nome + '" data-email="' + lst.Email + '"></td>';

                            cols += '<td><button type="button" class="btn btn-primary" onclick="AlterarSenha(this)" data-usuario="' + lst.Nome + '" data-email="' + lst.Email + '"><%= Resources.Resource.alterar %> <%= Resources.Resource.senha %></button></td>';
                            cols += '<td><button type="button" class="btn btn-success" onclick="RegraAcesso(this)" data-origem="" data-ativo="' + lst.Ativo + '" data-idprefeitura="' + lst.idPrefeitura + '"  data-usuario="' + lst.Nome + '" data-email="' + lst.Email + '"><%= Resources.Resource.permissao %></button></td>';
                            cols += '<td><button type="button" class="btn btn-warning" onclick="Dispositivos(this)" data-usuario="' + lst.Nome + '" data-email="' + lst.Email + '"><%= Resources.Resource.dispositivos %> </button></td>';
                            //cols += "<td> <div class=\"btn-group\">" +
                            //	" <button type=\"button\" style=\"width:125px;\"  class=\"btn btn-danger dropdown-toggle\" data-toggle=\"dropdown\">" +
                            //	"Excluir <span class=\"caret\"></span></button>" +
                            //	"<ul class=\"dropdown-menu\" role=\"menu\">" +
                            //	"<li><a href=\"#\"onclick='ExcluirUsuario(this)' data-nome='" + lst.Nome + "' data-email='" + lst.Email + "'>Sim</a></li>" +
                            //	"</ul>" +
                            //	"</div></td>";
                            newRow.append(cols);
                            $("#tbUsuarioAtivo").append(newRow);
                        }
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='13'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbUsuarioAtivo").append(newRow);
                    }
                }
            });
        }
        function fecharDispo() {
            $("#mpDispositivos").modal("hide");
        }

        function Dispositivos(btn) {
            $("#mpDispositivos").modal("show");
            $("#tbDispositivos").empty();
            $.ajax({
                type: 'POST',
                url: 'Usuarios.aspx/getDispositivos',
                dataType: 'json',
                data: "{'email':'" + btn.dataset.email + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + lst.Dispositivo + "</td>";

                            if (lst.Ativo == "True")
                                cols += "<td> <div class=\"btn-group\">" +
                                    " <button type=\"button\" style=\"width:125px;\"  class=\"btn btn-primary dropdown-toggle\" data-toggle=\"dropdown\">" +
                                    "Ativo <span class=\"caret\"></span></button>" +
                                    "<ul class=\"dropdown-menu\" role=\"menu\">" +
                                    "<li><a href=\"#\"onclick='DesativarDispo(this)' data-id='" + lst.Id + "'><%= Resources.Resource.desativar %></a></li>" +
                                    "</ul>" +
                                    "</div></td>";
                            else
                                cols += '<td><%= Resources.Resource.inativo %></td>';

                            newRow.append(cols);
                            $("#tbDispositivos").append(newRow);
                        }
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='3'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbDispositivos").append(newRow);
                    }

                }
            });

        }
        function DesativarDispo(btn) {
            $.ajax({
                type: 'POST',
                url: 'Usuarios.aspx/Desativar',
                dataType: 'json',
                data: "{'id':'" + btn.dataset.id + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#mpDispositivos").modal("hide");
                    alert("<%= Resources.Resource.salvoComSucesso %>");
                }
            });
        }
        function RegraAcesso(btn) {

            $("#slePrefeitura").css("border-color", "");
            $("#lblPrefeitura").css("box-shadow", "");
            $("#slePrefeitura").css("outline", "");
            var idPrefeitura = btn.dataset.idprefeitura;
            $("#mpRegraAcesso").modal("show");
            $("#lblUsuarioRegra").val("");
            $("#lblUsuarioRegra").val(btn.dataset.usuario);
            $("#lblUsuarioRegra")[0].title = btn.dataset.email;
            if (btn.origem == "licensa") {
                $("#chkAtivo")[0].checked = true;
            } else {
                $("#chkAtivo")[0].checked = btn.dataset.ativo;
            }

            $("#chkApaga_Logs_Falha_Restabelecimento").prop("checked", false);
            $("#chkApaga_Logs_Operacao").prop("checked", false);
            $("#chkCriar_Login").prop("checked", false);
            $("#chkEnvia_Programacao_Para_O_Equipamento").prop("checked", false);
            $("#chkExcluir_Login").prop("checked", false);
            $("#chkManipula_Roles").prop("checked", false);
            $("#chkExcluir_Programacao").prop("checked", false);
            $("#chkAlterar_IP_Do_Equipamento").prop("checked", false);
            if (idPrefeitura == "") {
                $("#slePrefeitura")[0].disabled = false;
                $("#slePrefeitura").val("");
                $("#chkEnvia_Programacao_Para_O_Equipamento")[0].checked = true;
                changeChkRoles($("#chkEnvia_Programacao_Para_O_Equipamento")[0]);

                $("#chkExcluir_Programacao")[0].checked = true;
                changeChkRoles($("#chkExcluir_Programacao")[0]);
                $("#chkAlterar_IP_Do_Equipamento")[0].checked = true;
                changeChkRoles($("#chkAlterar_IP_Do_Equipamento")[0]);
                $("#chkApaga_Logs_Falha_Restabelecimento")[0].checked = true;
                changeChkRoles($("#chkApaga_Logs_Falha_Restabelecimento")[0]);
            }
            else {
                $("#slePrefeitura").val(idPrefeitura);
                $("#slePrefeitura")[0].disabled = true;
            }

            $.ajax({
                type: 'POST',
                url: 'Usuarios.aspx/GetRoles',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','email':'" + btn.dataset.email + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            if (data.d[i].Roles == "Apaga_Logs_Falha_Restabelecimento") {
                                $("#chkApaga_Logs_Falha_Restabelecimento")[0].checked = true;
                            }
                            if (data.d[i].Roles == "Apaga_Logs_Operacao") {
                                $("#chkApaga_Logs_Operacao")[0].checked = true;
                            }
                            if (data.d[i].Roles == "Criar_Login") {
                                $("#chkCriar_Login")[0].checked = true;
                            }
                            if (data.d[i].Roles == "Envia_Programacao_Para_O_Equipamento") {
                                $("#chkEnvia_Programacao_Para_O_Equipamento")[0].checked = true;
                            }
                            if (data.d[i].Roles == "Excluir_Login") {
                                $("#chkExcluir_Login")[0].checked = true;
                            }
                            if (data.d[i].Roles == "Manipula_Roles") {
                                $("#chkManipula_Roles")[0].checked = true;
                            }
                            if (data.d[i].Roles == "Excluir_Programacao") {
                                $("#chkExcluir_Programacao")[0].checked = true;
                            }
                            if (data.d[i].Roles == "Alterar_IP_Do_Equipamento") {
                                $("#chkAlterar_IP_Do_Equipamento")[0].checked = true;
                            }
                        }
                    }
                },
                error: function (data) {
                }
            });
        }

        function changeChkRoles(chk) {
            if (chk.checked == true) {

                $.ajax({
                    type: 'POST',
                    url: 'Usuarios.aspx/AlteraRegraAcesso',
                    dataType: 'json',
                    data: "{'email':'" + $("#lblUsuarioRegra")[0].title + "', 'nomerole':'" + chk.value + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "SUCESSO") {
                            alert("<%= Resources.Resource.erro %>");
                        }
                    }
                });
            }
            else {
                $.ajax({
                    type: 'POST',
                    url: 'Usuarios.aspx/ExcluiRegraAcesso',
                    dataType: 'json',
                    data: "{'email':'" + $("#lblUsuarioRegra")[0].title + "', 'nomerole':'" + chk.value + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "SUCESSO") {
                            alert("<%= Resources.Resource.erro %>");
                        }
                    }
                });
            }
        }

        function CancelarRegra() {
            $("#mpRegraAcesso").modal("hide");
        }

        function SalvarRegra() {
            if ($("#lblUsuarioRegra").val() == "") {
                $("#lblUsuarioRegra").css("border-color", "#ff0000");
                $("#lblUsuarioRegra").css("outline", "0");
                $("#lblUsuarioRegra").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#lblUsuarioRegra").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#lblUsuarioRegra").focus();
                return false;
            }
            if ($("#slePrefeitura").val() == "") {
                $("#slePrefeitura").css("border-color", "#ff0000");
                $("#slePrefeitura").css("outline", "0");
                $("#slePrefeitura").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#slePrefeitura").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#slePrefeitura").focus();
                return false;
            }
            $.ajax({
                type: 'POST',
                url: 'Usuarios.aspx/SalvarRegra',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#slePrefeitura").val() + "','usuario':'" + $("#lblUsuarioRegra").val() + "','email':'" + $("#lblUsuarioRegra")[0].title + "','prefeitura':'" + $("#slePrefeitura option:selected").text() + "','chk':'" + $("#chkAtivo")[0].checked + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "SUCESSO") {
                        alert(data.d);
                    }
                    else {
                        $("#lblUsuarioRegra").css("border-color", "");
                        $("#lblUsuarioRegra").css("box-shadow", "");
                        $("#slePrefeitura").css("border-color", "");
                        $("#slePrefeitura").css("box-shadow", "");

                        $("#lblUsuarioRegra").val("");
                        GetUsuariosInativos();
                        GetUsuariosAtivos();
                        $("#mpRegraAcesso").modal("hide");
                        alert("<%= Resources.Resource.salvoComSucesso %>");
                        GetUsuariosInativos();
                        GetUsuariosAtivos();
                        $("#mpRegraAcesso").modal("hide");
                    }
                }
            });
        }

        function AlterarSenha(btn) {
            $("#mpSenha").modal("show");
            $("#txtUsuario").val("");
            $("#txtEmail").val("");
            $("#txtSenha").val("");
            $("#txtUsuario").val(btn.dataset.usuario);
            $("#txtEmail").val(btn.dataset.email);
        }


        function SalvarSenha() {
            if ($("#txtSenha").val() == "") {
                $("#txtSenha").css("border-color", "#ff0000");
                $("#txtSenha").css("outline", "0");
                $("#txtSenha").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtSenha").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#txtSenha").focus();
                return false;
            }
            $("#txtSenha").css("border-color", "");
            $("#txtSenha").css("box-shadow", "");

            $.ajax({
                type: 'POST',
                url: 'Usuarios.aspx/SalvarSenha',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#slePrefeitura").val() + "','usuario':'" + $("#txtUsuario").val() +
                    "','email':'" + $("#txtEmail").val() + "','senha':'" + $("#txtSenha").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "SUCESSO") {
                        alert(data.d);
                    }
                    else {
                        $("#txtSenha").val("");
                        GetUsuariosInativos();
                        GetUsuariosAtivos();
                        $("#mpSenha").modal("hide");
                        alert("<%= Resources.Resource.salvoComSucesso %>");
                    }
                }
            });
        }

        function Cancelar() {
            $("#mpSenha").modal("hide");
        }

        function ExcluirUsuario(btn) {
            $.ajax({
                type: 'POST',
                url: 'Usuarios.aspx/ExcluirUsuario',
                dataType: 'json',
                data: "{'email':'" + btn.dataset.email + "','nome':'" + btn.dataset.nome + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "SUCESSO") {
                        alert(data.d);
                    }
                    else {
                        GetUsuariosInativos();
                        GetUsuariosAtivos();
                        alert("<%= Resources.Resource.excluidoSucesso %>");
                    }
                }
            });
        }


        function NovoUsuario() {
            $("#mpNovoUsuario").modal("show");
            $("#divUploadMain").modal("show");
            //$("#txtNovoUsuario").val("");
            //$("#txtUserEmail").val("");
            //$("#txtUserSenha").val("");
            //$("#txtUserEmpresa").val("");
            //$("#txtUserTelefone").val("");
            //$("#txtUserVersao").val("");
            //$("#sleMnc").val($("#sleMnc").val());
        }

        function SalvarNovoUsuario(chave) {
            if ($("#txtNovoUsuario").val() == "") {
                $("#txtNovoUsuario").css("border-color", "#ff0000");
                $("#txtNovoUsuario").css("outline", "0");
                $("#txtNovoUsuario").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtNovoUsuario").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#txtNovoUsuario").focus();
                return false;
            }

            if ($("#txtUserEmail").val() == "") {
                $("#txtUserEmail").css("border-color", "#ff0000");
                $("#txtUserEmail").css("outline", "0");
                $("#txtUserEmail").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtUserEmail").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#txtUserEmail").focus();
                return false;
            }

            if ($("#txtUserSenha").val() == "") {
                $("#txtUserSenha").css("border-color", "#ff0000");
                $("#txtUserSenha").css("outline", "0");
                $("#txtUserSenha").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtUserSenha").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#txtUserSenha").focus();
                return false;
            }

            $("#txtNovoUsuario").css("border-color", "");
            $("#txtNovoUsuario").css("box-shadow", "");

            $("#txtUserEmail").css("border-color", "");
            $("#txtUserEmail").css("box-shadow", "");

            $("#txtUserSenha").css("border-color", "");
            $("#txtUserSenha").css("box-shadow", "");

            $.ajax({
                type: 'POST',
                url: 'Usuarios.aspx/SalvarNovoUsuario',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','usuario':'" + $("#txtNovoUsuario").val() + "','email':'" + $("#txtUserEmail").val() + "','senha':'" + $("#txtUserSenha").val()
                    + "','telefone':'" + $("#txtUserTelefone").val() + "','versao':'" + $("#txtUserVersao").val() + "','mnc':'" + $("#sleMnc").val() + "','empresa':'" + $("#txtUserEmpresa").val() + "','chave':'" + chave + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "SUCESSO") {
                        alert(data.d);
                    }
                    else {
                        $("#txtNovoUsuario").val("");
                        GetUsuariosInativos();
                        GetUsuariosAtivos();
                        $("#mpNovoUsuario").modal("hide");
                        alert("<%= Resources.Resource.salvoComSucesso %>");
                    }
                }
            });
        }



        function CancelarNovoUsuario() {
            $("#mpNovoUsuario").modal("hide");
        }

        function loadMunicipio(idMnc) {
            $.ajax({
                url: 'Usuarios.aspx/loadMunicipio',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
                dataType: "json",
                async: false,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#sleMnc").empty();
                    $.each(data.d, function () {
                        $("#sleMnc").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                    if (idMnc != '') {
                        $("#sleMnc").val(idMnc);
                    }
                }
            });
        }


        function GetKeyCode() {
            if ($("#txtNovoUsuario").val() == "") {
                $("#txtNovoUsuario").css("border-color", "#ff0000");
                $("#txtNovoUsuario").css("outline", "0");
                $("#txtNovoUsuario").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtNovoUsuario").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#txtNovoUsuario").focus();
                return false;
            }

            if ($("#txtUserEmail").val() == "") {
                $("#txtUserEmail").css("border-color", "#ff0000");
                $("#txtUserEmail").css("outline", "0");
                $("#txtUserEmail").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtUserEmail").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#txtUserEmail").focus();
                return false;
            }

            if ($("#txtUserSenha").val() == "") {
                $("#txtUserSenha").css("border-color", "#ff0000");
                $("#txtUserSenha").css("outline", "0");
                $("#txtUserSenha").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtUserSenha").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#txtUserSenha").focus();
                return false;
            }

            $("#txtNovoUsuario").css("border-color", "");
            $("#txtNovoUsuario").css("box-shadow", "");

            $("#txtUserEmail").css("border-color", "");
            $("#txtUserEmail").css("box-shadow", "");

            $("#txtUserSenha").css("border-color", "");
            $("#txtUserSenha").css("box-shadow", "");

            $.ajax({
                url: 'Usuarios.aspx/GetKeyCode',
                data: "{'email':'" + $("#txtUserEmail").val() + "'}",
                dataType: "json",
                async: false,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        SalvarNovoUsuario(data.d);
                    }
                }
            });
        }


        function chkAtivoInativo(chk) {
            if (chk.checked == true) {
                $("#chkAtivo")[0].checked = true;
                RegraAcesso(chk);
                return;
            }
            $.ajax({
                type: 'POST',
                url: 'Usuarios.aspx/chkAtivoInativo',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','usuario':'" + chk.dataset.usuario + "','email':'" + chk.dataset.email + "', 'chk':'" + chk.checked + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    GetUsuariosInativos();
                    GetUsuariosAtivos();
                    alert("<%= Resources.Resource.salvoComSucesso %>");
                }
            });
        }
    </script>
</asp:Content>
