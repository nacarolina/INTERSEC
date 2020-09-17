using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;

namespace GwCentral.Relatorios.HistoricoFalhas
{
    /// <summary>
    /// Summary description for HistoFalha
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    //[System.ComponentModel.ToolboxItem(false)] 
    [System.Web.Script.Services.ScriptService]
    public class HistoFalha : System.Web.Services.WebService
    {
        Banco db = new Banco("");

        [WebMethod]
        public List<string> PesquisarFalhas(string consorcioId, string empresa, string idPonto, string statusFalha, string dataInicial, string dataFinal)
        {
            List<string> lstFalhas = new List<string>();

            StringBuilder queryFalhas = new StringBuilder();

            long idPrefeitura = GetIdCityHall();

            switch (statusFalha)
            {
                case "falha":
                    queryFalhas.Append(string.Format(@"select lf.IdDna,lf.Falha,lf.Data,lf.PortaAberta
from  LogFalhas lf
join semaforo.dbo.EmpresaDNA e
on lf.IdDna = e.Id
join semaforo.dbo.DNA dna
on lf.IdDna = dna.Id
where lf.IdDna <>'' and dna.idPrefeitura={0} ",idPrefeitura));
                    break;

                case "semComunicacao":
                    queryFalhas.Append(string.Format(@"select sc.IdDna,sc.Data,sc.Porta,ISNULL(SemComunicacao,0) as SemComunicacao
from LogSemComunicacao sc
join semaforo.dbo.EmpresaDNA e
on sc.IdDna = e.Id
join semaforo.dbo.DNA dna
on sc.IdDna = dna.Id
where sc.IdDna <>'' and dna.idPrefeitura={0} ",idPrefeitura));
                    break;
            }


            if (!string.IsNullOrEmpty(consorcioId))
            {
                queryFalhas.Append(string.Format(" and e.ConsorcioId={0}", consorcioId));
            }
            if (!string.IsNullOrEmpty(empresa))
            {
                queryFalhas.Append(string.Format(" and e.Empresa='{0}'", empresa));
            }
            switch (statusFalha)
            {
                case "falha":
                    if (!string.IsNullOrEmpty(idPonto))
                    {
                        queryFalhas.Append(string.Format(" and lf.IdDna='{0}'", idPonto));
                    }
                    if (!string.IsNullOrEmpty(dataInicial) && !string.IsNullOrEmpty(dataFinal))
                    {
                        queryFalhas.Append(string.Format(" and CONVERT(Date,lf.Data,103) between CONVERT(Date,'{0}',103) and CONVERT(Date,'{1}',103)", dataInicial, dataFinal));
                    }
                    queryFalhas.Append(" order by lf.IdDna");

                    break;

                case "semComunicacao":
                    if (!string.IsNullOrEmpty(idPonto))
                    {
                        queryFalhas.Append(string.Format(" and sc.IdDna='{0}'", idPonto));
                    }
                    if (!string.IsNullOrEmpty(dataInicial) && !string.IsNullOrEmpty(dataFinal))
                    {
                        queryFalhas.Append(string.Format(" and CONVERT(Date,sc.Data,103) between CONVERT(Date,'{0}',103) and CONVERT(Date,'{1}',103)", dataInicial, dataFinal));
                    }
                    queryFalhas.Append(" order by sc.IdDna");
                    break;
            }

            DataTable dt = db.ExecuteReaderQuery(queryFalhas.ToString());
            int total = dt.Rows.Count;

            foreach (DataRow item in dt.Rows)
            {
                if (statusFalha == "falha")
                {
                    lstFalhas.Add(string.Format("{0}@{1}@{2}@{3}@{4}", item["IdDna"].ToString(), item["Data"].ToString(), item["PortaAberta"].ToString(), item["Falha"].ToString(),total));
                }
                else
                {
                    lstFalhas.Add(string.Format("{0}@{1}@{2}@{3}@{4}", item["IdDna"].ToString(), item["Data"].ToString(), item["Porta"].ToString(), item["SemComunicacao"].ToString(),total));
                }
            }

            return lstFalhas;
        }

        #region GetCityHallId

        public long GetIdCityHall()
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
}
