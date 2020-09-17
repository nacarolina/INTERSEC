using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.Services;

namespace GwCentral.Relatorios.HistoricoOrdemServico
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    public class Default1 : System.Web.Services.WebService
    {
        Banco db = new Banco("");

        [WebMethod]
        public List<OrdemServico> PesquisarOs(string dataIni, string dataFini, string idPonto, string idFalha, string statusAtendimento)
        {
            List<OrdemServico> lstOs = new List<OrdemServico>();
            long idPrefeitura = GetIdCityHall();

            StringBuilder query = new StringBuilder();

            query.Append(string.Format(@"select aos.idDna,d.Cruzamento,f.Nome,aos.causa,aos.dataHora,aos.processado
from AbrirOrdemServico aos
join DNA d
on aos.idDna = d.Id
join Falha f
on aos.idFalha = f.Id
where d.idPrefeitura = {0}
and CONVERT(Date,aos.dataHora,103)
between CONVERT(Date,'{1}',103) and CONVERT(Date,'{2}',103)", idPrefeitura, dataIni, dataFini));

            if (!string.IsNullOrEmpty(idPonto))
            {
                query.Append(string.Format(" and aos.idDna='{0}'", idPonto));
            }
            if (!string.IsNullOrEmpty(idFalha))
            {
                query.Append(string.Format(" and aos.idFalha={0}", idFalha));
            }
            if (!string.IsNullOrEmpty(statusAtendimento))
            {
                query.Append(string.Format(" and aos.processado={0}", statusAtendimento));
            }

            DataTable dt = db.ExecuteReaderQuery(query.ToString());

            foreach (DataRow item in dt.Rows)
            {
                lstOs.Add(new OrdemServico
                {
                    idPonto = item["idDna"].ToString(),
                    cruzamento = item["Cruzamento"].ToString(),
                    falha = item["Nome"].ToString(),
                    causa = item["causa"].ToString(),
                    data = item["dataHora"].ToString(),
                    atendido = item["processado"].ToString()
                });
            }

            return lstOs;
        }

        #region GetCityHallId

        private long GetIdCityHall()
        {
            long idPrefeitura = 0;
            foreach (string role in Roles.GetRolesForUser())
            {
                DataTable dt = db.ExecuteReaderQuery(string.Format("SELECT * FROM Prefeitura Where Prefeitura ='{0}'", role.Replace("cliente: ", "")));
                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    idPrefeitura = Convert.ToInt64(dr["id"].ToString());
                }
            }

            return idPrefeitura;
        }

        #endregion
    }

    public struct OrdemServico
    {
        public string idPonto { get; set; }
        public string cruzamento { get; set; }
        public string falha { get; set; }
        public string causa { get; set; }
        public string data { get; set; }
        public string atendido { get; set; }
    }
}
