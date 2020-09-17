<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Register.Dna.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <!--<script src="../../Scripts/jquery-1.8.2.min.js"></script>-->

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>

    <style type="text/css">
        .tblgrid tr:nth-child(even) {
            background-color: #eee;
        }

        .tblgrid tr:nth-child(odd) {
            background-color: #fff;
        }

        .tblgrid th {
            text-align: left;
            background: #fff url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAUCAAAAABpZQh9AAAAF0lEQVQI12P4z/SP6S8Q/sOCYawPTO8Ajz0T2VT0ZeQAAAAASUVORK5CYII=') /*../../Images/bar_top.png*/ repeat-x left bottom;
            border-bottom: 1px solid #333;
        }

        .tblgrid tr:nth-child(even):hover {
            background-color: #fff;
        }

        .tblgrid tr:nth-child(odd):hover {
            background-color: #f5f5f5;
        }

        .valida-input::-webkit-input-placeholder {
            color: #ff0000;
        }

        .ui-autocomplete {
            max-height: 100px;
            overflow-y: auto;
            overflow-x: hidden;
            width: 300px;
            background-color: #ffffff;
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hdfId" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfUser" runat="server" ClientIDMode="Static"></asp:HiddenField>
    <h2 id="titleCad" style="margin-bottom: 15px; border-bottom: 1px solid #D8D8D8; padding: 5px; margin-left: 10px; width: 800px;">
        <img src="../../Images/register-icon.png" style="width: 32px; height: 32px;" />
        <%= Resources.Resource.cadastroCruzamento %>
    </h2>
    <div class="input-group">
        <input type="text" id="txtIdLocal" placeholder="Id <%= Resources.Resource.cruzamento %>..." class="form-control" style="display: inline;" />
        <span class="input-group-addon" onclick="pesqCruzamento()" style="cursor: pointer;"><i class="glyphicon glyphicon-search"></i></span>
        <input id="txtCruzamento" placeholder="<%= Resources.Resource.endereco %>..." class="form-control" type="text" style="display: inline;" />
        <span class="input-group-addon" onclick="Geocodificacao()" style="cursor: pointer;"><i class="glyphicon glyphicon-search"></i></span>
    </div>

    <div style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; padding-left: 4px; width: 870px; border-color: #f4f4f4; margin-top: 5px; margin-left: 10px; height: 500px;">
        <p style="margin-left: 10px; margin-top: 5px; display:none;">
            <%= Resources.Resource.latitude %>:
            <input id="txtLat" placeholder="<%= Resources.Resource.latitude %>..." class="form-control" type="text" style="width: 150px; margin-left: 5px; display: inline;" disabled="disabled" />
            <%= Resources.Resource.longitude %>:
            <input id="txtLong" placeholder="<%= Resources.Resource.longitude %>..." class="form-control" type="text" style="width: 150px; display: inline;" disabled="disabled" />
        </p>
        <div id="map" style="border: 1px solid #9b9b9b; -webkit-border-radius: 10px; border-radius: 10px; background-color: #FFFFFF; width: 850px; border-color: #f4f4f4; margin-top: 20px; height: 300px; visibility: hidden;">
        </div>
        <p style="margin-left: 10px; margin-top: 10px;">
            <input id="btnSalvar" type="button" class="btn btn-sucess" value="<%= Resources.Resource.salvar %>" onclick="SalvarCruzamento();" />
            <input id="btnExcluir" type="button" class="btn btn-danger" value="<%= Resources.Resource.excluir %>" onclick="Excluir();" style="visibility: hidden;" />
        </p>
    </div>

    <div id="popupAviso" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 id="hInfoCad" class="modal-title"><%= Resources.Resource.atencao %>!</h4>
                </div>
                <div class="modal-body">
                    <p>
                        <%= Resources.Resource.dnaNPodeSerExcluido %>.
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><%= Resources.Resource.cancelar %></button>
                </div>
            </div>
        </div>
    </div>

    <script src="Dna.js"></script>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBYQJ8OSMm1XQcb2h8lla6IbG2rNeKtQ9Q" type="text/javascript"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.js"></script>
    <script src="../../Scripts/jquery.ui.addresspicker.js"></script>
    <script>
        $(function () {
            Geocodificacao('São Paulo,SP');
            var addresspicker = $("#txtCruzamento").addresspicker({
                componentsFilter: 'country:BR'
            });
        });
    </script>


</asp:Content>
