using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace GwCentral.Relatorios.ListaControladores
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class Default1 : System.Web.Services.WebService
    {
        Banco db = new Banco("");
        [WebMethod]
        public List<Controlador> GetControllers()
        {
            List<Controlador> lstControlador = new List<Controlador>();

            DataTable dt = db.ExecuteReaderQuery(@"select s.Serial,Falha, 
case PortaAberta when 0 then 'Fechada' when 1  then 'Aberta' end as Porta,IP,Atualizado, 
(select top(1) case Reset when 1 then 'reset pendente' 
when 0 then lr.DataHora+' - '+lr.Resposta end 
from Status s2 join logReseteControlador lr on lr.serial= s2.serial where s2.Serial =s.serial
and mib='.1.3.6.1.4.1.13267.3.2.4.2.1.6'
order by convert(datetime,lr.datahora,103) desc)'Resposta Reset',
s.PortSnmpReset 
from Status s  where s.Serial like 'GWT%'");

            string falha = "";

            foreach (DataRow item in dt.Rows)
            {
                try
                {
                    if (DateTime.Now.Subtract(Convert.ToDateTime(item["Atualizado"].ToString())).TotalMinutes >= 15)
                    {
                        falha = "Falha Comunicação";
                    }
                    else
                    {
                        falha = item["Falha"].ToString();
                    }
                }
                catch
                {
                    falha = "Falha Comunicação";
                }

                lstControlador.Add(new Controlador
                {
                    serial = item["Serial"].ToString(),
                    falha = falha,
                    porta = item["Porta"].ToString(),
                    ip = item["IP"].ToString(),
                    atualizado = item["Atualizado"].ToString(),
                    portaReset = item["PortSnmpReset"].ToString(),
                    ultimoReset = item["Resposta Reset"].ToString()
                });
            }

            return lstControlador;
        }

        [WebMethod]
        public void ResetaControlador(string serial)
        {
            string statusReset = db.ExecuteScalarQuery(string.Format("select Reset from Status where Serial='{0}'", serial));
            if (statusReset != "True")
            {
                db.ExecuteNonQuery(string.Format("update Status set Reset=1 ,DtHrEnvioReset='" + DateTime.Now.ToString("dd/MM/yyy hh:mm:ss") + "' where Serial='{0}'", serial));
            }
        }

        [WebMethod]
        public void EditPortaReset(string serial, string portaReset)
        {
            db.ExecuteNonQuery(string.Format("update Status set PortSnmpReset='" + portaReset + "' where Serial='{0}'", serial));

        }

        public struct Controlador
        {
            public string serial { get; set; }
            public string falha { get; set; }
            public string porta { get; set; }
            public string ip { get; set; }
            public string atualizado { get; set; }
            public string portaReset { get; set; }
            public string ultimoReset { get; set; }
        }
    }
}
