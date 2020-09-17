using Infortronics;
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

namespace GwCentral.Register.AgendaSubAreas
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
                hfIdPrefeitura.Value = HttpContext.Current.Profile["idPrefeitura"].ToString();
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
        public static ArrayList loadArea(string idPrefeitura)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery("select Nome,id from Area_SubArea where tipo='area' and idPrefeitura=" + idPrefeitura);
            ArrayList lst = new ArrayList();
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["Nome"].ToString(), dr["id"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public static ArrayList loadSubareaPesq(string idPrefeitura)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(@"select (select Nome from Area_SubArea a1 where a1.id= a.idArea)+ ' - '+Nome Nome,id from Area_SubArea a 
where idPrefeitura= " + idPrefeitura + " and tipo='subArea'");
            ArrayList lst = new ArrayList();
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["Nome"].ToString(), dr["Id"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public static ArrayList loadSubArea(string idPrefeitura, string idArea)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery("select Nome,Id from Area_SubArea where idArea=" + idArea + " and idPrefeitura=" + idPrefeitura);
            ArrayList lst = new ArrayList();
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["Nome"].ToString(), dr["Id"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public static ArrayList loadAgenda(string idPrefeitura)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery("select * from AgendaCentral where idPrefeitura=" + idPrefeitura);
            ArrayList lst = new ArrayList();
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["NomeAgenda"].ToString(), dr["Id"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public static List<Agenda> GetAgendaHorarios(string idPrefeitura, string idAgenda)
        {
            Banco db = new Banco("");
            List<Agenda> lst = new List<Agenda>();

            List<string> diasSemana = new List<string>();
            string hrIni = "", hrFim = "", plano = "";

            DataTable dt = db.ExecuteReaderQuery("select * from AgendaCentralHorarios where idPrefeitura=" + idPrefeitura + " and idAgendaCentral=" + idAgenda + " and Tabelaespecial='true' order by Plano,DtHrIniTblEspecial");
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["TabelaEspecial"].ToString().ToLower() == "true")
                {
                    hrIni = dr["DtHrIniTblEspecial"].ToString().Substring(0, 2) + "/" + dr["DtHrIniTblEspecial"].ToString().Substring(2, 2) + "/" + dr["DtHrIniTblEspecial"].ToString().Substring(4, 4) + " " + dr["DtHrIniTblEspecial"].ToString().Substring(8, 2) + ":" + dr["DtHrIniTblEspecial"].ToString().Substring(10, 2) + ":" + dr["DtHrIniTblEspecial"].ToString().Substring(12, 2);
                    hrFim = dr["DtHrFimTblEspecial"].ToString().Substring(0, 2) + "/" + dr["DtHrFimTblEspecial"].ToString().Substring(2, 2) + "/" + dr["DtHrFimTblEspecial"].ToString().Substring(4, 4) + " " + dr["DtHrFimTblEspecial"].ToString().Substring(8, 2) + ":" + dr["DtHrFimTblEspecial"].ToString().Substring(10, 2) + ":" + dr["DtHrFimTblEspecial"].ToString().Substring(12, 2);

                    lst.Add(new Agenda
                    {
                        Id = dr["Id"].ToString(),
                        Plano = dr["Plano"].ToString(),
                        Dia = "",
                        HrFim = hrFim,
                        HrIni = hrIni,
                        TabelaEspecial = "Sim"
                    });
                }
            }

            dt = db.ExecuteReaderQuery("select * from AgendaCentralHorarios where idAgendaCentral=" + idAgenda + " and  idPrefeitura=" + idPrefeitura + " and Tabelaespecial='false' order by Plano,HrIni");

            foreach (DataRow dr in dt.Rows)
            {

                if (plano == "")
                {
                    plano = dr["Plano"].ToString();
                    hrIni = dr["HrIni"].ToString();
                    diasSemana.Add(dr["DiasSemana"].ToString());
                }
                else
                {
                    if (plano != dr["Plano"].ToString() || hrIni != dr["HrIni"].ToString())
                    {
                        hrIni = hrIni.PadLeft(6, '0');
                        hrIni = hrIni.Substring(0, 2) + ":" + hrIni.Substring(2, 2) + ":" + hrIni.Substring(4, 2);

                        if (diasSemana.Count == 7)
                            lst.Add(new Agenda
                            {
                                Id = "",
                                Plano = plano,
                                Dia = "Todos os dias",
                                HrFim = "",
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else if (diasSemana.Count == 6 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta") && diasSemana.Contains("Sabado"))
                            lst.Add(new Agenda
                            {
                                Id = "",
                                Plano = plano,
                                Dia = "Segunda - Sábado",
                                HrFim = "",
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else if (diasSemana.Count == 5 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta"))
                            lst.Add(new Agenda
                            {
                                Id = "",
                                Plano = plano,
                                Dia = "Segunda - Sexta",
                                HrFim = "",
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else if (diasSemana.Count == 2 && diasSemana.Contains("Sabado") && diasSemana.Contains("Domingo"))
                            lst.Add(new Agenda
                            {
                                Id = "",
                                Plano = plano,
                                Dia = "Sábado - Domingo",
                                HrFim = "",
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else
                            lst.Add(new Agenda
                            {
                                Id = "",
                                Plano = plano,
                                Dia = diasSemana.Count > 1 ? string.Join(", ", diasSemana) : diasSemana[0],
                                HrFim = "",
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        diasSemana.Clear();
                    }
                    plano = dr["Plano"].ToString();
                    hrIni = dr["HrIni"].ToString();
                    diasSemana.Add(dr["DiasSemana"].ToString());

                }

            }
            if (diasSemana.Count > 0)
            {
                hrIni = hrIni.PadLeft(6, '0');
                hrIni = hrIni.Substring(0, 2) + ":" + hrIni.Substring(2, 2) + ":" + hrIni.Substring(4, 2);
                if (diasSemana.Count == 7)
                    lst.Add(new Agenda
                    {
                        Plano = plano,
                        Dia = "Todos os dias",
                        HrFim = "",
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else if (diasSemana.Count == 6 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta") && diasSemana.Contains("Sabado"))
                    lst.Add(new Agenda
                    {
                        Plano = plano,
                        Dia = "Segunda - Sábado",
                        HrFim = "",
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else if (diasSemana.Count == 5 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta"))
                    lst.Add(new Agenda
                    {
                        Plano = plano,
                        Dia = "Segunda - Sexta",
                        HrFim = "",
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else if (diasSemana.Count == 2 && diasSemana.Contains("Sabado") && diasSemana.Contains("Domingo"))
                    lst.Add(new Agenda
                    {
                        Plano = plano,
                        Dia = "Sábado - Domingo",
                        HrFim = "",
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else
                    lst.Add(new Agenda
                    {
                        Plano = plano,
                        Dia = string.Join(", ", diasSemana),
                        HrFim = "",
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                diasSemana.Clear();
            }


            return lst;
        }

        [WebMethod]
        public static string Salvar(string idPrefeitura, string idArea, string idSubarea, string idAgenda, string subarea, string user)
        {
            Banco db = new Banco("");
            string existe = db.ExecuteScalarQuery("select id from AgendaSubarea where idPrefeitura=" + idPrefeitura + " and idSubarea=" + idSubarea + " and idAgendaCentral<>" + idAgenda);
            if (!string.IsNullOrEmpty(existe))
                return getResource("subAreaVinculadaAgenda");

            existe = db.ExecuteScalarQuery("select id from AgendaSubarea where idPrefeitura=" + idPrefeitura + " and idSubarea=" + idSubarea + " and idAgendaCentral=" + idAgenda);
            if (string.IsNullOrEmpty(existe))
            {
                string agenda = db.ExecuteScalarQuery("select nomeagenda from AgendaCentral where id=" + idAgenda);
                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Vincular Sub-Area na Agenda'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                        "','Cadastrou a sub-area: " + subarea + ", idSubarea: " + idSubarea + ", idArea: " + idArea + " na agenda: " + agenda + " idAgendaCentral: " + idAgenda + "','AgendaSubArea')");

                db.ExecuteNonQuery("insert into AgendaSubArea (idAgendaCentral,idArea,idSubarea,idPrefeitura) values (" + idAgenda + "," + idArea + "," + idSubarea + "," + idPrefeitura + ")");
            }
            DataTable dt = db.ExecuteReaderQuery(@"select byte1,IdControlador from TarefasImposicao ti JOIN
Status s on s.serial = convert(varchar, ti.IdControlador)
JOIN AreaAneis aa on aa.idEqp = s.idDNA
 where aa.idArea = " + idSubarea);
            foreach (DataRow dr in dt.Rows)
            {
                int[] byte1 = DecimalToBinary(int.Parse(dr["Byte1"].ToString()));
                byte1[4] = 1;
                setByteTarefas(byte1, dr["IdControlador"].ToString());
            }
            return "SUCESSO";
        }

        public static void setByteTarefas(int[] byte1, string idEqp)
        {
            Banco db = new Banco("");
            Array.Reverse(byte1);
            string byteTarefas = string.Join("", byte1);
            int decimalValue = Convert.ToInt32(byteTarefas, 2);
            db.ExecuteNonQuery("Update TarefasImposicao set Byte1=" + decimalValue + " Where IdControlador='" + idEqp+"'");
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
        public static void ExcluirSubAreaAgenda(string idPrefeitura, string idSubArea, string idAgenda, string user)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery("select nome,idArea from Area_SUbarea where id=" + idSubArea);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                string agenda = db.ExecuteScalarQuery("select nomeagenda from AgendaCentral where id=" + idAgenda);
                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Vincular Sub-Area na Agenda'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                         "','Excluiu a sub-area: " + dr["nome"].ToString() + ", idSubarea: " + idSubArea + ", idArea: " + dr["idArea"].ToString() + " da agenda: " + agenda + ", idAgendaCentral: " + idAgenda + "','AgendaSubArea')");

                db.ExecuteNonQuery("delete AgendaSubarea where idAgendaCentral=" + idAgenda + " and idPrefeitura=" + idPrefeitura + " and idSubArea=" + idSubArea);
            }
        }

        [WebMethod]
        public static void Delete(string idPrefeitura, string idArea, string idAgenda)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery("delete AgendaSubarea where idAgendaCentral=" + idAgenda + " and idPrefeitura=" + idPrefeitura + " and idArea=" + idArea);
        }

        [WebMethod]
        public static List<AgendaSubarea> GetAgendaSubarea(string idPrefeitura, string idAgenda, string idSubArea)
        {
            Banco db = new Banco("");
            List<AgendaSubarea> lst = new List<AgendaSubarea>();

            string sql = @"select distinct area=(select nome from Area_SubArea ars where ars.id=ags.idArea),
(STUFF((SELECT ', ' + (ars.nome) from AgendaSubArea ags1
JOIN Area_SubArea ars on ars.id=ags1.idSubArea
where ags1.idarea=ags.idarea and ags1.idAgendaCentral=ags.idAgendaCentral
FOR XML PATH('')), 1, 2, '' )) subAreas,
agenda=(select nomeAgenda from AgendaCentral ac where ac.id=ags.idAgendaCentral),idAgendaCentral,idArea 
from AgendaSubArea ags
where idprefeitura=" + idPrefeitura;
            if (!string.IsNullOrEmpty(idAgenda))
            {
                sql += " and idAgendaCentral=" + idAgenda;
            }
            if (!string.IsNullOrEmpty(idSubArea))
            {
                sql += " and idSubarea=" + idSubArea;
            }
            DataTable dt = db.ExecuteReaderQuery(sql);
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new AgendaSubarea
                {
                    Agenda = dr["agenda"].ToString(),
                    Area = dr["area"].ToString(),
                    SubAreas = dr["subAreas"].ToString(),
                    idAgenda = dr["idAgendaCentral"].ToString(),
                    idArea = dr["idArea"].ToString()
                });
            }
            return lst;
        }

        public struct Agenda
        {
            public string HrIni { get; set; }
            public string HrFim { get; set; }
            public string Plano { get; set; }
            public string TabelaEspecial { get; set; }
            public string DtHrIniTblEspecial { get; set; }
            public string DtHrFimTblEspecial { get; set; }
            public string idAgendaCentral { get; set; }
            public string Dia { get; set; }
            public string Id { get; set; }
        }
        public struct AgendaSubarea
        {
            public string id { get; set; }
            public string Area { get; set; }
            public string SubAreas { get; set; }
            public string Agenda { get; set; }
            public string idArea { get; set; }
            public string idSubarea { get; set; }
            public string idAgenda { get; set; }
        }
    }
}