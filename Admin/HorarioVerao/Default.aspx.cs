using Infortronics;
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

namespace GwCentral.Admin.HorarioVerao
{
    public partial class Default : System.Web.UI.Page
    {
        public static string idioma = "pt-BR";
        public static CultureInfo cultureInfo;
        protected override void InitializeCulture()
        {
            idioma = Request.UserLanguages != null ? Request.UserLanguages[0] : "pt-BR";
            if (HttpContext.Current.Profile["idioma"].Equals(idioma) || string.IsNullOrEmpty(HttpContext.Current.Profile["idioma"].ToString()))
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfUser.Value = User.Identity.Name;
            }
        }

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

        [WebMethod]
        public static List<HorarioVerao> getHorarioVerao()
        {
            List<HorarioVerao> lst = new List<HorarioVerao>();
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery("select * from HorarioVeraoCentral where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
            foreach (DataRow dr in dt.Rows)
            {
                string anoI = dr["DataInicial"].ToString().Substring(0, 4);
                string mesI = dr["DataInicial"].ToString().Substring(4, 2);
                string diaI = dr["DataInicial"].ToString().Substring(6, 2);
                string dtIni = diaI + "/" + mesI + "/" + anoI + " " + dr["DataInicial"].ToString().Substring(8, 2) + ":" + dr["DataInicial"].ToString().Substring(10, 2) + ":" + dr["DataInicial"].ToString().Substring(12, 2);
                string anoF = dr["DataFinal"].ToString().Substring(0, 4);
                string mesF = dr["DataFinal"].ToString().Substring(4, 2);
                string diaF = dr["DataFinal"].ToString().Substring(6, 2);
                string dtFim = diaF + "/" + mesF + "/" + anoF + " " + dr["DataFinal"].ToString().Substring(8, 2) + ":" + dr["DataFinal"].ToString().Substring(10, 2) + ":" + dr["DataFinal"].ToString().Substring(12, 2);

                lst.Add(new HorarioVerao
                {
                    Id = dr["Id"].ToString(),
                    Ano = dr["Ano"].ToString(),
                    DataFinal = dtFim,
                    DataInicial = dtIni,
                    User = dr["User"].ToString(),
                    DtHrAtualizacao = dr["DtHrAtualizacao"].ToString()
                });
            }
            return lst;
        }

        [WebMethod]
        public static void Enviar(string user)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(@"select d.id idEqp,ti.byte1,ti.id from DNA d JOIN 
TarefasImposicao ti on ti.IdControlador = d.id where idPrefeitura = "+ HttpContext.Current.Profile["idPrefeitura"]);
            foreach (DataRow dr in dt.Rows)
            {
                string valor = dr["Byte1"].ToString();
                int[] byte1 = DecimalToBinary(int.Parse(valor));
                byte1[5] = 1;

                Array.Reverse(byte1);
                string byteTarefas = string.Join("", byte1);
                int decimalValue = Convert.ToInt32(byteTarefas, 2);
                db.ExecuteNonQuery("Update TarefasImposicao set Byte1=" + decimalValue + " Where id=" + dr["id"].ToString());
                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Horario Verao Central'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                         "','Alterou a tarefa de todos os controladores para enviar o horario de verao','TarefasImposicao')");
            }
        }

