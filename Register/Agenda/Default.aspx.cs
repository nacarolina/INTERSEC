using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Resources;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace GwCentral.Register.Agenda
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
                hfIdPrefeitura.Value = HttpContext.Current.Profile["idPrefeitura"].ToString();
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

        [WebMethod]
        public static string ValidarAgendaHorarios(string idAgendaCentral, string idPrefeitura, string user)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Agenda'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Validou a agenda idAgendaCentral: " + idAgendaCentral + "','AgendaCentralHorarios')");

            #region VALIDAÇÃO

            #region VALIDAÇÃO TABELA NÃO ESPECIAL
            DataTable dt = db.ExecuteReaderQuery("Select distinct DiasSemana from AgendaCentralHorarios Where IdPrefeitura=" + idPrefeitura + " and idAgendaCentral=" + idAgendaCentral + " AND tabelaespecial = 0");

            if (dt.Rows.Count < 7)
                return getResource("alert_agendaTodoDia");

            foreach (DataRow dr in dt.Rows)
            {
                DataTable dtHrDiaSemana = db.ExecuteReaderQuery("SELECT HrIni,id from AgendaCentralHorarios WHERE  DiasSemana = '" + dr[0].ToString() + "' and idAgendaCentral=" + idAgendaCentral + " and idPrefeitura=" + idPrefeitura + " order by convert(int,HrIni)");

                int SequenciaDiaria = 0;

                foreach (DataRow drHoraDiaSemana in dtHrDiaSemana.Rows)
                {

                    if (SequenciaDiaria == 0)
                    {
                        if (Convert.ToInt32(drHoraDiaSemana["HrIni"]) > 0)
                            return dr[0].ToString() + " " + getResource("naoPossuiPlanoConfigurado") + " - 00:00:00!";
                    }

                    DataTable dtEncavalamentoDeHora = db.ExecuteReaderQuery("SELECT count(0)qtd from AgendaCentralHorarios WHERE DiasSemana = '" + dr[0].ToString() + "' AND idPrefeitura = " + idPrefeitura + " and idAgendaCentral=" + idAgendaCentral + " and (" + drHoraDiaSemana["HrIni"].ToString() + " =HrIni)");
                    if (dtEncavalamentoDeHora.Rows.Count > 0)
                    {
                        #region convert to brTime
                        string drHoraIniDiaSemana = drHoraDiaSemana["HrIni"].ToString();
                        try
                        {
                            drHoraIniDiaSemana = drHoraIniDiaSemana.PadLeft(6, '0');
                            drHoraIniDiaSemana = drHoraIniDiaSemana.Substring(0, 2) + ":" + drHoraIniDiaSemana.Substring(2, 2) + ":" + drHoraIniDiaSemana.Substring(4);
                        }
                        catch (Exception)
                        {

                        }
                        #endregion
                        if (Convert.ToInt32(dtEncavalamentoDeHora.Rows[0][0]) > 1)
                            return getResource("existe") + " " + dtEncavalamentoDeHora.Rows[0][0] + " " + getResource("planosConfigMesmoHorario") + " - " + drHoraIniDiaSemana;
                    }

                    SequenciaDiaria++;

                    db.ExecuteNonQuery("update AgendaCentralHorarios set validouAgenda='true' where id=" + drHoraDiaSemana["id"].ToString());
                }
            }
            #endregion

            #region VALIDAÇÃO TABELA ESPECIAL

            dt = db.ExecuteReaderQuery("Select id,DtHrIniTblEspecial, DtHrFimTblEspecial  from AgendaCentralHorarios Where idAgendaCentral=" + idAgendaCentral + " and idPrefeitura=" + idPrefeitura + " AND tabelaespecial = 1");

            foreach (DataRow drTblEspecial in dt.Rows)
            {
                DataTable dtEncavalamentoDeHora = db.ExecuteReaderQuery("SELECT count(0)qtd from AgendaCentralHorarios WHERE idAgendaCentral=" + idAgendaCentral + " and idPrefeitura = " + idPrefeitura + " and ((" + drTblEspecial["DtHrIniTblEspecial"].ToString() + " >=DtHrIniTblEspecial and " + drTblEspecial["DtHrIniTblEspecial"].ToString() + " <= DtHrFimTblEspecial) or (" + drTblEspecial["DtHrFimTblEspecial"].ToString() + "  >=DtHrIniTblEspecial and " + drTblEspecial["DtHrFimTblEspecial"].ToString() + " <= DtHrFimTblEspecial))");
                if (dtEncavalamentoDeHora.Rows.Count > 0)
                {
                    string DtHrIniTblEspecial = drTblEspecial["DtHrIniTblEspecial"].ToString();
                    string DtHrFimTblEspecial = drTblEspecial["DtHrFimTblEspecial"].ToString();
                    #region convert to DatetimeBR
                    try
                    {
                        if (DtHrIniTblEspecial.Length < 14)
                            DtHrIniTblEspecial = DtHrIniTblEspecial.Substring(6, 2) + "/" + DtHrIniTblEspecial.Substring(4, 2) + "/" + DtHrIniTblEspecial.Substring(0, 4);
                        else
                        {
                            DtHrIniTblEspecial = DtHrIniTblEspecial.Substring(6, 2) + "/" + DtHrIniTblEspecial.Substring(4, 2) + "/" + DtHrIniTblEspecial.Substring(0, 4) + " " + DtHrIniTblEspecial.Substring(8, 2) + ":" + DtHrIniTblEspecial.Substring(10, 2) + ":" + DtHrIniTblEspecial.Substring(12);
                        }//2018043019120000
                    }
                    catch
                    {

                    }
                    try
                    {
                        if (DtHrFimTblEspecial.Length < 14)
                            DtHrFimTblEspecial = DtHrFimTblEspecial.Substring(6, 2) + "/" + DtHrFimTblEspecial.Substring(4, 2) + "/" + DtHrFimTblEspecial.Substring(0, 4);
                        else
                        {
                            DtHrFimTblEspecial = DtHrFimTblEspecial.Substring(6, 2) + "/" + DtHrFimTblEspecial.Substring(4, 2) + "/" + DtHrFimTblEspecial.Substring(0, 4) + " " + DtHrFimTblEspecial.Substring(8, 2) + ":" + DtHrIniTblEspecial.Substring(10, 2) + ":" + DtHrFimTblEspecial.Substring(12);
                        }//2018043019120000
                    }
                    catch
                    {

                    }

                    #endregion
                    if (Convert.ToInt32(dtEncavalamentoDeHora.Rows[0][0]) > 1)
                        return getResource("existe") + " " + dtEncavalamentoDeHora.Rows[0][0] + " " + getResource("planoConfigMesmoPeriodo") + " : " + DtHrIniTblEspecial + " - " + DtHrFimTblEspecial;
                }
                db.ExecuteNonQuery("update AgendaCentralHorarios set validouAgenda='true' where id=" + drTblEspecial["id"].ToString());
            }
            #endregion
            #endregion

            return "SUCESSO";
        }

        [WebMethod]
        public static string SalvarAgendaHorarios(string plano, bool tblEspecial, string HrIni, string TblEspecialHrIni, string TblEspecialHrFim,
            string diasSemana, string idPrefeitura, string idAgenda, string origem, string idAgendaAnterior, string planoAnterior, string hrIniAnterior, string diasSemanaAnterior, string user)
        {
            Banco db = new Banco("");
            string HrIniSemPonto = HrIni.Replace(":", "").Trim();

            DataTable dt;
            if (tblEspecial)
            {
                string DtHrIni = TblEspecialHrIni, DtHrFim = TblEspecialHrFim;

                DateTime dtIni, dtFim;

                try
                {
                    dtIni = Convert.ToDateTime(TblEspecialHrIni);

                    DtHrIni = TblEspecialHrIni.Substring(6, 4) + TblEspecialHrIni.Substring(3, 2) + TblEspecialHrIni.Substring(0, 2) + TblEspecialHrIni.Replace(":", "").Substring(11, 6);
                }
                catch
                {
                    return getResource("data") + " " + getResource("hora") + " " + getResource("inicial") + " " + getResource("invalida") + "!";
                }

                try
                {
                    dtFim = Convert.ToDateTime(TblEspecialHrFim);
                    if (TblEspecialHrFim.Replace(":", "").Substring(11, 4) == "0000")
                    {
                        TblEspecialHrFim = TblEspecialHrFim.Replace(TblEspecialHrFim.Substring(11, 7), "23:59:59");
                    }
                    DtHrFim = TblEspecialHrFim.Substring(6, 4) + TblEspecialHrFim.Substring(3, 2) + TblEspecialHrFim.Substring(0, 2) + TblEspecialHrFim.Replace(":", "").Substring(11, 6);
                    if (Convert.ToInt64(DtHrIni) >= Convert.ToInt64(DtHrFim))
                    {
                        return getResource("data") + " " + getResource("hora") + " " + getResource("final") + " " + getResource("invalida") + "!";
                    }
                }
                catch
                {
                    return getResource("data") + " " + getResource("hora") + " " + getResource("final") + " " + getResource("invalida") + "!";
                }
                db.ExecuteNonQuery(@"insert into AgendaCentralHorarios (idAgendaCentral,Plano,idPrefeitura,HrIni,TabelaEspecial,DtHrIniTblEspecial,
DtHrFimTblEspecial,DiasSemana,validouAgenda) values(" + idAgenda + ",'" + plano + "'," + idPrefeitura + ",'','true','" + TblEspecialHrIni.Replace("/", "").Replace(":", "").Replace(" ", "") + "','" + TblEspecialHrFim.Replace("/", "").Replace(":", "").Replace(" ", "") + "','','false')");

                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Agenda'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
              "','Salvou a agenda Horarios HrIni: " + TblEspecialHrIni + ", HrFim: " + TblEspecialHrFim + ", TabelaEspecial: true, validouAgenda: false, Plano: " + plano + ", idAgendaCentral: " + idAgenda + "','AgendaCentralHorarios')");
            }
            else
            {
                HrIniSemPonto = HrIniSemPonto.PadLeft(6, '0');
                string[] days = diasSemana.Split(',');
                string[] dayAnterior = diasSemanaAnterior.Split(',');
                int ii = 0;

                if (origem == "Alterar")
                {
                    db.ExecuteNonQuery("delete from AgendaCentralHorarios where idAgendaCentral=" + idAgendaAnterior + " and Plano='" + planoAnterior + "' and IdPrefeitura=" + idPrefeitura + " and hrini='" + Convert.ToInt32(hrIniAnterior.Replace(":", "")) + "' and diassemana in ('" + string.Join("','", dayAnterior.ToArray()) + "')");
                }
                while (days.Length > ii)
                {
                    string dia = days[ii].ToString();

                    dt = db.ExecuteReaderQuery("select id, Plano,HrIni,HrFim,DiasSemana,TabelaEspecial,DtHrIniTblEspecial," +
                    "DtHrFimTblEspecial from agendaCentralHorarios where idAgendaCentral=" + idAgenda + " and TabelaEspecial=0 and " + HrIniSemPonto + " = HrIni and idPrefeitura=" + idPrefeitura + " AND DiasSemana = '" + dia + "'");
                    if (dt.Rows.Count > 0)
                    {
                        return getResource("horarioAgendaExistente") + "!";
                    }
                    db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Agenda'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                  "','Salvou a agenda Horarios HrIni: " + HrIni + ", TabelaEspecial: false, validouAgenda: false, DiasSemana: " + dia + ", Plano: " + plano + ", idAgendaCentral: " + idAgenda + "','AgendaCentralHorarios')");

                    db.ExecuteNonQuery("INSERT INTO  AgendaCentralHorarios (idAgendaCentral, Plano,HrIni,DiasSemana,TabelaEspecial,DtHrIniTblEspecial," +
                    "DtHrFimTblEspecial,idPrefeitura,validouAgenda) VALUES(" + idAgenda + ", '" + plano + "'," + HrIniSemPonto + ",'" + dia + "',0,NULL,NULL," + idPrefeitura + ",'false')");
                    ii++;
                }
            }

            return "SUCESSO";
        }

        [WebMethod]
        public static string SalvarAgenda(string nomeAgenda, string idPrefeitura, string user)
        {
            Banco db = new Banco("");
            string existe = db.ExecuteScalarQuery("select id from AgendaCentral where idPrefeitura=" + idPrefeitura + " and nomeAgenda='" + nomeAgenda + "'");
            if (!string.IsNullOrEmpty(existe))
            {
                return "ATENÇÃO:" + getResource("AgendaExisteMesmoNome") + "!";
            }
            string id = db.ExecuteScalarQuery("insert into AgendaCentral (nomeAgenda, idPrefeitura) values ('" + nomeAgenda + "'," + idPrefeitura + ") select SCOPE_IDENTITY()");

            db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Agenda'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                  "','Salvou a agenda: " + nomeAgenda + ", idAgendaCentral: " + id + "','AgendaCentral')");

            return id;
        }

        [WebMethod]
        public static string ExcluirAgenda(string idAgenda, string user)
        {
            Banco db = new Banco("");
            string nomeAgenda = db.ExecuteScalarQuery("select nomeAgenda from AgendaCentral where id=" + idAgenda);

            db.ExecuteNonQuery("delete AgendaCentral where id=" + idAgenda);
            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Agenda', " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','Excluiu a agenda: " + nomeAgenda + ", idAgendaCentral: " + idAgenda + "','AgendaCentral')");

            return "sucesso";
        }

        [WebMethod]
        public static string AlterarAgenda(string nomeAgenda, string idAgenda, string user)
        {
            Banco db = new Banco("");
            string existe = db.ExecuteScalarQuery("select id from AgendaCentral where id<>" + idAgenda + " and nomeAgenda='" + nomeAgenda + "'");
            if (!string.IsNullOrEmpty(existe))
            {
                return getResource("AgendaExisteMesmoNome") + "!";
            }

            db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Agenda'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
          "','Alterou a agenda: " + nomeAgenda + ", idAgendaCentral: " + idAgenda + "','AgendaCentral')");

            db.ExecuteNonQuery("update AgendaCentral set NomeAgenda='" + nomeAgenda + "' where id=" + idAgenda);

            return "SUCESSO";
        }

        [WebMethod]
        public static string ExcluirAgendaHorarios(string plano, string idAgendaHorarios, string HrIni, string idPrefeitura, string idAgendaCentral, string user, string HrFim, string dia)
        {
            Banco db = new Banco("");

            if (idioma == "es")
            {
                plano = plano.Replace("PLAN", "PLANO").Replace("AMARILLO", "AMARELO");
            }
            if (string.IsNullOrEmpty(idAgendaHorarios) || idAgendaHorarios == "null")
            {
                db.ExecuteNonQuery("delete AgendaCentralHorarios where idAgendaCentral=" + idAgendaCentral + " and plano='" + plano + "' and idPrefeitura=" + idPrefeitura + " and HrIni='" + Convert.ToInt32(HrIni.Replace(":", "")) + "'");

                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Agenda'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
              "','Excluiu a agenda horarios plano: " + plano + ", HrIni: " + HrIni + ", tabelaEspecial: false, idAgendaCentral: " + idAgendaCentral + ", dia: " + dia + "','AgendaCentral')");
            }
            else
            {
                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + user + "','Cadastro Agenda'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
              "','Excluiu a agenda horarios plano: " + plano + ", HrIni: " + HrIni + ", HrFim: " + HrFim + ", tabelaEspecial: true, idAgendaCentral: " + idAgendaCentral + ", dia: " + dia + "','AgendaCentral')");
                db.ExecuteNonQuery("delete AgendaCentralHorarios where id=" + idAgendaHorarios);
            }

            return "SUCESSO";
        }

        [WebMethod]
        public static List<Agenda> GetAgendaHorarios(string idPrefeitura, bool agruparDias, string idAgenda)
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

                    if (idioma == "es")
                    {
                        lst.Add(new Agenda
                        {
                            Id = dr["Id"].ToString(),
                            Plano = dr["Plano"].ToString().Replace("PLANO", "PLAN").Replace("AMARELO", "AMARILLO"),
                            Dia = "",
                            HrFim = hrFim,
                            HrIni = hrIni,
                            TabelaEspecial = "Sim"
                        });
                    }
                    else
                    {
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
            }

            dt = db.ExecuteReaderQuery("select * from AgendaCentralHorarios where idAgendaCentral=" + idAgenda + " and  idPrefeitura=" + idPrefeitura + " and Tabelaespecial='false' order by Plano,HrIni");

            if (agruparDias)
            {
                foreach (DataRow dr in dt.Rows)
                {

                    if (idioma == "es")
                    {
                        dr["Plano"] = dr["Plano"].ToString().Replace("PLANO", "PLAN").Replace("AMARELO", "AMARILLO");

                    }
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
                        if (idioma == "es")
                        {
                            plano = dr["Plano"].ToString().Replace("PLANO", "PLAN").Replace("AMARELO", "AMARILLO");
                        }
                        else
                        {
                            plano = dr["Plano"].ToString();
                        }
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
            }
            else
            {

                foreach (DataRow dr in dt.Rows)
                {
                    if (idioma == "es")
                    {
                        plano = dr["Plano"].ToString().Replace("PLANO", "PLAN").Replace("AMARELO", "AMARILLO");
                    }
                    else
                    {
                        plano = dr["Plano"].ToString();
                    }
                    hrIni = dr["HrIni"].ToString();
                    string dia = dr["DiasSemana"].ToString();
                    string tblEspecial = dr["TabelaEspecial"].ToString();
                    if (tblEspecial.ToLower() == "true")
                    {
                        tblEspecial = "Sim";
                        hrIni = dr["DtHrIniTblEspecial"].ToString().Substring(0, 2) + "/" + dr["DtHrIniTblEspecial"].ToString().Substring(2, 2) + "/" + dr["DtHrIniTblEspecial"].ToString().Substring(4, 4) + " " + dr["DtHrIniTblEspecial"].ToString().Substring(8, 2) + ":" + dr["DtHrIniTblEspecial"].ToString().Substring(10, 2) + ":" + dr["DtHrIniTblEspecial"].ToString().Substring(12, 2);
                        hrFim = dr["DtHrFimTblEspecial"].ToString().Substring(0, 2) + "/" + dr["DtHrFimTblEspecial"].ToString().Substring(2, 2) + "/" + dr["DtHrFimTblEspecial"].ToString().Substring(4, 4) + " " + dr["DtHrFimTblEspecial"].ToString().Substring(8, 2) + ":" + dr["DtHrFimTblEspecial"].ToString().Substring(10, 2) + ":" + dr["DtHrFimTblEspecial"].ToString().Substring(12, 2);
                    }
                    else
                    {
                        hrFim = "";
                        tblEspecial = "Nao";
                        hrIni = hrIni.PadLeft(6, '0');
                        hrIni = hrIni.Substring(0, 2) + ":" + hrIni.Substring(2, 2) + ":" + hrIni.Substring(4, 2);
                    }
                    lst.Add(new Agenda
                    {
                        Id = dr["id"].ToString(),
                        Plano = plano,
                        Dia = dia,
                        HrFim = hrFim,
                        HrIni = hrIni,
                        TabelaEspecial = tblEspecial
                    });
                }

            }

            return lst;
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

        public struct localesResource
        {
            public string name { get; set; }
            public string value { get; set; }
        }

    }
}