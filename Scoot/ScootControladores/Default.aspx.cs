using Infortronics;
using Newtonsoft.Json;
using System;
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

namespace GwCentral.Register.ScootControladores
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfUsuarioLogado.Value = User.Identity.Name;
            }
        }

        public struct controladoresCad
        {
            public string qtdCaractereIdentificacaoControlador { get; set; }
            public string id { get; set; }
            public string scnControlador { get; set; }
            public string ipControlador { get; set; }
            public string cruzamento { get; set; }
            public string anel1 { get; set; }
            public string anel2 { get; set; }
            public string anel3 { get; set; }
            public string anel4 { get; set; }
            public string qtdEstagio1 { get; set; }
            public string qtdEstagio2 { get; set; }
            public string qtdEstagio3 { get; set; }
            public string qtdEstagio4 { get; set; }
            public string estagiosDesativarTMPE1 { get; set; }
            public string estagiosDesativarTMPE2 { get; set; }
            public string estagiosDesativarTMPE3 { get; set; }
            public string estagiosDesativarTMPE4 { get; set; }
            public string cruzamentoAnel1 { get; set; }
            public string cruzamentoAnel2 { get; set; }
            public string cruzamentoAnel3 { get; set; }
            public string cruzamentoAnel4 { get; set; }
            public string tempoEnvioEstagio { get; set; }
        }

        [WebMethod]
        public static List<controladoresCad> carregarControladoresCad()
        {
            Banco db = new Banco("");
            List<controladoresCad> lst = new List<controladoresCad>();
            DataTable dt = db.ExecuteReaderQuery(
                @"SELECT id, scnControlador, ipControlador, cruzamento, scnAnel1, scnAnel2,[qtdCaractereIdentificacaoControlador], 
                scnAnel3, scnAnel4, qtdEstagioAnel1, qtdEstagioAnel2,qtdEstagioAnel3,
                qtdEstagioAnel4, estagiosDesativarTMPE1, estagiosDesativarTMPE2,
                estagiosDesativarTMPE3, estagiosDesativarTMPE4, cruzamentoAnel1,
                cruzamentoAnel2,cruzamentoAnel3,cruzamentoAnel4,tempoAntesEnvioEstagio 
                FROM scootControladores
                WHERE idPrefeitura='" + HttpContext.Current.Profile["idPrefeitura"] + "' "
                );

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new controladoresCad
                {
                    id = item["id"].ToString(),
                    scnControlador = item["scnControlador"].ToString(),
                    ipControlador = item["ipControlador"].ToString(),
                    cruzamento = item["cruzamento"].ToString(),
                    anel1 = item["scnAnel1"].ToString(),
                    anel2 = item["scnAnel2"].ToString(),
                    anel3 = item["scnAnel3"].ToString(),
                    anel4 = item["scnAnel4"].ToString(),
                    qtdEstagio1 = item["qtdEstagioAnel1"].ToString(),
                    qtdEstagio2 = item["qtdEstagioAnel2"].ToString(),
                    qtdEstagio3 = item["qtdEstagioAnel3"].ToString(),
                    qtdEstagio4 = item["qtdEstagioAnel4"].ToString(),
                    estagiosDesativarTMPE1 = item["estagiosDesativarTMPE1"].ToString(),
                    estagiosDesativarTMPE2 = item["estagiosDesativarTMPE2"].ToString(),
                    estagiosDesativarTMPE3 = item["estagiosDesativarTMPE3"].ToString(),
                    estagiosDesativarTMPE4 = item["estagiosDesativarTMPE4"].ToString(),
                    cruzamentoAnel1 = item["cruzamentoAnel1"].ToString(),
                    cruzamentoAnel2 = item["cruzamentoAnel2"].ToString(),
                    cruzamentoAnel3 = item["cruzamentoAnel3"].ToString(),
                    cruzamentoAnel4 = item["cruzamentoAnel4"].ToString(),
                    tempoEnvioEstagio = item["tempoAntesEnvioEstagio"].ToString(),
                    qtdCaractereIdentificacaoControlador=item["qtdCaractereIdentificacaoControlador"].ToString()
                });
            }

            return lst;
        }

        [WebMethod]
        public static string salvar(string qtdCaracteres, string controladorScn,
            string ipControlador, string cruzamento, string usuarioLogado,
            string anel1, string anel2, string anel3, string anel4, string lat,
            string lon, string qtdEstagio1, string qtdEstagio2, string qtdEstagio3,
            string qtdEstagio4, string tmpe1, string tmpe2, string tmpe3,
            string tmpe4, string cruzamentoAnel1, string cruzamentoAnel2,
            string cruzamentoAnel3, string cruzamentoAnel4, string tempoEnvioEstagio)
        {
            Banco db = new Banco("");
            string scnExistente = db.ExecuteScalarQuery(
                "SELECT id FROM scootControladores " +
                " WHERE scnControlador='" + controladorScn + "' " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " "
                );
            if (!string.IsNullOrEmpty(scnExistente))
            {
                return "Este controlador já está cadastrado";
            }

            string ipExistente = db.ExecuteScalarQuery(
                "SELECT id FROM scootControladores " +
                " WHERE ipControlador='" + ipControlador + "' " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " "
                );
            if (!string.IsNullOrEmpty(ipExistente))
            {
                return "Este IP já está cadastrado";
            }

            string idDepartamento = db.ExecuteScalarQuery(
               @"SELECT id FROM Departamento 
               WHERE idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " " +
               " AND nome='cruzamentos'"
               );

            db.ExecuteNonQuery(@"INSERT INTO Subdivisao_Departamento(Subdivisao,Endereco,cruzamento,idDepartamento,idPrefeitura)
                VALUES ('" + controladorScn + "','" + cruzamento + "','true','" + idDepartamento + "'," + HttpContext.Current.Profile["idPrefeitura"] + ")");

            //scootCONTROLADORES
            string id = db.ExecuteScalarQuery(
                "INSERT INTO scootControladores (qtdCaractereIdentificacaoControlador, " +
                " scnControlador, ipControlador,cruzamento,scnAnel1,scnAnel2,scnAnel3, " +
                " scnAnel4,latitude,longitude,qtdEstagioAnel1,qtdEstagioAnel2,qtdEstagioAnel3, " +
                " qtdEstagioAnel4,estagiosDesativarTMPE1,estagiosDesativarTMPE2, " +
                " estagiosDesativarTMPE3,estagiosDesativarTMPE4,idPrefeitura,cruzamentoAnel1, " +
                " cruzamentoAnel2,cruzamentoAnel3,cruzamentoAnel4,tempoAntesEnvioEstagio) " +
                " VALUES ('" + qtdCaracteres + "','" + controladorScn + "', " +
                " '" + ipControlador + "','" + cruzamento + "', " +
                " '" + anel1 + "','" + anel2 + "','" + anel3 + "','" + anel4 + "', " +
                " '" + lat + "','" + lon + "','" + qtdEstagio1 + "','" + qtdEstagio2 + "', " +
                " '" + qtdEstagio3 + "','" + qtdEstagio4 + "','" + tmpe1 + "', " +
                " '" + tmpe2 + "','" + tmpe3 + "','" + tmpe4 + "', " +
                " " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + cruzamentoAnel1 + "','" + cruzamentoAnel2 + "', " +
                " '" + cruzamentoAnel3 + "','" + cruzamentoAnel4 + "','" + tempoEnvioEstagio + "') " +
                " SELECT SCOPE_IDENTITY()"
                );

            string scnControladorE = db.ExecuteScalarQuery(
                "SELECT scnControlador FROM scootControladores WHERE id=" + id
                );

            //LOG
            db.ExecuteNonQuery(
                @"INSERT INTO LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) " +
                " VALUES ('" + usuarioLogado + "','Cadastro Controladores Scoot', " +
                HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "', " +
                " 'Salvou o scnControlador: " + controladorScn + ", " +
                " qtdCaractereIdentificacaoControlador: " + qtdCaracteres + ", " +
                " ipControlador: " + ipControlador + ",tempoEnvioEstagio: " + tempoEnvioEstagio + " " +
                " scnAnel1=" + anel1 + ", scnAnel2=" + anel2 + ", " +
                " scnAnel3=" + anel3 + ", scnAnel4=" + anel4 + " , " +
                " qtdEstagioAnel1=" + qtdEstagio1 + ", qtdEstagioAnel2=" + qtdEstagio2 + ", " +
                " qtdEstagioAnel3=" + qtdEstagio3 + ", qtdEstagioAnel4=" + qtdEstagio4 + ", " +
                " estagiosDesativarTMPE1=" + tmpe1 + ", estagiosDesativarTMPE2=" + tmpe2 + ", " +
                " estagiosDesativarTMPE3=" + tmpe3 + ", estagiosDesativarTMPE4=" + tmpe4 + " , " +
                " cruzamentoAnel1=" + cruzamentoAnel1 + ", cruzamentoAnel2=" + cruzamentoAnel2 + ", " +
                " cruzamentoAnel3=" + cruzamentoAnel3 + ", cruzamentoAnel4=" + cruzamentoAnel4 + "', " +
                " 'scootControladores')"
                );

            string idStatus = db.ExecuteScalarQuery(
                "SELECT ip FROM [status] " +
                " WHERE serial='" + controladorScn + "' " +
                " AND idPrefeitura is null"
                );
            if (idStatus != "")
            {
                db.ExecuteNonQuery(
                    "UPDATE [Status] SET  idDna ='" + controladorScn + "', " +
                    " idPrefeitura =" + HttpContext.Current.Profile["idPrefeitura"] +
                    " WHERE serial = '" + controladorScn + "' "
                    );
            }
            else
            {
                //STATUS
                db.ExecuteNonQuery(string.Format(
                    "INSERT INTO [Status] (Serial,IP,IdDna,IdPrefeitura,bRecebeIpTrap) " +
                    " VALUES ('{0}','{1}','{2}','{3}','true')", controladorScn, ipControlador,
                    controladorScn, HttpContext.Current.Profile["idPrefeitura"]
                    ));
            }

            //DNA
            db.ExecuteReaderQuery(string.Format(
                "INSERT INTO dna (Id,Cruzamento,latitude,longitude,Usuario,idPrefeitura, " +
                " datacadastro,habilitacaoCentral) " +
                " VALUES ('" + controladorScn + "','" + cruzamento + "','" + lat + "', " +
                " '" + lon + "','" + usuarioLogado + "', " +
                " " + HttpContext.Current.Profile["idPrefeitura"]) + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','true' )"
                );


            return "sucesso";
            //return id;
        }

        [WebMethod]
        public static string salvarAlteracoes(string controladorScn, string ipControlador,
            string cruzamento, string usuarioLogado, string anel1, string anel2, string anel3,
            string anel4, string lat, string lon, string qtdEstagio1, string qtdEstagio2,
            string qtdEstagio3, string qtdEstagio4, string id, string tmpe1, string tmpe2,
            string tmpe3, string tmpe4, string cruzamentoAnel1, string cruzamentoAnel2,
            string cruzamentoAnel3, string cruzamentoAnel4, string tempoEnvioEstagio)
        {

            Banco db = new Banco("");
            string scnExistente = db.ExecuteScalarQuery(
                "SELECT id FROM scootControladores " +
                " WHERE scnControlador=" + controladorScn + " " +
                " AND id<> " + id + " " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " "
                );
            if (!string.IsNullOrEmpty(scnExistente))
            {
                return "Este controlador já está cadastrado!";
            }

            string ipExistente = db.ExecuteScalarQuery(
                "SELECT id FROM scootControladores " +
                " WHERE ipControlador=" + ipControlador + " " +
                " AND id<> " + id + " " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " "
                );
            if (!string.IsNullOrEmpty(ipExistente))
            {
                return "Este IP já está cadastrado!";
            }

            db.ExecuteNonQuery(
                "UPDATE scootControladores SET ipControlador='" + ipControlador + "', " +
                " cruzamento='" + cruzamento + "', tempoAntesEnvioEstagio='" + tempoEnvioEstagio + "', " +
                " scnAnel1='" + anel1 + "', scnAnel2='" + anel2 + "', scnAnel3='" + anel3 + "', " +
                " scnAnel4='" + anel4 + "', latitude='" + lat + "', longitude='" + lon + "', " +
                " qtdEstagioAnel1='" + qtdEstagio1 + "', qtdEstagioAnel2='" + qtdEstagio2 + "', " +
                " qtdEstagioAnel3='" + qtdEstagio3 + "', qtdEstagioAnel4='" + qtdEstagio4 + "', " +
                " estagiosDesativarTMPE1='" + tmpe1 + "', estagiosDesativarTMPE2='" + tmpe2 + "', " +
                " estagiosDesativarTMPE3='" + tmpe3 + "', estagiosDesativarTMPE4='" + tmpe4 + "', " +
                " cruzamentoAnel1='" + cruzamentoAnel1 + "', cruzamentoAnel2='" + cruzamentoAnel2 + "', " +
                " cruzamentoAnel3='" + cruzamentoAnel3 + "', cruzamentoAnel4='" + cruzamentoAnel4 + "' " +
                " WHERE id=" + id
                );

            db.ExecuteNonQuery("UPDATE Subdivisao_Departamento set Endereco='" + cruzamento + "' where Subdivisao ='"+controladorScn+"' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

            db.ExecuteNonQuery(
                "UPDATE [Status] SET ip='" + ipControlador + "' " +
                " WHERE serial='" + controladorScn + "' " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]
                );

            db.ExecuteNonQuery(
                "UPDATE DNA SET cruzamento='" + cruzamento + "', " +
                " latitude='" + lat + "', longitude='" + lon + "' " +
                " WHERE id='" + controladorScn + "' " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]
                );

            //LOG
            db.ExecuteNonQuery(
                @"INSERT INTO LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) " +
                " VALUES ('" + usuarioLogado + "','Cadastro Controladores Scoot', " +
                HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "', " +
                " 'Alterou o controlador scoot:" + controladorScn + ", " +
                " IP: " + ipControlador + ", tempoEnvioEstagio='" + tempoEnvioEstagio + "', " +
                " idDNA: " + controladorScn + ", " +
                " scnAnel1=" + anel1 + ", scnAnel2=" + anel2 + ", " +
                " scnAnel3=" + anel3 + ", scnAnel4=" + anel4 + " , " +
                " qtdEstagioAnel1=" + qtdEstagio1 + ", " +
                " qtdEstagioAnel2=" + qtdEstagio2 + ", " +
                " qtdEstagioAnel3=" + qtdEstagio3 + ", " +
                " qtdEstagioAnel4=" + qtdEstagio4 + ", " +
                " estagiosDesativarTMPE1=" + tmpe1 + ", " +
                " estagiosDesativarTMPE2=" + tmpe2 + ", " +
                " estagiosDesativarTMPE3=" + tmpe3 + ", " +
                " estagiosDesativarTMPE4=" + tmpe4 + ", " +
                " cruzamentoAnel1=" + cruzamentoAnel1 + ", " +
                " cruzamentoAnel2=" + cruzamentoAnel2 + ", " +
                " cruzamentoAnel3=" + cruzamentoAnel3 + ", " +
                " cruzamentoAnel4=" + cruzamentoAnel4 + "', " +
                " 'scootControladores')"
                );

            return "sucesso";
        }

        [WebMethod]
        public static string excluirControladorScoot(string idControlador, string anel1, string anel2, string anel3, string anel4, string usuarioLogado, string scnControlador)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery("delete scootControladores where scnControlador='" + scnControlador + "' ");
            db.ExecuteNonQuery("delete [Status] where Serial='" + scnControlador + "' ");
            db.ExecuteNonQuery("delete DNA where Id='" + scnControlador + "' ");
            db.ExecuteNonQuery("delete Subdivisao_Departamento where subdivisao='"+scnControlador+"' and idprefeitura="+ HttpContext.Current.Profile["idPrefeitura"]);
            db.ExecuteNonQuery("delete scootAgendas where scnControlador='" + scnControlador + "' ");

            if (anel1 != "")
            {
                db.ExecuteNonQuery("delete scootEntreverdes where scnAnel='" + anel1 + "' ");
                db.ExecuteNonQuery("delete scootEstagios where scnAnel='" + anel1 + "' ");
                db.ExecuteNonQuery("delete scootPlanos where scnAnel='" + anel1 + "' ");
            }

            if (anel2 != "")
            {
                db.ExecuteNonQuery("delete scootEntreverdes where scnAnel='" + anel2 + "' ");
                db.ExecuteNonQuery("delete scootEstagios where scnAnel='" + anel2 + "' ");
                db.ExecuteNonQuery("delete scootPlanos where scnAnel='" + anel2 + "' ");
            }

            if (anel3 != "")
            {
                db.ExecuteNonQuery("delete scootEntreverdes where scnAnel='" + anel3 + "' ");
                db.ExecuteNonQuery("delete scootEstagios where scnAnel='" + anel3 + "' ");
                db.ExecuteNonQuery("delete scootPlanos where scnAnel='" + anel3 + "' ");
            }

            if (anel4 != "")
            {
                db.ExecuteNonQuery("delete scootEntreverdes where scnAnel='" + anel4 + "' ");
                db.ExecuteNonQuery("delete scootEstagios where scnAnel='" + anel4 + "' ");
                db.ExecuteNonQuery("delete scootPlanos where scnAnel='" + anel4 + "' ");
            }

            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + usuarioLogado + "','Cadastro Controladores Scoot', " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','Excluiu o Controlador Scoot: " + scnControlador + ", idControladorScoot: " + idControlador + "','scootControladores')");

            return "sucesso";
        }

        //TRADUÇÃO ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

        public static string getResource(string nameResource)        {            string valueResource = "";            string file = getFileResource(idioma);            string folder = "App_GlobalResources";            string filePath = HttpContext.Current.Server.MapPath(@"~\" + folder + @"\" + file);            XmlDocument document = new XmlDocument();            document.Load(filePath);            XmlNodeList nodes = document.SelectNodes("//data");            foreach (XmlNode node in nodes)            {                XmlAttribute attr = node.Attributes["name"];                string resourceKey = attr.Value;                if (resourceKey == nameResource)                {                    valueResource = HttpContext.GetGlobalResourceObject("Resource", resourceKey, cultureInfo).ToString();                    break;                }            }            return valueResource;        }        public static string getFileResource(string idioma)        {            string file = "Resource.resx";            if (!string.IsNullOrEmpty(idioma))            {                file = idioma.IndexOf("es") != -1 ? "Resource.es.resx" : file; //espanhol
                file = idioma.IndexOf("en") != -1 ? "Resource.en.resx" : file; //ingles
            }            return file;        }

        public static string idioma = "pt-BR";        public static CultureInfo cultureInfo;        protected override void InitializeCulture()        {            idioma = Request.UserLanguages != null ? Request.UserLanguages[0] : "pt-BR";            if (HttpContext.Current.Profile["idioma"].Equals(idioma) || string.IsNullOrEmpty(HttpContext.Current.Profile["idioma"].ToString()))            {                cultureInfo = new CultureInfo(idioma);                HttpContext.Current.Profile["idioma"] = idioma;                Thread.CurrentThread.CurrentCulture = cultureInfo;                Thread.CurrentThread.CurrentUICulture = cultureInfo;            }            else            {                idioma = HttpContext.Current.Profile["idioma"].ToString();                cultureInfo = new CultureInfo(idioma);                Thread.CurrentThread.CurrentCulture = cultureInfo;                Thread.CurrentThread.CurrentUICulture = cultureInfo;            }        }

        [WebMethod]        public static void changeLanguage(string idioma)        {            HttpContext.Current.Profile["idioma"] = idioma;        }

        [WebMethod]        public static object requestResource()        {            List<localesResource> resource = new List<localesResource>();            string file = getFileResource(idioma);            string folder = "App_GlobalResources";            string filePath = HttpContext.Current.Server.MapPath(@"~\" + folder + @"\" + file);            XmlDocument document = new XmlDocument();            document.Load(filePath);            XmlNodeList nodes = document.SelectNodes("//data");            foreach (XmlNode node in nodes)            {                XmlAttribute attr = node.Attributes["name"];                string resourceKey = attr.Value;                resource.Add(new localesResource                {                    name = resourceKey,                    value = HttpContext.GetGlobalResourceObject("Resource", resourceKey, cultureInfo).ToString()                });            }            var json = JsonConvert.SerializeObject(new { resource });            return json;        }
    }
}