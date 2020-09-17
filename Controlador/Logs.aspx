<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Logs.aspx.cs" Inherits="GwCentral.Logs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <style>
        @media (max-width: 3044px) {
            .proporcaoRow {
                display: flex !important;
            }
        }

        @media (max-width: 1440px) {
            .tituloDataHora {
                margin-bottom: 10px !important;
            }
        }

        @media (max-width: 1440px) {
            .divMes {
                border-left: hidden !important;
                margin-top: 8px;
                min-width: -webkit-fill-available;
            }
        }

        @media (max-width: 1440px) {
            .btnBuscar {
                border-left: hidden !important;
                margin-top: 8px;
                min-width: -webkit-fill-available;
                margin-left: 6px;
            }
        }

        @media (max-width: 1440px) {
            .divPeriodo {
                border-left: hidden !important;
            }
        }

        @media (max-width: 1440px) {
            .divData {
                border-left: hidden !important;
            }

            #txtDt {
                margin-top: 10px;
            }
        }

        @media (max-width: 1440px) {
            #lblDtFinal {
                margin-bottom: 0.5rem;
                margin-left: 0 !important;
                margin-top: 5px;
            }
        }

        @media (max-width: 3044px) {
            #lblDtFinal {
                margin-left: 16px;
            }
        }

        @media (max-width: 1440px) {
            #lblDtInicial {
                margin-top: 10px;
            }
        }

        #tbLogs tr:hover {
            background-color: #e3ebf338;
        }

        /*CHECKBOX*/
        input[type=checkbox].tipoLogs {
            display: block;
            margin: 0.1em;
            cursor: pointer;
            padding: 0.2em;
            opacity: 0;
            width: 40px;
            height: 19px;
            position: absolute;
        }

            input[type=checkbox].tipoLogs + label:before {
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
                padding-left: 3px;
            }


            input[type=checkbox].tipoLogs:checked + label:before {
                background-color: #5c5c5d;
                border-color: #5c5c5d;
                color: #fff;
            }

            input[type=checkbox].tipoLogs:disabled + label:before {
                transform: scale(1);
                border-color: #aaa;
            }

            input[type=checkbox].tipoLogs:checked:disabled + label:before {
                transform: scale(1);
                background-color: #bfb;
                border-color: #bfb;
            }

        /*RADIO*/
        input[type=radio].permissoes {
            display: block;
            margin: 0em;
            cursor: pointer;
            padding: 0.2em;
            opacity: 0;
            height: 21px;
            width: 22px;
            position: absolute;
        }

            input[type=radio].permissoes + label:before {
                content: "\2714";
                border: 0.1em solid #464953;
                border-radius: 1.2em;
                display: inline-block;
                width: 20px;
                height: 20px;
                font-size: small;
                margin-right: 0.2em;
                vertical-align: bottom;
                color: transparent;
                text-align-last: center;
                content: "●";
            }


            input[type=radio].permissoes:checked + label:before {
                background-color: #5c5c5d;
                border-color: #5c5c5d;
                color: #fff;
                border-top: transparent;
            }

            input[type=radio].permissoes:disabled + label:before {
                transform: scale(1);
                border-color: #aaa;
            }

            input[type=radio].permissoes:checked:disabled + label:before {
                transform: scale(1);
                background-color: #bfb;
                border-color: #bfb;
            }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.logs %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hfIdEqp" ClientIDMode="Static" runat="server" />

    <form class="form form-horizontal">
        <div id="divPesquisa" class="form-body">
            <h5 class="form-section" style="border-bottom: 1px solid #e9ecef; font-size: 1.32rem;"><i class="ft-map-pin"></i>
                <%= Resources.Resource.controlador %>:
            <label id="lblIdEqp" style="letter-spacing: 0.2rem;"></label>
            </h5>

            <%--CHECKBOX TIPO LOGS--%>
            <div class="row-separator">
                <label style="border-bottom: outset; margin-bottom: 10px;"><%= Resources.Resource.tipo %> </label>
                <div class="row">
                    <div class="col-md-6 col-sm-12" style="max-width: fit-content;">
                        <fieldset>
                            <input type="checkbox" class="tipoLogs" id="chkOperacao" value="" name="" checked="checked" />
                            <label for="chkOperacao"><%= Resources.Resource.operacao %></label>
                        </fieldset>
                    </div>

                    <div class="col-md-6 col-sm-12" style="max-width: fit-content;">
                        <fieldset>
                            <input type="checkbox" class="tipoLogs" id="chkRestab" value="" name="" checked="checked" />
                            <label for="chkRestab"><%= Resources.Resource.restabelecimento %></label>
                        </fieldset>
                    </div>

                    <div class="col-md-6 col-sm-12" style="max-width: fit-content;">
                        <fieldset>
                            <input type="checkbox" class="tipoLogs" id="chkFalha" value="" name="" checked="checked" />
                            <label for="chkFalha"><%= Resources.Resource.falhas %></label>
                        </fieldset>
                    </div>
                </div>

                <%--DATA/HORA--%>
                <label class="tituloDataHora" style="border-bottom: outset; margin-bottom: 0px; margin-top: 10px;"><%= Resources.Resource.data %>/<%= Resources.Resource.hora %></label>
                <div class="row proporcaoRow" style="align-items: center; margin-bottom: 15px;">
                    <div class="col-md-6 col-sm-12" style="max-width: fit-content;">
                        <fieldset>
                            <input type="radio" class="permissoes" id="rdbMensal" value="Mensal" name="TipoData" checked="checked" onclick="dataHora(this);" />
                            <label for="rdbMensal"><%= Resources.Resource.mensal %></label>
                        </fieldset>
                    </div>

                    <div class="col-md-6 col-sm-12" style="max-width: fit-content;">
                        <fieldset>
                            <input type="radio" class="permissoes" id="rdbPeriodo" value="Periodo" name="TipoData" onclick="dataHora(this);" />
                            <label for="rdbPeriodo"><%= Resources.Resource.periodo %></label>
                        </fieldset>
                    </div>

                    <div class="col-md-6 col-sm-12" style="max-width: fit-content;">
                        <fieldset>
                            <input type="radio" class="permissoes" id="rdbEspecifico" value="Data" name="TipoData" onclick="dataHora(this);" />
                            <label for="rdbEspecifico"><%= Resources.Resource.data %></label>
                        </fieldset>
                    </div>

                    <div class="col-md-6 col-sm-12 divMes" id="dvMensal" style="margin-bottom: 6px; display: block; border-left: outset;">
                        <fieldset>
                            <label><%= Resources.Resource.mes %> :&nbsp;</label>
                            <input type="month" id="txtMes" class="form-control" style="width: 220px; display: inline;" />
                        </fieldset>
                    </div>

                    <div class="col-md-6 col-sm-12 divPeriodo" id="dvPeriodo" style="display: none; margin-bottom: 6px; border-left: outset; flex: 0 0 60%; max-width: 60%;">
                        <fieldset>
                            <label id="lblDtInicial"><%= Resources.Resource.dataInicial %>:&nbsp; </label>
                            <input type="date" id="txtDtIni" class="form-control" style="display: inline; width: 220px;" />
                            <label id="lblDtFinal"><%= Resources.Resource.dataFinal %>:&nbsp; </label>
                            <input type="date" id="txtDtFim" class="form-control" style="display: inline; width: 220px;" />
                        </fieldset>
                    </div>

                    <div class="col-md-6 col-sm-12 divData" id="dvData" style="display: none; margin-bottom: 6px; border-left: outset;">
                        <fieldset>
                            <%= Resources.Resource.data %>:&nbsp;<input type="date" id="txtDt" class="form-control" style="display: inline; width: 220px;" />
                        </fieldset>
                    </div>
                </div>

                <div class="row-separator" style="border-top: 1px solid #e9ecef;">
                    <div style="text-align: right;">
                        <button type="button" class="btn btn-info btnBuscar" onclick="Filtrar()" style="margin-top: 1rem;"><%= Resources.Resource.buscar %></button>
                    </div>
                </div>
            </div>

        </div>
    </form>

    <br />
    <label id="lblQtd">Qtd:</label>
    <div class="table-responsive">
        <table class="table table-bordered mb-0">
            <thead>
                <tr>
                    <th><%= Resources.Resource.data %> <%= Resources.Resource.hora %></th>
                    <th><%= Resources.Resource.funcao %></th>
                    <th><%= Resources.Resource.falhas %></th>
                    <th><%= Resources.Resource.usuario %></th>
                </tr>
            </thead>
            <tbody id="tbLogs"></tbody>
        </table>
    </div>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>


    <script>
        $(function () {
            $("#lblIdEqp")[0].innerHTML = $("#hfIdEqp").val();
        });

        $(window).load(function () {
            // Declare variables
            var today = new Date();
            var tomorrow = new Date(new Date().getTime() + 24 * 60 * 60 * 30000);

            // Set values
            $("#txtMes").val(getMes(today));
            $("#txtDtIni").val(getFormattedDate(today));
            $("#txtDt").val(getFormattedDate(today));
            $("#txtDtFim").val(getFormattedDate(tomorrow));
            Filtrar();

            // Get date formatted as YYYY-MM-DD
            function getMes(date) {
                return date.getFullYear()
                    + "-"
                    + ("0" + (date.getMonth() + 1)).slice(-2);
            }

            // Get date formatted as YYYY-MM-DD
            function getFormattedDate(date) {
                return date.getFullYear()
                    + "-"
                    + ("0" + (date.getMonth() + 1)).slice(-2)
                    + "-"
                    + ("0" + date.getDate()).slice(-2);
            }
        });

        function dataHora(status) {

            if (status.value == 'Mensal') {
                $("#dvMensal").css('display', 'block');
                $("#dvPeriodo").css('display', 'none');
                $("#dvData").css('display', 'none');
            }
            else if (status.value == 'Periodo') {
                $("#dvPeriodo").css('display', 'block');
                $("#dvMensal").css('display', 'none');
                $("#dvData").css('display', 'none');
            }
            else if (status.value == 'Data') {
                $("#dvData").css('display', 'block');
                $("#dvMensal").css('display', 'none');
                $("#dvPeriodo").css('display', 'none');
            }
        }

        //$('input[type=radio][name=TipoData]').change(function () {
        //    if (this.value == 'Mensal') {
        //        $("#dvMensal").css('display', 'block');
        //        $("#dvPeriodo").css('display', 'none');
        //        $("#dvData").css('display', 'none');
        //    }
        //    else if (this.value == 'Periodo') {
        //        $("#dvPeriodo").css('display', 'block');
        //        $("#dvMensal").css('display', 'none');
        //        $("#dvData").css('display', 'none');
        //    }
        //    else if (this.value == 'Data') {
        //        $("#dvData").css('display', 'block');
        //        $("#dvMensal").css('display', 'none');
        //        $("#dvPeriodo").css('display', 'none');
        //    }
        //});

        function Filtrar() {
            var ini = "", fim = "";
            var tipo = $('input[name="TipoData"]:checked').val();
            if (tipo == "Mensal") {
                ini = $('#txtMes').val().substring(0, 4) + $('#txtMes').val().substring(5, 7);

            }
            else if (tipo == "Periodo") {
                ini = $('#txtDtIni').val().substring(0, 4) + $('#txtDtIni').val().substring(5, 7) + $('#txtDtIni').val().substring(8, 10);
                fim = $('#txtDtFim').val().substring(0, 4) + $('#txtDtFim').val().substring(5, 7) + $('#txtDtFim').val().substring(8, 10);

            }
            else {
                ini = $('#txtDt').val().substring(0, 4) + '/' + $('#txtDt').val().substring(5, 7) + '/' + $('#txtDt').val().substring(8, 10);
                //document.getElementById("lblDataRel").innerHTML = 'Data especifica: ' + ini;
            }


            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'Logs.aspx/GetLogs',
                dataType: 'json', 
                data: "{'operacao':'" + $("#chkOperacao")[0].checked + "','restabelecimento':'" + $("#chkRestab")[0].checked + "','bFalha':'" + $("#chkFalha")[0].checked + "','dtIni':'" + ini + "','dtFim':'" + fim + "','idEqp':'" + $("#hfIdEqp").val() + "','tipoData':'" + tipo + "'}",

                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var i = 0;
                    $("#lblQtd")[0].innerHTML = "Qtd: " + data.d.length;
                    $("#tbLogs").empty();
                    while (data.d[i]) {
                        var newRow = $("<tr>");
                        var cols = "";
                        if (data.d[i].DataHora == "") {
                            cols += "<td><%= Resources.Resource.naoHaRegistros %></td>";
                        }
                        else {
                            cols += "<td>" + data.d[i].DtHr + "</td>";
                            cols += "<td>" + data.d[i].Funcao + "</td>";

                            cols += "<td>" + data.d[i].Falha + "</td>";
                            cols += "<td>" + data.d[i].Usuario + "</td>";
                        }

                        newRow.append(cols);
                        $("#tbLogs").append(newRow);
                        i++;
                    }

                    $("#divLoading").css("display", "none");
                },
                error: function (data) {
                    params = data; alert('<%= Resources.Resource.erro %>');
                    $("#divLoading").css("display", "none");
                }
            });
        }

        function VerificaFalhas(bitsFalha, callName, status) {

            this.statusFalha = "";
            this.falhas = "";

            if (bitsFalha == 0) {
                if (callName == "CarregaPonto") {
                    this.statusFalha = "Normal";
                    falhas = "N";
                    qtdNormal++;
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
                            qtdFaltaEnergia++;
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

                            qtdSubtencao++;
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

                            qtdDesligado++;
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

                            qtdAmareloIntermitente++;
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
                            qtdEstacionado++;
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
                        this.statusFalha = "Plug"
                        qtdPlugManual++;
                    }

                    //Imposicao Plano
                    if (positionBit == 6 && bitsFalha[positionBit] == "1") {
                        this.statusFalha = "Imposicao"
                        qtdImposicaoPlano++;
                    }
                }
            }
        }
    </script>
</asp:Content>
