using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.Services;

namespace GwCentral.Relatorios.HistoricoChipControlador
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class Default1 : System.Web.Services.WebService
    {
        Banco db = new Banco("");

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

        [WebMethod]
        public List<Chip> PesquisarChip(string dataIni, string dataFini, string idPonto, string operadora, string planoChip, string Consorcio, string Empresa, string EmpInsta)
        {
            List<Chip> lstChip = new List<Chip>();
            long idPrefeitura = GetIdCityHall();

            StringBuilder query = new StringBuilder();

            query.Append(string.Format(@"select idDna,tipo,empresa,empresaInsta,operadora,hexa,numero,plano,consorcio
from ChipDna
where idPrefeitura = {0}
and CONVERT(Date,data,103)
between CONVERT(Date,'{1}',103) and CONVERT(Date,'{2}',103)", idPrefeitura, dataIni, dataFini));


            if (!string.IsNullOrEmpty(idPonto))
            {
                query.Append(string.Format(" and idDna='{0}'", idPonto));
            }
            if (!string.IsNullOrEmpty(operadora))
            {
                query.Append(string.Format(" and operadora='{0}'", operadora));
            }
            if (!string.IsNullOrEmpty(planoChip))
            {
                query.Append(string.Format(" and plano='{0}'", planoChip));
            }
            if (!string.IsNullOrEmpty(Consorcio))
            {
                query.Append(string.Format(" and Consorcio='{0}'", Consorcio));
            }
            if (!string.IsNullOrEmpty(Empresa))
            {
                query.Append(string.Format(" and Empresa='{0}'", Empresa));
            }
            if (!string.IsNullOrEmpty(EmpInsta))
            {
                query.Append(string.Format(" and empresaInsta='{0}'", EmpInsta));
            }
            DataTable dt = db.ExecuteReaderQuery(query.ToString());

            foreach (DataRow item in dt.Rows)
            {
                lstChip.Add(new Chip
                {
                    idDna = item["idDna"].ToString(),
                    tipo = item["tipo"].ToString(),
                    empresa = item["empresa"].ToString(),
                    empresainsta = item["empresaInsta"].ToString(),
                    operadora = item["operadora"].ToString(),
                    hexa = item["hexa"].ToString(),
                    numero = item["numero"].ToString(),
                    plano = item["plano"].ToString(),
                    consorcio = item["consorcio"].ToString()
                });
            }

            return lstChip;
        }

        [WebMethod]
        public List<string> GetBusinesses(string consorcioId)
        {
            Banco dbStatic = new Banco("");
            //DataTable dt = dbStatic.ExecuteReaderQuery(string.Format("select Id,Empresa from Empresa where IdConsorcio={0}", consorcioId));
            DataTable dt = dbStatic.ExecuteReaderQuery("select idconsorcio,Id,Empresa from Empresa");
            List<string> lstEmpresa = new List<string>();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow item in dt.Rows)
                {
                    lstEmpresa.Add(string.Format("{0}@{1}`@{2}", item["Empresa"].ToString(), item["Id"].ToString(), item["idconsorcio"]));
                }
            }

            return lstEmpresa;
        }

        public struct Chip
        {
            public string id { get; set; }
            public string idDna { get; set; }
            public string tipo { get; set; }
            public string empresa { get; set; }
            public string empresainsta { get; set; }
            public string operadora { get; set; }
            public string hexa { get; set; }
            public string numero { get; set; }
            public string plano { get; set; }
            public string consorcio { get; set; }
        }
    }
}
