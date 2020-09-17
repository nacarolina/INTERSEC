<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Trajetos.aspx.cs" Inherits="GwCentral.Register.Trajetos.Trajetos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <title><%= Resources.Resource.rota %></title>
    <style>
        .loading {
            position: absolute;
            background: #fff;
            width: 150px;
            height: 150px;
            border-radius: 100%;
            border: 10px solid #00acff;
            z-index: 10;
            padding-top: 52px;
            font-size: large;
            color: #00a7f7;
        }

            .loading:after {
                content: '';
                background: trasparent;
                width: 140%;
                height: 140%;
                position: absolute;
                border-radius: 100%;
                top: -20%;
                left: -20%;
                opacity: 1.7;
                box-shadow: rgb(0, 172, 255) -4px -5px 3px -3px;
                animation: rotate 2s infinite linear;
            }

        @keyframes rotate {
            0% {
                transform: rotateZ(0deg);
            }

            100% {
                transform: rotateZ(360deg);
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <div id="divLoading" style="z-index: 99; display: none;">
        <div style="background-color: rgba(0,0,0,.4); position: absolute; z-index: 99; width: 100%; height: 100%; transition: background-color .1s; top: 45px;">
            <div style="background-color: #fff; width: 300px; height: 300px; text-align: center; z-index: 10; padding-left: 75px; padding-top: 52px; border-radius: 10px; position: absolute; margin: auto; top: 0; right: 0; bottom: 0; left: 0;">
                <div class="loading"><%= Resources.Resource.aguarde %> ...</div>
                <div style="font-size: large; color: #00a7f7; font-size: x-large; color: #00a7f7; margin-top: 192px; margin-left: -60px;"><%= Resources.Resource.carregando %> ...</div>
            </div>
        </div>
    </div>
    <div class="panel-group">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" href="#collapse1"><%= Resources.Resource.listaRotas %></a>&nbsp;
                        <button type="button" onclick="newRegister()" class="btn btn-default"><%= Resources.Resource.novo %></button>
                </h4>
            </div>
            <div id="collapse1" class="panel-collapse collapse in">
                <table>
                    <tr style="height: 60px;">
                        <td style="padding-left: 10px;">
                            <div class="input-group">
                                <input type="text" class="form-control" onkeyup="FindlistRows('0',this)" placeholder="<%= Resources.Resource.buscar %>..." style="height: 32px; width: 200px;" />
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-search" onclick="FindlistRows('0',this)"></span>
                                </span>
                            </div>
                        </td>
                    </tr>
                </table>
                <div id="divScroolTable" style="height: 300px; overflow: auto; padding: 10px;">
                    <table id="tblTrajetos" class="table table-bordered">
                        <thead>
                            <tr>
                                <th><%= Resources.Resource.rota %></th>
                                <th><%= Resources.Resource.area %></th>
                                <th><%= Resources.Resource.informacao %></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="tbTrajetos"></tbody>
                        <tfoot id="tfTrajetos">
                            <tr>
                                <td colspan="4"><%= Resources.Resource.naoHaRegistros %></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="panel-footer"></div>
            </div>
        </div>
    </div>
    <script src="https://maps.googleapis.com/maps/api/js?libraries=drawing,places,geometry&key=AIzaSyAEbTl1Ap78hKxlDNENs6iu8iBBJaWg2Lc"></script>
    <script src="../MapUtils.js"></script>
    <script>
        $(function () {
            $("#tbTrajetos").empty();
            $("#tfTrajetos").css("display", "none");

            callServer('Trajetos.aspx/FindAllRoutes', "",
                function (results) {
                    if (results != "") {
                        $.each(results, function (index, lst) {

                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + lst.Nome + "</td>";
                            cols += "<td>" + lst.Area + "</td>";
                            cols += '<td><div style="margin-left: 10px; height: 120px; overflow-y: scroll;">' +
                                '<table id="tblInfo' + lst.Id + '" class="table table-bordered"><thead><tr><th><%= Resources.Resource.grupo %></th><th><%= Resources.Resource.anel %></th><th><%= Resources.Resource.endereco %></th></tr></thead><tbody id="tbInfo' + lst.Id + '"></tbody>' +
                                '<tfoot id="tfInfo' + lst.Id + '" style="display: none;"><tr><td colspan="3"><%= Resources.Resource.naoHaRegistros %></td></tr></tfoot></table></div></td>';
                            cols += "<td><button type='button' class='btn btn-primary' data-id='" + lst.Id + "' onclick='Details(this)'><%= Resources.Resource.detalhes %></button></td>";
                            newRow.append(cols);
                            $("#tblTrajetos").append(newRow);
                            loadGruposVinculados(lst.Id);
                        });
                    }
                    else {
                        $("#tbTrajetos").empty();
                        $("#tfTrajetos").css("display", "");
                    }
                });
        })

        function FindlistRows(position, element) {
            var input, filter, table, tr, td, i;
            input = document.getElementById(element.id);
            filter = input.value.toUpperCase();
            table = document.getElementById("tblTrajetos");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[parseInt(position)];
                if (td) {
                    if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        function newRegister() {
            window.location.replace("TrajetoGrupoSemaforico.aspx?Call=NewRegister");
        }

        function Details(attribute) {
            window.location.replace("TrajetoGrupoSemaforico.aspx?Call=Datails&Id=" + $(attribute).data("id"));
        }

        function loadGruposVinculados(id) {
            $("#tbInfo" + id).empty();
            $("#tfInfo" + id).css("display", "none");
            callServer('TrajetoGrupoSemaforico.aspx/getGruposVinculados', "{'idTrajeto':'" + id + "'}",
                function (results) {
                    if (results != "") {
                        $.each(results, function (index, lst) {
                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + lst.grupo + "</td>";
                            cols += "<td>" + lst.anel + "</td>";
                            cols += "<td>" + lst.Endereco + "</td>";
                            newRow.append(cols);
                            $("#tblInfo" + id).append(newRow);
                        });
                    }
                    else {
                        $("#tbInfo" + id).empty();
                        $("#tfInfo" + id).css("display", "");
                    }
                });
        }
    </script>
</asp:Content>
