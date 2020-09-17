using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using static GwCentral.Admin.MapConfig;

namespace GwCentral.Scoot.Agenda
{
    public partial class Default : System.Web.UI.Page
    {
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

        protected void Page_Load(object sender, EventArgs e)
        {
            hfUser.Value = User.Identity.Name;
        }

        [WebMethod]
        public static ArrayList loadControladores()
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(@"select scnControlador from scootControladores where idprefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["scnControlador"].ToString(), dr["scnControlador"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public static ArrayList loadPlanosControlador(string controlador)
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco("");

            DataTable dtPlanos = db.ExecuteReaderQuery("select distinct Plano from scootPlanos p JOIN scootControladores c on c.scnControlador=p.scnControlador where p.scnControlador='" + controlador + "' ");
            //"(select distinct plano from scootAgendas where scnControlador = '"+controlador+"' ) <> plano");
            foreach (DataRow item in dtPlanos.Rows)
            {
                string sql = "select distinct scnAnel from scootPlanos where Plano=" + item["Plano"].ToString() + " and (";
                string aneis = "";
                DataTable dtAneis = db.ExecuteReaderQuery(@"select scnAnel1 from scootControladores where scnAnel1<>'' and scnControlador='" + controlador + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() +
    "union select scnAnel2 from scootControladores where scnAnel2<>'' and scnControlador='" + controlador + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() +
    "union select scnAnel3 from scootControladores where scnAnel3<>'' and scnControlador='" + controlador + "' and idPrefeitura= " + HttpContext.Current.Profile["idPrefeitura"].ToString() +
    "union select scnAnel4 from scootControladores where scnAnel4<>'' and scnControlador='" + controlador + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
                foreach (DataRow dr in dtAneis.Rows)
                {
                    if (aneis == "")
                        aneis = "scnAnel='" + dr["scnAnel1"].ToString() + "' ";
                    else
                        aneis += " or scnAnel='" + dr["scnAnel1"].ToString() + "'";
                }
                DataTable dtQtdAneisNoPlano = db.ExecuteReaderQuery(sql + aneis + ")");
                if (dtQtdAneisNoPlano.Rows.Count == dtAneis.Rows.Count)
                {
                    lst.Add(new ListItem(item["Plano"].ToString(), item["Plano"].ToString()));
                }
            }
            return lst;
        }

        public struct DiasAgenda
        {
            public string Dia { get; set; }
            public string Id { get; set; }
            public string Plano { get; set; }
            public string HorarioEntrada { get; set; }
        }

        [WebMethod]
        public static List<DiasAgenda> carregarDiasAgenda(string controlador, bool agruparDias)
        {
            List<DiasAgenda> lst = new List<DiasAgenda>();
            Banco db = new Banco("");

            DataTable dt;
            if (agruparDias)
            {
                dt = db.ExecuteReaderQuery("select diaSemana,Id, Plano,HorarioEntrada from scootAgendas where scnControlador='" + controlador + "' " +
                    " and idprefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() + " order by HorarioEntrada,diaSemana");
            }
            else
            {
                dt = db.ExecuteReaderQuery("select diaSemana,Id, Plano,HorarioEntrada from scootAgendas where scnControlador='" + controlador + "' " + 
                    " and idprefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() + " order by diaSemana,HorarioEntrada");
            }

            int i = 0;
            string diaSemana = ""; string hrIni = "", plano = "";
            string horario, hora, minuto, horarioFormatado;
            List<string> diasSemana = new List<string>();
            foreach (DataRow dr in dt.Rows)
            {
                i++;
                if (dr["diaSemana"].ToString() == "0")                    diaSemana = "Domingo";

                if (dr["diaSemana"].ToString() == "1")                    diaSemana = "Segunda";

                if (dr["diaSemana"].ToString() == "2")                    diaSemana = "Terça";

                if (dr["diaSemana"].ToString() == "3")                    diaSemana = "Quarta";

                if (dr["diaSemana"].ToString() == "4")                    diaSemana = "Quinta";

                if (dr["diaSemana"].ToString() == "5")                    diaSemana = "Sexta";

                if (dr["diaSemana"].ToString() == "6")                    diaSemana = "Sábado";

                if (agruparDias)
                {
                    horario = dr["HorarioEntrada"].ToString();
                    hora = horario.Substring(0, 2);
                    minuto = horario.Substring(2, 2);
                    horarioFormatado = hora + ":" + minuto;

                    if (plano == "")
                    {
                        plano = dr["Plano"].ToString();

                        hrIni = horarioFormatado;
                        diasSemana.Add(diaSemana);
                    }
                    else
                    {
                        if (plano != dr["Plano"].ToString() || hrIni != horarioFormatado)
                        {
                            if (diasSemana.Count == 7)
                                lst.Add(new DiasAgenda
                                {
                                    Id = "",
                                    Plano = plano,
                                    Dia = "Todos os dias",
                                    HorarioEntrada = hrIni
                                });
                            else if (diasSemana.Count == 6 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta") && diasSemana.Contains("Sabado"))
                                lst.Add(new DiasAgenda
                                {
                                    Id = "",
                                    Plano = plano,
                                    Dia = "Segunda - Sábado",
                                    HorarioEntrada = hrIni,
                                });
                            else if (diasSemana.Count == 5 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta"))
                                lst.Add(new DiasAgenda
                                {
                                    Id = "",
                                    Plano = plano,
                                    Dia = "Segunda - Sexta",
                                    HorarioEntrada = hrIni,
                                });
                            else if (diasSemana.Count == 2 && diasSemana.Contains("Sabado") && diasSemana.Contains("Domingo"))
                                lst.Add(new DiasAgenda
                                {
                                    Id = "",
                                    Plano = plano,
                                    Dia = "Sábado - Domingo",
                                    HorarioEntrada = hrIni
                                });
                            else
                                lst.Add(new DiasAgenda
                                {
                                    Id = "",
                                    Plano = plano,
                                    Dia = diasSemana.Count > 1 ? string.Join(", ", diasSemana) : diasSemana[0],
                                    HorarioEntrada = hrIni
                                });
                            diasSemana.Clear();
                        }
                        plano = dr["Plano"].ToString();
                        hrIni = horarioFormatado;
                        diasSemana.Add(diaSemana);
                    }
                    if (i == dt.Rows.Count)
                    {

                        if (diasSemana.Count == 7)
                            lst.Add(new DiasAgenda
                            {
                                Id = "",
                                Plano = plano,
                                Dia = "Todos os dias",
                                HorarioEntrada = hrIni
                            });
                        else if (diasSemana.Count == 6 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta") && diasSemana.Contains("Sabado"))
                            lst.Add(new DiasAgenda
                            {
                                Id = "",
                                Plano = plano,
                                Dia = "Segunda - Sábado",
                                HorarioEntrada = hrIni,
                            });
                        else if (diasSemana.Count == 5 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta"))
                            lst.Add(new DiasAgenda
                            {
                                Id = "",
                                Plano = plano,
                                Dia = "Segunda - Sexta",
                                HorarioEntrada = hrIni,
                            });
                        else if (diasSemana.Count == 2 && diasSemana.Contains("Sabado") && diasSemana.Contains("Domingo"))
                            lst.Add(new DiasAgenda
                            {
                                Id = "",
                                Plano = plano,
                                Dia = "Sábado - Domingo",
                                HorarioEntrada = hrIni
                            });
                        else
                            lst.Add(new DiasAgenda
                            {
                                Id = "",
                                Plano = plano,
                                Dia = diasSemana.Count > 1 ? string.Join(", ", diasSemana) : diasSemana[0],
                                HorarioEntrada = hrIni
                            });
                        diasSemana.Clear();
                    }
                }
                else
                {
                    horario = dr["HorarioEntrada"].ToString();
                    hora = horario.Substring(0, 2);
                    minuto = horario.Substring(2, 2);
                    horarioFormatado = hora + ":" + minuto;

                    lst.Add(new DiasAgenda
                    {
                        Id = dr["Id"].ToString(),
                        Dia = diaSemana,
                        Plano = dr["Plano"].ToString(),
                        HorarioEntrada = horarioFormatado
                    });
                }
            }

            return lst;
        }

        [WebMethod]
        public static string Salvar(string plano, string horarioEntrada, string controlador, string user, string diasSemana)
        {
            Banco db = new Banco("");

            string[] days = diasSemana.Split(',');
            int ii = 0;
            while (days.Length > ii)
            {
                string dia = days[ii].ToString();
                string diaSemanaFormatado = "";
                if (dia == "Domingo")
                    diaSemanaFormatado = "0";

                if (dia == "Segunda")
                    diaSemanaFormatado = "1";

                if (dia == "Terça")
                    diaSemanaFormatado = "2";

                if (dia == "Quarta")
                    diaSemanaFormatado = "3";

                if (dia == "Quinta")
                    diaSemanaFormatado = "4";

                if (dia == "Sexta")
                    diaSemanaFormatado = "5";

                if (dia == "Sábado")
                    diaSemanaFormatado = "6";

                string existe = db.ExecuteScalarQuery("select id from scootAgendas where scnControlador='" + controlador + "' " + 
                    " and horarioEntrada='" + horarioEntrada + "' and diaSemana='" + diaSemanaFormatado + "'");
                if (existe != "")
                    return "plano";

                db.ExecuteNonQuery("insert into scootAgendas (plano,scnControlador,horarioEntrada,idPrefeitura,diaSemana) " +
                    " values ('" + plano + "','" + controlador + "','" + horarioEntrada + "', " +
                    " " + HttpContext.Current.Profile["idPrefeitura"] + ", '" + diaSemanaFormatado + "')");
                ii++;
            }

            return "SUCESSO";
        }

        [WebMethod]
        public static string SalvarAlteracao(string id, string horarioEntrada, string user, string plano, string controlador)
        {
            Banco db = new Banco("");

            string existe = db.ExecuteScalarQuery("select id from scootAgendas where scnControlador='" + controlador + "' and horarioEntrada='" + horarioEntrada + "' and id<>" + id);
            if (existe != "")
                return "plano";

            db.ExecuteNonQuery("update scootAgendas set horarioEntrada='" + horarioEntrada + "' where id=" + id);
            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Scoot - Agendas'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Alterou o horarioEntrada: " + horarioEntrada + " do plano: " + plano + " do controlador: " + controlador + "','scootAgendas')");
            return "SUCESSO";
        }

        [WebMethod]
        public static void Excluir(string plano, string id, string controlador, string user, string horarioEntrada)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery("delete scootAgendas where id=" + id);
            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Scoot - Agendas'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Excluiu a agenda horarioEntrada:" + horarioEntrada + " do plano: " + plano + " do controlador: " + controlador + "','scootAgendas')");
        }

        [WebMethod]
        public static void excluirAgenda(string diaSemana, string controlador, string usuarioLogado)
        {
            Banco db = new Banco("");

            string diaSemanaFormatado = "";
            if (diaSemana == "Domingo")
                diaSemanaFormatado = "0";

            if (diaSemana == "Segunda")
                diaSemanaFormatado = "1";

            if (diaSemana == "Terça")
                diaSemanaFormatado = "2";

            if (diaSemana == "Quarta")
                diaSemanaFormatado = "3";

            if (diaSemana == "Quinta")
                diaSemanaFormatado = "4";

            if (diaSemana == "Sexta")
                diaSemanaFormatado = "5";

            if (diaSemana == "Sábado")
                diaSemanaFormatado = "6";

            db.ExecuteNonQuery("delete scootAgendas where diaSemana='" + diaSemanaFormatado + "' and scnControlador='" + controlador + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " ");

            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + usuarioLogado + "','Scoot - Agendas'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Excluiu a agenda do Controlador:" + controlador + " do Dia: " + diaSemanaFormatado + " ,'scootAgendas')");
        }

        public struct Agenda
        {
            public string Plano { get; set; }
            public string HorarioEntrada { get; set; }
            public string Dia { get; set; }
            public string id { get; set; }
        }

        public struct Estagios
        {
            public string id { get; set; }
            public string estagio { get; set; }
            public string verdeSeguranca { get; set; }
            public string verdeMax { get; set; }
        }
    }
}