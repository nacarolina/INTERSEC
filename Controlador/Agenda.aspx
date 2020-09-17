<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Agenda.aspx.cs" Inherits="GwCentral.Controlador.Agenda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css" />

    <%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />--%>

    <style>
        .checkbox {
            padding-left: 0px;
        }

            .checkbox label {
                display: inline-block;
                position: relative;
                padding-left: 5px;
            }

                .checkbox label::before {
                    content: "";
                    display: inline-block;
                    position: absolute;
                    width: 17px;
                    height: 17px;
                    left: 0;
                    margin-left: -20px;
                    border: 1px solid #cccccc;
                    border-radius: 3px;
                    background-color: #fff;
                    -webkit-transition: border 0.15s ease-in-out, color 0.15s ease-in-out;
                    -o-transition: border 0.15s ease-in-out, color 0.15s ease-in-out;
                    transition: border 0.15s ease-in-out, color 0.15s ease-in-out;
                }

                .checkbox label::after {
                    display: inline-block;
                    position: absolute;
                    width: 16px;
                    height: 16px;
                    left: 0;
                    top: 0;
                    margin-left: -20px;
                    padding-left: 3px;
                    padding-top: 1px;
                    font-size: 11px;
                    color: #555555;
                }

            .checkbox input[type="checkbox"] {
                opacity: 0;
            }

                .checkbox input[type="checkbox"]:focus + label::before {
                    outline: thin dotted;
                    outline: 5px auto -webkit-focus-ring-color;
                    outline-offset: -2px;
                }

                .checkbox input[type="checkbox"]:checked + label::after {
                    font-family: 'FontAwesome';
                    content: "\f00c";
                }

                .checkbox input[type="checkbox"]:disabled + label {
                    opacity: 0.65;
                }

                    .checkbox input[type="checkbox"]:disabled + label::before {
                        background-color: #eeeeee;
                        cursor: not-allowed;
                    }

            .checkbox.checkbox-circle label::before {
                border-radius: 50%;
            }

            .checkbox.checkbox-inline {
                margin-top: 0;
            }

        .checkbox-primary input[type="checkbox"]:checked + label::before {
            background-color: #428bca;
            border-color: #428bca;
        }

        .checkbox-primary input[type="checkbox"]:checked + label::after {
            color: #fff;
        }

        .checkbox-danger input[type="checkbox"]:checked + label::before {
            background-color: #d9534f;
            border-color: #d9534f;
        }

        .checkbox-danger input[type="checkbox"]:checked + label::after {
            color: #fff;
        }

        .checkbox-info input[type="checkbox"]:checked + label::before {
            background-color: #5bc0de;
            border-color: #5bc0de;
        }

        .checkbox-info input[type="checkbox"]:checked + label::after {
            color: #fff;
        }

        .checkbox-warning input[type="checkbox"]:checked + label::before {
            background-color: #f0ad4e;
            border-color: #f0ad4e;
        }

        .checkbox-warning input[type="checkbox"]:checked + label::after {
            color: #fff;
        }

        .checkbox-success input[type="checkbox"]:checked + label::before {
            background-color: #5cb85c;
            border-color: #5cb85c;
        }

        .checkbox-success input[type="checkbox"]:checked + label::after {
            color: #fff;
        }

        .btn span.glyphicon {
            opacity: 0;
        }

        .btn.active span.glyphicon {
            opacity: 1;
        }
        /* Hiding the checkbox, but allowing it to be focused */
        .badgebox {
            opacity: 0;
        }

            .badgebox + .badge {
                /* Move the check mark away when unchecked */
                text-indent: -999999px;
                /* Makes the badge's width stay the same checked and unchecked */
                width: 27px;
            }

            .badgebox:focus + .badge {
                /* Set something to make the badge looks focused */
                /* This really depends on the application, in my case it was: */
                /* Adding a light border */
                box-shadow: inset 0px 0px 5px;
                /* Taking the difference out of the padding */
            }

            .badgebox:checked + .badge {
                /* Move the check mark back when checked */
                text-indent: 0;
            }

        .radio label {
            display: inline-block;
            position: relative;
            padding-left: 5px;
        }

            .radio label::before {
                content: "";
                display: inline-block;
                position: absolute;
                width: 17px;
                height: 17px;
                left: 0;
                margin-left: -20px;
                border: 1px solid #cccccc;
                border-radius: 50%;
                background-color: #fff;
                -webkit-transition: border 0.15s ease-in-out;
                -o-transition: border 0.15s ease-in-out;
                transition: border 0.15s ease-in-out;
            }

            .radio label::after {
                display: inline-block;
                position: absolute;
                content: " ";
                width: 11px;
                height: 11px;
                left: 3px;
                top: 3px;
                margin-left: -20px;
                border-radius: 50%;
                background-color: #555555;
                -webkit-transform: scale(0, 0);
                -ms-transform: scale(0, 0);
                -o-transform: scale(0, 0);
                transform: scale(0, 0);
                -webkit-transition: -webkit-transform 0.1s cubic-bezier(0.8, -0.33, 0.2, 1.33);
                -moz-transition: -moz-transform 0.1s cubic-bezier(0.8, -0.33, 0.2, 1.33);
                -o-transition: -o-transform 0.1s cubic-bezier(0.8, -0.33, 0.2, 1.33);
                transition: transform 0.1s cubic-bezier(0.8, -0.33, 0.2, 1.33);
            }

        .radio input[type="radio"] {
            opacity: 0;
        }

            .radio input[type="radio"]:focus + label::before {
                outline: thin dotted;
                outline: 5px auto -webkit-focus-ring-color;
                outline-offset: -2px;
            }

            .radio input[type="radio"]:checked + label::after {
                -webkit-transform: scale(1, 1);
                -ms-transform: scale(1, 1);
                -o-transform: scale(1, 1);
                transform: scale(1, 1);
            }

            .radio input[type="radio"]:disabled + label {
                opacity: 0.65;
            }

                .radio input[type="radio"]:disabled + label::before {
                    cursor: not-allowed;
                }

        .radio.radio-inline {
            margin-top: 0;
        }

        .radio-primary input[type="radio"] + label::after {
            background-color: #428bca;
        }

        .radio-primary input[type="radio"]:checked + label::before {
            border-color: #428bca;
        }

        .radio-primary input[type="radio"]:checked + label::after {
            background-color: #428bca;
        }

        .radio-danger input[type="radio"] + label::after {
            background-color: #d9534f;
        }

        .radio-danger input[type="radio"]:checked + label::before {
            border-color: #d9534f;
        }

        .radio-danger input[type="radio"]:checked + label::after {
            background-color: #d9534f;
        }

        .radio-info input[type="radio"] + label::after {
            background-color: #5bc0de;
        }

        .radio-info input[type="radio"]:checked + label::before {
            border-color: #5bc0de;
        }

        .radio-info input[type="radio"]:checked + label::after {
            background-color: #5bc0de;
        }

        .radio-warning input[type="radio"] + label::after {
            background-color: #f0ad4e;
        }

        .radio-warning input[type="radio"]:checked + label::before {
            border-color: #f0ad4e;
        }

        .radio-warning input[type="radio"]:checked + label::after {
            background-color: #f0ad4e;
        }

        .radio-success input[type="radio"] + label::after {
            background-color: #5cb85c;
        }

        .radio-success input[type="radio"]:checked + label::before {
            border-color: #5cb85c;
        }

        .radio-success input[type="radio"]:checked + label::after {
            background-color: #5cb85c;
        }

        /*DEIXA O BOTÃO MAIS RESPONSIVO A TELAS MENORES*/
        @media (max-width: 1440px) {
            .proporcaoPlanos {
                min-width: fit-content;
                flex: 0 0 100% !important;
                max-width: 100% !important;
                padding-right: 15px !important;
            }

            #btnPlanos {
                width: 100% !important;
            }
        }

        @media (max-width: 3044px) {
            .proporcaoRow {
                display: flex !important;
            }
        }

        #tbAgenda tr:hover {
            background-color: #e3ebf338;
        }

        /*RADIO*/
        input[type=radio].tiposAgenda {
            display: block;
            margin: 0em;
            cursor: pointer;
            padding: 0.2em;
            opacity: 0;
            height: 21px;
            width: 22px;
            position: absolute;
        }

            input[type=radio].tiposAgenda + label:before {
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


            input[type=radio].tiposAgenda:checked + label:before {
                background-color: #5c5c5d;
                border-color: #5c5c5d;
                color: #fff;
                border-top: transparent;
            }

            input[type=radio].tiposAgenda:disabled + label:before {
                transform: scale(1);
                border-color: #aaa;
            }

            input[type=radio].tiposAgenda:checked:disabled + label:before {
                transform: scale(1);
                background-color: #bfb;
                border-color: #bfb;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <%= Resources.Resource.agenda %> <%= Resources.Resource.controlador %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FeaturedContent2" runat="server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="#">Início</a>
        </li>
        <li class="breadcrumb-item"><a href="#">Agenda Controlador</a>
        </li>
    </ol>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="hfIdEqp" ClientIDMode="Static" runat="server" />

    <form class="form form-horizontal">
        <div class="form-body" id="divDetalhesDna">
            <h5 class="form-section" style="border-bottom: 1px solid #e9ecef;"><i class="ft-map-pin"></i>
                <%= Resources.Resource.controlador %> -
                    <label id="lblIdEqp">1234 - Av. Parana, 234</label></h5>

            <div class="row-separator">
                <div class="row proporcaoRow" style="align-items: center; margin-bottom: 15px;">
                    <%--BOTÃO PLANOS--%>
                    <%--            <div class="col-md-6 col-sm-12 proporcaoPlanos" style="max-width: fit-content;">
                <input type="button" id="btnPlanos" value="<%= Resources.Resource.planos %>" class="btn btn-success btn-min-width mr-1 mb-1" onclick="Planos()" />
            </div>--%>

                    <div class="col-md-6 col-sm-12" style="max-width: fit-content; margin-bottom: 8px;">
                        <fieldset>
                            <input type="radio" class="tiposAgenda" id="rdoEqp" value="controlador" name="TipoAgenda" checked="checked" onclick="tblControladorCentral(this);" />
                            <label for="rdoEqp"><%= Resources.Resource.agenda %> <%= Resources.Resource.controlador %></label>
                        </fieldset>
                    </div>

                    <div class="col-md-6 col-sm-12" style="max-width: fit-content; margin-bottom: 8px;">
                        <fieldset>
                            <input type="radio" class="tiposAgenda" id="rdoCentral" value="central" name="TipoAgenda" onclick="tblControladorCentral(this);" />
                            <label for="rdoCentral"><%= Resources.Resource.agenda %> central</label>
                        </fieldset>
                    </div>
                </div>

                <%--ARRUMAR--%>
                <div class="row-separator">
                    <div id="divCentral" style="display: none;">
                        <table class="table table-bordered">
                            <tr>
                                <td><b><%= Resources.Resource.subArea %>:</b>
                                    <span id="lblSubarea"></span>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="table-responsive">
                        <label style="margin-bottom: 0px;"><%= Resources.Resource.tabela %> <%= Resources.Resource.agenda %></label>
                        <table class="table table-bordered mb-0">
                            <thead>
                                <tr>
                                    <th><%= Resources.Resource.agenda %></th>
                                    <th><%= Resources.Resource.plano %></th>
                                    <th><%= Resources.Resource.hora %> - <%= Resources.Resource.inicial %></th>
                                    <th><%= Resources.Resource.hora %> - <%= Resources.Resource.final %></th>
                                    <th><%= Resources.Resource.dias %></th>
                                    <th><%= Resources.Resource.subArea %></th>
                                    <th><%= Resources.Resource.anel %></th>
                                </tr>
                            </thead>
                            <tbody id="tbAgenda"></tbody>
                        </table>
                    </div>
                </div>

                <%--TABELA ESPECIAL--%>
                <div class="table-responsive" style="margin-top: 15px;">
                    <label style="margin-bottom: 0px;"><%= Resources.Resource.tabela %> <%= Resources.Resource.especial %></label>
                    <table class="table table-bordered mb-0">
                        <thead>
                            <tr>
                                <th><%= Resources.Resource.agenda %></th>
                                <th><%= Resources.Resource.plano %></th>
                                <th><%= Resources.Resource.data %> <%= Resources.Resource.hora %> - <%= Resources.Resource.inicial %></th>
                                <th><%= Resources.Resource.data %> <%= Resources.Resource.hora %> - <%= Resources.Resource.final %></th>
                                <th><%= Resources.Resource.subArea %></th>
                                <th><%= Resources.Resource.anel %></th>
                            </tr>
                        </thead>
                        <tbody id="tbTblEspecial"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <%--    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>--%>


    <script>
        function Planos() {
            window.open("http://187.122.100.125:90/chart/Default.aspx?idEqp=" + $("#hfIdEqp").val())
        }

        $(function () {
            $("#lblIdEqp")[0].innerHTML = $("#hfIdEqp").val();
            AgendaEqp();
        });

        function tblControladorCentral(status) {

            if (status.value == 'central') {
                AgendaCentral();
            }
            else {
                AgendaEqp();
            }
        }

        //$('input[type=radio][name=TipoAgenda]').change(function () {
        //    if (this.value == 'Central') {
        //        AgendaCentral();
        //    }
        //    else {
        //        AgendaEqp();
        //    }
        //});

        function AgendaCentral() {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'Agenda.aspx/GetAgendaCentral',
                dataType: 'json',
                data: "{'idEqp':'" + $("#hfIdEqp").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbAgenda").empty();
                    $("#tbTblEspecial").empty();
                    var temTblEspecial = false;
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            if (lst.TabelaEspecial == "Nao") {
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Agenda + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Plano + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.HrIni + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.HrFim + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + getDayCultureLanguage(lst.Dia) + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Subarea + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Anel + "</td>";

                                newRow.append(cols);
                                $("#tbAgenda").append(newRow);
                            }
                            else {
                                temTblEspecial = true;
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Agenda + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Plano + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.HrIni + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.HrFim + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Subarea + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Anel + "</td>";

                                newRow.append(cols);
                                $("#tbTblEspecial").append(newRow);
                            }
                        }
                        if (temTblEspecial == false) {
                            var newRow = $("<tr>");
                            var cols = "<td colspan='7' style='border-collapse: collapse; padding: 5px;'><%= Resources.Resource.naoHaRegistros %></td>";
                            newRow.append(cols);
                            $("#tbTblEspecial").append(newRow);
                        }
                    }
                    else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='7' style='border-collapse: collapse; padding: 5px;'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbAgenda").append(newRow);
                        $("#tbTblEspecial").append(newRow);
                    }

                    $("#divLoading").css("display", "none");
                },

                error: function (data) {
                    $("#divLoading").css("display", "none");
                }
            });
        }

        function AgendaEqp() {

            $("#divLoading").css("display", "block");

            $.ajax({
                type: 'POST',
                url: 'Agenda.aspx/GetAgendaEqp',
                dataType: 'json',
                data: "{'idEqp':'" + $("#hfIdEqp").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $("#tbAgenda").empty();
                    $("#tbTblEspecial").empty();
                    var temTblEspecial = false;
                    if (data.d.length > 0) {

                        for (var i = 0; i < data.d.length; i++) {
                            var lst = data.d[i];
                            var newRow = $("<tr>");
                            var cols = "";
                            if (lst.TabelaEspecial == "Nao") {
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Agenda + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Plano + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.HrIni + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.HrFim + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + getDayCultureLanguage(lst.Dia) + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Subarea + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Anel + "</td>";

                                newRow.append(cols);
                                $("#tbAgenda").append(newRow);
                            }
                            else {
                                temTblEspecial = true;
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Agenda + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.Plano + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.HrIni + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'>" + lst.HrFim + "</td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'></td>";
                                cols += "<td style='border-collapse: collapse; padding: 5px;'></td>";

                                newRow.append(cols);
                                $("#tbTblEspecial").append(newRow);
                            }
                        }
                        if (temTblEspecial == false) {
                            var newRow = $("<tr>");
                            var cols = "<td colspan='7' style='border-collapse: collapse; padding: 5px;'><%= Resources.Resource.naoHaRegistros %></td>";
                            newRow.append(cols);
                            $("#tbTblEspecial").append(newRow);
                        }
                    } else {
                        var newRow = $("<tr>");
                        var cols = "<td colspan='7' style='border-collapse: collapse; padding: 5px;'><%= Resources.Resource.naoHaRegistros %></td>";
                        newRow.append(cols);
                        $("#tbAgenda").append(newRow);
                        $("#tbTblEspecial").append(newRow);
                    }

                    $("#divLoading").css("display", "none");
                },
                error: function (data) {
                    $("#divLoading").css("display", "none");
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
                case "Segunda - Sábado":
                    diaSemana = "<%= Resources.Resource.segunda %> - <%= Resources.Resource.sabado %>"
                    break;
                case "Segunda - Sexta":
                    diaSemana = "<%= Resources.Resource.segunda %> - <%= Resources.Resource.sexta %>"
                    break;
                case "Sábado - Domingo":
                    diaSemana = "<%= Resources.Resource.sabado %> - <%= Resources.Resource.domingo %>"
                    break;
                case "Todos os dias":
                    diaSemana = "<%= Resources.Resource.todosOsDias %>"
                    break;
                default:
                    diaSemana = "<%= Resources.Resource.todosOsDias %>"
                    break;
            }
            return diaSemana;
        }
    </script>
</asp:Content>
