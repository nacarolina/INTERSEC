
var areaObj = "", areaId = "";

$(function () {
    $('[data-toggle="tooltip"]').tooltip();
    listArea();
    //loadTreeView();
    ListarEqp();
    loadResourcesLocales();
});

var globalResources;
function loadResourcesLocales() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: 'AreaSubArea.aspx/requestResource',
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

var callServer = function (urlName, params, sync, callback) {
    $("#divLoading").css("display", "block");
    $.ajax({
        type: 'POST',
        url: urlName,
        dataType: 'json',
        data: params,
        async: sync,
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

var allAreas = function () {
    var areas = [];
    callServer('AreaSubArea.aspx/ListarTodasAreas', "", true,
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var tipo = lst.tipo == "area" ? "Área" : "Sub-Área";
                    areas.push(lst.nome + " - " + tipo);
                });
            }
        });
    return areas;
}

function ListarEqp() {
    $("#tblControl").empty();
    callServer('AreaSubArea.aspx/ListaEqpAneis', "", false,
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var rowEqp = $("<tr class='header'>");
                    var colsEqp = "<td colspan='2'> <input id='txt" + lst.idPonto + "-' type='checkbox' onclick='vincularAneis(this)' style='margin-right:10px;' data-qtdanel='" + lst.qtdAneis + "' data-idponto=" + lst.idPonto + " />" + lst.idPonto + " - " + lst.cruzamento + "</td>";
                    rowEqp.append(colsEqp);
                    $("#tblControl").append(rowEqp);

                    //for (var i = 0; i < lst.qtdAneis; i++) {
                    //    var anel = i + 1;
                    //    var rowAneis = $("<tr>");
                    //    var cols = "<td><div class='checkbox'><label>" +
                    //        "<input id='txt" + lst.idPonto + "-" + anel + "' type='checkbox' onclick='vincularAneis(this)' data-idponto=" + lst.idPonto + " data-anel=" + anel + ">Anel - " + anel + "</label></div></td>";
                    //    rowAneis.append(cols);
                    //    $("#tblControl").append(rowAneis);
                    //}
                });
                //var ua = navigator.userAgent,
                //    event = (ua.match(/iPad/i)) ? "touchstart" : "click";
                //if ($('.collapse-table').length > 0) {
                //    $('.collapse-table .header').on(event, function () {
                //        $(this).toggleClass("active", "").nextUntil('.header').css('display', function (i, v) {
                //            return this.style.display === 'table-row' ? 'none' : 'table-row';
                //        });
                //    });
                //}
            }
        });
}

function getAneisVinculados() {
    $("#modalControl").modal("show");
    $("#divLoading").css("display", "block");
    ListarEqp('edit');
    callServer('AreaSubArea.aspx/getAneisVinculados', "{'idArea':'" + areaId + "'}", true,
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    $("#txt" + lst.idPonto + "-").attr("checked", true);
                });
            }
            $("#modalControl").modal("show");
            $("#divLoading").css("display", "none");
        });
}

function getAneisArea(obj) {
    $("#divAneisVinculados").css("display", "block");
    areaId = $(obj)[0].parentElement.dataset.id;
    areaObj = $(obj)[0].parentElement.id;
    $("#spnArea").text($(obj).text());
    $("#tblAneis").empty();
    $("#divLoading").css("display", "block");
    callServer('AreaSubArea.aspx/getAneisVinculados', "{'idArea':'" + areaId + "'}", true,
        function (results) {

            var head = "<thead><tr><th>Id Eqp</th><th>" + getResourceItem("cruzamento") + "</th></tr><thead>";
            $("#tblAneis").append(head);

            if (results != "") {
                $.each(results, function (index, lst) {
                    var newRow = $("<tr>");
                    var cols = "";

                    cols += "<td>" + lst.idPonto + "</td>";
                    cols += "<td>" + lst.cruzamento + "</td>";
                    //cols += "<td>" + lst.anel + "</td>";
                    newRow.append(cols);
                    $("#tblAneis").append(newRow);
                });
            }
            else {
                var newFooter = $("<tfoot>");
                var cols = "";

                cols += "<tr><th colspan='3'>" + getResourceItem("naoHaEqpVinculadoNaSubArea") + "</th></tr>";
                newFooter.append(cols);
                $("#tblAneis").append(newFooter);
            }
            $("#divLoading").css("display", "none");
        });
}

