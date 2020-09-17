using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Dynamic;
using System.Globalization;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.Profile;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace GwCentral
{
    public partial class Mapa : System.Web.UI.Page
    {
        Banco db = new Banco("");
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

                if (string.IsNullOrEmpty(User.Identity.Name))
                {
                    pnlMap.Visible = false;
                    Response.Redirect("~/Account/Login.aspx");
                }

                else
                {
                    HttpContext.Current.Profile["idioma"] = idioma;
                    pnlMap.Visible = true;

                    #region Verifica Resete Controlador

                    bool rolesUser = Roles.IsUserInRole("ResetaControlador");

                    if (rolesUser == true)
                    {
                        hfResetaControlador.Value = "True";
                    }
                    else
                    {
                        hfResetaControlador.Value = "False";
                    }

                    #endregion

                    if (HttpContext.Current.Profile["idPrefeitura"].ToString() == "" || HttpContext.Current.Profile["idPrefeitura"].ToString() == "0")
                    {
                        string idPrefeitura = GetCityHallId();
                        HttpContext.Current.Profile["idPrefeitura"] = idPrefeitura;
                        hfIdPrefeitura.Value = idPrefeitura;
                    }

                    DataTable dt = db.ExecuteReaderQuery(string.Format(@"select top 1 cm.latitude,cm.longitude,cm.zoom,cm.TempoAtualizaMapa,d.HabilitacaoCentral
from  ConfigMap cm
left join  Dna d
on cm.idPrefeitura = d.idPrefeitura
and d.HabilitacaoCentral = 1
where cm.idPrefeitura = {0}", HttpContext.Current.Profile["idPrefeitura"]));

                    if (dt.Rows.Count > 0)
                    {
                        DataRow dr = dt.Rows[0];
                        if (dr["HabilitacaoCentral"].ToString() == "True")
                        {
                            hfTemEqp.Value = "true";
                        }
                        else
                        {
                            hfTemEqp.Value = "False";
                        }
                        Page.ClientScript.RegisterStartupScript(this.GetType(),
    "LoadMap", "LoadMap('" + dr["latitude"].ToString() + "','" + dr["longitude"].ToString() + "','" + dr["zoom"].ToString() + "','" + dr["TempoAtualizaMapa"].ToString() + "');", true);

                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(),
                        "LoadMap", "LoadMap('','','','');", true);
                    }
                }

            }
        }

        public struct localesResource
        {
            public string name { get; set; }
            public string value { get; set; }
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

        #region GetCityHallId

        private string GetCityHallId()
        {
            long idPrefeitura = 0;

            foreach (string role in Roles.GetRolesForUser())
            {
                if (!role.Contains("cliente: ")) continue;
                DataTable dt = db.ExecuteReaderQuery(string.Format("SELECT * FROM Prefeitura Where Prefeitura ='{0}'", role.Replace("cliente: ", "")));
                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    idPrefeitura = Convert.ToInt64(dr["id"].ToString());
                    return idPrefeitura.ToString();
                }
            }

            return idPrefeitura.ToString();
        }

        #endregion

        [WebMethod]
        public static ArrayList GetFailures()
        {
            Banco db = new Banco("");
            ArrayList lstFailures = new ArrayList();

            DataTable dt = db.ExecuteReaderQuery(@"select Id,Nome 
from Falha 
where Familia='SEMAFORO'
and Id in (553,561,565,563,586)
order by Nome");

            foreach (DataRow item in dt.Rows)
            {
                lstFailures.Add(new ListItem(item["Nome"].ToString(), item["Id"].ToString()));
            }

            return lstFailures;
        }

        [ScriptMethod()]
        [WebMethod]
        public static List<string> GetDna(string prefixText)
        {
            Banco db = new Banco("");

            // _Default main = new _Default();

            db.ClearSQLParams();
            db.AddSQLParam("Cruzamento", prefixText);
            db.AddSQLParam("idPrefeitura", HttpContext.Current.Profile["idPrefeitura"]);
            DataTable dt = db.ExecuteReaderStoredProcedure("GetDna", true);

            List<string> lstDna = new List<string>();

            foreach (DataRow item in dt.Rows)
            {
                lstDna.Add(string.Format("{0}@{1}", item["Id"].ToString(), item["Cruzamento"].ToString()));
            }

            return lstDna;
        }

        public struct LoadAneis
        {
            public string nomeSubArea { get; set; }
            public string anel { get; set; }
            public string idLocal { get; set; }
            public string idEqp { get; set; }
            public string lat { get; set; }
            public string lng { get; set; }
        }

        [WebMethod]
        public static List<LoadAneis> LoadAnel(string idArea)
        {
            Banco db = new Banco("");
            List<LoadAneis> lst = new List<LoadAneis>();
            string subArea = getNomeSubArea(idArea);

            string sql = @"Select a.anel,idLocal,lg.idEqp,latitude,longitude,a.idArea from AreaAneis a join Status s on a.idEqp=s.IdDna 
Join GruposLogicos g on s.Serial = Convert(varchar, g.IdEqp) and a.anel=g.anel join LocaisGruposLogicos lg ON g.IdLocal=lg.Id
Where a.idArea=" + idArea + " order by lg.idEqp, a.anel";
            DataTable dt = db.ExecuteReaderQuery(sql);

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new LoadAneis
                {
                    anel = item["anel"].ToString(),
                    idLocal = item["idLocal"].ToString(),
                    idEqp = item["idEqp"].ToString(),
                    lat = item["latitude"].ToString(),
                    lng = item["longitude"].ToString(),
                    nomeSubArea = subArea
                });

            }

            return lst;
        }

        [WebMethod]
        public static List<LoadAneis> LoadEqpSubArea(string idArea)
        {
            Banco db = new Banco("");
            List<LoadAneis> lst = new List<LoadAneis>();

            string sql = @"Select distinct idEqp from AreaAneis Where idArea=" + idArea + " order by idEqp";
            DataTable dt = db.ExecuteReaderQuery(sql);

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new LoadAneis
                {
                    idEqp = item["idEqp"].ToString()
                });

            }

            return lst;
        }

        public struct AnelSubArea
        {
            public string nomeSubArea { get; set; }
            public string Endereco { get; set; }
            public string anel { get; set; }
            public string idEqp { get; set; }
            public bool Imposicao { get; set; }

            public string idDna { get; set; }
        }

        [WebMethod]
        public static List<AnelSubArea> getAneisVinculados(string idArea)
        {
            Banco db = new Banco("");
            List<AnelSubArea> lst = new List<AnelSubArea>();
            string subArea = getNomeSubArea(idArea);

            string sql = @"Select a.anel,Cruzamento,s.Serial idEqp, s.idDna from AreaAneis a join Status s on Convert(varchar,a.IdEqp)=s.IdDna join Dna d on s.IdDna=d.Id
Where s.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and idArea=" + idArea + " order by IdEqp,Anel";

            DataTable dt = db.ExecuteReaderQuery(sql);
            foreach (DataRow item in dt.Rows)
            {
                DataTable dtImposicao = db.ExecuteReaderQuery(@"Select id from CentralizacaoAneis Where Anel='" + item["anel"].ToString() +
                    "' and IdEqp='" + item["idEqp"].ToString() + "'");

                bool imposicao = dtImposicao.Rows.Count > 0 ? true : false;

                lst.Add(new AnelSubArea
                {
                    Endereco = item["Cruzamento"].ToString(),
                    anel = item["Anel"].ToString(),
                    idDna = item["idDna"].ToString(),
                    idEqp = item["idEqp"].ToString(),
                    nomeSubArea = subArea,
                    Imposicao = imposicao
                });
            }
            return lst;
        }

        public struct Area
        {
            public string id { get; set; }
            public string tipo { get; set; }
            public string nome { get; set; }
            public string idArea { get; set; }
        }

        [WebMethod]
        public static List<Area> ListarAreas(string tipo)
        {
            Banco db = new Banco("");
            DataTable dtAreas = db.ExecuteReaderQuery(@"Select * from Area_SubArea Where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] +
                " and tipo='" + tipo + "'");

            List<Area> lstAreas = new List<Area>();

            foreach (DataRow item in dtAreas.Rows)
            {
                lstAreas.Add(new Area
                {
                    id = item["id"].ToString(),
                    tipo = item["tipo"].ToString(),
                    nome = item["nome"].ToString(),
                    idArea = item["idArea"].ToString()
                });
            }

            return lstAreas;
        }

        public static string getNomeSubArea(string idArea)
        {
            Banco db = new Banco("");
            string nomeSubArea = db.ExecuteScalarQuery("Select Nome from Area_SubArea Where id=" + idArea);
            return nomeSubArea;
        }

        public struct CorredorSubArea
        {
            public string idCorredor { get; set; }
            public string Corredor { get; set; }
            public string GrupoLogico { get; set; }
            public string Anel { get; set; }
            public string TipoGrupo { get; set; }
            public string Endereco { get; set; }
            public string latitude { get; set; }
            public string longitude { get; set; }
            public string TempoPercurso { get; set; }
            public string Distancia { get; set; }
            public string TempoEntreCruzamentos { get; set; }
            public string IdEqp { get; set; }
            public string nomeSubArea { get; set; }
        }

        [WebMethod]
        public static List<CorredorSubArea> getCorredor(string idArea)
        {
            Banco db = new Banco("");

            string subArea = getNomeSubArea(idArea);
            string sql = @"select distinct c.id, Corredor from CorredorAneis ca Join Corredor c on ca.idCorredor=c.id  JOIN AreaAneis a on a.id=ca.idAreaAneis 
Where c.idSubArea=" + idArea;
            DataTable dt = db.ExecuteReaderQuery(sql);

            List<CorredorSubArea> lst = new List<CorredorSubArea>();

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new CorredorSubArea
                {
                    idCorredor = item["id"].ToString(),
                    Corredor = item["Corredor"].ToString(),
                    nomeSubArea = subArea
                });
            }
            return lst;
        }

        [WebMethod]
        public static List<CorredorSubArea> getCorredorSubArea(string idArea, string idCorredor)
        {
            Banco db = new Banco("");

            string sql = @"select c.id, Corredor,gl.GrupoLogico,gl.anel,TipoGrupo,Endereco,
latitude,longitude,TempoPercurso,Distancia,TempoEntreCruzamentos,(convert(varchar,a.idEqp))IdEqp
from CorredorAneis ca Join Corredor c on ca.idCorredor=c.id JOIN GruposLogicos gl on gl.GrupoLogico = ca.GrupoLogico and gl.idEqp=ca.idEqp
Join LocaisGruposLogicos lgl on lgl.id=gl.idLocal JOIN AreaAneis a on a.id=ca.idAreaAneis 
Where c.idSubArea=" + idArea + " And c.id=" + idCorredor + " order by Corredor, gl.anel, gl.GrupoLogico";

            DataTable dt = db.ExecuteReaderQuery(sql);

            List<CorredorSubArea> lst = new List<CorredorSubArea>();

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new CorredorSubArea
                {
                    idCorredor = item["id"].ToString(),
                    Corredor = item["Corredor"].ToString(),
                    GrupoLogico = item["GrupoLogico"].ToString(),
                    Anel = item["anel"].ToString(),
                    TipoGrupo = item["TipoGrupo"].ToString(),
                    Endereco = item["Endereco"].ToString(),
                    latitude = item["latitude"].ToString(),
                    longitude = item["longitude"].ToString(),
                    TempoPercurso = item["TempoPercurso"].ToString(),
                    Distancia = item["Distancia"].ToString(),
                    TempoEntreCruzamentos = item["TempoEntreCruzamentos"].ToString(),
                    IdEqp = item["IdEqp"].ToString()
                });
            }
            return lst;
        }

        public struct PendenciasImposicao
        {
            public string Byte1 { get; set; }
            public string Byte2 { get; set; }
            public string IdControlador { get; set; }
        }

        [WebMethod]
        public static List<PendenciasImposicao> getPendencias(string subArea)
        {
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"Select distinct Byte1, IdControlador from TarefasImposicao ti Join Status s on convert(varchar, ti.IdControlador)=s.Serial 
Join AreaAneis a on s.IdDna=convert(varchar, a.IdEqp) Join Area_SubArea sa on a.idArea=sa.id
Where Nome='{0}' and Tipo='subArea' and sa.IdPrefeitura={1}", subArea, HttpContext.Current.Profile["idPrefeitura"].ToString()));

            List<PendenciasImposicao> lst = new List<PendenciasImposicao>();

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new PendenciasImposicao
                {
                    Byte1 = item["Byte1"].ToString(),
                    IdControlador = item["IdControlador"].ToString()
                });
            }
            return lst;
        }

        [WebMethod]
        public static List<PendenciasImposicao> getTarefasPendentes()
        {
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"Select distinct isnull(Byte1,0) Byte1, isnull(Byte2,0) Byte2, IdControlador from TarefasImposicao ti Join Status s on convert(varchar, ti.IdControlador)=s.Serial
Where s.IdPrefeitura={0} order by IdControlador", HttpContext.Current.Profile["idPrefeitura"].ToString()));

            List<PendenciasImposicao> lst = new List<PendenciasImposicao>();

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new PendenciasImposicao
                {
                    Byte1 = item["Byte1"].ToString(),
                    Byte2 = item["Byte2"].ToString(),
                    IdControlador = item["IdControlador"].ToString()
                });
            }
            return lst;
        }

        public struct LogFalhaCtrl
        {
            public string idEqp { get; set; }
            public string tipo { get; set; }
            public string funcao { get; set; }
            public string valor { get; set; }
            public string falha { get; set; }
            public string usuario { get; set; }
            public string dataHora { get; set; }
        }

        [WebMethod]
        public static List<LogFalhaCtrl> getLogFalhasCtrl(string subArea)
        {
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"Select l.idEqp, isnull(l.tipo,'')tipo, isnull(funcao,'')funcao, isnull(valor,'')valor, 
isnull(l.falha,'')falha, isnull(usuario,'')usuario, dataHora from Logs l 
Join Status s on convert(varchar, l.IdEqp)=s.Serial Join AreaAneis a on s.IdDna=convert(varchar, a.IdEqp) Join Area_SubArea sa on a.idArea=sa.id
Where Nome='{0}' and sa.Tipo='subArea' and sa.IdPrefeitura={1}", subArea, HttpContext.Current.Profile["idPrefeitura"].ToString()));

            List<LogFalhaCtrl> lst = new List<LogFalhaCtrl>();

            foreach (DataRow item in dt.Rows)
            {
                string dtHora = ToBrDatetime(item["dataHora"].ToString());

                lst.Add(new LogFalhaCtrl
                {
                    idEqp = item["idEqp"].ToString(),
                    tipo = item["tipo"].ToString() == "null" ? "" : item["tipo"].ToString(),
                    funcao = item["funcao"].ToString() == "null" ? "" : item["funcao"].ToString(),
                    valor = item["valor"].ToString() == "null" ? "" : item["valor"].ToString(),
                    falha = item["falha"].ToString() == "null" ? "" : item["falha"].ToString(),
                    usuario = item["usuario"].ToString() == "null" ? "" : item["usuario"].ToString(),
                    dataHora = dtHora
                });
            }
            return lst;
        }

        [WebMethod]
        public static List<LogFalhaCtrl> FiltrarLogFalhasCtrl(string subArea, string dataHora, string tipo)
        {
            Banco db = new Banco("");

            dataHora = ToStringNumberDatetime(dataHora);

            string sql = string.Format(@"Select l.idEqp, isnull(l.tipo,'')tipo, isnull(funcao,'')funcao, isnull(valor,'')valor, 
isnull(l.falha,'')falha, isnull(usuario,'')usuario, dataHora from Logs l 
Join Status s on convert(varchar, l.IdEqp)=s.Serial Join AreaAneis a on s.IdDna=convert(varchar, a.IdEqp) Join Area_SubArea sa on a.idArea=sa.id
Where Nome='{0}' and sa.Tipo='subArea' and sa.IdPrefeitura={1}", subArea, HttpContext.Current.Profile["idPrefeitura"].ToString());

            if (!string.IsNullOrEmpty(dataHora)) sql += " And dataHora like '%" + dataHora + "%'";
            if (!string.IsNullOrEmpty(tipo)) sql += " And l.tipo like '%" + tipo + "%'";

            DataTable dt = db.ExecuteReaderQuery(sql);

            List<LogFalhaCtrl> lst = new List<LogFalhaCtrl>();

            foreach (DataRow item in dt.Rows)
            {
                string dtHora = ToBrDatetime(item["dataHora"].ToString());

                lst.Add(new LogFalhaCtrl
                {
                    idEqp = item["idEqp"].ToString(),
                    tipo = item["tipo"].ToString() == "null" ? "" : item["tipo"].ToString(),
                    funcao = item["funcao"].ToString() == "null" ? "" : item["funcao"].ToString(),
                    valor = item["valor"].ToString() == "null" ? "" : item["valor"].ToString(),
                    falha = item["falha"].ToString() == "null" ? "" : item["falha"].ToString(),
                    usuario = item["usuario"].ToString() == "null" ? "" : item["usuario"].ToString(),
                    dataHora = dtHora
                });
            }
            return lst;
        }

        public static string ToBrDatetime(string stringNumberDate)
        {
            try
            {
                if (stringNumberDate.Length < 14) return $"{stringNumberDate.Substring(6, 2)}/{stringNumberDate.Substring(4, 2)}/{stringNumberDate.Substring(0, 4)}";
                else return $"{stringNumberDate.Substring(6, 2)}/{stringNumberDate.Substring(4, 2)}/{stringNumberDate.Substring(0, 4)} {stringNumberDate.Substring(8, 2)}:{stringNumberDate.Substring(10, 2)}:{stringNumberDate.Substring(12)}";
            }
            catch
            {
                return "";
            }

        }

        public static string ToStringNumberDatetime(string BrDate)
        {
            try
            {
                return Convert.ToInt64(Convert.ToDateTime(BrDate).ToString("yyyyMMddHHmm")).ToString();
            }
            catch
            {
                return "";
            }
        }

        public struct Planos
        {
            public string NomePlano { get; set; }
            public bool Imposicao { get; set; }
        }

        [WebMethod]
        public static List<Planos> getPlanoSubArea(string subArea)
        {
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"Select NomePlano=(case NomePlano when 'PLANO APAGADO' then 'APAGADO' else NomePlano end)
from Planos p Join Status s on convert(varchar, p.IdEqp)=s.Serial 
Join AreaAneis a on s.IdDna=convert(varchar, a.IdEqp) and p.Anel=a.Anel
Join Area_SubArea sa on a.idArea=sa.id Where Nome='{0}' and sa.IdPrefeitura={1}
UNION SELECT 'PISCANTE' NomePlano UNION SELECT 'APAGADO' NomePlano
order by NomePlano", subArea, HttpContext.Current.Profile["idPrefeitura"].ToString()));

            List<Planos> lst = new List<Planos>();

            foreach (DataRow item in dt.Rows)
            {
                bool imposicao = getImposicaoSubArea(item["NomePlano"].ToString(), subArea);
                lst.Add(new Planos
                {
                    NomePlano = item["NomePlano"].ToString(),
                    Imposicao = imposicao
                });
            }
            return lst;
        }

        private static bool getImposicaoSubArea(string nomePlano, string subArea)
        {
            Banco db = new Banco("");
            DataTable dtImposicao = db.ExecuteReaderQuery(@"Select distinct i.id from ImposicaoPlanos i join Planos p on i.IdEqp = p.idEqp
Join Status s on convert(varchar, p.IdEqp) = s.Serial Join AreaAneis a on s.IdDna = convert(varchar, a.IdEqp) and p.Anel = a.Anel
Join Area_SubArea sa on a.idArea = sa.id Where PlanoImposto='" + nomePlano + "' And Nome='" + subArea +
"' And sa.IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());

            bool imposicao = dtImposicao.Rows.Count > 0 ? true : false;
            return imposicao;
        }

        [WebMethod]
        public static bool ImporPlanoSubArea(string plano, string tempo, string subArea, string tipo)
        {
            Banco db = new Banco("");

            bool planoExistente = true;
            if (!plano.ToUpper().Contains("APAGADO") && !plano.ToUpper().Contains("PISCANTE"))
            {
                planoExistente = verificaPlanoExistente(plano, subArea);
                if (!planoExistente)
                    return planoExistente;
            }

            DataTable dtEqpSubArea = db.ExecuteReaderQuery(@"Select distinct IdEqp From Area_SubArea sa 
Join AreaAneis a on sa.id=a.idArea Where Nome='" + subArea + "' And sa.IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
            foreach (DataRow item in dtEqpSubArea.Rows)
            {
                string idEqp = item["IdEqp"].ToString();

                DataTable dt = db.ExecuteReaderQuery(@"Select Byte1 from TarefasImposicao Where IdControlador='" + idEqp + "'");
                int[] byte1 = DecimalToBinary(int.Parse(dt.Rows[0]["Byte1"].ToString()));

                if (tipo == "cancelamento")
                {
                    db.ExecuteNonQuery("Delete from ImposicaoPlanos Where PlanoImposto='" + plano + "' and IdEqp='" + idEqp + "'");
                    byte1[1] = 0;
                    byte1[2] = 1;
                    byte1[7] = 0;

                    setByteTarefas(byte1, idEqp);
                }
                else
                {
                    db.ExecuteNonQuery("Insert Into ImposicaoPlanos (PlanoImposto, TempoImposicao, IdEqp) values ('" + plano + "','" + tempo + "','" + idEqp + "')");
                    byte1[1] = 1;
                    byte1[2] = 0;
                    byte1[7] = 0;

                    setByteTarefas(byte1, idEqp);
                }
            }
            return planoExistente;
        }

        private static bool verificaPlanoExistente(string plano, string subArea)
        {
            bool planoExistente = true;
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(@"Select distinct Serial IdEqp From Status s Join AreaAneis 
a on s.IdDna = IdEqp Join Area_SubArea sa on sa.id = a.idArea Where Nome='" + subArea +
"' And s.IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());

            foreach (DataRow item in dt.Rows)
            {
                if (int.TryParse(item["IdEqp"].ToString(), out int idEqp))
                {
                    DataTable dtConsulta_Planos = db.ExecuteReaderQuery(@"Select id from Planos Where NomePlano='" + plano +
                        "' And idEqp=" + item["IdEqp"].ToString());
                    if (dtConsulta_Planos.Rows.Count == 0)
                    {
                        planoExistente = false;
                        break;
                    }
                }
            }
            return planoExistente;
        }

        [WebMethod]
        public static void ImporModoOperacional(string anel, string idEqp, string tipo)
        {
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(@"Select Byte1 from TarefasImposicao Where IdControlador='" + idEqp + "'");
            int[] byte1 = DecimalToBinary(int.Parse(dt.Rows[0]["Byte1"].ToString()));

            if (tipo == "cancelamento")
            {
                db.ExecuteNonQuery("Delete from CentralizacaoAneis Where anel='" + anel + "' and IdEqp='" + idEqp + "'");
                byte1[7] = 0;

                setByteTarefas(byte1, idEqp);
            }
            else
            {
                db.ExecuteNonQuery("Insert Into CentralizacaoAneis (Centralizado, Anel, IdEqp, flag, falhaCentralizacao) values (1,'" + anel + "','" + idEqp + "', 0, 0)");
                byte1[7] = 1;

                setByteTarefas(byte1, idEqp);
            }
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
    }
}