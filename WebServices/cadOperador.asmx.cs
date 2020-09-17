using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;

namespace GwCentral.WebServices
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class cadOperador : System.Web.Services.WebService
    {
        Banco db = new Banco("");
        DataTable dt;
        string sql = "";

        [WebMethod]
        public void Salvar(string NomeOperador, string cel, string email, string bitsFalha, string tempoReenvio)
        {
            sql = @"Insert into avisoFalhasOperador(nomeOperador,cel,email,dtCad,falhas,idPrefeitura,MinutosParaReenvio,EnviaSms,EnviaEmail)values('" + NomeOperador + "','" + cel +
            "','" + email + "','" + DateTime.Now.ToString("dd/MM/yyy") + "','" + bitsFalha + "'," +
            HttpContext.Current.Profile["idPrefeitura"] + "," + tempoReenvio + ", 'True', 'True')";
            db.ExecuteNonQuery(sql);
        }

        [WebMethod]
        public void Editar(string Id, string NomeOperador, string cel, string email, string bitsFalha, string tempoReenvio)
        {
            sql = @"Update avisoFalhasOperador set nomeOperador='" + NomeOperador + "',cel='" + cel + "',email='" + email +
                "',falhas='" + bitsFalha + "',MinutosParaReenvio=" + tempoReenvio + " where id=" + Id;
            db.ExecuteNonQuery(sql);
        }

        [WebMethod]
        public void UpdateSms(string Id, string enviaSms)
        {
            sql = @"Update avisoFalhasOperador set EnviaSms='" + enviaSms + "' where id=" + Id;
            db.ExecuteNonQuery(sql);
        }

        [WebMethod]
        public void UpdateEmail(string Id, string enviaEmail)
        {
            sql = @"Update avisoFalhasOperador set EnviaEmail='" + enviaEmail + "' where id=" + Id;
            db.ExecuteNonQuery(sql);
        }

        [WebMethod]
        public void Excluir(string IdOperador)
        {
            sql = "delete from avisoFalhasOperador where id=" + IdOperador;
            db.ExecuteNonQuery(sql);
        }

        [WebMethod]
        public List<AvisoFalhasOperador> FilterOperator(string nomeOperador)
        {
            List<AvisoFalhasOperador> lstAvisoFalhas = new List<AvisoFalhasOperador>();
            StringBuilder query = new StringBuilder();
            query.AppendFormat("select Id,nomeOperador,cel,email,falhas,EnviaSms,EnviaEmail,MinutosParaReenvio from avisoFalhasOperador where idPrefeitura={0}", HttpContext.Current.Profile["idPrefeitura"].ToString());
            if (!string.IsNullOrEmpty(nomeOperador))
            {
                query.AppendFormat(" and nomeOperador like '%{0}%' ", nomeOperador);
            }
            dt = db.ExecuteReaderQuery(query.ToString());

            foreach (DataRow item in dt.Rows)
            {
                lstAvisoFalhas.Add(new AvisoFalhasOperador
                {
                    id = item["Id"].ToString(),
                    nomeOperador = item["NomeOperador"].ToString(),
                    celularOperador = item["cel"].ToString(),
                    emailOperador = item["email"].ToString(),
                    falhas = item["falhas"].ToString(),
                    enviarSms = item["EnviaSms"].ToString(),
                    enviarEmail = item["EnviaEmail"].ToString(),
                    MinutosParaReenvio = item["MinutosParaReenvio"].ToString()
                });
            }

            return lstAvisoFalhas;
        }

        [WebMethod]
        public List<AvisoFalhasOperador> GetAdviceFailureOperator(string id)
        {
            List<AvisoFalhasOperador> lstAvisoFalhas = new List<AvisoFalhasOperador>();
            DataTable dt = db.ExecuteReaderQuery(string.Format("select Id,nomeOperador,cel,email,falhas,EnviaSms,EnviaEmail,MinutosParaReenvio from avisoFalhasOperador where id={0}", id));

            foreach (DataRow item in dt.Rows)
            {
                lstAvisoFalhas.Add(new AvisoFalhasOperador
                {
                    id = item["Id"].ToString(),
                    nomeOperador = item["NomeOperador"].ToString(),
                    celularOperador = item["cel"].ToString(),
                    emailOperador = item["email"].ToString(),
                    falhas = item["falhas"].ToString(),
                    enviarSms = item["EnviaSms"].ToString(),
                    enviarEmail = item["EnviaEmail"].ToString(),
                    MinutosParaReenvio = item["MinutosParaReenvio"].ToString()
                });
            }

            return lstAvisoFalhas;
        }


    }
    public class AvisoFalhasOperador
    {
        public string id { get; set; }
        public string nomeOperador { get; set; }
        public string celularOperador { get; set; }
        public string emailOperador { get; set; }
        public string falhas { get; set; }
        public string enviarSms { get; set; }
        public string enviarEmail { get; set; }
        public string MinutosParaReenvio { get; set; }
    }
}
