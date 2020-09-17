<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="MapConfig.aspx.cs" Inherits="GwCentral.Admin.MapConfig" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title><%= Resources.Resource.configuracoes %></title>
    <style type="text/css">
        .infoMessage {
            color: #555;
            border-radius: 10px;
            font-family: Tahoma,Geneva,Arial,sans-serif;
            font-size: 13px;
            padding: 10px 10px 10px 36px;
            margin: 10px;
            background: #e3f7fc url('../../Images/notice.png') no-repeat 10px 50%;
            border: 1px solid #8ed9f6;
            width: 400px;
        }

        #txtTempoAtualizaMapa.valida::-webkit-input-placeholder {
            color: #ff0000;
        }
    </style>

    <link href="../../Scripts/leaflet/leaflet.css" rel="stylesheet" />
    <link href="../../Scripts/distLeaflet/leaflet.zoomdisplay.css" rel="stylesheet" />
    <link href='https://api.mapbox.com/mapbox.js/v2.2.3/mapbox.css' rel='stylesheet' />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div id="map" style="position: absolute; top: 45px; left: 0px; width: 100%; height: 100%;"></div>

    <div style="position: absolute; right: 0.5%; top: 10%;">
        <button class="btn btn-primary" type="button" onclick="GetConfiParams();" title="<%= Resources.Resource.configuracoes %>"><i class="fas fa-cogs"></i></button>
    </div>

    <div id="popupConfigParams" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">
                        <i class="fas fa-cogs"></i>
                        <%= Resources.Resource.configuracoes %></h4>
                </div>
                <div class="modal-body">
                    <p style="border-bottom: 1px solid #eee;">
                        <b><%= Resources.Resource.tempo %> <%= Resources.Resource.falhasNaComunicacao %>:</b>
                        <input type="text" id="txtTempoFalhaComunicacao" class="form-control" placeholder="<%= Resources.Resource.minutos %>" value="15" />
                        <b><%= Resources.Resource.minutos %></b>
                    </p>
                    <p style="border-bottom: 1px solid #eee;">
                        <b><%= Resources.Resource.tempoAtualizacao %> - <%= Resources.Resource.mapa %>:</b>&nbsp;&nbsp;&nbsp;
                        <input type="text" id="txtTempoAtualizaMapa" class="form-control" placeholder="<%= Resources.Resource.minutos %>" onkeyup="GetMilissegundos(this);" />
                        <b><%= Resources.Resource.minutos %></b>
                    </p>
                    <p style="border-bottom: 1px solid #eee;">
                        <b><%= Resources.Resource.milisegundos %>:  </b><span id="spaTempoAtualizaMapa">0</span>
                    </p>
                </div>
                <div class="modal-footer">
                    <input type="button" id="btnSalvar" value="<%= Resources.Resource.confirmar %>" onclick="SalvarParams();" class="btn btn-success" />
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><%= Resources.Resource.fechar %></button>
                </div>
            </div>

        </div>
    </div>

    <div id="divInfoMessage" style="position: absolute; top: 60px; left:0px;right:0px;margin:auto;" class="infoMessage">
        <p style="float: right; margin-bottom: 0px; margin-top: -0px;">
            <img id="imgFechar" alt="Fechar" style="cursor: pointer; width: 16px; height: 16px;" src="../../Images/close24.png" onclick="CloseInfo();" />
        </p>

        <p><%= Resources.Resource.cliqueNoLocalParaSalvar %></p>
    </div>

    <script src="../../Scripts/leaflet/leaflet-src.js"></script>
    <script src="../../Scripts/distLeaflet/leaflet.zoomdisplay-src.js"></script>
    <script src="../../Scripts/mapbox.js"></script>
    <script src="../../Scripts/map-config.js"></script>

</asp:Content>
