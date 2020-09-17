<%@ Page Title="Cadastro de Corredor" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Register.Corredor.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
	</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.cadastroCorredor %>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FeaturedContent2" runat="server">
    <%= Resources.Resource.cadastro %> - <%= Resources.Resource.corredor %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hfIdCorredorCad" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfIdCorredorAnel" ClientIDMode="Static" runat="server" />

    <div class="btn-group" style="width: 55%">
        <label style="margin-right: 10px; margin-top: 10px;"><%= Resources.Resource.corredor %>:</label>
        <select id="sleCorredor" class="form-control" onchange="getCorredorAneis()"></select>
        <input type="button" class="btn btn-success" value="<%= Resources.Resource.novo %> <%= Resources.Resource.corredor %>" style="cursor: pointer; padding-top: 4px;" onclick="Novo()" />

    </div>
    <br />
    <div style="margin-bottom: 15px;">
        <label style="margin-right: 10px; margin-top: 10px;"><%= Resources.Resource.subArea %>:</label>
        <label id="lblSubAreaPesq">Av teste, 123031</label>
    </div>
    <div id="dvGrdCorredor" style="display: none;">
        <input type="button" id="btnNovo" style="margin-bottom: 15px;" onclick="AdicionarAnel()" class="btn btn-info" value="<%= Resources.Resource.adicionar %> <%= Resources.Resource.anel %>" />
        <input type="button" id="btnTrajeto" onclick="Trajeto()" class="btn btn-primary" value="<%= Resources.Resource.trajeto %> " style="display: none; margin-bottom: 15px;" />
        <table class="table table-bordered table-striped" style="width: 100%">
            <thead>
                <tr>
                    <th style="font-size: small"><%= Resources.Resource.cruzamento %></th>
                    <th style="font-size: small"><%= Resources.Resource.controlador %> - <%= Resources.Resource.anel %></th>
                    <th style="font-size: small"><%= Resources.Resource.grupo %></th>
                    <th style="font-size: small"><%= Resources.Resource.distancia %> (m)</th>
                    <th style="font-size: small"><%= Resources.Resource.tempoEntreCruzamentos %></th>
                    <th style="font-size: small"><%= Resources.Resource.indiceCorredor %></th>
                    <th style="font-size: small"></th>
                    <th style="font-size: small"></th>
                </tr>
            </thead>
            <tbody id="tbCorredor">
                <tr>
                    <td colspan="8">Não há registros!</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="container">
        <div class="modal fade" id="mpCadCorredor" role="dialog">
            <div class="modal-dialog modal-lg" style="width: 80%">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title"><%= Resources.Resource.cadastrar %> <%= Resources.Resource.corredor %></h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div id="dvCadastro">
                            <table class="table table-bordered" style="width: 100%">
                                <tr>
                                    <td colspan="2"><%= Resources.Resource.corredor %>:
                                        <input id="txtCorredor" style="display:inline; width:90%;" class="form-control" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"><%= Resources.Resource.subArea %>:
                                        <select id="sleSubArea" style="display:inline; width:90%;" class="form-control"></select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><%= Resources.Resource.tempoPercurso %> :
                                        <input id="txtTempoPercurso" class="form-control" onkeypress="MinSeg(event,this)" placeholder="00:00"  style="display:inline; width:66%;" />
                                    </td>
                                    <td>
                            <input type="button" class="btn btn-success" data-origem="Salvar" value="<%= Resources.Resource.salvar %>" onclick="Salvar()" id="btnSalvar" />
                            <input type="button" class="btn btn-secondary" style="display: none;" value="<%= Resources.Resource.cancelar %>" id="btnCancelar" onclick="CancelarAlteracaoCorredor()" />
                                    </td>
                                </tr>
                            </table>

                            <hr />
                            <table class="table table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th><%= Resources.Resource.corredor %></th>
                                        <th><%= Resources.Resource.subArea %></th>
                                        <th><%= Resources.Resource.tempoPercurso %></th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody id="tbCorredoresCad">
                                    <tr>
                                        <td colspan="7"><%= Resources.Resource.naoHaRegistros %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="mpCadCorredorAneis" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content" style="width:115%">
                    <div class="modal-header" style="border-bottom: 1px solid #e9ecef;">
                        <h4 class="modal-title"><%= Resources.Resource.cadastrar %> <%= Resources.Resource.anel %> - <%= Resources.Resource.corredor %></h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div style="margin-bottom: 15px;">
                            <label style="margin-right: 10px; margin-top: 10px;"><%= Resources.Resource.corredor %>:</label>
                            <select id="sleCadCorredor" style="display: inline; width: 90%;" onchange="getAneisSubArea()" data-idsubarea="" class="form-control"></select>
                        </div>
                        <div style="margin-bottom: 15px;">
                            <label style="margin-right: 10px; margin-top: 10px;"><%= Resources.Resource.subArea %>:</label>
                            <label id="lblSubArea"></label>
                        </div>
                        <div>
                            <table class="table table-bordered" id="tblAnel" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th><%= Resources.Resource.controlador %> - <%= Resources.Resource.anel %></th>
                                        <th><%= Resources.Resource.distancia %> (m)</th>
                                        <th><%= Resources.Resource.tempoEntreCruzamentos %></th>
                                        <th><%= Resources.Resource.indiceCorredor %></th>
                                        <th><%= Resources.Resource.grupo %></th>
                                    </tr>
                                </thead>
                                <tbody id="tbAnel">
                                    <tr>
                                        <td colspan="6"><%= Resources.Resource.naoHaRegistros %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <br />

                    </div>
                    <div class="modal-footer" style="border-top: 1px solid #e9ecef;">
                        <input type="button" class="btn btn-success" style="width: 200px;" data-origem="Salvar" value="<%= Resources.Resource.salvar %>" onclick="SalvarAneis()" id="Button1" />
                        <input type="button" class="btn btn-danger" style="width: 200px" value="<%= Resources.Resource.cancelar %>" onclick="FecharCadAneis()" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="mpAlterarAnel" role="dialog">
            <div class="modal-dialog" style="width: 80%">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title"><%= Resources.Resource.alterar %> <%= Resources.Resource.anel %> - <%= Resources.Resource.corredor %></h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered" style="width: 100%">
                            <tr>
                                <td><%= Resources.Resource.corredor %>:
                                    <br />
                                    <label id="lblCorredor"></label>
                                </td>
                                <td><%= Resources.Resource.controlador %> - <%= Resources.Resource.anel %>:<br />
                                    <label id="lblEqpAnel" data-anel="" data-ideqp=""></label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"><%= Resources.Resource.distancia %> (m):
                                        <input id="txtDistancia" type="number" class="form-control" />
                                </td>
                            </tr>
                            <tr>
                                <td><%= Resources.Resource.tempoEntreCruzamentos %>:
                                        <input id="txtTempoEntreCruzamentos" class="form-control" onkeypress="MinSeg(event,this)" placeholder="00:00" style="width: 120px" />
                                </td>
                                <td>
                                    <%= Resources.Resource.indiceCorredor %>:
                                        <input id="txtIndice" class="form-control" type="number" min="0" style="width: 120px" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"><%= Resources.Resource.grupo %>:
                                        <select id="sleGrupo" class="form-control"></select>
                                </td>
                            </tr>
                        </table>
                        <input type="button" class="btn btn-success" style="" data-origem="Salvar" value="<%= Resources.Resource.salvarAlteracoes %>" onclick="AlterarAnel()" id="Button2" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>

    <script>
        $(function () {
            loadCorredor();
        });

        function getCorredorAneis() {
            if ($("#sleCorredor").val() == "Selecione..." || $("#sleCorredor").val() == "") {
                $("#dvGrdCorredor").css("display", "none");
                $("#lblSubAreaPesq")[0].innerHTML = "";
                $("#lblSubAreaPesq")[0].title = "";
            } else
                $("#dvGrdCorredor").css("display", "");


            $.ajax({
                type: 'POST',
                url: 'Default.aspx/getSubAreaCorredor',
                dataType: 'json',
                data: "{'idCorredor':'" + $("#sleCorredor").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#lblSubAreaPesq")[0].innerHTML = data.d[0].Text;
                        $("#lblSubAreaPesq")[0].title = data.d[0].Value;
                    }
                }
            });

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/GetCorredorAneis',
                dataType: 'json',
                data: "{'idCorredor':'" + $("#sleCorredor").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbCorredor").empty();
                    if (data.d.length > 0) {
                        $("#btnTrajeto").css("display", "");
                        $.each(data.d, function () {
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + this['Cruzamento'] + "</td>";
                            cols += "<td>" + this['idEqp'] + " - " + this['Anel'] + "</td>";
                            cols += "<td>" + this['GrupoLogico'] + " </td>";
                            cols += "<td>" + this['Distancia'] + "</td>";
                            cols += "<td>" + this['TempoEntreCruzamento'] + " </td>";
                            cols += "<td>" + this['indice'] + " </td>";
                            cols += "<td><input type='button' onclick='EditarAnel(this)' data-indice='" + this['indice'] + "' data-idcorredoranel='" + this['idCorredorAnel'] + "' data-grupologico='" + this['GrupoLogico'] + "' data-anel='" + this['Anel'] + "' data-ideqp='" + this['idEqp'] + "' data-idsubarea='" + this['idSubArea'] + "' data-distancia='" + this['Distancia'] + "' data-TempoEntreCruzamento='" + this['TempoEntreCruzamento'] + "' value='<%= Resources.Resource.editar %>' style='width:100px' class='btn btn-warning'/> </td>";
                            cols += "<td>" +
                                "<div class='btn-group'>" +
                                "<button type='button' class='btn btn-danger dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>" +
                                "<span class='glyphicon glyphicon-remove-circle' style='padding-right: 4px;'></span><%= Resources.Resource.excluir %> <span class='caret'></span></button>" +
                                "<ul class='dropdown-menu'>" +
                                "<li><a href='#' data-idCorredorAnel='" + this['idCorredorAnel'] + "' onclick='ExcluirAnel(this)'><%= Resources.Resource.sim %></a></li></ul></div></td>";

                            newRow.append(cols);
                            $("#tbCorredor").append(newRow);
                        });
                    }
                    else {
                        var newRow = $("<tr>");
                        $("#btnTrajeto").css("display", "none");
                        var cols = "<td colspan='8'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbCorredor").append(newRow);
                    }
                }
            });
        }

        function loadCorredor() {
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/loadCorredor',
                dataType: 'json',
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#sleCadCorredor").empty();
                    $("#sleCorredor").empty();
                    $("#sleCorredor").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>...'));
                    $("#sleCadCorredor").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>...'));
                    $.each(data.d, function () {
                        $("#sleCadCorredor").append($("<option></option>").val(this['idCorredor']).html(this['Corredor']));
                        $("#sleCorredor").append($("<option></option>").val(this['idCorredor']).html(this['Corredor']));
                    });

                    getCorredorAneis();
                }
            });
        }

        function getCorredoresCad() {
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/GetCorredoresCad',
                dataType: 'json',
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbCorredoresCad").empty();
                    if (data.d.length > 0) {
                        $.each(data.d, function () {
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + this['Corredor'] + "</td>";
                            cols += "<td>" + this['SubArea'] + "</td>";
                            cols += "<td>" + this['TempoPercurso'] + "</td>";
                            cols += "<td style='padding:10px'><input type='button' onclick='EditarCorredor(this)' data-qtdaneis='" + this['qtdAneis'] + "' data-corredor='" + this['Corredor'] + "' data-idsubarea='" + this['idSubArea'] + "' data-tempopercurso='" + this['TempoPercurso'] + "' data-idcorredor='" + this['idCorredor'] + "' value='Editar' style='width:100px' class='btn btn-warning'/> </td>";
                            cols += "<td style='padding:10px'>" +
                                "<div class='btn-group'>" +
                                "<button type='button' class='btn btn-danger dropdown-toggle' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>" +
                                "<span class='glyphicon glyphicon-remove-circle' style='padding-right: 4px;'></span>Excluir <span class='caret'></span></button>" +
                                "<ul class='dropdown-menu'>" +
                                "<li><a href='#' data-idCorredor=" + this['idCorredor'] + " data-subarea='" + this['SubArea'] + "'  onclick='ExcluirCorredor(this)'><%= Resources.Resource.excluirAneisVinculados %></a></li></ul></div></td>";

                            newRow.append(cols);
                            $("#tbCorredoresCad").append(newRow);

                        });
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='6' style='border-collapse: collapse; padding: 5px;'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbCorredoresCad").append(newRow);
                    }
                }
            });
        }

        function EditarCorredor(btn) {
            $("#btnCancelar").css("display", "");
            $("#btnSalvar").val("<%= Resources.Resource.salvarAlteracoes %>");
            $("#txtCorredor").val(btn.dataset.corredor);
            $("#txtTempoPercurso").val(btn.dataset.tempopercurso);
            $("#sleSubArea").val(btn.dataset.idsubarea);
            $("#hfIdCorredorCad").val(btn.dataset.idcorredor);
            if (btn.dataset.qtdaneis != "0") {
                $("#sleSubArea")[0].disabled = true;
            }
            else {
                $("#sleSubArea")[0].disabled = false;
            }
        }

        function ExcluirCorredor(btn) {
            $.ajax({
                url: 'Default.aspx/ExcluirCorredor',
                data: "{'idCorredor':'" + btn.dataset.idcorredor + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    loadCorredor();
                    getCorredoresCad();
                },
                error: function (data) {
                }
            });
        }

        function Novo() {
            $("#btnSalvar").val("<%= Resources.Resource.salvar %>");
            $("#mpCadCorredor").modal("show");
            $("#txtCorredor").val("");
            $("#txtTempoPercurso").val("");
            $("#sleSubArea").val("");
            $("#btnCancelar").css("display", "none");
            $("#sleSubArea")[0].disabled = false;
            loadSubarea();
            getCorredoresCad();
        }

        function CancelarAlteracaoCorredor() {
            $("#txtCorredor").val("");
            $("#txtTempoPercurso").val("");
            $("#sleSubArea").val("");
            $("#sleSubArea")[0].disabled = false;
            $("#btnSalvar").val("<%= Resources.Resource.salvar %>");
            $("#btnCancelar").css("display", "none");
        }

        function AdicionarAnel() {
            $("#mpCadCorredorAneis").modal("show");
            $("#sleCadCorredor").val($("#sleCorredor").val());
            getAneisSubArea();
        }

        function loadSubarea() {
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/loadSubarea',
                dataType: 'json',
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#sleSubArea").empty();
                    $("#sleSubArea").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>...'));
                    $.each(data.d, function () {
                        $("#sleSubArea").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });
        }

        function getAneisSubArea() {
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/getSubAreaCorredor',
                dataType: 'json',
                data: "{'idCorredor':'" + $("#sleCadCorredor").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#lblSubArea")[0].innerHTML = data.d[0].Text;
                }
            });

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/getAneisSubArea',
                dataType: 'json',
                data: "{'idCorredor':'" + $("#sleCadCorredor").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbAnel").empty();
                    if (data.d.length > 0) {
                        $.each(data.d, function () {
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td style='border-collapse: collapse; padding: 5px; width:10px'><div class='icheckbox_flat' id='dvchk2' style='margin-left:38%'><input type='checkbox' value='" + this['idAreaAneis'] + "' style='opacity:0; width:20px; height:20px; cursor:pointer' onclick='onCheck(this)' id='chk2'>"
                                + "<ins class='iCheck-helper' style='position: absolute; top: 0 %; left: 0 %; display: block; width: 100 %; height: 100 %; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;'></ins></div > </td>";

                            cols += "<td style='border-collapse: collapse; padding: 5px;' data-anel='" + this["Anel"] + "' data-ideqp='" + this['idEqp'] + "'>" + this['idEqp'] + " - " + this["Anel"] + "</td>";

                            cols += "<td style='border-collapse: collapse; padding: 5px;'><input type='number' class='form-control' id='txtDistancia' /></td>";
                            cols += "<td style='border-collapse: collapse; padding: 5px;'><input type='text' onkeypress='MinSeg(event,this)' placeholder='00:00' class='form-control' id='txtTempo' /> </td>";
                            cols += "<td style='border-collapse: collapse; padding: 5px;'><input type='number' min='0' placeholder='00' class='form-control' id='txtIndice' /> </td>";

                            cols += "<td style='border-collapse: collapse; padding: 5px;'><select id='sleGrupo" + this['idAreaAneis'] + "' class='form-control'></select> </td>";

                            newRow.append(cols);
                            $("#tbAnel").append(newRow);
                            var idAreaAneis = this['idAreaAneis'];
                            $.ajax({
                                type: 'POST',
                                url: 'Default.aspx/GetGrupoLogico',
                                dataType: 'json',
                                async: false,
                                data: "{'idEqp':'" + this['idEqp'] + "','anel':'" + this['Anel'] + "'}",
                                contentType: "application/json; charset=utf-8",
                                success: function (data) {
                                    $("#sleGrupo" + idAreaAneis).append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>...'));
                                    $.each(data.d, function () {
                                        $("#sleGrupo" + idAreaAneis).append($("<option></option>").val(this['Text']).html(this['Text'] + ' - ' + this['Value']));
                                    });
                                }
                            });
                        });
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='6' style='border-collapse: collapse; padding: 5px;'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbAnel").append(newRow);
                    }
                }
            });
        }

        function onCheck(chk) {
            var id = chk.id;
            if (chk.checked) {
                $("#dv"+id).removeClass("icheckbox_flat");
                $("#dv" + id).addClass("icheckbox_flat checked");
            }
            else {
                $("#dv" + id).removeClass("icheckbox_flat checked");
                $("#dv" + id).addClass("icheckbox_flat");
            }
        }
        function Salvar() {
            if ($("#txtCorredor").val() == "") {
                alert("<%= Resources.Resource.informeNomeCorredor %>!");
                $("#txtCorredor").focus();
                return;
            }
            if ($("#sleSubArea").val() == "") {
                alert("<%= Resources.Resource.selecioneSubArea %>!");
                $("#sleSubArea").focus();
                return;
            }
            if ($("#txtTempoPercurso").val() == "") {
                alert("<%= Resources.Resource.informeTempoPercurso %>!");
                $("#txtTempoPercurso").focus();
                return;
            }

            if ($("#btnSalvar").val() == "<%= Resources.Resource.salvar %>") {
                $.ajax({
                    url: 'Default.aspx/SalvarCorredor',
                    data: "{'idSubArea':'" + $("#sleSubArea").val() + "','corredor':'" + $("#txtCorredor").val() + "','tempoPercurso':'" + $("#txtTempoPercurso").val() + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d.includes("ATENÇÃO")) alert(data.d.replace("ATENÇÃO:"));
                        else {
                            loadCorredor();
                            $("#mpCadCorredor").modal("hide");
                            $("#sleCorredor").val(data.d);
                            getCorredorAneis();
                        }
                    },
                    error: function (data) {
                    }
                });
            }
            else {
                $.ajax({
                    url: 'Default.aspx/AlterarCorredor',
                    data: "{'idSubArea':'" + $("#sleSubArea").val() + "','corredor':'" + $("#txtCorredor").val() + "','tempoPercurso':'" + $("#txtTempoPercurso").val() + "','idCorredor':'" + $("#hfIdCorredorCad").val() + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d != "SUCESSO") {
                            alert(data.d);
                        }
                        else {
                            loadCorredor();
                            $("#sleCorredor").val($("#hfIdCorredorCad").val());
                            getCorredoresCad();
                            CancelarAlteracaoCorredor();
                            getCorredorAneis();
                        }
                    },
                    error: function (data) {
                    }
                });
            }
        }

        function SalvarAneis() {
            if ($("#sleCadCorredor").val() == "") {
                alert("<%= Resources.Resource.informeNomeCorredor %>!");
                return;
            }
            validaAneis();
            var table = $("#tblAnel tbody");
            table.find('tr').each(function (i, el) {
                var $tds = $(this).find('td'),
                    chk = $tds[0].firstChild.firstElementChild,
                    anel = $tds[1].dataset.anel,
                    idEqp = $tds[1].dataset.ideqp,
                    distancia = $tds[2].firstChild.value,
                    tempo = $tds[3].firstChild.value,
                    indice = $tds[4].firstChild.value,
                    sleGrupo = $tds[5].firstChild;

                if (chk.checked) {
                    if (indice == "" || indice == "0") {
                        return;
                    }
                    $.ajax({
                        url: 'Default.aspx/SalvarCorredorAneis',
                        data: "{'idCorredor':'" + $("#sleCadCorredor").val() + "','idAreaAneis':'" + chk.value + "','distancia':'" + distancia + "','tempoEntreCruzamentos':'" + tempo +
                            "','grupoLogico':'" + sleGrupo.value + "','idEqp':'" + idEqp + "','anel':'" + anel + "','indice':'" + indice + "'}",
                        dataType: "json",
                        async: false,
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d.includes("ATENÇÃO")) alert(data.d.replace("ATENÇÃO:"));
                            else {
                                getCorredorAneis();
                                $("#mpCadCorredorAneis").modal("hide");
                            }
                        },
                        error: function (data) {
                        }
                    });

                }
            });
        }

        function EditarAnel(btn) {
            $("#mpAlterarAnel").modal("show");
            $("#lblCorredor")[0].innerHTML = $("#sleCorredor")[0].options[$("#sleCorredor")[0].selectedIndex].text;
            $("#lblEqpAnel")[0].innerHTML = btn.dataset.ideqp + ' - ' + btn.dataset.anel;
            $("#lblEqpAnel")[0].dataset.eqp = btn.dataset.ideqp;
            $("#lblEqpAnel")[0].dataset.anel = btn.dataset.anel;
            $("#hfIdCorredorAnel").val(btn.dataset.idcorredoranel);
            $("#txtDistancia").val(btn.dataset.distancia);
            $("#txtIndice").val(btn.dataset.indice);
            $("#txtTempoEntreCruzamentos").val(btn.dataset.tempoentrecruzamento);
            var gp = btn.dataset.grupologico;
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/GetGrupoLogico',
                dataType: 'json',
                data: "{'idEqp':'" + btn.dataset.ideqp + "','anel':'" + btn.dataset.anel + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#sleGrupo").empty();
                    $("#sleGrupo").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>...'));
                    $.each(data.d, function () {
                        $("#sleGrupo").append($("<option></option>").val(this['Text']).html(this['Text'] + ' - ' + this['Value']));
                    });
                    $("#sleGrupo").val(gp);
                }
            });
        }

        function AlterarAnel() {
            //if ($("#txtDistancia").val() == "") {
            //    alert("Informe a Distancia!");
            //    $("#txtDistancia").focus();
            //    return;
            //}
            //if ($("#txtTempoEntreCruzamentos").val() == "") {
            //    alert("Informe o Tempo entre cruzamentos!");
            //    $("#txtTempoEntreCruzamentos").focus();
            //    return;
            //}
            if ($("#sleGrupo").val() == "") {
                alert("<%= Resources.Resource.selecioneGrupo %>");
                $("#sleGrupo").focus();
                return;
            }
            if ($("#txtIndice").val() == "" || $("#txtIndice").val() == "0") {
                alert("<%= Resources.Resource.informeIndiceCorredor %>");
                $("#txtIndice").focus();
                return;
            }
            $.ajax({
                url: 'Default.aspx/AlterarCorredorAnel',
                data: "{'idCorredorAnel':'" + $("#hfIdCorredorAnel").val() + "','distancia':'" + $("#txtDistancia").val() + "','tempoEntreCruzamentos':'" + $("#txtTempoEntreCruzamentos").val() + "','grupoLogico':'" + $("#sleGrupo").val() + "','indice':'" + $("#txtIndice").val() + "','idEqp':'" + $("#lblEqpAnel")[0].dataset.eqp + "','idCorredor':'" + $("#sleCorredor").val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "SUCESSO") {
                        alert(data.d);
                    }
                    else {
                        getCorredorAneis();
                        $("#hfIdCorredorAnel").val("");
                        alert("<%= Resources.Resource.salvoComSucesso %>!");
                        $("#mpAlterarAnel").modal("hide");

                    }
                }
            });

        }

        function validaAneis() {
            var selAnel = false;
            var table = $("#tblAnel tbody");
            table.find('tr').each(function (i, el) {
                var $tds = $(this).find('td'),
                    chk = $tds[0].firstChild.firstElementChild,
                    anel = $tds[1].dataset.anel,
                    distancia = $tds[2].firstChild.value,
                    tempo = $tds[3].firstChild.value,
                    indice = $tds[4].firstChild.value,
                    sleGrupo = $tds[5].firstChild;

                if (chk.checked) {
                    selAnel = true;
                    if (sleGrupo.value == "") {
                        alert("<%= Resources.Resource.selecioneGrupo %> - <%= Resources.Resource.anel %>: " + anel + "!");
                        sleGrupo.focus();
                        return;
                    }

                    if (indice == "" || indice == "0") {
                        alert("<%= Resources.Resource.informeIndiceCorredor %>- <%= Resources.Resource.anel %>: " + anel + "!");
                        $tds[4].firstChild.focus();
                        return;
                    }
                }
            });

            if (selAnel == false) {
                alert("<%= Resources.Resource.selecioneAnel %>!");
                return;
            }
        }

        function ExcluirAnel(btn) {
            $.ajax({
                url: 'Default.aspx/ExcluirAnel',
                data: "{'idCorredorAnel':'" + btn.dataset.idcorredoranel + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    getCorredorAneis();
                },
                error: function (data) {
                }
            });
        }

        function MinSeg(evento, objeto) {
            var keypress = (window.event) ? event.keyCode : evento.which;
            campo = eval(objeto);
            caracteres = '0123456789';
            separacao1 = '/';
            separacao2 = ' ';
            separacao3 = ':';
            conjunto1 = 2;
            conjunto2 = 5;
            conjunto3 = 10;
            conjunto4 = 13;
            conjunto5 = 16;
            if ((caracteres.search(String.fromCharCode(keypress)) != -1)) {

                var digito = parseInt(String.fromCharCode(keypress));
                if (campo.value.length == 0 && (digito > 5 || digito < 0)) {
                    event.returnValue = false;
                    return;
                }
                if (campo.value.length == 1 && (digito > 9 || digito < 0)) {
                    event.returnValue = false;
                    return;
                }
                if ((campo.value.length == 3 || campo.value.length == 2) && (digito > 5 || digito < 0)) {
                    event.returnValue = false;
                    return;
                }
                if (campo.value.length == 5 && (digito > 9 || digito < 0)) {
                    event.returnValue = false;
                    return;
                }
                if (campo.value.length < 5) {
                    if (campo.value.length == conjunto1)
                        campo.value = campo.value + separacao3;
                    //else if (campo.value.length == conjunto2)
                    //    campo.value = campo.value + separacao3;
                }
                else {
                    event.returnValue = false;
                }
            }
            else {
                event.returnValue = false;
            }
        }

        function FecharCad() {
            $("#mpCadCorredor").modal("hide");
        }

        function FecharCadAneis() {
            $("#mpCadCorredorAneis").modal("hide");
        }
        function Trajeto() {
            $.ajax({
                url: 'Default.aspx/getTrajeto',
                data: "{'idSubarea':'" + $("#lblSubAreaPesq")[0].title + "'}",
                dataType: "json",
                async: false,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d == "") {
                        window.location.replace("../Trajetos/TrajetoGrupoSemaforico.aspx?Call=NewRegister&idSubarea=" + $("#lblSubAreaPesq")[0].title + "&Subarea=" + $("#lblSubAreaPesq")[0].innerText);
                    }
                    else
                        window.location.replace("../Trajetos/TrajetoGrupoSemaforico.aspx?Call=Datails&Id=" + data.d + "&idSubarea=" + $("#lblSubAreaPesq")[0].title);

                },
                error: function (data) {
                }
            });

        }
    </script>
</asp:Content>
