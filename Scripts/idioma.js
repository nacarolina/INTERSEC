function changeLanguage(idioma) {
    var address_request = window.location.pathname.indexOf(".aspx") == -1 ?
        window.location.origin + window.location.pathname + "Default.aspx" : window.location.origin + window.location.pathname;

    $.ajax({
        url: address_request + '/changeLanguage',
        data: "{'idioma':'" + idioma + "'}",
        dataType: "json",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            window.location.reload(true);
        }, error: function (data) {
            alert(data);
        }
    });
}