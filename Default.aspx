<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /*CHECKBOX*/
        input[type=checkbox].dias {
            display: block;
            margin: 0.2em;
            cursor: pointer;
            padding: 0.2em;
            opacity: 0;
            width: 18px;
            height: 18px;
            position: absolute;
        }

            input[type=checkbox].dias + label:before {
                content: "\2714";
                border: 0.1em solid #464953;
                border-radius: 0.2em;
                display: inline-block;
                width: 18px;
                height: 18px;
                font-size: small;
                padding-left: 0.2em;
                padding-bottom: 1.2em;
                margin-right: 0.2em;
                vertical-align: bottom;
                color: transparent;
                transition: .2s;
            }


            input[type=checkbox].dias:checked + label:before {
                background-color: #5c5c5d;
                border-color: #5c5c5d;
                color: #fff;
            }

            input[type=checkbox].dias:disabled + label:before {
                transform: scale(1);
                border-color: #aaa;
            }

            input[type=checkbox].dias:checked:disabled + label:before {
                transform: scale(1);
                background-color: #bfb;
                border-color: #bfb;
            }

        @media (max-width: 3044px) {
            .proporcao {
                display: table;
            }

            .normal {
                width: 30%;
                float: left;
            }

            .subtensao {
                width: 30%;
                float: left;
            }

            .intermitente {
                width: 30%;
                float: left;
            }

            .faltaEnergia {
                width: 30%;
                float: left;
            }

            .apagado {
                width: 30%;
                float: left;
            }

            .estacionado {
                width: 30%;
                float: left;
            }

            .imposicao {
                width: 30%;
                float: left;
            }

            .semComunicacao {
                width: 30%;
                float: left;
            }

            .botao {
                float: right;
            }

            .col-lg-4 col-md-6 col-sm-12 responsive {
                flex: 50% !important;
                max-width: 50% !important;
            }
        }

        @media (max-width: 1440px) {
            .proporcao {
                display: table;
            }

            .normal {
                width: 100%;
                float: left;
            }

            .subtensao {
                width: 100%;
                float: left;
            }

            .intermitente {
                width: 100%;
                float: left;
            }

            .faltaEnergia {
                width: 100%;
                float: left;
            }

            .apagado {
                width: 100%;
                float: left;
            }

            .estacionado {
                width: 100%;
                float: none;
            }

            .imposicao {
                width: 100%;
                float: none;
            }

            .semComunicacao {
                width: 100%;
                float: none;
            }

            .botao {
                width: 100%;
                float: none;
            }

            .col-lg-4 col-md-6 col-sm-12 responsive {
                flex: 100% !important;
                max-width: 100% !important;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.inicio%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent2" runat="server">
    <input type="checkbox" id="chkAtualizacaoAutom" class="dias" onclick="AtualizacaoAutom(this)" checked="checked" />
    <label style="color: white; font-size: medium;"><%= Resources.Resource.atualizacaoAutomatica%></label>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hfUser" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfIdPrefeitura" ClientIDMode="Static" runat="server" />
    <div class="cardAnimation">
        <div class="row">

            <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%">
                <div class="card box-shadow-0" data-appear="appear">
                    <div class="card-header white bg-info">
                        <h4 class="card-title white"><%= Resources.Resource.intersecoes %>  </h4>
                        <a class="heading-elements-toggle"><i class="la la-ellipsis font-medium-3"></i></a>
                        <div class="heading-elements">
                            <ul class="list-inline mb-0">
                                <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                                <li><a onclick="GetControladores()"><i class="ft-rotate-cw"></i></a></li>
                                <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="card-content collapse show">
                        <div class="card-body border-bottom-info" <%--style="border-bottom: 2px solid #f2f222 !important;"--%>>
                            <div class="btn-group" style="width: 100%; padding-bottom: 10px;">
                                <span style="margin-right: 10px; margin-top: 3px">Id/Cruzamento:</span>
                                <input class="form-control input-sm" placeholder="<%= Resources.Resource.pesquisar %>..." onkeyup="FiltrarControladores()" id="txtEqpListaCtrl" />
                                <%--<button type="button" class="btn btn-secondary btn-sm" onclick="GetControladores();"><i class="ficon ft-search"></i></button>--%>
                            </div>
                            <div class="proporcao" style="width: 100%; padding-bottom: 10px; font-size: small">
                                <div class="normal">
                                    <input type="checkbox" id="chkNormal" class="dias" onclick="FiltrarControladores()" value="TodoDia" checked="checked" />
                                    <label id="lblNormal"><%= Resources.Resource.normal%> &nbsp</label>
                                </div>
                                <div class="intermitente">
                                    <input type="checkbox" id="chkAmareloIntermitente" class="dias" onclick="FiltrarControladores()" checked="checked" />
                                    <label id="lblAmareloIntermitente"><%= Resources.Resource.amareloIntermitente%> &nbsp</label>
                                </div>
                                <div class="subtensao">
                                    <input type="checkbox" id="chkSubtensao" class="dias" onclick="FiltrarControladores()" checked="checked" />
                                    <label id="lblSubtensao"><%= Resources.Resource.subtensao%> &nbsp</label>
                                </div>
                                <div class="apagado">
                                    <input type="checkbox" id="chkApagado" class="dias" onclick="FiltrarControladores()" checked="checked" />
                                    <label id="lblApagado"><%= Resources.Resource.apagado%> &nbsp /<%= Resources.Resource.desligado%> </label>
                                </div>
                                <div class="faltaEnergia">
                                    <input type="checkbox" id="chkFaltaEnergia" class="dias" onclick="FiltrarControladores()" checked="checked" />
                                    <label id="lblFaltaEnergia"><%= Resources.Resource.faltaEnergia%> &nbsp</label>
                                </div>
                                <div class="estacionado">
                                    <input type="checkbox" id="chkEstacionado" class="dias" onclick="FiltrarControladores()" checked="checked" />
                                    <label id="lblEstacionado"><%= Resources.Resource.semaforoEstacionado%> &nbsp</label>
                                </div>
                                <div class="imposicao">
                                    <input type="checkbox" id="chkImposicao" class="dias" onclick="FiltrarControladores()" checked="checked" />
                                    <label id="lblImposicao"><%= Resources.Resource.imposicaoPlano%> &nbsp</label>
                                </div>
                                <div class="semComunicacao">
                                    <input type="checkbox" id="chkSemComunicacao" class="dias" onclick="FiltrarControladores()" checked="checked" />
                                    <label id="lblSemComunicacao"><%= Resources.Resource.semComunicacao%> &nbsp</label>
                                </div>
                                <div class="btn-group botao">
                                    <button onclick="Reset()" id="btnReset" disabled style='min-width: 0px; margin: 0px; padding: 0.15rem 0.65rem; font-size: smaller;' class='btn btn-info'>
                                        <%= Resources.Resource.reset%></button>
                                    <div class="btn-group" role="group">
                                        <button id="btnAmarelo" disabled type="button" style='min-width: 0px; margin: 0px; padding: 0.15rem 0.65rem; font-size: smaller;' class='btn btn-warning' data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <%= Resources.Resource.amareloIntermitente%>
                                        </button>
                                        <div class="dropdown-menu" aria-labelledby="btnAmarelo">
                                            <a class="dropdown-item" href="#"><%= Resources.Resource.tempo%> (<%= Resources.Resource.minutos%>)</a>
                                            <a class="dropdown-item" href="#">
                                                <input type="number" id="txtMinAmarelo" class="form-control input-sm" /></a>
                                            <a class="dropdown-item" href="#">
                                                <input type="button" id="btnImporAmarelo" onclick="ImporAmarelo()" style='min-width: 0px; margin: 0px; padding: 0.55rem 2.65rem; font-size: smaller;' class="btn btn-success" value="<%= Resources.Resource.impor%>" /></a>
                                        </div>

                                    </div>
                                    <div class="btn-group" role="group">
                                        <button id="btnApagado" disabled data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style='min-width: 0px; margin: 0px; padding: 0.15rem 0.65rem; font-size: smaller;' class='btn btn-light'>
                                            <%= Resources.Resource.apagado%>/<%= Resources.Resource.desligado%></button>

                                        <div class="dropdown-menu" aria-labelledby="btnApagado">
                                            <a class="dropdown-item" href="#"><%= Resources.Resource.tempo%> (<%= Resources.Resource.minutos%>)</a>
                                            <a class="dropdown-item" href="#">
                                                <input type="number" id="txtMinApagado" class="form-control input-sm" /></a>
                                            <a class="dropdown-item" href="#">
                                                <input type="button" onclick="ImporApagado()" id="btnImporApagado" style='min-width: 0px; margin: 0px; padding: 0.55rem 2.65rem; font-size: smaller;' class="btn btn-success" value="<%= Resources.Resource.impor%>" /></a>
                                        </div>
                                    </div>

                                    <button onclick="cancelarImposicao()" id="btnCancelarImposicao" style='display: none; min-width: 0px; margin: 0px; padding: 0.15rem 0.65rem; font-size: smaller;' class='btn btn-danger'>
                                        <%= Resources.Resource.cancelar%>  <%= Resources.Resource.imposicao%></button>
                                </div>
                            </div>
                            <div class="table-responsive" id="dvControladores">
                                <table class="table table-bordered" style="font-size: small;" id="tblControladores">
                                    <thead>
                                        <tr>
                                            <th style="width: 75%;"><%=Resources.Resource.intersecao%></th>
                                            <th style="width: 25%;"><%= Resources.Resource.status%>
                                            </th>
                                            <th>
                                                <%= Resources.Resource.data%>/<%= Resources.Resource.hora%></th>
                                            <th></th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbControladores"></tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6 col-sm-12" id="dvTarefasPendentes">
                <div class="card box-shadow-0" data-appear="appear">
                    <div class="card-header white bg-success" style="background-color: #11cf77 !important;">
                        <h4 class="card-title white"><%= Resources.Resource.tarefas %> <%= Resources.Resource.pendente %></h4>
                        <a class="heading-elements-toggle"><i class="la la-ellipsis font-medium-3"></i></a>
                        <div class="heading-elements">
                            <ul class="list-inline mb-0">
                                <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                                <li><a onclick="GetTarefasPendentes()"><i class="ft-rotate-cw"></i></a></li>
                                <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="card-content collapse show">
                        <div class="card-body border-bottom-success">
                            <div class="table-responsive" id="dvTarefas">
                                <table class="table table-bordered" style="font-size: smaller;">
                                    <thead>
                                        <tr>
                                            <th>Eqp</th>
                                            <th><%= Resources.Resource.tarefas %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbTarefasPendentes"></tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-12" id="dvLog">
                <div class="card box-shadow-0" data-appear="appear">
                    <div class="card-header white bg-blue-grey" <%--style="background-color: #ff453c !important;"--%>>
                        <h4 class="card-title white"><%= Resources.Resource.logs %></h4>
                        <a class="heading-elements-toggle"><i class="la la-ellipsis font-medium-3"></i></a>
                        <div class="heading-elements">
                            <ul class="list-inline mb-0">
                                <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                                <li><a onclick="GetLogs()"><i class="ft-rotate-cw"></i></a></li>
                                <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="card-content collapse show">
                        <div class="card-body border-bottom-blue-grey">
                            <div class="btn-group" style="width: 100%; padding-bottom: 10px;">
                                <span style="/* margin: 10px; */margin-top: 3px; margin-right: 10px;">Id:</span>
                                <input class="form-control input-sm" placeholder="<%= Resources.Resource.pesquisar %>..." id="txtIdEqpLogs" />
                                <button type="button" class="btn btn-secondary btn-sm" onclick="GetLogs();"><i class="ficon ft-search"></i></button>
                            </div>
                            <div class="table-responsive" id="dvLogs">
                                <table class="table table-bordered" style="font-size: smaller;">
                                    <thead>
                                        <tr>
                                            <th>Id</th>
                                            <th><%= Resources.Resource.descricao %></th>
                                            <th><%= Resources.Resource.data %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbLogs"></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <br />
            <div class="col-lg-4 col-md-6 col-sm-12" style="flex: 100%; max-width: 100%">
                <div class="card box-shadow-0" data-appear="appear" data-animation="fadeInDown">
                    <div class="card-header white bg-primary white" id="dvTituloCorredor" <%--style="background-color: #ff453c !important;"--%>>
                        <h4 class="card-title white"><%= Resources.Resource.corredor %></h4>
                    </div>
                    <div class="card-content collapse show">
                        <div class="card-body border-bottom-primary white">
                            <div class="btn-group" style="width: 100%; padding-bottom: 10px;">
                                <span style="margin-right: 10px; margin-top: 3px;">Id:</span>
                                <input class="form-control input-sm" placeholder="<%= Resources.Resource.pesquisar %>..." id="" />
                            </div>
                            <div class="table-responsive" id="dvCorredor">
                                <table class="table table-bordered" style="font-size: smaller;">
                                    <tbody id="tbCorredor"></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div id="modalImposicao" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="border-bottom: 1px solid #e9ecef;">
                    <h4 class="modal-title">
                        <%= Resources.Resource.imposicaoPlano %></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <%= Resources.Resource.minutos %>:
                    <p style="border-bottom: 1px solid #d4d4d4; height: 40px;">
                        <input id="txtTempoImposicao" type="number" class="form-control" value="1" min="1" />
                    </p>
                    <hr />
                    <div id="divScrool" style="height: 250px; overflow: auto;">
                        <table id="tblPlanos" class="table table-bordered" style="font-size: 11px;">
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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <script>
        var html_titulo = $('#liTitulo').html();

        function PosicionarDiv() {
            var larguraPagina = window.innerWidth;
            if (larguraPagina < 817) {
                $('#dvTarefasPendentes').css('max-width', '100%');
                $('#dvTarefasPendentes').css('flex', '100%');
                $('#dvLog').css('max-width', '100%');
                $('#dvLog').css('flex', '100%');

            }
            else {
                $('#dvTarefasPendentes').css('max-width', '50%');
                $('#dvTarefasPendentes').css('flex', '50%');
                $('#dvLog').css('max-width', '50%');
                $('#dvLog').css('flex', '50%');
            }

            $('body').css('padding-top', navMenu);
        }

        PosicionarDiv();

        // Update manual scroller when window is resized
        $(window).resize(function () {
            $.app.menu.manualScroller.updateHeight();
            if ($.app.menu.expanded == false)
                PosicionarDiv();
        });
        var globalResources, timerAll;
        function loadResourcesLocales() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: 'Default.aspx/requestResource',
                async: false,
                dataType: "json",
                success: function (data) {
                    globalResources = JSON.parse(data.d);
                }
            });
        }

        function getResourceItem(name) {
            if (globalResources != undefined) {
                for (var i = 0; i < globalResources.resource.length; i++) {
                    if (globalResources.resource[i].name === name) {
                        return globalResources.resource[i].value;
                    }
                }
            }
        }
        $(function () {
            loadResourcesLocales();
            GetControladores(); GetTarefasPendentes(); GetLogs();
            timerAll = setInterval(function () { GetControladores(); GetTarefasPendentes(); GetLogs(); }, 40000);

            //$("#dvTituloCorredor").css({
            //    width: (window.innerWidth - 180)
            //});
            $("#dvCorredor").css({
                width: (window.innerWidth - 130)
            });

            $("#dvTarefas").css({
                height: (window.innerHeight - 184)
            });
            $("#dvLogs").css({
                height: (window.innerHeight - 227)
            });
            $("#dvControladores").css({
                height: (window.innerHeight - 250)
            });
        });
        function AtualizacaoAutom(chk) {
            if (chk.checked) {
                timerAll = setInterval(function () { GetControladores(); GetTarefasPendentes(); GetLogs(); }, 40000);
            }
            else {
                clearInterval(timerAll);
            }
        }
        function GetControladores() {
            var qtdNormal = 0, qtdAmareloInter = 0, qtdApagado = 0, qtdImposicao = 0, qtdFaltaEnergia = 0, qtdSemComunicacao = 0, qtdSubtensao = 0, qtdEstacionado = 0;
            $("#btnAmarelo")[0].disabled = true;
            $("#btnApagado")[0].disabled = true;
            $("#btnReset")[0].disabled = true;
            $("#btnCancelarImposicao").css("display", "none");

            $("#divLoading").css("display", "");
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/getControladores',
                dataType: 'json',
                data: "{'idPrefeitura':'" + $("#hfIdPrefeitura").val() + "','idEqp':''}",//" + $("#txtEqpListaCtrl").val() + "
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbControladores").empty();

                    if (data.d.length > 0) {
                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i]; var verificaFalhas;
                            var obs = data.d[i].Observacao;
                            if (lst.Status == "" || lst.DtHr == "" || lst.StatusComunicacao == "False")
                                verificaFalhas = new VerificaFalhas("", "CarregaFalha", "");
                            else {
                                var bitsFalha = parseInt(lst.Status).toString(2);
                                verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaFalha", "");
                            }
                            var newRow = $("<tr>");
                            var cols = "";

                            if (verificaFalhas.falhas == "semComunicacao") {
                                cols += "<td>" + lst.idEqp + " - " + lst.Cruzamento;
                                if (lst.serialMestre != "") {
                                    cols += "</br> <b>"+getResourceItem("controlador") + " " + getResourceItem("mestre")+": " + lst.serialMestre + "</b>";
                                }
                                cols += "</td>";
                            }
                            else {
                                cols += "<td>" + lst.idEqp + " - " + lst.Cruzamento + "</br><i class='ft-battery-charging' style='font-size: 18px !important;' />&nbsp&nbsp" + lst.Tensao + "&nbsp&nbsp&nbsp<i class='ft-thermometer' style='font-size: 18px !important;'></i>&nbsp" + lst.Temperatura + "</br><i class='ft-activity' style='font-size: 18px !important;'></i>&nbsp&nbsp" + lst.Estado + "";
                                if (lst.serialMestre != "") {
                                    cols += "</br> <b>" + getResourceItem("controlador") + " " + getResourceItem("mestre") + ": "  + lst.serialMestre + "</b>";
                                }
                                cols += "</td>";
                            }

                            cols += "<td style='padding-bottom: 0px;padding-right: 0px;'>";
                            if (verificaFalhas.falhas == "Normal") {
                                qtdNormal++;
                                cols += "<span class='badge badge-success' style='font-size:small;width:130px;'>Em operação</span></br>";
                                if (lst.Plano != "") {
                                    cols += "</br><label style='font-size:small;'>" + lst.Plano + "</label></br>";
                                }
                            }

                            if (verificaFalhas.falhas.includes("Imposicao")) {
                                qtdImposicao++;
                                cols += "<span class='badge badge-danger' style='font-size:small;width:130px;'>" + getResourceItem("imposicaoPlano") + "</span></br>";
                            }

                            if (verificaFalhas.falhas.includes("Falta")) {
                                qtdFaltaEnergia++;
                                cols += "<span class='badge badge-warning' style='font-size:small;width:130px;'>" + getResourceItem("faltaEnergia") + "</span></br>";
                            }

                            if (verificaFalhas.falhas.includes("Apagado")) {
                                qtdApagado++;
                                cols += "<span class='badge badge-danger' style='font-size:small;width:130px;'>" + getResourceItem("apagado") + "/" + getResourceItem("desligado") + "</span></br>";
                            }

                            if (verificaFalhas.falhas.includes("Amarelo")) {
                                qtdAmareloInter++;
                                cols += "<span class='badge badge-danger' style='font-size:small;width:130px;'>" + getResourceItem("amareloIntermitente") + "</span></br>";
                            }

                            if (verificaFalhas.falhas.includes("Subtensao")) {
                                qtdSubtensao++;
                                cols += "<span class='badge badge-danger' style='font-size:small;width:130px;'>" + getResourceItem("subtensao") + "</span></br>";
                            }

                            if (verificaFalhas.falhas.includes("Estacionado")) {
                                qtdEstacionado++;
                                cols += "<span class='badge badge-danger' style='font-size:small;width:130px;'>Estacionado</span></br>";
                            }

                            if (verificaFalhas.falhas == "semComunicacao") {
                                qtdSemComunicacao++;
                                cols += "<span class='badge badge-danger' style='font-size:small;background-color: gray;width:130px;' >" + getResourceItem("semComunicacao") + "</span></br>";
                            }

                            cols += "</br><label style='font-size:small;'>" + obs + "</label>";
                            cols += "<td style='padding-bottom: 0px;padding-right: 0px;'><label>" + lst.DtHr + "</label></td>";

                            //cols += "<td style='padding-bottom: 0px;padding-right: 0px;'><input type='checkbox' id='chk" + i + "' class='dias' onclick='GetControladores()' /> <label>a</label></td>";
                            cols += "<td style='padding: 0px;padding-top: 2%;'><div class='icheckbox_flat' id='dvChk" + i + "' style='margin-left:38%'><input type='checkbox' data-ideqp='" + lst.idEqp + "' style='opacity:0; width:20px; height:20px; cursor:pointer' onclick='onCheck(this," + i + ")' id='chk" + i + "'>"
                                + "<ins class='iCheck-helper' style='position: absolute; top: 0 %; left: 0 %; display: block; width: 100 %; height: 100 %; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;'></ins></div > ";

                            // class='btn-group-vertical'
                            cols += "<td style=''><div class='btn-group'><button class='btn btn-outline-secondary' onclick='Agenda(this)' data-id='" + lst.idEqp + "' title='" + getResourceItem("agenda") + "' style='padding:10px;'><i class='la la-calendar'></i></button><br/>" +
                                "<button class='btn btn-outline-secondary' onclick='GruposSemaforicos(this)' data-id='" + lst.idEqp + "' style='padding:10px;' title='" + getResourceItem("gruposSemaforicos") + "'><i class='ft-more-vertical'> </i></button>" +
                                "<button class='btn btn-outline-secondary' onclick='ImposicaoPlano(this)' data-id='" + lst.idEqp + "' style='padding:10px; border-left: none;' title='" + getResourceItem("imposicaoPlano") + "'><i class='ft-zap'> </i></button></div ></td > ";
                            newRow.append(cols);
                            $("#tbControladores").append(newRow);
                        }
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='5' style='border-collapse: collapse; padding: 5px;'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbControladores").append(newRow);
                    }
                    $("#lblNormal")[0].innerText = (getResourceItem("normal") + " - " + qtdNormal);
                    $("#lblAmareloIntermitente")[0].innerText = (getResourceItem("amareloIntermitente") + " - " + qtdAmareloInter);
                    $("#lblApagado")[0].innerText = (getResourceItem("apagado") + "/" + getResourceItem("desligado") + " - " + qtdApagado);
                    $("#lblEstacionado")[0].innerText = ("Estacionado - " + qtdEstacionado);
                    $("#lblSubtensao")[0].innerText = (getResourceItem("subtensao") + " - " + qtdSubtensao);
                    $("#lblImposicao")[0].innerText = (getResourceItem("imposicaoPlano") + " - " + qtdImposicao);
                    $("#lblSemComunicacao")[0].innerText = (getResourceItem("semComunicacao") + " - " + qtdSemComunicacao);
                    $("#lblFaltaEnergia")[0].innerText = (getResourceItem("faltaEnergia") + " - " + qtdFaltaEnergia);
                    $("#divLoading").css("display", "none");
                    FiltrarControladores();
                }
            });
        }
        function onCheck(chk, i) {
            if (chk.checked) {
                $("#dvChk" + i).removeClass("icheckbox_flat");
                $("#dvChk" + i).addClass("icheckbox_flat checked");
            }
            else {
                $("#dvChk" + i).removeClass("icheckbox_flat checked");
                $("#dvChk" + i).addClass("icheckbox_flat");
            }

            var input, filter, table, tr, td, i;
            table = document.getElementById("tblControladores");
            tr = table.getElementsByTagName("tr");

            var selecionado = false; var imposicao = false;
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[3];
                tdStatus = tr[i].getElementsByTagName("td")[1];

                if (td) {
                    var chk = td.childNodes[0].childNodes[0];
                    if (chk.checked == true) {
                        selecionado = true;
                        if (tdStatus.innerHTML.toUpperCase().includes(getResourceItem("imposicao").toUpperCase()))
                            imposicao = true;
                        else
                            imposicao = false;
                    }
                }
            }

            if (selecionado == false) {
                $("#btnAmarelo")[0].disabled = true;
                $("#btnApagado")[0].disabled = true;
                $("#btnReset")[0].disabled = true;
            }
            else {
                $("#btnAmarelo")[0].disabled = false;
                $("#btnApagado")[0].disabled = false;
                $("#btnReset")[0].disabled = false;
            }

            if (imposicao)
                $("#btnCancelarImposicao").css("display", "");
            else
                $("#btnCancelarImposicao").css("display", "none");
        }
        function VerificaFalhas(bitsFalha, callName, status) {

            this.statusFalha = "";
            this.falhas = "";

            if (bitsFalha == "")
                this.falhas = "semComunicacao";
            else if (bitsFalha == 0) {
                if (callName == "CarregaPonto") {
                    this.statusFalha = "Normal";
                    falhas = "N";
                }
                else if (callName == "CarregaFalha") {
                    this.falhas = "Normal";
                }
            }
            else {
                if (callName == "CarregaPonto") {
                    this.statusFalha = "Falha";
                    qtdFalhas++;
                }

                bitsFalha = bitsFalha.split('').reverse().join('');
                for (var positionBit = 0; positionBit < bitsFalha.length; positionBit++) {
                    //Falta de Energia
                    if (positionBit == 0 && bitsFalha[positionBit] == "1") {

                        if (callName == "CarregaPonto") {
                            falhas = "F";
                        }

                        else if (callName == "CarregaFalha") {
                            this.falhas = "Falta de Energia";
                        }
                    }

                    //Subtensao
                    if (positionBit == 1 && bitsFalha[positionBit] == "1") {

                        if (callName == "CarregaPonto") {
                            if (falhas == "") {
                                falhas = "S";
                            }
                            else {
                                falhas += ",S"
                            }
                        }
                        if (callName == "CarregaFalha") {
                            if (this.falhas == "") {
                                this.falhas = "Subtensao";
                            }
                            else {
                                this.falhas += ",Subtensao";
                            }
                        }
                    }

                    //Apagado/Desligado
                    if (positionBit == 2 && bitsFalha[positionBit] == "1") {
                        if (callName == "CarregaPonto") {
                            if (falhas == "") {
                                falhas = "D";
                            }
                            else {
                                falhas += ",D"
                            }
                        }
                        if (callName == "CarregaFalha") {
                            if (this.falhas == "") {
                                this.falhas = "Apagado/Desligado";
                            }
                            else {
                                this.falhas += ",Apagado/Desligado";
                            }
                        }
                    }

                    //Amarelo intermitente
                    if (positionBit == 3 && bitsFalha[positionBit] == "1") {
                        if (callName == "CarregaPonto") {
                            if (falhas == "") {
                                falhas = "A";
                            }
                            else {
                                falhas += ",A"
                            }
                        }
                        if (callName == "CarregaFalha") {
                            if (this.falhas == "") {
                                this.falhas += "Amarelo intermitente";
                            }
                            else {
                                this.falhas += ",Amarelo intermitente";
                            }
                        }
                    }

                    //Estacionado
                    if (positionBit == 4 && bitsFalha[positionBit] == "1") {
                        if (callName == "CarregaPonto") {
                            if (falhas == "") {
                                falhas = "E";
                            }
                            else {
                                falhas += ",E";
                            }
                        }
                        if (callName == "CarregaFalha") {
                            if (this.falhas == "") {
                                this.falhas += "Estacionado";
                            }
                            else {
                                this.falhas += ",Estacionado";
                            }
                        }
                    }

                    //Plug Manual
                    if (positionBit == 5 && bitsFalha[positionBit] == "1") {
                        this.falhas = "Plug";
                    }

                    //Imposicao Plano
                    if (positionBit == 6 && bitsFalha[positionBit] == "1") {
                        this.falhas = "Imposicao"
                    }
                }
            }
        }

        function GetTarefasPendentes() {
            $("#tbTarefasPendentes").empty();

            $("#btnAmarelo")[0].disabled = true;
            $("#btnApagado")[0].disabled = true;
            $("#btnReset")[0].disabled = true;
            $("#btnCancelarImposicao").css("display", "none");
            $.ajax({
                type: 'POST',
                url: "Default.aspx/getTarefasPendentes",
                dataType: 'json',
                data: "",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (data.d != "") {
                        $.each(data.d, function (index, item) {
                            var TarefasPendentes = [];
                            var binary1 = (item.Byte1 >>> 0).toString(2);
                            var binary2 = (item.Byte2 >>> 0).toString(2);

                            var pad = "00000000";
                            binary1 = (pad.substring(0, pad.length - binary1.length) + binary1).split('').reverse();
                            binary2 = (pad.substring(0, pad.length - binary2.length) + binary2).split('').reverse();

                            if (binary1 == "0,0,0,0,0,0,0,0" && binary2 == "0,0,0,0,0,0,0,0") return true;

                            if (binary1[0] == "1") TarefasPendentes.push("* " + getResourceItem("reset"));
                            if (binary1[1] == "1") TarefasPendentes.push("* " + getResourceItem("imposicao"));
                            if (binary1[2] == "1") TarefasPendentes.push("* " + getResourceItem("cancelamento") + " " + getResourceItem("imposicao"));
                            if (binary1[3] == "1") TarefasPendentes.push("* " + getResourceItem("envio") + " " + getResourceItem("planos"));
                            if (binary1[4] == "1") TarefasPendentes.push("* " + getResourceItem("envio") + " " + getResourceItem("agenda"));
                            if (binary1[5] == "1") TarefasPendentes.push("*  " + getResourceItem("envio") + " " + getResourceItem("horarioVerao"));
                            if (binary1[6] == "1") TarefasPendentes.push("* " + getResourceItem("solicitacao") + " " + getResourceItem("imagem"));
                            if (binary1[7] == "1") TarefasPendentes.push("* " + getResourceItem("imposicao") + " " + getResourceItem("modoOperacional"));

                            if (binary2[0] == "1") TarefasPendentes.push("* " + getResourceItem("reset") + " " + getResourceItem("anel") + " 1");
                            if (binary2[1] == "1") TarefasPendentes.push("* " + getResourceItem("reset") + " " + getResourceItem("anel") + " 2");
                            if (binary2[2] == "1") TarefasPendentes.push("* " + getResourceItem("reset") + " " + getResourceItem("anel") + " 3");
                            if (binary2[3] == "1") TarefasPendentes.push("* " + getResourceItem("reset") + " " + getResourceItem("anel") + " 4");

                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td>" + item.IdControlador + "</td>";
                            cols += "<td>" + TarefasPendentes.toString().replace(",", "; ") + "</td>";

                            newRow.append(cols);
                            $("#tbTarefasPendentes").append(newRow);
                        });
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='5'>" + getResourceItem("naoHaRegistros") + "</td>";

                        newRow.append(cols);
                        $("#tbTarefasPendentes").append(newRow);
                    }
                    $("#divLoading").css("display", "none");
                },
                error: function (data) {
                    $("#divLoading").css("display", "none");
                }
            });
        }
        function GetLogs() {
            $("#btnAmarelo")[0].disabled = true;
            $("#btnApagado")[0].disabled = true;
            $("#btnReset")[0].disabled = true;
            $("#btnCancelarImposicao").css("display", "none");
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/GetLogs',
                dataType: 'json',
                data: "{'idEqp':'" + $("#txtIdEqpLogs").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbLogs").empty();
                    if (data.d != "") {
                        $.each(data.d, function (index, item) {
                            var newRow = $("<tr>");
                            var cols = "";

                            cols += "<td>" + item.idEqp + "</td>";
                            if (item.Dsc.length > 4) {
                                cols += "<td>" + item.Dsc + "</td>";
                            } else {
                                try {
                                    var bitsFalha = parseInt(item.Dsc).toString(2);
                                    var verificaFalhas = new VerificaFalhas(bitsFalha, "CarregaFalha", "");

                                    cols += "<td>" + verificaFalhas.falhas + "</td>";
                                } catch (err) {
                                    cols += "<td>" + item.Dsc + "</td>";
                                }
                            }
                            cols += "<td>" + item.dataHora + "</td>";
                            newRow.append(cols);
                            $("#tbLogs").append(newRow);
                        });
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += "<td colspan='4'>" + getResourceItem("naoHaRegistros") + "</td >";
                        newRow.append(cols);
                        $("#tbLogs").append(newRow);
                    }
                }
            });
        }


        function FiltrarControladores() {
            var input, filter, table, tr, td, i;
            table = document.getElementById("tblControladores");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[1];
                tdEqp = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    var status = td.innerHTML;
                    var eqp = tdEqp.innerHTML;

                    if (status.includes("Em operação") && $("#chkNormal")[0].checked) {
                        tr[i].style.display = "";
                    }
                    else if (status.includes("Em operação") && $("#chkNormal")[0].checked == false) {
                        tr[i].style.display = "none";
                    }

                    if (status.includes(getResourceItem("apagado")) && $("#chkApagado")[0].checked) {
                        tr[i].style.display = "";

                    }
                    else if (status.includes(getResourceItem("apagado")) && $("#chkApagado")[0].checked == false) {
                        tr[i].style.display = "none";
                    }

                    if (status.includes(getResourceItem("subtensao")) && $("#chkSubtensao")[0].checked) {
                        tr[i].style.display = "";

                    }
                    else if (status.includes(getResourceItem("subtensao")) && $("#chkSubtensao")[0].checked == false) {
                        tr[i].style.display = "none";
                    }

                    if (status.includes(getResourceItem("imposicaoPlano")) && $("#chkImposicao")[0].checked) {
                        tr[i].style.display = "";

                    }
                    else if (status.includes(getResourceItem("imposicaoPlano")) && $("#chkImposicao")[0].checked == false) {
                        tr[i].style.display = "none";
                    }

                    if (status.includes(getResourceItem("faltaEnergia")) && $("#chkFaltaEnergia")[0].checked) {
                        tr[i].style.display = "";

                    }
                    else if (status.includes(getResourceItem("faltaEnergia")) && $("#chkFaltaEnergia")[0].checked == false) {
                        tr[i].style.display = "none";
                    }

                    if (status.includes(getResourceItem("amareloIntermitente")) && $("#chkAmareloIntermitente")[0].checked) {
                        tr[i].style.display = "";

                    }
                    else if (status.includes(getResourceItem("amareloIntermitente")) && $("#chkAmareloIntermitente")[0].checked == false) {
                        tr[i].style.display = "none";
                    }

                    if (status.includes(getResourceItem("semComunicacao")) && $("#chkSemComunicacao")[0].checked) {
                        tr[i].style.display = "";

                    }
                    else if (status.includes(getResourceItem("semComunicacao")) && $("#chkSemComunicacao")[0].checked == false) {
                        tr[i].style.display = "none";
                    }

                    if (eqp.toUpperCase().includes($("#txtEqpListaCtrl").val().toUpperCase()) && $("#txtEqpListaCtrl").val() != "")
                        tr[i].style.display = "";
                    else if ($("#txtEqpListaCtrl").val() != "")
                        tr[i].style.display = "none";

                }
            }
        }

        function Agenda(btn) {
            window.open("Controlador/Agenda.aspx?idEqp=" + btn.dataset.id);
        }

        function GruposSemaforicos(btn) {
            window.open("Controlador/GruposSemaforicos.aspx?idEqp=" + btn.dataset.id);
        }

        function Reset() {
            var input, filter, table, tr, td, i;
            table = document.getElementById("tblControladores");
            tr = table.getElementsByTagName("tr");

            var idEqp = "";
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[3];
                if (td) {
                    var chk = td.childNodes[0].childNodes[0];
                    if (chk.checked == true) {
                        if (idEqp == "") {
                            idEqp = chk.dataset.ideqp;
                        } else {
                            idEqp += "," + chk.dataset.ideqp;
                        }
                    }
                }
            }


            var idPonto = $("#lblIdPonto").text().replace(getResourceItem("idPonto") + ": ", "");

            Swal.fire({
                title: getResourceItem("desejaRestarEqp"),
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("sim")
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        type: 'POST',
                        url: "Default.aspx/ResetaControlador",
                        dataType: 'json',
                        data: "{'idPonto':'" + idEqp + "','user':'" + $("#hfUser").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            $("#popupConfirmResetarControl").modal("hide");

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("sucesso") + '!',
                                text: getResourceItem("reset") + ' ' + getResourceItem("solicitado") + '.',
                            });
                            GetControladores();
                            GetTarefasPendentes();
                        },
                        error: function (data) {
                            window.location.reload(true);
                        }
                    });

                }
            });
        }

        function ImporAmarelo() {
            if ($("#txtMinAmarelo").val() == "" || $("#txtMinAmarelo").val() == "0") {

                $("#txtMinAmarelo").css("border-color", "#ff0000");
                $("#txtMinAmarelo").css("outline", "0");
                $("#txtMinAmarelo").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtMinAmarelo").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#txtMinAmarelo").focus();
                return;
            }
            else {
                $("#txtMinAmarelo").css("border-color", "");
                $("#txtMinAmarelo").css("outline", "");
                $("#txtMinAmarelo").css("-webkit-box-shadow", "");
                $("#txtMinAmarelo").css("box-shadow", "");
            }
            var input, filter, table, tr, td, i;
            table = document.getElementById("tblControladores");
            tr = table.getElementsByTagName("tr");

            var idEqp = "";
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[3];
                if (td) {
                    var chk = td.childNodes[0].childNodes[0];
                    if (chk.checked == true) {
                        if (idEqp == "") {
                            idEqp = chk.dataset.ideqp;
                        } else {
                            idEqp += "," + chk.dataset.ideqp;
                        }
                    }
                }
            }

            Swal.fire({
                title: getResourceItem("deseja") + ' ' + getResourceItem("impor") + ' ' + getResourceItem("modoOperacional") + ' ' + getResourceItem("amareloIntermitente") + '?',
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("sim")
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        type: 'POST',
                        url: "Default.aspx/ImporPlano",
                        dataType: 'json',
                        data: "{'plano':'PISCANTE','idEqp':'" + idEqp + "','tempo':'" + $("#txtMinAmarelo").val() + "','tipo':'AMARELO INTERMITENTE'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("sucesso") + '!',
                                text: getResourceItem("imposicaoAndamento") + '.',
                            });
                            GetControladores();
                            GetTarefasPendentes();
                        },
                        error: function (data) {
                        }
                    });

                }
            });
        }

        function ImporApagado() {
            if ($("#txtMinApagado").val() == "" || $("#txtMinApagado").val() == "0") {

                $("#txtMinApagado").css("border-color", "#ff0000");
                $("#txtMinApagado").css("outline", "0");
                $("#txtMinApagado").css("-webkit-box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6)");
                $("#txtMinApagado").css("box-shadow", "inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 0, 0, 0.55)");
                $("#txtMinApagado").focus();
                return;
            }
            else {
                $("#txtMinApagado").css("border-color", "");
                $("#txtMinApagado").css("outline", "");
                $("#txtMinApagado").css("-webkit-box-shadow", "");
                $("#txtMinApagado").css("box-shadow", "");
            }
            var input, filter, table, tr, td, i;
            table = document.getElementById("tblControladores");
            tr = table.getElementsByTagName("tr");

            var idEqp = "";
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[3];
                if (td) {
                    var chk = td.childNodes[0].childNodes[0];
                    if (chk.checked == true) {
                        if (idEqp == "") {
                            idEqp = chk.dataset.ideqp;
                        } else {
                            idEqp += "," + chk.dataset.ideqp;
                        }
                    }
                }
            }

            Swal.fire({
                title: getResourceItem("deseja") + ' ' + getResourceItem("impor") + ' ' + getResourceItem("modoOperacional") + ' ' + getResourceItem("apagado") + '?',
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("sim")
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        type: 'POST',
                        url: "Default.aspx/ImporPlano",
                        dataType: 'json',
                        data: "{'plano':'APAGADO','idEqp':'" + idEqp + "','tempo':'" + $("#txtMinApagado").val() + "','tipo':'APAGADO DESLIGADO'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("sucesso") + '!',
                                text: getResourceItem("imposicaoAndamento") + '.',
                            });
                            GetControladores();
                            GetTarefasPendentes();
                        },
                        error: function (data) {
                        }
                    });

                }
            });
        }
        function cancelarImposicao() {

            var input, filter, table, tr, td, i;
            table = document.getElementById("tblControladores");
            tr = table.getElementsByTagName("tr");

            var idEqp = "";
            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[3];
                if (td) {
                    var chk = td.childNodes[0].childNodes[0];
                    if (chk.checked == true) {
                        if (idEqp == "") {
                            idEqp = chk.dataset.ideqp;
                        } else {
                            idEqp += "," + chk.dataset.ideqp;
                        }
                    }
                }
            }

            Swal.fire({
                title: getResourceItem("deseja") + ' ' + getResourceItem("cancelar") + ' ' + getResourceItem("imposicao") + '?',
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: getResourceItem("cancelar"),
                confirmButtonText: getResourceItem("sim")
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        type: 'POST',
                        url: "Default.aspx/ImporPlano",
                        dataType: 'json',
                        data: "{'plano':'','idEqp':'" + idEqp + "','tempo':'','tipo':'cancelamento'}",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            Swal.fire({
                                type: 'success',
                                title: getResourceItem("sucesso") + '!',
                                text: getResourceItem("cancelamento") + ' ' + getResourceItem("solicitado") + '.',
                            });
                            GetControladores();
                            GetTarefasPendentes();
                        },
                        error: function (data) {
                        }
                    });

                }
            });
        }

        var callServer = function (urlName, params, callback) {
            $("#divLoading").css("display", "block");
            $.ajax({
                type: 'POST',
                url: urlName,
                dataType: 'json',
                data: params,
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    if (callback && typeof (callback) == "function") callback(data.d);

                    $("#divLoading").css("display", "none");
                },
                error: function (data) {
                    $("#divLoading").css("display", "none");
                }
            });
        };


        function ImposicaoPlano(btn) {
            $("#tbPlanos").empty();
            $("#tfPlanos").css("display", "none");

            callServer("Default.aspx/getPlanos", "{'idEqp':'" + btn.dataset.id + "'}",
                function (results) {
                    if (results != "") {
                        $.each(results, function (index, item) {
                            var newRow = $("<tr>");
                            var cols = "<td>" + item.NomePlano + "</td>";
                            cols += "<td>" + item.Tipo + "</td>";

                            if (item.Imposicao == true)
                                cols += "<td><button style='padding:0.45em;width:100px;' type='button' class='btn btn-warning' data-tipo='cancelamento' data-ideqp='" + btn.dataset.id + "' data-plano='" + item.NomePlano + "' onclick='ImporPlano(this)'><i class='ft-zap'>Cancelar</i></button></td>";
                            else
                                cols += "<td><button style='padding:0.45em;width:100px;' type='button' class='btn btn-danger' data-tipo='imposicao' data-ideqp='" + btn.dataset.id + "' data-plano='" + item.NomePlano + "' onclick='ImporPlano(this)'><i class='ft-zap'>Impor</i></button></td>";

                            $(newRow).append(cols);
                            $("#tblPlanos").append(newRow);
                        });
                    }
                    else $("#tfPlanos").css("display", "");

                });

            $("#modalImposicao").modal("show");
        }

        function ImporPlano(obj) {
            var tipo = $(obj).data("tipo"), idEqp = obj.dataset.ideqp, plano = $(obj).data("plano");

            callServer("Default.aspx/ImporPlano", "{'plano':'" + plano + "','idEqp':'" + idEqp + "','tempo':'" + $("#txtTempoImposicao").val() + "','tipo':'" + tipo + "'}",
                function (results) {
                    if (results == false) {
                        if (tipo == "imposicao") {
                            $(obj).attr("class", "btn btn-warning");
                            $(obj).html("<i class='ft-zap'>Cancelar</i>");
                            $(obj).data("tipo", "cancelamento");
                            swal(getResourceItem("informacao"), getResourceItem("imposicao") + " " + getResourceItem("solicitada"), "success");

                        } else {
                            $(obj).attr("class", "btn btn-danger");
                            $(obj).html("<i class='ft-zap'>Impor</i>");
                            $(obj).data("tipo", "imposicao");
                            swal(getResourceItem("informacao"), getResourceItem("cancelamento") + " " + getResourceItem("imposicao") + " " + getResourceItem("solicitada"), "success");
                        }
                        GetTarefasPendentes();
                    }
                    else swal(getResourceItem("atencao"), getResourceItem("imposicaoAndamento"), "warning");
                });
        }
    </script>
</asp:Content>