function vincularAneis(obj) {
    callServer('AreaSubArea.aspx/vincularAneis', "{'idEqp':'" + $(obj).data("idponto") + "','qtdAnel':'" + $(obj).data("qtdanel") + "','idArea':'" + areaId + "','user':'" + $("#hfUser").val() + "'}", true,
        function (results) {
            if ($(obj).is(":checked")) {
                if (results != "SUCESSO") {
                    $(obj)[0].checked = false;
                    swal(getResourceItem("atencao"), getResourceItem("EqpJaVinculadoArea") + "!", "warning");
                    return;
                }
                swal(getResourceItem("informacao"), getResourceItem("controladorVinculado"), "success");
            }
            else swal(getResourceItem("informacao"), getResourceItem("controladorDesvinculado"), "success");

            getAneisArea($("#lnkSub" + areaId));
        });
}

function listArea() {
    $("#treeArea").empty();
    $("#treeArea").removeClass("tree");

    callServer('AreaSubArea.aspx/ListarAreas', "{'tipo':'area'}", true,
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var newArea = "<li id='area" + lst.id + "' data-id='" + lst.id + "' onmousedown= 'HideMenu();' onmouseup= 'HideMenu();'> " +
                        "<img src='../../Images/area.png' style='width:16px; heigth:16px;'/> - <a href='#' oncontextmenu='ShowMenu(event,this);'>" + lst.nome + "</a>" +
                        "</li>";
                    $("#treeArea").append(newArea);
                });
            }
            else {
                $("#treeArea").empty();
                $("#treeArea").removeClass("tree");
            }

            listSubArea();
            autocomplete(document.getElementById("inputFindArea"), allAreas());
        });
}

function listSubArea() {
    callServer('AreaSubArea.aspx/ListarAreas', "{'tipo':'subArea'}", true,
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    var newSubArea = "<ul><li id='subArea" + lst.id + "' data-id='" + lst.id + "' onmousedown='HideMenu();' onmouseup='HideMenu();'>" +
                        "<img src='../../Images/subArea.png' style='width:16px; heigth:16px;'/> - <a href='#' onclick='getAneisArea(this)' id='lnkSub" + lst.id + "' oncontextmenu='ShowMenu(event,this);'>" + lst.nome + "</a>" +
                        "</li></ul>";

                    $('[data-id=' + lst.idArea + ']').append(newSubArea);
                });
            }
            // loadTreeView();
        });
}

function NovaArea() {
    var newArea = "<li id='area' onmousedown='HideMenu();' onmouseup='HideMenu();'>" +
        "<img src='../../Images/area.png' style='width:16px; heigth:16px;'/> - " +
        "<input id='txtNovaArea' type='text' class='form-control not-display' onkeyup='if(event.keyCode === 13)SalvarArea();' style='width: 150px;' placeholder='" + getResourceItem("area") + "'/>" +
        "  <a href='#' onclick='SalvarArea();' class='glyphicon glyphicon-ok' style='color:green'></a>" +
        "</li>";
    $("#treeArea").append(newArea);
    //loadTreeView();
}

function SalvarArea() {
    var obj = $("#txtNovaArea")[0];

    var nomeArea = obj.value;
    if (nomeArea == "") {
        swal(getResourceItem("atencao"), getResourceItem("preenchaNomeArea"), "warning");
        return false;
    }

    callServer('AreaSubArea.aspx/SalvarArea', "{'nome':'" + nomeArea + "','user':'" + $("#hfUser").val() + "'}", true,
        function (results) {
            if (results == "") listArea();
            else swal("Atenção", results, "warning");
        });
}

function NovaSubArea() {
    var newSubArea = "<ul><li id='subArea' onmousedown='HideMenu();' onmouseup='HideMenu();'>" +
        "<img src='../../Images/subArea.png' style='width:16px; heigth:16px;'/> - <input id='txtNovaSubArea' type='text' class='form-control not-display' onkeyup='if(event.keyCode === 13) SalvarSubArea();' style='width: 150px;' placeholder='" + getResourceItem("subArea") + "'/>" +
        "  <a href='#' onclick='SalvarSubArea();' class='glyphicon glyphicon-ok' style='color:green'></a>" +
        "</li></ul>";
    $("#" + areaObj).append(newSubArea);
}

