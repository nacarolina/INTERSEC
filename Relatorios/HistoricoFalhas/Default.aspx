<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMapa.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GwCentral.Relatorios.HistoricoFalhas.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Histórico de falhas</title>
    <link href="../../Styles/forms-styles.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />

    <link href="../../Styles/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/css/bootstrap-datepicker.css" />
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.0/locales/bootstrap-datepicker.pt-BR.min.js"></script>

    <style type="text/css">
        .tblgrid tr:nth-child(even) {
            background-color: #eee;
        }

        .tblgrid tr:nth-child(odd) {
            background-color: #fff;
        }

        .tblgrid th {
            text-align: left;
            background: #fff url(../../Images/bar_top.png) repeat-x left bottom;
            border-bottom: 1px solid #333;
        }

        .tblgrid tr:nth-child(even):hover {
            background-color: #fff;
        }

        .tblgrid tr:nth-child(odd):hover {
            background-color: #f5f5f5;
        }

        .ui-autocomplete {
            max-height: 100px;
            overflow-y: auto;
            overflow-x: hidden;
            width: 300px;
            background-color: #ffffff;
            cursor: pointer;
        }

        * html .ui-autocomplete {
            height: 100px;
        }

        #txtDataInicial.valida-Data::-webkit-input-placeholder {
            color: #ff0000;
        }
        #txtDataFinal.valida-Data::-webkit-input-placeholder {
            color: #ff0000;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <div id="divTitle">
        <p style="margin-top: 40px;">
            <asp:Image ID="imgPrefeitura" runat="server" Width="56px" Height="56px" Style="margin-left: 2%;" />
            <b><span style="font-size: xx-large;">Prefeitura de </span></b>
            <asp:Label ID="lblNomePrefeitura" Font-Size="XX-Large" runat="server" Text=""></asp:Label>
        </p>
        <h1 style="margin-left: 2%; color: #cccccc; border-bottom: 1px solid #cccccc; margin-top: 15px; width: 1000px;">Relatório de Falhas e Sem Comunicação</h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="main" style="margin-left: 2%; padding: 5px; width: 1000px;">

        <div id="divLoad" style="width: 100%; height: 200%; background-color: #D8D8D8; position: absolute; display: none; opacity: 0.4;">
            <p style="top: 10%; left: 40%; position: absolute;">
                <img id="imgLoad" alt="Carregando" src="../../Images/carregando.gif" />
            </p>
        </div>

        <div id="divPesquisar" style="width: 100%; padding: 5px; background-color: white; -moz-border-radius: 10px; -webkit-border-radius: 10px; border-radius: 10px;">
            <h3 style="color: #cccccc;">Pesquisar</h3>
            <ul style="list-style: none; width: 80%; padding: 5px;">
                <li style="display: inline-block; width: 80px;"><b>Consorcio:</b></li>
                <li style="display: inline-block; width: 210px; height: 40px;">
                    <select id="sleConsorcio" style="width: 200px; height: 30px;" class="form-control" onchange="GetBusinesses();">
                        <option selected="selected" value="0">Selecione...</option>
                        <option value="1">CONSORCIO SINAL PAULISTANO</option>
                        <option value="2">CONSORCIO ONDAVERDE</option>
                        <option value="3">CONSORCIO MCS</option>
                        <option value="4">CONSORCIO SEMAFORICO PAULISTANO</option>
                    </select>
                </li>
                <li style="display: inline-block;"><b>Empresa:</b></li>
                <li style="display: inline-block; width: 210px;">
                    <select id="sleEmpresa" style="width: 200px; height: 30px;" class="form-control">
                    </select>
                </li>
                <li style="display: inline-block;"><b>Id do Ponto:</b></li>
                <li style="display: inline-block;">
                    <input type="text" id="txtIdPonto" style="width: 100px;" class="form-control" />
                </li>
                <li style="display: inline-table; width: 80px; margin-top: 15px;"><b>Data:</b></li>
                <li style="display: inline-block; width: 120px;">
                    <input type="text" id="txtDataInicial" class="datepicker" placeholder="Inicial" style="width: 100px;" />
                </li>
                <li style="display: inline-block;">
                    <input type="text" id="txtDataFinal" class="datepicker" placeholder="Final" style="width: 100px;" />
                </li>
                <li style="display: inline-block;"><b>Cruzamento:</b></li>
                <li style="display: inline-block; width: 260px;">
                    <input type="text" id="txtCruzamento" style="width: 250px;" class="form-control" />
                </li>
                <li style="display: inline-grid; margin-top: 15px;">
                    <b>Falha:</b>
                    <input id="rdoFalha" type="radio" name="statusFalha" checked="checked" />&nbsp;
                    <b>Sem Comunicação:</b>
                    <input id="rdoSemComunicacao" type="radio" name="statusFalha" />
                    <img id="imgFiltrar" src="../../Images/search.png" style="cursor: pointer; margin-left: 90px; width: 36px; height: 36px;" onclick="PesquisarFalhas();" />
                </li>
            </ul>
            <p>
                <img id="imgExcel" src="../../Images/excel.png" alt="Excel" style="width: 36px; height: 32px; cursor: pointer;" onclick="Excel();" />
                <img id="imgImprimir" src="../../Images/print.png" alt="Imprimir" style="width: 56px; height: 56px; cursor: pointer;" onclick="Imprimir();" />
            </p>
        </div>

        <div id="divListaFalhaControl" style="margin-top: 10px; display: none; padding: 5px; background-color: white; -moz-border-radius: 10px; -webkit-border-radius: 10px; border-radius: 10px; width: 100%; height: 300px;">
            <div id="scrollHistoFalhas" style="overflow-x: hidden; overflow-y: scroll; height: 290px; width: 95%;">
                <b>Total:</b><span id="spaTotal">0</span>
                <table id="tblHistoricoFalhas" class="tblgrid" style="width: 95%; margin-left: 10px; margin-top: 10px;">
                    <caption style="text-align: left;"><b>Historico de falhas</b></caption>
                    <thead style="margin-top: 5px;">
                        <tr>
                            <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Semaforo</th>
                            <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Falha</th>
                            <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Porta</th>
                            <th style="border: 1px solid black; border-collapse: collapse; padding: 5px;">Data</th>
                        </tr>
                    </thead>
                    <tbody id="tbHistoricoFalhas"></tbody>
                </table>
            </div>
        </div>
    </div>
    <script src="Default.js"></script>
</asp:Content>
