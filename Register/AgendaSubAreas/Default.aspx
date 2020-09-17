<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Register.AgendaSubAreas.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style>
/*TBL DIAS SEMANA - TAMANHOS*/
        @media (max-width: 3044px) {
            .grid {
            }
        }

        @media (max-width: 1440px) {
            .grid {
                overflow: scroll;
            }
        }

        </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="Server">
    <%= Resources.Resource.subAreaAgenda %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FeaturedContent2" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="index.html"><%= Resources.Resource.cadastro %></a>
        </li>
        <li class="breadcrumb-item"><a href="#"><%= Resources.Resource.subAreaAgenda %></a>
        </li>
    </ol>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:HiddenField ID="hfIdPrefeitura" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfUser" ClientIDMode="Static" runat="server" />
    <div id="dvPesquisa">
        <h4>Pesquisa</h4>
        <hr />

        <table style="width: 100%; margin-bottom: 10px">
            <tr>
                <td>
                    <%= Resources.Resource.agenda %>:
                    <select id="sleAgendaPesq" class="form-control" onchange="GetAgendaSubarea();"></select>
                </td>
                <td>
                    <%= Resources.Resource.areaSubArea %>:
                    <select id="sleSubArea" class="form-control" data-idarea="" onchange="GetAgendaSubarea();"></select>
                </td>
            </tr>
        </table>
        <input type="button" id="btnNovo" value="<%= Resources.Resource.novo %>" class="btn btn-success" onclick="Novo()" style="width: 150px" />
        <div class="grid">
            <table class="table table-bordered" style="width: 100%; margin-top: 10px;">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.agenda %></th>
                        <th><%= Resources.Resource.area %></th>
                        <th><%= Resources.Resource.subArea %></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbAgendaSubArea">
                    <tr>
                        <td colspan="6"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div id="dvCadastro" style="display: none;">
        <h4 class="form-section"><%= Resources.Resource.cadastro %></h4>
        <hr />
        <div class="form-group">
            <label for="sleAgendaCad">
                <%= Resources.Resource.agenda %>
            </label>
            <select id="sleAgendaCad" onchange="GetAgendaHorarios();" class="form-control"></select>
        </div>
        <div class="form-group">
            <h4><%= Resources.Resource.horarios %></h4>
            <div class="grid">
            <table class="table table-bordered" style="width: 100%">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.plano %></th>
                        <th><%= Resources.Resource.hora %>/<%= Resources.Resource.inicial %></th>
                        <th><%= Resources.Resource.hora %>/<%= Resources.Resource.final %></th>
                        <th><%= Resources.Resource.dias %></th>
                    </tr>
                </thead>
                <tbody id="tbAgendaHorarios">
                    <tr>
                        <td colspan="4"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table></div>
        </div>
        <div class="form-group">
            <label for="sleAreaCad"><%= Resources.Resource.area %></label>
            <select id="sleAreaCad" onchange="loadSubArea()" class="form-control"></select>
        </div>
        <div class="form-group">

            <table class="table table-bordered" id="tblSubAreas" style="width: 100%">
                <thead>
                    <tr>
                        <th></th>
                        <th><%= Resources.Resource.subArea %></th>
                    </tr>
                </thead>
                <tbody id="tbSubAreas">
                    <tr>
                        <td colspan="2"><%= Resources.Resource.naoHaRegistros %></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <input type="button" id="btnSalvar" value="<%= Resources.Resource.salvar %>" onclick="Salvar()" style="width: 180px" class="btn btn-success" />
        <input type="button" id="btnCancelar" value="<%= Resources.Resource.cancelar %>" onclick="Cancelar()" style="width: 180px" class="btn btn-warning" />
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script type="text/javascript">
        $(function () {
            loadAgenda('');
            GetAgendaHorarios();
            loadArea();
            loadSubareaPesq();
            loadSubArea();
            GetAgendaSubarea();
        });

        function loadArea() {
            $.ajax({
                url: 'Default.aspx/loadArea',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#sleAreaCad").empty();
                    $("#sleAreaCad").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>...'));
                    $.each(data.d, function () {
                        $("#sleAreaCad").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });
        }

        function loadSubareaPesq() {
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/loadSubareaPesq',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
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

        function loadSubArea() {
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/loadSubArea',
                dataType: 'json',
                async: false,
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idArea':'" + $("#sleAreaCad").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbSubAreas").empty();
                    if (data.d.length > 0) {
                        var i = 0;
                        $.each(data.d, function () {
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td style='width:10px'><input id='chk" + i + "' type='checkbox' value='" + this['Value'] + "' /></td>";
                            cols += "<td><label for='chk" + i + "'>" + this['Text'] + "</label></td>";

                            newRow.append(cols);
                            $("#tbSubAreas").append(newRow);
                            i++;
                        });
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='2'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbSubAreas").append(newRow);
                    }
                }
            });
        }

        function loadAgenda() {
            $.ajax({
                url: 'Default.aspx/loadAgenda',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#sleAgendaCad").empty();
                    $("#sleAgendaCad").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>...'));
                    $("#sleAgendaPesq").empty();
                    $("#sleAgendaPesq").append($("<option></option>").val('').html('<%= Resources.Resource.selecione %>...'));

                    $.each(data.d, function () {
                        $("#sleAgendaCad").append($("<option></option>").val(this['Value']).html(this['Text']));
                        $("#sleAgendaPesq").append($("<option></option>").val(this['Value']).html(this['Text']));
                    });
                }
            });
        }

        function GetAgendaHorarios() {
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/GetAgendaHorarios',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idAgenda':'" + $("#sleAgendaCad").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbAgendaHorarios").empty();
                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + lst.Plano + "</td>";
                            cols += "<td>" + lst.HrIni + "</td>";
                            cols += "<td>" + lst.HrFim + "</td>";
                            cols += "<td>" + getDayCultureLanguage(lst.Dia) + "</td>";

                            newRow.append(cols);
                            $("#tbAgendaHorarios").append(newRow);
                        }
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='6'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbAgendaHorarios").append(newRow);
                    }
                }
            });
        }

        function getDayCultureLanguage(dia) {
            var diaSemana = "";

            switch (dia) {
                case "Segunda":
                    diaSemana = "<%= Resources.Resource.segunda %>"
                    break;
                case "Terca":
                    diaSemana = "<%= Resources.Resource.terca %>"
                    break;
                case "Quarta":
                    diaSemana = "<%= Resources.Resource.quarta %>"
                    break;
                case "Quinta":
                    diaSemana = "<%= Resources.Resource.quinta %>"
                    break;
                case "Sexta":
                    diaSemana = "<%= Resources.Resource.sexta %>"
                    break;
                case "Sabado":
                    diaSemana = "<%= Resources.Resource.sabado %>"
                    break;
                case "Domingo":
                    diaSemana = "<%= Resources.Resource.domingo %>"
                    break;
                default:
                    diaSemana = "<%= Resources.Resource.todosOsDias %>"
                    break;
            }
            return diaSemana;
        }

        function Novo() {
            $("#btnSalvar").val("<%= Resources.Resource.salvar %>");
            $("#dvCadastro").css("display", "block");
            $("#dvPesquisa").css("display", "none");
            $("#sleAgendaCad")[0].disabled = false;
            $("#sleAgendaCad").val($("#sleAgendaPesq").val());
            loadArea();
            GetAgendaHorarios();
            loadSubArea();
        }

        function Cancelar() {
            $("#dvCadastro").css("display", "none");
            $("#dvPesquisa").css("display", "block");
        }

        function Salvar() {
            if ($("#sleAgendaCad").val() == "") {
                alert("<%= Resources.Resource.selecioneAgenda %>!");
                $("#sleAgendaCad").focus();
                return;
            }
            if ($("#sleAreaCad").val() == "") {
                alert("<%= Resources.Resource.selecioneArea %>!");
                $("#sleAreaCad").focus();
                return;
            }

            var selSubArea = false;
            var table = $("#tblSubAreas tbody");
            table.find('tr').each(function (i, el) {
                var $tds = $(this).find('td'),
                    chk = $tds[0].firstChild;

                if (chk.checked) {
                    selSubArea = true;
                    $.ajax({
                        url: 'Default.aspx/Salvar',
                        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idArea':'" + $("#sleAreaCad").val() + "','idSubarea':'" + chk.value + "','idAgenda':'" + $("#sleAgendaCad").val() + "','subarea':'" + $tds[1].textContent + "','user':'" + $("#hfUser").val() + "'}",
                        dataType: "json",
                        async: false,
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            if (data.d != "SUCESSO") {
                                alert(data.d);
                                return false;
                            } else {
                                $("#dvPesquisa").css("display", "block");
                                $("#dvCadastro").css("display", "none");
                                GetAgendaSubarea();
                            }
                        }
                    });
                }
                else if ($("#btnSalvar").val() != "<%= Resources.Resource.salvar %>") {
                    $.ajax({
                        url: 'Default.aspx/ExcluirSubAreaAgenda',
                        data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idSubArea':'" + chk.value + "','idAgenda':'" + $("#sleAgendaCad").val() + "','user':'" + $("#hfUser").val() + "'}",
                        dataType: "json",
                        async: false,
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                        }
                    });
                }
            });

            if (selSubArea == false) {
                alert("<%= Resources.Resource.selecioneSubArea %>!");
                  return;
              }
          }

          function GetAgendaSubarea() {
              $.ajax({
                  type: 'POST',
                  url: 'Default.aspx/GetAgendaSubarea',
                  dataType: 'json',
                  data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idAgenda':'" + $("#sleAgendaPesq").val() + "','idSubArea':'" + $("#sleSubArea").val() + "'}",
                  contentType: "application/json; charset=utf-8",
                  success: function (data) {
                      $("#tbAgendaSubArea").empty();
                      if (data.d.length > 0) {
                          for (var i = 0; i < data.d.length; i++) {
                              var lst = data.d[i];
                              var newRow = $("<tr>");
                              var cols = "";
                              cols += "<td>" + lst.Agenda + "</td>";
                              cols += "<td>" + lst.Area + "</td>";
                              cols += "<td>" + lst.SubAreas + "</td>";
                              cols += "<td style='width:120px'><input type=\"button\" style=\"width:150px;\" class=\"btn btn-warning\" value=\"<%= Resources.Resource.editar %>\" onclick=\"Editar(this);\"  data-idArea='" + lst.idArea + "' data-idAgenda='" + lst.idAgenda + "' data-subareas='" + lst.SubAreas + "'/></td>";
                            cols += "<td style='width:120px'><div class=\"btn-group mr-1 mb-1\"><button type=\"button\" style=\"width:125px;\"  class=\"btn btn-danger btn-min-width dropdown-toggle\" data-toggle=\"dropdown\">" +
                                "<%= Resources.Resource.excluir %> </button> <div class='dropdown-menu' x-placement='bottom-start' style='position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 40px, 0px); '>" +
                                "<a href=\"#\" class='dropdown-item' onclick='Excluir(" + lst.idArea + "," + lst.idAgenda + ")'  data-subareas='" + lst.SubAreas + "'><%= Resources.Resource.sim %></a></div></div></td>";
                            newRow.append(cols);
                            $("#tbAgendaSubArea").append(newRow);
                        }
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='6'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbAgendaSubArea").append(newRow);
                    }
                }
            });
          }

          function Editar(btn) {
              $("#sleAgendaCad")[0].disabled = true;
              $("#sleAgendaCad").val(btn.dataset.idagenda);
              GetAgendaHorarios();
              $("#sleAreaCad").val(btn.dataset.idarea);
              loadSubArea();
              $("#dvCadastro").css("display", "block");
              $("#dvPesquisa").css("display", "none");
              $("#btnSalvar").val("<%= Resources.Resource.salvarAlteracoes %>");

              var table = $("#tblSubAreas tbody");
              table.find('tr').each(function (i, el) {
                  var $tds = $(this).find('td'),
                      chk = $tds[0].firstChild,
                      subarea = $tds[1].innerText;
                  if (btn.dataset.subareas.replace(",", " ").includes(subarea)) {
                      chk.checked = true;
                  }
              });
          }

          function Excluir(idArea, idAgenda) {
              $.ajax({
                  url: 'Default.aspx/Delete',
                  data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idArea':'" + idArea + "','idAgenda':'" + idAgenda + "'}",
                  dataType: "json",
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  success: function (data) {
                      GetAgendaSubarea();
                  }
              });
          }

    </script>
</asp:Content>