function SalvarSubArea() {
    var obj = $("#txtNovaSubArea")[0];

    var nomeSubArea = obj.value;
    if (nomeSubArea == "") {
        swal(getResourceItem("atencao"), getResourceItem("preenchaNomeSubArea"), "warning");
        return false;
    }

    callServer('AreaSubArea.aspx/SalvarSubArea', "{'nome':'" + nomeSubArea + "','idArea':'" + areaId + "','user':'" + $("#hfUser").val() + "'}", true,
        function (results) {
            if (results == "") listArea();
            else swal("Atenção", results, "warning");
        });
}

function ShowMenu(e, obj) {
    $("#infoArea").text("* " + obj.innerText);
    areaId = $(obj)[0].parentElement.dataset.id;
    areaObj = $(obj)[0].parentElement.id;

    if (areaObj.indexOf("area") != -1) $("#trVincularAnel").css("display", "none");
    else $("#trVincularAnel").css("display", "block");

    $("#contextMenu").css({
        position: "absolute", top: (e.pageY - 180),
        left: (e.pageX - 5), display: "inline-table"
    });
    return false;
}

function HideMenu() {
    $("#contextMenu").css("display", "none");
    return false;
}

$('html').click(function () {
    $("#contextMenu").css("display", "none");
});

$('body').contextmenu(function () {
    return false;
});

function Renomear() {
    var newObj = "";

    var nome = $('#' + areaObj + '> a').text();

    if (areaObj.indexOf("area") != -1) {
        newObj = "<input id='txtNovaArea' type='text' value='" + nome + "' class='form-control not-display' onkeyup='if(event.keyCode === 13) Editar();' style='width: 150px;' placeholder='" + getResourceItem("area") + "'/>" +
            " <a href='#' onclick='Editar();' class='glyphicon glyphicon-ok' style='color:green'></a>";
    } else {
        newObj = "<input id='txtNovaSubArea' type='text' value='" + nome + "' class='form-control not-display' onkeyup='if(event.keyCode === 13) Editar();' style='width: 150px;' placeholder='" + getResourceItem("subArea") + "'/>" +
            " <a href='#' onclick='Editar();' class='glyphicon glyphicon-ok' style='color:green'></a>";
    }

    $('#' + areaObj + '> a').replaceWith(newObj);
    $('#' + areaObj + '> input').select();
}

function Editar() {
    var nome = $('#' + areaObj + '> input').val();
    callServer('AreaSubArea.aspx/Renomear', "{'nome':'" + nome + "','id':'" + areaId + "','user':'" + $("#hfUser").val() + "'}", true,
        function (results) {
            if (results == "") listArea();
            else {
                swal(getResourceItem("atencao"), results, "warning");
                $('#' + areaObj + '> input').select();
            }
        });
}

function BuscarArea() {
    var filter = $("#inputFindArea").val(), tipo = "";
    if (filter == "") {
        listArea();
        return false;
    }

    if (filter.indexOf("Sub-Área") != -1) {
        tipo = "subArea";
        filter = filter.replace(" - Sub-Área", "");
    }
    else {
        tipo = "area";
        filter = filter.replace(" - Área", "");
    }

    $("#treeArea").empty();
    $("#treeArea").removeClass("tree");

    callServer('AreaSubArea.aspx/BuscarAreas', "{'tipo':'" + tipo + "','nome':'" + filter + "'}", true,
        function (results) {
            if (results != "") {
                $.each(results, function (index, lst) {
                    if (tipo == "area") {
                        var newArea = "<li id='area" + lst.id + "' data-id='" + lst.id + "' onmousedown= 'HideMenu();' onmouseup= 'HideMenu();'> " +
                            "<img src='../../Images/area.png' style='width:16px; heigth:16px;'/> - <a href='#' oncontextmenu='ShowMenu(event,this);'>" + lst.nome + "</a>" +
                            "</li>";
                        $("#treeArea").append(newArea);
                    }
                    else {
                        var newSubArea = "<li id='subArea" + lst.id + "' data-id='" + lst.id + "' onmousedown='HideMenu();' onmouseup='HideMenu();'>" +
                            "<img src='../../Images/subArea.png' style='width:16px; heigth:16px;'/> - <a href='#' onclick='getAneisArea(this)' id='lnkSub" + lst.id + "' oncontextmenu='ShowMenu(event,this);'>" + lst.nome + "</a>" +
                            "</li>";
                        $("#treeArea").append(newSubArea);
                    }

                });
            }
            else {
                $("#treeArea").empty();
                $("#treeArea").removeClass("tree");
            }
            // reloadTree();
        });

}