        public static int[] DecimalToBinary(int number)
        {
            int[] binaryNum = new int[8];

            int i = 0;
            while (number > 0)
            {
                binaryNum[i] = number % 2;
                number = number / 2;
                i++;
            }
            return binaryNum;
        }
        [WebMethod]
        public static void Gerar(string user)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Horario Verao Central'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                     "','Gerou os horarios de verao','HorarioVeraoCentral')");
            int ano = Convert.ToInt32(DateTime.Now.Year.ToString());
            int contatador = 0;
            int qtd = 20;
            string Inicio = "";
            string Fim = "";
            string domingoCarnaval = "";
            string domingoPascoa = "";
            db.ExecuteNonQuery("DELETE FROM HorarioVeraoCentral where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
            while (qtd > contatador)
            {
                Inicio = Convert.ToString(InicioHorarioVerao(ano)).Replace("/","").Replace(":","").Replace(" ","0");
                Fim = Convert.ToString(TerminoHorarioVerao(ano)).Replace("/", "").Replace(":", "").Replace(" ", "0");
                domingoCarnaval = Convert.ToString(DomingoDeCarnaval(ano));
                domingoPascoa = Convert.ToString(DomingoDePascoa(ano));
                string anoI = Inicio.Substring(4, 4);
                string mesI = Inicio.Substring(2, 2);
                string diaI = Inicio.Substring(0, 2);
                string dtIni = anoI +  mesI  + diaI + Inicio.Substring(8, 2) + Inicio.Substring(10, 2)+ Inicio.Substring(12, 2);
                string anoF = Fim.Substring(4, 4);
                string mesF = Fim.Substring(2, 2);
                string diaF = Fim.Substring(0, 2);
                string dtFim = anoF + mesF  + diaF + Fim.Substring(8, 2) + Fim.Substring(10, 2) + Fim.Substring(12, 2);

                db.ExecuteNonQuery($"INSERT INTO  HorarioVeraoCentral (Ano, DataInicial, DataFinal,idPrefeitura,[user],dtHrAtualizacao) VALUES ('" + ano + "','"
                    + dtIni + "','" + dtFim + "'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + user + "','" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "')");
                contatador++;
                ano++;
            }
        }

        public static DateTime DomingoDePascoa(int ano)
        {
            Int32 a = ano % 19;
            Int32 b = ano / 100;
            Int32 c = ano % 100;
            Int32 d = b / 4;
            Int32 e = b % 4;
            Int32 f = (b + 8) / 25;
            Int32 g = (b - f + 1) / 3;
            Int32 h = (19 * a + b - d - g + 15) % 30;
            Int32 i = c / 4;
            Int32 k = c % 4;
            Int32 L = (32 + 2 * e + 2 * i - h - k) % 7;
            Int32 m = (a + 11 * h + 22 * L) / 451;
            Int32 mes = (h + L - 7 * m + 114) / 31;
            Int32 dia = ((h + L - 7 * m + 114) % 31) + 1;
            return new DateTime(ano, mes, dia);
        }

        private static DateTime DomingoDeCarnaval(int ano)
        {
            return DomingoDePascoa(ano).AddDays(-49);
        }

        private static DateTime InicioHorarioVerao(Int32 ano)
        {
            // terceiro domingo de outubro
            DateTime primeiroDeNovembro = new DateTime(ano, 10, 1);
            DateTime primeiroDomingoDeNovembro = primeiroDeNovembro.AddDays((7 - (Int32)primeiroDeNovembro.DayOfWeek) % 7);
            //  DateTime terceiroDomingoDeOutubro = primeiroDomingoDeNovembro.AddDays(14);
            return primeiroDomingoDeNovembro;
        }

        private static DateTime TerminoHorarioVerao(Int32 ano)
        {
            DateTime primeiroDeFevereiro = new DateTime(ano + 1, 2, 1);
            DateTime primeiroDomingoDeFevereiro = primeiroDeFevereiro.AddDays((7 - (Int32)primeiroDeFevereiro.DayOfWeek) % 7);
            DateTime terceiroDomingoDeFevereiro = primeiroDomingoDeFevereiro.AddDays(14);

            if (terceiroDomingoDeFevereiro != DomingoDeCarnaval(ano))
            {
                return terceiroDomingoDeFevereiro;
            }
            else
            {
                return terceiroDomingoDeFevereiro.AddDays(7);
            }
        }

        [WebMethod]
        public static string Salvar(string Id, string Ano, string DtInicial, string DtFinal, string user)
        {
            Banco db = new Banco("");
            DtInicial = DtInicial.Replace("/", "").Replace(":", "").Replace(" ", "");
            DtFinal = DtFinal.Replace("/", "").Replace(":", "").Replace(" ", "");
            string dtIni = DtInicial.Substring(4, 4) + DtInicial.Substring(2, 2) + DtInicial.Substring(0, 2) + DtInicial.Substring(6, 6);
            string dtFim = DtFinal.Substring(4, 4) + DtFinal.Substring(2, 2) + DtFinal.Substring(0, 2) + DtFinal.Substring(6, 6);

            string existe = db.ExecuteScalarQuery("select id from HorarioVeraoCentral where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and Id<>" + Id +
                " and Ano='" + Ano);
            if (existe != "")
            {
                return getResource("anoExistente");
            }

            db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Horario Verao Central'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                     "','Alterou o horario DataInicial: "+dtIni+", DataFinal: "+dtFim+", Ano: "+Ano+" do Id: "+Id+"','HorarioVeraoCentral')");
            db.ExecuteNonQuery("update HorarioVeraoCentral set Ano='" + Ano + "',DataInicial='" + dtIni + "',DataFinal='" + dtFim + "',[user]='" + user + "',DtHrAtualizacao='" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "' where id=" + Id);
            return "";
        }

        public struct HorarioVerao
        {
            public string Id { get; set; }
            public string Ano { get; set; }
            public string DataInicial { get; set; }
            public string DataFinal { get; set; }
            public string User { get; set; }
            public string DtHrAtualizacao { get; set; }
        }
    }
}