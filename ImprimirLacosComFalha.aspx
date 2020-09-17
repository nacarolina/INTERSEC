<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImprimirLacosComFalha.aspx.cs" Inherits="GwCentral.Relatorios.ImprimirLacosComFalha" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%= Resources.Resource.lacosEmFalha %></title>
</head>
<body>
    <form id="form1" runat="server">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css" />

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
        <asp:HiddenField ID="hfIdPrefeitura" ClientIDMode="Static" runat="server" />
        <div style="text-align: center;">
            <h3><%= Resources.Resource.lacosEmFalha %></h3>
            <asp:Label ID="lblDtHr" Font-Size="Medium" runat="server" Text=""></asp:Label>
            <hr />
            <br />
        </div>
        <div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th><%= Resources.Resource.descricao %></th>
                        <th><%= Resources.Resource.controlador %></th>
                        <th><%= Resources.Resource.data %></th>
                    </tr>
                </thead>
                <tbody id="tbGrd">
                </tbody>
            </table>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
        <script type="text/javascript">
            $(function () {
                $.ajax({
                    type: 'POST',
                    url: 'ImprimirLacosComFalha.aspx/getFalhas',
                    dataType: 'json',
                    data: "",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var i = 0;
                        $("#tbGrd").empty();
                        if (data.d.length == 0) {
                            var newRow = $("<tr>");
                            var cols = "<td colspan='3'>" + getResourceItem("naoHaRegistros") + "</td>";
                            newRow.append(cols);
                            $("#tbGrd").append(newRow);
                        }
                        while (data.d[i]) {
                            var lst = data.d[i];

                            var newRow = $("<tr>");
                            var cols = "";
                            cols += "<td>" + lst.Dsc + "</td>";
                            cols += "<td>" + lst.idEqp + "</td>";
                            cols += "<td>" + lst.DtHr + "</td>";

                            newRow.append(cols);
                            $("#tbGrd").append(newRow);
                            i++;
                        }
                        window.print();
                    }
                });
            });

        </script>
    </form>
</body>
</html>
