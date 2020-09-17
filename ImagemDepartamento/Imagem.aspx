<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Imagem.aspx.cs" Inherits="Dna_Imagem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        #preview {
            position: absolute;
            border: 3px solid #ccc;
            background: #333;
            padding: 5px;
            display: none;
            color: #fff;
            box-shadow: 4px 4px 3px rgba(103, 115, 130, 1);
        }

        .auto-style3 {
            font-size: medium;
            text-decoration: underline;
        }

        .ajax__fileupload_fileItemInfo div.removeButton {
            width: 100px;
        }



        div.ajax__fileupload_uploadbutton {
            width: 125px;
        }



        .ajax__fileupload .ajax__fileupload_selectFileContainer {
            width: 110px;
        }



        .ajax__fileupload_selectFileContainer .ajax__fileupload_selectFileButton {
            width: 110px;
        }
    </style>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>

    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            ShowImagePreview();
        });
        // Configuration of the x and y offsets
        function ShowImagePreview() {
            xOffset = -20;
            yOffset = 40;

            $("a.preview").hover(function (e) {
                this.t = this.title;
                this.title = "";
                var c = (this.t != "") ? "<br/>" + this.t : "";
                $("body").append("<p id='preview'><img src='" + this.href + "' alt='Image preview' />" + c + "</p>");
                $("#preview")
                .css("top", (e.pageY - xOffset) + "px")
                .css("left", (e.pageX + yOffset) + "px")
                .fadeIn("slow");
            },

        function () {
            this.title = this.t;
            $("#preview").remove();
        });

            $("a.preview").mousemove(function (e) {
                $("#preview")
                .css("top", (e.pageY - xOffset) + "px")
                .css("left", (e.pageX + yOffset) + "px");
            });
        };

    </script>




    <script type="text/javascript">

        // run AjaxFileUpload_change_text() function after page load

        $(document).ready(function () {

            AjaxFileUpload_change_text();

        });

        function AjaxFileUpload_change_text() {

            Sys.Extended.UI.Resources.AjaxFileUpload_SelectFile = "Selecione arquivos";

            Sys.Extended.UI.Resources.AjaxFileUpload_DropFiles = "Arraste arquivos aqui";

            Sys.Extended.UI.Resources.AjaxFileUpload_Pending = "pendente";

            Sys.Extended.UI.Resources.AjaxFileUpload_Remove = "Remover";

            Sys.Extended.UI.Resources.AjaxFileUpload_Upload = "Carregar";

            Sys.Extended.UI.Resources.AjaxFileUpload_Uploaded = "Carregado";

            Sys.Extended.UI.Resources.AjaxFileUpload_UploadedPercentage = "Carregando {0} %";

            Sys.Extended.UI.Resources.AjaxFileUpload_Uploading = "Carregando";

            Sys.Extended.UI.Resources.AjaxFileUpload_FileInQueue = "{0} arquivos(s) na fila.";

            Sys.Extended.UI.Resources.AjaxFileUpload_AllFilesUploaded = "Todos arquivos carregaram.";

            Sys.Extended.UI.Resources.AjaxFileUpload_FileList = "Lista de arquivos:";

            Sys.Extended.UI.Resources.AjaxFileUpload_SelectFileToUpload = "Selecione os arquivos para carregar.";

            Sys.Extended.UI.Resources.AjaxFileUpload_Cancelling = "Cancelando...";

            Sys.Extended.UI.Resources.AjaxFileUpload_UploadError = "Um erro ocorreu.";

            Sys.Extended.UI.Resources.AjaxFileUpload_CancellingUpload = "Cancelando...";

            Sys.Extended.UI.Resources.AjaxFileUpload_UploadingInputFile = "Carregando arquivo: {0}.";

            Sys.Extended.UI.Resources.AjaxFileUpload_Cancel = "Cancelar";

            Sys.Extended.UI.Resources.AjaxFileUpload_Canceled = "cancelado";

            Sys.Extended.UI.Resources.AjaxFileUpload_UploadCanceled = "Upload cancelado";

            Sys.Extended.UI.Resources.AjaxFileUpload_DefaultError = "Erro";

            Sys.Extended.UI.Resources.AjaxFileUpload_UploadingHtml5File = "Carregando arquivo: {0} tamanho: {1} bytes.";

            Sys.Extended.UI.Resources.AjaxFileUpload_error = "erro";

        }






        function onClientUploadComplete(sender, e) {
            onImageValidated("TRUE", e);
        }

        function onImageValidated(arg, context) {

            var test = document.getElementById("testuploaded");
            test.style.display = 'block';

            var fileList = document.getElementById("fileList");
            var item = document.createElement('div');
            item.style.padding = '4px';

            if (arg == "TRUE") {
                var url = context.get_postedUrl();
                url = url.replace('&amp;', '&');
                item.appendChild(createThumbnail(context, url));
            } else {
                item.appendChild(createFileInfo(context));
            }

            fileList.appendChild(item);
        }

        function createFileInfo(e) {
            var holder = document.createElement('div');
            holder.appendChild(document.createTextNode(e.get_fileName() + ' com ' + e.get_fileSize() + ' bytes'));

            return holder;
        }

        function createThumbnail(e, url) {
            var holder = document.createElement('div');
            //   var img = document.createElement("img");
            //   img.style.width = '80px';
            //   img.style.height = '80px';
            //   img.setAttribute("src", url);

            holder.appendChild(createFileInfo(e));
            //  holder.appendChild(img);

            return holder;
        }

        function onClientUploadStart(sender, e) {
            document.getElementById('uploadCompleteInfo').innerHTML = 'Carregando ' + e.get_filesInQueue() + ' arquivo(s)...';
        }

        function onClientUploadCompleteAll(sender, e) {

            var args = JSON.parse(e.get_serverArguments()),
                unit = args.duration > 60 ? 'minutos' : 'segundos',
                duration = (args.duration / (args.duration > 60 ? 60 : 1)).toFixed(2);

            var info = 'Horario do servidor: <b>' + args.time + '</b> </br> <b>'
                + e.get_filesUploaded() + '</b> de <b>' + e.get_filesInQueue()
                + ' </br> </b> Status <b>"' + e.get_reason()
                + '" </br> </b> Tempo de carregamento: <b>' + duration + ' ' + unit + '</b>';

            document.getElementById('uploadCompleteInfo').innerHTML = info;
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="Server">
    <h3>
        <asp:Label ID="lblId" runat="server"></asp:Label>
        &nbsp;-
        <asp:Label ID="lblDna" runat="server"></asp:Label>
    </h3>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:DataList ID="lstData" runat="server" CellPadding="4" Width="100%" OnItemDataBound="lstData_ItemDataBound" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" GridLines="Horizontal">
        <FooterStyle BackColor="White" ForeColor="#333333" />
        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
        <ItemStyle BackColor="White" ForeColor="#333333" />
        <ItemTemplate>
            <strong><span class="auto-style3">Data:
            <asp:Label ID="lblData" runat="server" Text='<%#Bind("DtHr") %>'></asp:Label>
            </span></strong>
            <asp:DataList ID="dtlist" runat="server" CellPadding="5" RepeatColumns="4">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" class="preview" NavigateUrl='<%# Bind("Name", "Images/{0}") %>' ToolTip='<%#Bind("Name") %>'>
                        <asp:Image Width="100" ID="Image1" ImageUrl='<%# Bind("Name", "Images/{0}") %>' runat="server" />
                    </asp:HyperLink>
                    <br />
                    <asp:LinkButton ID="LinkButton1" PostBackUrl='<%# Bind("Name", "edit.aspx?img={0}") %>' runat="server">
                        Editar
                    </asp:LinkButton>

                </ItemTemplate>
                <ItemStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" VerticalAlign="Bottom" />
            </asp:DataList>
            <br />
            <hr />
        </ItemTemplate>
        <SelectedItemStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
    </asp:DataList>
    <br />


    <div class="demoarea">
        Clique em <i>Selecione Arquivo</i> para selecionar um arquivo de imagem para upload. Você pode enviar arquivos com a extensão jpg, jpeg ou png.  
       
        <br />
        <asp:Label runat="server" ID="myThrobber" Style="display: none;"><img align="absmiddle" alt="" src="uploading.gif"/></asp:Label>
        <ajaxToolkit:AjaxFileUpload ID="AjaxFileUpload1" runat="server" Padding-Bottom="4"
            Padding-Left="2" Padding-Right="1" Padding-Top="4" ThrobberID="myThrobber" OnClientUploadComplete="onClientUploadComplete"
            OnUploadComplete="AjaxFileUpload1_UploadComplete" MaximumNumberOfFiles="10"
            AllowedFileTypes="jpg,jpeg,png" AzureContainerName="" OnClientUploadCompleteAll="onClientUploadCompleteAll" OnUploadCompleteAll="AjaxFileUpload1_UploadCompleteAll" OnUploadStart="AjaxFileUpload1_UploadStart" OnClientUploadStart="onClientUploadStart" />

        <div id="uploadCompleteInfo"></div>
        <br />
        <div id="testuploaded" style="display: none; padding: 4px; border: gray 1px solid;">
            <strong>Arquivos:</strong>
            <hr />
            <div id="fileList">
            </div>
        </div>
        <%--  <asp:Button ID="btnSubmit" runat="server" Text="Submit" />--%>
    </div>








    </i>









</asp:Content>

