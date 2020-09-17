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

namespace GwCentral
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


        public struct ListaControlador
        {
            public string serialMestre { get; set; }
            public string idEqp { get; set; }
            public string Cruzamento { get; set; }
            public string Status { get; set; }
            public string Plano { get; set; }
            public string DtHr { get; set; }
            public string StatusComunicacao { get; set; }
            public string Observacao { get; set; }
            public string Tensao { get; set; }
            public string Temperatura { get; set; }
            public string Estado { get; set; }
        }

        [WebMethod]
        public static List<ListaControlador> getControladores(string idPrefeitura, string idEqp)
        {
            Banco db = new Banco("");
            List<ListaControlador> lst = new List<ListaControlador>();
            string dtHr = DateTime.Now.ToString("yyyyMMddHHmmss");
            string hr = DateTime.Now.ToString("HHmmss");
            string dia = "";
            switch (DateTime.Now.DayOfWeek)
            {
                case DayOfWeek.Monday:
                    dia = "Segunda";
                    break;
                case DayOfWeek.Tuesday:
                    dia = "Terca";
                    break;
                case DayOfWeek.Wednesday:
                    dia = "Quarta";
                    break;
                case DayOfWeek.Thursday:
                    dia = "Quinta";
                    break;
                case DayOfWeek.Friday:
                    dia = "Sexta";
                    break;
                case DayOfWeek.Saturday:
                    dia = "Sabado";
                    break;
                case DayOfWeek.Sunday:
                    dia = "Domingo";
                    break;
            }

            string sql = @"select top 50 d.id,Cruzamento,isnull(s.Falha,'')Falha,isnull(serialMestre,'')serialMestre,s.Atualizado,isnull((case when (DATEDIFF(minute,convert(datetime,s.atualizado),getdate()) < isnull(tempofalhacomunicacao,15))
then 'True' else 'False' end),'False') estado,
PlanoEspecial=(  select Plano from Agenda where ideqp=d.id and Convert(bigint,DtHrIniTblEspecial)<=" + dtHr + " and Convert(bigint,DtHrFimTblEspecial)>=" + dtHr + @"),
Plano =( select Plano from  Agenda where ideqp=d.id and Convert(int,HrIni)<=" + hr + " and Convert(int,HrFim)>=" + hr + @" and DiasSemana='" + dia + @"'),s.Versao, s.IP, s.Observacao obs, s.Tensao, s.Temperatura, s.Estado ess from DNA d 
left JOIN [Status] s on s.Serial=d.Id
join ConfigMap cm on cm.idprefeitura=d.idPrefeitura  where d.idPrefeitura = " + idPrefeitura;

            if (string.IsNullOrEmpty(idEqp) == false)
                sql += " and (d.Id='" + idEqp + "' or Cruzamento like '%" + idEqp + "%')";

            sql += " order by CASE ISNUMERIC(SUBSTRING(d.id,1,1)) WHEN 1 THEN Convert(int, d.id) WHEN 0 THEN Convert(int, SUBSTRING(d.id,2,100)) END; ";

            //, bool intermitente, bool apagado, bool faltaEnergia, bool subtensao, bool estacionado, bool imposicao
            //int[] byte1 = new int[7];

            //if (normal == true)
            //    byte1[0] = 1;
            //if (subtensao==true)
            //    byte1[1] = 1;
            //if (apagado==true)
            //    byte1[2] = 1;
            //if (intermitente==true)
            //    byte1[3] = 1;
            //if (estacionado==true)
            //    byte1[4] = 1;
            ////if (plugManual == true)
            ////    byte1[5] = 1;
            //if (imposicao==true)
            //    byte1[6] = 1;

            //int bit = Convert.ToInt32(byte1);
            //sql += " and s.Falha='"+bit+"'";

            DataTable dt = db.ExecuteReaderQuery(sql);
            foreach (DataRow dr in dt.Rows)
            {
                string serialMestre = dr["SerialMestre"].ToString();
                string plano = dr["PlanoEspecial"].ToString();
                if (plano == "")
                {
                    plano = dr["Plano"].ToString();
                }
                string atualizacao = dr["Atualizado"].ToString();
                //if (dr["Atualizado"].ToString() != "")
                //{
                //    string ano = dr["Atualizado"].ToString().Substring(0, 4);
                //    string mes = dr["Atualizado"].ToString().Substring(5, 2);
                //    string dia = dr["Atualizado"].ToString().Substring(8, 2);
                //    dtHr = dia + "/" + mes + "/" + ano + " " + dr["Atualizado"].ToString().Substring(11, 8);
                //}
                lst.Add(new ListaControlador
                {
                    idEqp = dr["id"].ToString(),
                    Cruzamento = dr["cruzamento"].ToString(),
                    Status = dr["Falha"].ToString(),
                    Plano = plano,
                    DtHr = atualizacao,
                    StatusComunicacao = dr["estado"].ToString(),
                    Observacao = dr["obs"].ToString(),
                    Tensao = dr["Tensao"].ToString(),
                    Temperatura = dr["Temperatura"].ToString(),
                    Estado = dr["ess"].ToString(),
                    serialMestre= serialMestre
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
        public static List<PendenciasImposicao> getTarefasPendentes()
        {
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"Select distinct top 50 isnull(Byte1,0) Byte1, isnull(Byte2,0) Byte2, IdControlador from TarefasImposicao ti Join Status s on convert(varchar, ti.IdControlador)=s.Serial
Where s.IdPrefeitura={0} and (Byte1<>'0' or Byte2<>'0') order by IdControlador", HttpContext.Current.Profile["idPrefeitura"].ToString()));

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


        public struct ListaLogs
        {
            public string Dsc { get; set; }
            public string idEqp { get; set; }
            public string dataHora { get; set; }
        }

        [WebMethod]
        public static List<ListaLogs> GetLogs(string idEqp)
        {
            Banco db = new Banco("");
            List<ListaLogs> lst = new List<ListaLogs>();
            string valor, falha, usuario = "";

            string sql = @"select top 50 Funcao Dsc,DataHora,idEqp from LogsControlador l
JOIN Dna d on d.id=l.ideqp where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString() + " and Funcao<>'null' ";

            if (idEqp != "")
                sql += "and d.id='" + idEqp + "'";

            sql += "order by DataHora desc";
            DataTable dt = db.ExecuteReaderQuery(sql);
            foreach (DataRow dr in dt.Rows)
            {
                string ano = dr["DataHora"].ToString().Substring(0, 4);
                string mes = dr["DataHora"].ToString().Substring(4, 2);
                string dia = dr["DataHora"].ToString().Substring(6, 2);
                string hr = dr["DataHora"].ToString().Substring(8, 2);
                string min = dr["DataHora"].ToString().Substring(10, 2);
                string seg = dr["DataHora"].ToString().Substring(12, 2);
                falha = dr["Dsc"].ToString();
                if (falha == "null")
                    falha = "";

                lst.Add(new ListaLogs
                {
                    idEqp = dr["idEqp"].ToString(),
                    Dsc = falha,
                    dataHora = dia + "/" + mes + "/" + ano + " " + hr + ":" + min + ":" + seg
                });
            }

            sql = @"select DISTINCT TOP 50 isnull(Falha,'0')Falha, Convert(DATETIME,Data,103)  DataHora,serial idEqp from LogFalhas l 
JOIN DNA d on d.id=l.Serial where d.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString();
            if (idEqp != "")
                sql += "and d.id='" + idEqp + "'";
            sql += " order by Convert(DATETIME,Data,103) desc";
            dt = db.ExecuteReaderQuery(sql);
            foreach (DataRow dr in dt.Rows)
            {
                falha = dr["Falha"].ToString();
                if (falha == "null")
                    falha = "";

                lst.Add(new ListaLogs
                {
                    idEqp = dr["idEqp"].ToString(),
                    Dsc = falha,
                    dataHora = dr["DataHora"].ToString()
                });
            }
            return lst;
        }


        [WebMethod]
        public static void ResetaControlador(string idPonto, string user)
        {
            Banco db = new Banco("");
            string[] idEqp = idPonto.Split(',');
            foreach (string item in idEqp)
            {
                if (item != ",")
                {
                    string statusReset = db.ExecuteScalarQuery(string.Format("select Reset from Status where IdDna='{0}' and idPrefeitura={1}", item, HttpContext.Current.Profile["idPrefeitura"]));
                    if (statusReset != "True")
                    {
                        db.ExecuteNonQuery(string.Format("update Status set Reset=1,UserReset='{1}' where IdDna='{0}' and idPrefeitura={2}",
                            item, user, HttpContext.Current.Profile["idPrefeitura"]));
                    }
                    DataTable dt = db.ExecuteReaderQuery(@"Select isnull(Byte1,0) Byte1 from TarefasImposicao Where IdControlador='" + item + "'");
                    if (dt.Rows.Count > 0)
                    {
                        int[] byte1 = DecimalToBinary(int.Parse(dt.Rows[0]["Byte1"].ToString()));
                        byte1[0] = 1;
                        setByteTarefas(byte1, item);
                    }
                }
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
        public static bool ImporPlano(string plano, string idEqp, string tempo, string tipo)
        {
            bool retorno = false;
            Banco db = new Banco("");


            string[] id = idEqp.Split(',');
            foreach (string item in id)
            {
                DataTable dt = db.ExecuteReaderQuery(@"Select Byte1 from TarefasImposicao Where IdControlador='" + item + "'");
                int[] byte1 = DecimalToBinary(int.Parse(dt.Rows[0]["Byte1"].ToString()));

                if (tipo == "cancelamento")
                {
                    db.ExecuteNonQuery("Delete from ImposicaoPlanos Where IdEqp='" + item + "'");
                    byte1[1] = 0;
                    byte1[2] = 1;
                    byte1[7] = 0;

                    setByteTarefas(byte1, item);
                }
                else
                {
                    DataTable dtImposicao = db.ExecuteReaderQuery(@"Select id from ImposicaoPlanos Where IdEqp='" + item + "'");
                    retorno = dtImposicao.Rows.Count > 0 ? true : false;

                    if (!retorno)
                    {
                        db.ExecuteNonQuery("Insert Into ImposicaoPlanos (PlanoImposto, TempoImposicao, IdEqp) values ('" + plano + "','" + tempo + "','" + item + "')");
                        byte1[1] = 1;
                        byte1[2] = 0;
                        byte1[7] = 0;

                        setByteTarefas(byte1, item);
                    }
                }
            }
            return retorno;
        }
        public struct Planos
        {
            public string NomePlano { get; set; }
            public string Tipo { get; set; }
            public bool Imposicao { get; set; }
        }


        [WebMethod]
        public static List<Planos> getPlanos(string idEqp)
        {
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"Select distinct NomePlano,TipoPlano from Planos p Where IdEqp='{0}'
UNION SELECT 'PISCANTE' NomePlano, 'AMARELO INTERMITENTE' TipoPlano UNION SELECT 'APAGADO' NomePlano, 'APAGADO' TipoPlano order by NomePlano", idEqp));

            List<Planos> lst = new List<Planos>();
            foreach (DataRow item in dt.Rows)
            {
                DataTable dtImposicao = db.ExecuteReaderQuery(@"Select id from ImposicaoPlanos Where PlanoImposto='" + item["NomePlano"].ToString() +
                    "' and IdEqp='" + idEqp + "'");

                bool imposicao = dtImposicao.Rows.Count > 0 ? true : false;
                lst.Add(new Planos
                {
                    NomePlano = item["NomePlano"].ToString(),
                    Tipo = item["TipoPlano"].ToString(),
                    Imposicao = imposicao
                });
            }
            return lst;
        }

        public static void setByteTarefas(int[] byte1, string idEqp)
        {
            Banco db = new Banco("");
            Array.Reverse(byte1);
            string byteTarefas = string.Join("", byte1);
            int decimalValue = Convert.ToInt32(byteTarefas, 2);
            db.ExecuteNonQuery("Update TarefasImposicao set Byte1=" + decimalValue + " Where IdControlador='" + idEqp + "'");
        }
    }
}