function Excluir() {

 /*   swal({
        title: 'Are you sure?',
        text: 'You won\'t be able to revert this!',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: getResourceItem("continuar")
    }).then(function () {
        swal('Deleted!', 'Your file has been deleted!', 'success');
    }).catch(swal.noop);*/
    swal({
        title: getResourceItem("atencao"),
        text: getResourceItem("exclusaoPodePerderDados") + " " + getResourceItem("desejaExcluirArea"),
        type: "warning",
        buttons: [getResourceItem("cancelar"), getResourceItem("continuar")]
    }).then(function (isConfirm) {
        if (isConfirm) callServer('AreaSubArea.aspx/Excluir', "{'id':'" + areaId + "','user':'" + $("#hfUser").val() + "'}", true,
            function (results) {
                listArea();
                swal(getResourceItem("informacao"), getResourceItem("excluidoSucesso") + "!", "success");
            });
    }).catch(swal.noop);

}

function print(elm) {
    var data = $('<div/>').append($(elm).clone()).html();

    var mywindow = window.open('');
    mywindow.document.write('<html><head><title>"' + getResourceItem("controladorVinculado") + "/" + getResourceItem("subArea") + '"</title>');
    mywindow.document.write('<style> #tblAneis { font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;border-collapse: collapse;width: 100%; } #tblAneis td, #tblAneis th {' +
        'border: 1px solid #ddd; padding: 8px; } #tblAneis tr:nth-child(even) { background-color: #f2f2f2; }  #tblAneis tr:hover { background-color: #ddd; }' +
        '#tblAneis th { padding-top: 12px; padding-bottom: 12px; text-align: left; background-color: #fff; }</style>');
    mywindow.document.write('</head><body>');
    mywindow.document.write('<div style="width: 97%; border: 1px solid #d4d4d4; margin: 10px;"><div style="border-bottom: 1px solid #d4d4d4;">' +
        '<p style="margin: 10px">' + getResourceItem("listaEqpVinculado") + " - " + getResourceItem("subArea") + ":" + '<span id="spnArea">' + $("#spnArea").text() + '</span></p> ' +
        '</div><div>' + data + '</div></div>');
    mywindow.document.write('</body></html>');

    mywindow.print();
    mywindow.close();
    window.location.reload(true);

}
$.fn.extend({
    treed: function (o) {

        var openedClass = 'glyphicon-minus', closedClass = 'glyphicon-plus';

        if (o == 'reload') {
            $(this).removeClass("tree");
            const $treeView = $(this).html();
            $(this).empty();
            $(this).html($treeView).addClass("tree");
        }
        else if (typeof o != 'undefined') {
            if (typeof o.openedClass != 'undefined') openedClass = o.openedClass;
            if (typeof o.closedClass != 'undefined') closedClass = o.closedClass;
        }

        //initialize each of the top levels
        var tree = $(this);

        if (!tree.hasClass("tree")) tree.addClass("tree");

        tree.find('li').has("ul").each(function () {
            var branch = $(this); //li with children ul
            if (branch.has("i").length == 0) {
                branch.prepend("<i style='font-size:10px !important;' class='indicator glyphicon " + closedClass + "'></i>");
                branch.addClass('branch');
                branch.children().children().toggle();
            }

            branch.on('click', function (e) {
                if (this == e.target) {
                    var icon = $(this).children('i:first');
                    icon.toggleClass(openedClass + " " + closedClass);
                    $(this).children().children().toggle();
                }
            })            
        });
        //fire event from the dynamically added icon
        tree.find('.branch .indicator').each(function () {
            $(this).on('click', function () {
                $(this).closest('li').click();
            });
        });
        //fire event to open branch if the li contains an anchor instead of text
        tree.find('.branch>a').each(function () {
            $(this).on('click', function (e) {
                $(this).closest('li').click();
                e.preventDefault();
            });
        });
        //fire event to open branch if the li contains a button instead of text
        tree.find('.branch>button').each(function () {
            $(this).on('click', function (e) {
                $(this).closest('li').click();
                e.preventDefault();
            });
        });
    }
});

function loadTreeView() {
    $('#treeArea').tree();
}

function reloadTree() {
    $('#treeArea').tree('reload', $('#treeArea'));
}

