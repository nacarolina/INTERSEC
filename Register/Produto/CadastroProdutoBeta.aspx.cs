using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using static GwCentral.Admin.MapConfig;

namespace GwCentral.Register.Produto
{
    public partial class CadastroProdutoBeta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //hfusuarioLogado.Value = User.Identity.Name;
            }
        }

        public struct categorias
        {
            public string id { get; set; }
            public string categoria { get; set; }
        }

        [WebMethod]
        public static List<categorias> carregarCategorias()
        {
            Banco db = new Banco("");

            List<categorias> lst = new List<categorias>();

            DataTable dt = db.ExecuteReaderQuery(
                @"SELECT id, categoria FROM Categoria
                WHERE categoria IN('CONTROLADOR', 'GPRS', 'ACESSORIOS',
                'SISTEMA DE ILUMINAÇÃO', 'SISTEMA DE ILUMINACAO',
                'GRUPO FOCAL', 'CABO', 'CABOS', 'PLACA', 'PLACAS',
                'NOBREAK', 'COLUNA', 'COLUNAS')"
                );

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new categorias
                {
                    id = item["id"].ToString(),
                    categoria = item["categoria"].ToString()
                });
            }

            return lst;
        }

        public struct fabricante
        {
            public string id { get; set; }
            public string razaosocial { get; set; }
        }

        [WebMethod]
        public static List<fabricante> carregarFabricante()
        {
            Banco db = new Banco("");

            List<fabricante> lst = new List<fabricante>();

            DataTable dt = db.ExecuteReaderQuery(
                @"SELECT id, razaosocial FROM Fabricante"
                );

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new fabricante
                {
                    id = item["id"].ToString(),
                    razaosocial = item["razaosocial"].ToString()
                });
            }

            return lst;
        }

        public struct controladores
        {
            public string checkbox { get; set; }
            public string nome { get; set; }
            public string marca { get; set; }
            public string modelo { get; set; }
            public bool check { get; set; }
        }

        [WebMethod]
        public static List<controladores> carregarControladores(string idProdutoCadastrado)
        {
            Banco db = new Banco("");
            List<controladores> lst = new List<controladores>();

            DataTable dt;
            string idCategoriaControlador = db.ExecuteScalarQuery(
                @"SELECT Id FROM Categoria WHERE Categoria='CONTROLADOR' "
                );
            if (idProdutoCadastrado == "")
            {
                dt = db.ExecuteReaderQuery(
                    @"SELECT Id, NomeProduto, Marca, Modelo,'0'idPlacaControlador FROM  Produto
                WHERE IdCategoria=" + idCategoriaControlador
                    );
            }
            else
            {
                dt = db.ExecuteReaderQuery(
                    @"SELECT DISTINCT p.Id, NomeProduto,marca, Modelo, 
                    ISNULL(pc.idProdutoControlador,0) idPlacaControlador FROM  Produto p
                    LEFT JOIN PlacasControlador pc ON pc.idProdutoControlador = p.ID 
                    AND idProdutoPlaca='" + idProdutoCadastrado + "' " +
                    " WHERE IdCategoria=" + idCategoriaControlador
                    );
            }

            bool UsaEsseCtrl = false;
            string idPlacaControlador = "";
            foreach (DataRow item in dt.Rows)
            {
                idPlacaControlador = item["idPlacaControlador"].ToString();

                if (idPlacaControlador == "0")
                {
                    UsaEsseCtrl = false;
                }
                else
                {
                    UsaEsseCtrl = true;
                }

                lst.Add(new controladores
                {
                    checkbox = item["Id"].ToString(),
                    nome = item["NomeProduto"].ToString(),
                    marca = item["Marca"].ToString(),
                    modelo = item["Modelo"].ToString(),
                    check = UsaEsseCtrl
                });
            }

            return lst;
        }

        [WebMethod]
        public static string salvarProduto(string numeroSerie, string nomeProduto, string marca,
            string modelo, string tipoUnidade, string volume, string IdTipoProduto, string IdCategoria,
            string IdFabricante, string nomeFabricante)
        {
            Banco db = new Banco("");
            //Busca a razão social pra comparar 
            var verificaFabricante = db.ExecuteScalarQuery(
                @"SELECT razaoSocial FROM Fabricante WHERE id=" + IdFabricante
                );
            //Cadastra um novo fabricante caso não exista
            if (verificaFabricante != nomeFabricante)
            {
                IdFabricante = db.ExecuteScalarQuery(
                  @"INSERT INTO fabricante (RazaoSocial)
                  VALUES ('" + nomeFabricante + "') " +
                  " SELECT SCOPE_IDENTITY()"
                  );
            }

            var validaProduto = db.ExecuteScalarQuery(
                @"SELECT id FROM produto WHERE numeroSerie=" + numeroSerie
                );

            if (validaProduto != "")
            {
                return "numeroSerie_repetido";
            }

            var idProdutoCadastrado = db.ExecuteScalarQuery(
                @"INSERT INTO Produto (NumeroSerie,NomeProduto,TipoUni,Marca,
                Modelo,Volume,IdTipoProduto,IdCategoria,IdFabricante,idPrefeitura)
                VALUES ('" + numeroSerie + "','" + nomeProduto + "', " +
                " '" + tipoUnidade + "','" + marca + "','" + modelo + "', " +
                " '" + volume + "'," + IdTipoProduto + "," + IdCategoria + ", " +
                " " + IdFabricante + "," + HttpContext.Current.Profile["idPrefeitura"].ToString() + ") " +
                " SELECT SCOPE_IDENTITY()"
                );

            return idProdutoCadastrado;
        }

        [WebMethod]
        public static string alterarProduto(string numeroSerie, string nomeProduto, string marca,
            string modelo, string tipoUnidade, string volume, string IdTipoProduto, string IdCategoria,
            string IdFabricante, string idProdutoAlterado)
        {
            Banco db = new Banco("");

            var validaProduto = db.ExecuteScalarQuery(
                @"SELECT id FROM produto WHERE numeroSerie='" + numeroSerie + "' " +
                " AND id<> '" + idProdutoAlterado + "' "
                );

            if (validaProduto != "")
            {
                return "numeroSerie_repetido";
            }

            db.ExecuteNonQuery(
                @"UPDATE produto SET numeroSerie='" + numeroSerie + "', nomeProduto='" + nomeProduto + "', " +
                " tipoUni='" + tipoUnidade + "', marca='" + marca + "', modelo='" + modelo + "', " +
                " volume='" + volume + "', idTipoProduto='" + IdTipoProduto + "', " +
                " idCategoria='" + IdCategoria + "', idFabricante='" + IdFabricante + "' " +
                " WHERE id=" + idProdutoAlterado);

            //221 = PLACA
            if (IdCategoria == "221")
            {
                db.ExecuteNonQuery(
                    @"DELETE placasControlador WHERE idProdutoPlaca=" + idProdutoAlterado
                    );
            }

            return "sucesso";
        }

        [WebMethod]
        public static string salvarControladorSelecionado(string idControladorSelecionado,
            string idProdutoCadastrado)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery(
                @"INSERT INTO PlacasControlador (idProdutoControlador,idProdutoPlaca,idPrefeitura) 
                VALUES (" + idControladorSelecionado + "," + idProdutoCadastrado + ", " +
                " " + HttpContext.Current.Profile["idPrefeitura"].ToString() + ")"
                );


            return "";
        }

        public struct produtosCadastrados
        {
            public string id { get; set; }
            public string nomeProduto { get; set; }
            public string numeroSerie { get; set; }
            public string tipoUnidade { get; set; }
            public string marca { get; set; }
            public string modelo { get; set; }
            public string volume { get; set; }
            public string tipoProduto { get; set; }
            public string categoria { get; set; }
            public string fabricante { get; set; }
            public string idFabricante { get; set; }
        }

        [WebMethod]
        public static List<produtosCadastrados> carregarProdutosCadastrados()
        {
            Banco db = new Banco("");
            List<produtosCadastrados> lst = new List<produtosCadastrados>();

            DataTable dt = db.ExecuteReaderQuery(
                @"SELECT Id,NomeProduto,NumeroSerie,TipoUni,Marca,Modelo,Volume,
                idTipoProduto,idCategoria,
				Fabricante=(select razaosocial from Fabricante f WHERE f.id = p.idFabricante),
                idFabricante
                FROM Produto p 
                ORDER BY NomeProduto"
                );

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new produtosCadastrados
                {
                    id = item["Id"].ToString(),
                    nomeProduto = item["NomeProduto"].ToString(),
                    numeroSerie = item["NumeroSerie"].ToString(),
                    tipoUnidade = item["TipoUni"].ToString(),
                    marca = item["Marca"].ToString(),
                    modelo = item["Modelo"].ToString(),
                    volume = item["Volume"].ToString(),
                    tipoProduto = item["idTipoProduto"].ToString(),
                    categoria = item["idCategoria"].ToString(),
                    fabricante = item["Fabricante"].ToString(),
                    idFabricante = item["idFabricante"].ToString()
                });
            }

            return lst;
        }

        [WebMethod]
        public static void excluirProdutoCadastrado(string idProduto, string categoria)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery(@"DELETE Produto WHERE id=" + idProduto);

            //221 = PLACA
            if (categoria == "221")
            {
                db.ExecuteNonQuery(
                    @"DELETE PlacasControlador
                    WHERE idProdutoPlaca=" + idProduto
                    );
            }
            //222 = CONTROLADOR
            if (categoria == "222")
            {
                db.ExecuteNonQuery(
                    @"DELETE PlacasControlador 
                    WHERE idProdutoControlador=" + idProduto
                    );
            }
        }

        #region TRADUÇÃO -----------------------------------------------------------------------------------------
        public static string getResource(string nameResource)
        {
            string valueResource = "";
            string file = getFileResource(idioma);
            string folder = "App_GlobalResources";

            string filePath = HttpContext.Current.Server.MapPath(@"~\" + folder + @"\" + file);
            XmlDocument document = new XmlDocument();
            document.Load(filePath);

            XmlNodeList nodes = document.SelectNodes("//data");
            foreach (XmlNode node in nodes)
            {
                XmlAttribute attr = node.Attributes["name"];
                string resourceKey = attr.Value;
                if (resourceKey == nameResource)
                {
                    valueResource = HttpContext.GetGlobalResourceObject("Resource", resourceKey, cultureInfo).ToString();
                    break;
                }
            }
            return valueResource;
        }

        public static string getFileResource(string idioma)
        {
            string file = "Resource.resx";
            if (!string.IsNullOrEmpty(idioma))
            {
                file = idioma.IndexOf("es") != -1 ? "Resource.es.resx" : file; //espanhol
                file = idioma.IndexOf("en") != -1 ? "Resource.en.resx" : file; //ingles
            }
            return file;
        }

        public static string idioma = "pt-BR";
        public static CultureInfo cultureInfo;
        protected override void InitializeCulture()
        {
            idioma = Request.UserLanguages != null ? Request.UserLanguages[0] : "pt-BR";
            if (HttpContext.Current.Profile["idioma"].Equals(idioma) ||
                string.IsNullOrEmpty(HttpContext.Current.Profile["idioma"].ToString()))
            {
                cultureInfo = new CultureInfo(idioma);
                HttpContext.Current.Profile["idioma"] = idioma;
                Thread.CurrentThread.CurrentCulture = cultureInfo;
                Thread.CurrentThread.CurrentUICulture = cultureInfo;
            }
            else
            {
                idioma = HttpContext.Current.Profile["idioma"].ToString();
                cultureInfo = new CultureInfo(idioma);
                Thread.CurrentThread.CurrentCulture = cultureInfo;
                Thread.CurrentThread.CurrentUICulture = cultureInfo;
            }
        }

        [WebMethod]
        public static void changeLanguage(string idioma)
        {
            HttpContext.Current.Profile["idioma"] = idioma;
        }

        [WebMethod]
        public static object requestResource()
        {
            List<localesResource> resource = new List<localesResource>();
            string file = getFileResource(idioma);
            string folder = "App_GlobalResources";

            string filePath = HttpContext.Current.Server.MapPath(@"~\" + folder + @"\" + file);
            XmlDocument document = new XmlDocument();
            document.Load(filePath);

            XmlNodeList nodes = document.SelectNodes("//data");
            foreach (XmlNode node in nodes)
            {
                XmlAttribute attr = node.Attributes["name"];
                string resourceKey = attr.Value;
                resource.Add(new localesResource
                {
                    name = resourceKey,
                    value = HttpContext.GetGlobalResourceObject("Resource", resourceKey, cultureInfo).ToString()
                });
            }
            var json = JsonConvert.SerializeObject(new { resource });
            return json;
        }
        #endregion
    }
}