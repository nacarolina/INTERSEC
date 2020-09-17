using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;

namespace GwCentral.Relatorios.TensaoEntradaNobreak
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    public class LogNobreak : System.Web.Services.WebService
    {
        Banco db = new Banco("");

        [WebMethod]
        public List<LogStatusNobreak> GetVoltageInputLine(string idDna, string serial, string data)
        {
            List<LogStatusNobreak> lstNobreaks = new List<LogStatusNobreak>();

            StringBuilder query = new StringBuilder();

            query.Append(@" select Descricao,Valor,SUBSTRING(convert(varchar(29),Data,121),12,5) as Data
  ,SUBSTRING(convert(varchar(29),Data,121),0,12)
from LogStatusNobreak
where Descricao in ('Valor,Tensão de entrada V', 'Tensão de saida V','Tensão das baterias V')");

            if (!string.IsNullOrEmpty(data))
            {
                query.Append(string.Format(" and SUBSTRING(convert(varchar(29),Data,121),0,12)='{0}' ", string.Format("{0}-{1}-{2}", data.Substring(6, 4), data.Substring(3, 2), data.Substring(0, 2))));
            }
            else
            {
                query.Append("and SUBSTRING(convert(varchar(29),Data,121),0,12) = SUBSTRING(CONVERT(varchar(30),GETDATE(),121),0,12)");
            }

            if (!string.IsNullOrEmpty(idDna))
            {
                query.Append(string.Format(" and iddna='{0}'", idDna));
            }
            if (!string.IsNullOrEmpty(serial))
            {
                query.Append(string.Format(" and serial='{0}'", serial));
            }

            DataTable dt = db.ExecuteReaderQuery(string.Format(query.ToString()));

            foreach (DataRow item in dt.Rows)
            {
                lstNobreaks.Add(new LogStatusNobreak
                {
                    descricao = item["Descricao"].ToString(),
                    valor = item["Valor"].ToString(),
                    data = item["Data"].ToString()
                });
            }

            return lstNobreaks;
        }

        
           
        public struct LogStatusNobreak
        {
            public string serial { get; set; }
            public string idDna { get; set; }
            public string descricao { get; set; }
            public string valor { get; set; }
            public string data { get; set; }
        }
    }
}
