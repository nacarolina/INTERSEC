using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Threading;
using System.Web;
using System.Web.Services;

namespace GwCentral.Controlador
{
    public partial class Agenda : System.Web.UI.Page
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
                hfIdEqp.Value = Request.QueryString["idEqp"];
            }
        }

        [WebMethod]
        public static List<Agendas> GetAgendaCentral(string idEqp)
        {
            List<Agendas> lst = new List<Agendas>();
            Banco db = new Banco("");

            List<string> diasSemana = new List<string>();
            string hrIni = "", hrFim = "", plano = "", agenda = "", subarea = "", anel = "";

            DataTable dt = db.ExecuteReaderQuery(@"select ah.DtHrFimTblEspecial,ah.DtHrIniTblEspecial,ah.plano,anel,
agenda=(select nomeagenda from AgendaCentral ac where ac.id=ah.idAgendaCentral),subarea=(select nome from Area_SubArea ass where ass.id=aa.idArea)
 from AgendaCentralHorarios ah 
 JOIN AgendaSubArea ags on ags.idAgendaCentral=ah.idAgendaCentral
 JOIN AreaAneis aa on aa.idArea=ags.idSubArea
 JOIN Area_SubArea a on a.id=aa.idArea
where ah.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and idEqp ='" + idEqp + "' and Tabelaespecial='true' order by anel,DtHrIniTblEspecial");
            foreach (DataRow dr in dt.Rows)
            {
                hrIni = dr["DtHrIniTblEspecial"].ToString().Substring(0, 2) + "/" + dr["DtHrIniTblEspecial"].ToString().Substring(2, 2) + "/" + dr["DtHrIniTblEspecial"].ToString().Substring(4, 4) + " " + dr["DtHrIniTblEspecial"].ToString().Substring(8, 2) + ":" + dr["DtHrIniTblEspecial"].ToString().Substring(10, 2) + ":" + dr["DtHrIniTblEspecial"].ToString().Substring(12, 2);
                hrFim = dr["DtHrFimTblEspecial"].ToString().Substring(0, 2) + "/" + dr["DtHrFimTblEspecial"].ToString().Substring(2, 2) + "/" + dr["DtHrFimTblEspecial"].ToString().Substring(4, 4) + " " + dr["DtHrFimTblEspecial"].ToString().Substring(8, 2) + ":" + dr["DtHrFimTblEspecial"].ToString().Substring(10, 2) + ":" + dr["DtHrFimTblEspecial"].ToString().Substring(12, 2);

                if (idioma=="es")
                {
                    dr["Plano"] = dr["Plano"].ToString().Replace("PLANO", "PLAN").Replace("AMARELO", "AMARILLO");
                }
                lst.Add(new Agendas
                {
                    Subarea = dr["Subarea"].ToString(),
                    Anel = dr["Anel"].ToString(),
                    Agenda = dr["Agenda"].ToString(),
                    Plano = dr["Plano"].ToString(),
                    Dia = "",
                    HrFim = hrFim,
                    HrIni = hrIni,
                    TabelaEspecial = "Sim"
                });
            }

            dt = db.ExecuteReaderQuery(@" select ah.HrIni,ah.plano,agenda=(select nomeagenda from AgendaCentral ac where ac.id=ah.idAgendaCentral),DiasSemana,
 subarea=(select nome from Area_SubArea ass where ass.id=aa.idArea),anel
 from AgendaCentralHorarios ah
 JOIN AgendaSubArea ags on ags.idAgendaCentral = ah.idAgendaCentral
 JOIN AreaAneis aa on aa.idArea = ags.idSubArea
 JOIN Area_SubArea a on a.id=aa.idArea
 where ah.idPrefeitura = " + HttpContext.Current.Profile["idPrefeitura"] + " and idEqp = '" + idEqp + "' and TabelaEspecial = 'false' order by anel, hrIni");

            foreach (DataRow dr in dt.Rows)
            {

                if (idioma == "es")
                {
                    dr["Plano"] = dr["Plano"].ToString().Replace("PLANO", "PLAN").Replace("AMARELO", "AMARILLO");
                }
                if (plano == "")
                {
                    anel = dr["Anel"].ToString();
                    subarea = dr["SubArea"].ToString();
                    plano = dr["Plano"].ToString();
                    hrIni = dr["HrIni"].ToString();
                    diasSemana.Add(dr["DiasSemana"].ToString());
                    agenda = dr["Agenda"].ToString();
                }
                else
                {
                    if (plano != dr["Plano"].ToString() || hrIni != dr["HrIni"].ToString() || anel != dr["Anel"].ToString())
                    {
                        hrIni = hrIni.PadLeft(6, '0');
                        hrIni = hrIni.Substring(0, 2) + ":" + hrIni.Substring(2, 2) + ":" + hrIni.Substring(4, 2);

                        if (diasSemana.Count == 7)
                            lst.Add(new Agendas
                            {
                                Subarea = subarea,
                                Anel = anel,
                                Agenda = agenda,
                                Plano = plano,
                                Dia = "Todos os dias",
                                HrFim = "",
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else if (diasSemana.Count == 6 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta") && diasSemana.Contains("Sabado"))
                            lst.Add(new Agendas
                            {
                                Subarea = subarea,
                                Anel = anel,
                                Agenda = agenda,
                                Plano = plano,
                                Dia = "Segunda - Sábado",
                                HrFim = "",
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else if (diasSemana.Count == 5 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta"))
                            lst.Add(new Agendas
                            {
                                Subarea = subarea,
                                Anel = anel,
                                Agenda = agenda,
                                Plano = plano,
                                Dia = "Segunda - Sexta",
                                HrFim = "",
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else if (diasSemana.Count == 2 && diasSemana.Contains("Sabado") && diasSemana.Contains("Domingo"))
                            lst.Add(new Agendas
                            {
                                Subarea = subarea,
                                Anel = anel,
                                Agenda = agenda,
                                Plano = plano,
                                Dia = "Sábado - Domingo",
                                HrFim = "",
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else
                            lst.Add(new Agendas
                            {
                                Subarea = subarea,
                                Anel = anel,
                                Agenda = agenda,
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
                    agenda = dr["Agenda"].ToString();
                    anel = dr["Anel"].ToString();
                    subarea = dr["Subarea"].ToString();
                }

            }
            if (diasSemana.Count > 0)
            {
                hrIni = hrIni.PadLeft(6, '0');
                hrIni = hrIni.Substring(0, 2) + ":" + hrIni.Substring(2, 2) + ":" + hrIni.Substring(4, 2);
                if (diasSemana.Count == 7)
                    lst.Add(new Agendas
                    {
                        Subarea = subarea,
                        Anel = anel,
                        Agenda = agenda,
                        Plano = plano,
                        Dia = "Todos os dias",
                        HrFim = "",
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else if (diasSemana.Count == 6 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta") && diasSemana.Contains("Sabado"))
                    lst.Add(new Agendas
                    {
                        Subarea = subarea,
                        Anel = anel,
                        Agenda = agenda,
                        Plano = plano,
                        Dia = "Segunda - Sábado",
                        HrFim = "",
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else if (diasSemana.Count == 5 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta"))
                    lst.Add(new Agendas
                    {
                        Subarea = subarea,
                        Anel = anel,
                        Agenda = agenda,
                        Plano = plano,
                        Dia = "Segunda - Sexta",
                        HrFim = "",
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else if (diasSemana.Count == 2 && diasSemana.Contains("Sabado") && diasSemana.Contains("Domingo"))
                    lst.Add(new Agendas
                    {
                        Subarea = subarea,
                        Anel = anel,
                        Agenda = agenda,
                        Plano = plano,
                        Dia = "Sábado - Domingo",
                        HrFim = "",
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else
                    lst.Add(new Agendas
                    {
                        Subarea = subarea,
                        Anel = anel,
                        Agenda = agenda,
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
        public static List<Agendas> GetAgendaEqp(string idEqp)
        {
            List<Agendas> lst = new List<Agendas>();
            Banco db = new Banco("");

            List<string> diasSemana = new List<string>();
            string hrIni = "", hrFim = "", plano = "", agenda = "", subarea = "", anel = "";

            DataTable dt = db.ExecuteReaderQuery(@"select DtHrFimTblEspecial,DtHrIniTblEspecial,plano,nomeagenda agenda, ''anel,''subarea from Agenda where idEqp='" + idEqp + "' and TabelaEspecial='true' order by Plano,DtHrIniTblEspecial");
            foreach (DataRow dr in dt.Rows)
            {
                string anoIni = dr["DtHrIniTblEspecial"].ToString().Substring(0, 4);
                string mesIni = dr["DtHrIniTblEspecial"].ToString().Substring(4, 2);
                string diaIni = dr["DtHrIniTblEspecial"].ToString().Substring(6, 2);
                string anoFim = dr["DtHrFimTblEspecial"].ToString().Substring(0, 4);
                string mesFim = dr["DtHrFimTblEspecial"].ToString().Substring(4, 2);
                string diaFim = dr["DtHrFimTblEspecial"].ToString().Substring(6, 2);
                hrIni = diaIni + "/" + mesIni + "/" + anoIni + " " + dr["DtHrIniTblEspecial"].ToString().Substring(8, 2) + ":" + dr["DtHrIniTblEspecial"].ToString().Substring(10, 2) + ":" + dr["DtHrIniTblEspecial"].ToString().Substring(12, 2);
                hrFim = diaFim + "/" + mesFim + "/" + anoFim + " " + dr["DtHrFimTblEspecial"].ToString().Substring(8, 2) + ":" + dr["DtHrFimTblEspecial"].ToString().Substring(10, 2) + ":" + dr["DtHrFimTblEspecial"].ToString().Substring(12, 2);

                if (idioma == "es")
                {
                    dr["Plano"] = dr["Plano"].ToString().Replace("PLANO", "PLAN").Replace("AMARELO", "AMARILLO");
                }
                lst.Add(new Agendas
                {
                    Subarea = dr["Subarea"].ToString(),
                    Anel = dr["Anel"].ToString(),
                    Agenda = dr["Agenda"].ToString(),
                    Plano = dr["Plano"].ToString(),
                    Dia = "",
                    HrFim = hrFim,
                    HrIni = hrIni,
                    TabelaEspecial = "Sim"
                });
            }

            dt = db.ExecuteReaderQuery(@" select HrIni,HrFim,plano,NomeAgenda agenda,DiasSemana,''anel,''subarea from Agenda where idEqp = '" + idEqp + "' and TabelaEspecial = 'false' order by Plano, hrIni");

            foreach (DataRow dr in dt.Rows)
            {

                if (idioma == "es")
                {
                    dr["Plano"] = dr["Plano"].ToString().Replace("PLANO", "PLAN").Replace("AMARELO", "AMARILLO");
                }
                if (plano == "")
                {
                    anel = dr["Anel"].ToString();
                    subarea = dr["SubArea"].ToString();
                    plano = dr["Plano"].ToString();
                    hrIni = dr["HrIni"].ToString();
                    hrFim = dr["hrFim"].ToString();
                    diasSemana.Add(dr["DiasSemana"].ToString());
                    agenda = dr["Agenda"].ToString();
                }
                else
                {
                    if (plano != dr["Plano"].ToString() || hrIni != dr["HrIni"].ToString())
                    {
                        if (hrIni.Contains(":") == false)
                        {
                            hrIni = hrIni.PadLeft(6, '0');
                            hrIni = hrIni.Substring(0, 2) + ":" + hrIni.Substring(2, 2) + ":" + hrIni.Substring(4, 2);
                        }
                        if (hrFim.Contains(":") == false)
                        {
                            hrFim = hrFim.PadLeft(6, '0');
                            hrFim = hrFim.Substring(0, 2) + ":" + hrFim.Substring(2, 2) + ":" + hrFim.Substring(4, 2);
                        }

                        if (diasSemana.Count == 7)
                            lst.Add(new Agendas
                            {
                                Subarea = subarea,
                                Anel = anel,
                                Agenda = dr["Agenda"].ToString(),
                                Plano = plano,
                                Dia = "Todos os dias",
                                HrFim = hrFim,
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else if (diasSemana.Count == 6 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta") && diasSemana.Contains("Sabado"))
                            lst.Add(new Agendas
                            {
                                Subarea = subarea,
                                Anel = anel,
                                Agenda = dr["Agenda"].ToString(),
                                Plano = plano,
                                Dia = "Segunda - Sábado",
                                HrFim = hrFim,
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else if (diasSemana.Count == 5 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta"))
                            lst.Add(new Agendas
                            {
                                Subarea = subarea,
                                Anel = anel,
                                Agenda = dr["Agenda"].ToString(),
                                Plano = plano,
                                Dia = "Segunda - Sexta",
                                HrFim = hrFim,
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else if (diasSemana.Count == 2 && diasSemana.Contains("Sabado") && diasSemana.Contains("Domingo"))
                            lst.Add(new Agendas
                            {
                                Subarea = subarea,
                                Anel = anel,
                                Agenda = dr["Agenda"].ToString(),
                                Plano = plano,
                                Dia = "Sábado - Domingo",
                                HrFim = hrFim,
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        else
                            lst.Add(new Agendas
                            {
                                Subarea = subarea,
                                Anel = anel,
                                Agenda = dr["Agenda"].ToString(),
                                Plano = plano,
                                Dia = diasSemana.Count > 1 ? string.Join(", ", diasSemana) : diasSemana[0],
                                HrFim = hrFim,
                                HrIni = hrIni,
                                TabelaEspecial = "Nao"
                            });
                        diasSemana.Clear();
                    }
                    hrFim = dr["hrFim"].ToString();
                    plano = dr["Plano"].ToString();
                    hrIni = dr["HrIni"].ToString();
                    diasSemana.Add(dr["DiasSemana"].ToString());
                    agenda = dr["Agenda"].ToString();
                    anel = dr["Anel"].ToString();
                    subarea = dr["Subarea"].ToString();
                }

            }
            if (diasSemana.Count > 0)
            {
                if (hrIni.Contains(":") == false)
                {
                    hrIni = hrIni.PadLeft(6, '0');
                    hrIni = hrIni.Substring(0, 2) + ":" + hrIni.Substring(2, 2) + ":" + hrIni.Substring(4, 2);
                }
                if (hrFim.Contains(":") == false)
                {
                    hrFim = hrFim.PadLeft(6, '0');
                    hrFim = hrFim.Substring(0, 2) + ":" + hrFim.Substring(2, 2) + ":" + hrFim.Substring(4, 2);
                }
                if (diasSemana.Count == 7)
                    lst.Add(new Agendas
                    {
                        Subarea = subarea,
                        Anel = anel,
                        Agenda = agenda,
                        Plano = plano,
                        Dia = "Todos os dias",
                        HrFim = hrFim,
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else if (diasSemana.Count == 6 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta") && diasSemana.Contains("Sabado"))
                    lst.Add(new Agendas
                    {
                        Subarea = subarea,
                        Anel = anel,
                        Agenda = agenda,
                        Plano = plano,
                        Dia = "Segunda - Sábado",
                        HrFim = hrFim,
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else if (diasSemana.Count == 5 && diasSemana.Contains("Segunda") && diasSemana.Contains("Terca") && diasSemana.Contains("Quarta") && diasSemana.Contains("Quinta") && diasSemana.Contains("Sexta"))
                    lst.Add(new Agendas
                    {
                        Subarea = subarea,
                        Anel = anel,
                        Agenda = agenda,
                        Plano = plano,
                        Dia = "Segunda - Sexta",
                        HrFim = hrFim,
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else if (diasSemana.Count == 2 && diasSemana.Contains("Sabado") && diasSemana.Contains("Domingo"))
                    lst.Add(new Agendas
                    {
                        Subarea = subarea,
                        Anel = anel,
                        Agenda = agenda,
                        Plano = plano,
                        Dia = "Sábado - Domingo",
                        HrFim = hrFim,
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                else
                    lst.Add(new Agendas
                    {
                        Subarea = subarea,
                        Anel = anel,
                        Agenda = agenda,
                        Plano = plano,
                        Dia = string.Join(", ", diasSemana),
                        HrFim = hrFim,
                        HrIni = hrIni,
                        TabelaEspecial = "Nao"
                    });
                diasSemana.Clear();
            }

            return lst;
        }
        public struct Agendas
        {
            public string Plano { get; set; }
            public string HrIni { get; set; }
            public string HrFim { get; set; }
            public string DtHrIni { get; }
            public string DtHrFim { get; set; }
            public string Dia { get; set; }
            public string TabelaEspecial { get; set; }
            public string Subarea { get; set; }
            public string Agenda { get; set; }
            public string Anel { get; set; }
        }
    }
}