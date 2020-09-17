using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Security.Authentication;
using Newtonsoft.Json;

namespace GwCentral.ListaConsorcioDnaEmpresa
{
    /// <summary>
    /// Summary description for wService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class wService : System.Web.Services.WebService
    {

        Banco db = new Banco("");
        Banco dbCet = new Banco(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringCET"].ConnectionString);
        [WebMethod]
        public List<DNA> GetDNAbyConsorcio(string idConsorcio)
        {

            List<DNA> lstDNAsbyConsorcioSME = new List<DNA>();
            List<DNA> lstDNAsbyConsorcio = new List<DNA>();
            string lote = "", loteAntigo = "", consorcio = "", cruzamento = "", idDna = "", ConsorcioAntigo = "";
            string lat = "0", lon = "0";
            string empresa = "0";
            


            DataTable dtSemaforo = db.ExecuteReaderQuery(string.Format(@"select Id,Cruzamento,Consorcio,Lote,Empresa,SemServico,latitude
from DNA  where idPrefeitura ={0}", HttpContext.Current.Profile["idPrefeitura"]));
            if (idConsorcio == "0")
                idConsorcio = " is null";
            else
                idConsorcio = "="+ idConsorcio;

            string s = @"SELECT l.id_local, dbo.funcNomeiaLocal(l.id_local) Endereco, l.latitude, l.longitude, 
isnull(convert(varchar,d.id_empresa), 'CET') id_empresa
 FROM Local l
  LEFT JOIN DnaFase1 d
   ON d.id_local = l.id_local
  LEFT JOIN db_locais..distritos di
    ON di.id_distrito = l.id_distrito
  LEFT JOIN db_locais..decs de
    ON de.sigla = l.dec
  LEFT JOIN db_locais..gets ge
    ON ge.id_get = de.id_get
 LEFT JOIN Alteracao a
   ON l.id_local = a.id_local
	  WHERE a.id_familia = 1
  AND a.status in (0)
  AND a.id_alteracao = 
  (SELECT MAX(a1.id_alteracao) FROM Alteracao a1 WHERE a1.id_local = a.id_local AND a1.id_familia = a.id_familia)
  and d.id_empresa" + idConsorcio;

            ServiceSME.ServiceClient svcSme = new ServiceSME.ServiceClient(); 
            string t = svcSme.GetExecuteReaderQuery(s);


            DataTable dtcet = (DataTable)JsonConvert.DeserializeObject(t, (typeof(DataTable)));

           // DataTable dtcet = dbCet.ExecuteReaderQuery(s);

            foreach (DataRow drCet in dtcet.Rows)
            {
                consorcio = "CET";
                if (drCet["id_empresa"].ToString() == "0" || drCet["id_empresa"].ToString() == "" || drCet["id_empresa"].ToString() == "CET")
                {
                    lote = "5";
                    consorcio = "CET";
                }
                else if (drCet["id_empresa"].ToString() == "23")
                {
                    lote = "3";
                    consorcio = "CONSORCIO MCS";
                }
                else if (drCet["id_empresa"].ToString() == "24")
                {
                    lote = "1";
                    consorcio = "CONSORCIO SINAL PAULISTANO";
                }
                else if (drCet["id_empresa"].ToString() == "25")
                {
                    lote = "2";
                    consorcio = "CONSORCIO ONDAVERDE";
                }
                else if (drCet["id_empresa"].ToString() == "27")
                {
                    lote = "4";
                    consorcio = "CONSORCIO SEMAFORICO PAULISTANO";
                }

                DataView dv = new DataView(dtSemaforo);
                dv.RowFilter = "id='" + drCet["id_local"].ToString() + "'";
                cruzamento = drCet["endereco"].ToString();
                lat = drCet["latitude"].ToString();
                lon = drCet["longitude"].ToString();
                idDna = drCet["id_local"].ToString();

                if (dv.Count > 0)
                {
                    empresa = dv[0].Row["empresa"].ToString();
                    if (lote != dv[0].Row["lote"].ToString())
                    {
                        empresa = DBNull.Value.ToString();
                        loteAntigo = dv[0].Row["lote"].ToString();
                        ConsorcioAntigo = dv[0].Row["consorcio"].ToString();

                        db.ExecuteNonQuery(string.Format(@"UPDATE DNA SET Cruzamento='{0}', latitude='{1}', longitude='{2}', Consorcio='{4}', 
empresa=NULL, lote={5} where Id='{3}'", cruzamento, lat, lon, idDna, consorcio, lote));

                        db.ExecuteNonQuery(string.Format(@"INSERT INTO [HistoricoDNA] ('[DNA]',[ConsorcioIdAtual],[ConsorcioAtual],[DataHora],[ConsorcioIdAntigo],[ConsorcioAntigo])
     VALUES ('{0}',{1},'{2}','{3}',{4},'{5}')", idDna, lote, consorcio, DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"), loteAntigo, ConsorcioAntigo));

                    }

                }
                else
                {
                    db.ExecuteNonQuery(string.Format(@"INSERT INTO DNA (Id,Consorcio,Cruzamento,latitude,longitude,Lote,DataCadastro,Usuario,idPrefeitura)
VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}')", idDna, consorcio, cruzamento, lat, lon, lote,
DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"), User.Identity.Name, HttpContext.Current.Profile["idPrefeitura"]));
                }

                lstDNAsbyConsorcio.Add(new DNA
                {
                    dna = idDna,
                    endereco = cruzamento,
                    consorcio = consorcio,
                    empresa = empresa
                });

            }

            var objetosEmOrdem = from o in lstDNAsbyConsorcio
                                  orderby o.empresa
                                  select o;
            return objetosEmOrdem.ToList();
        }

        [WebMethod]
        public List<DNA> GetDNAbyConsorcio_SemComparar(string idConsorcio)
        {
            List<DNA> lstDNAsbyEmpresa = new List<DNA>();

            string lote = "";

            if (idConsorcio == "0")
            {
                lote = "5";
            }
            else if (idConsorcio == "23")
            {
                lote = "3";
            }
            else if (idConsorcio == "24")
            {
                lote = "1";
            }
            else if (idConsorcio == "25")
            {
                lote = "2";
            }
            else if (idConsorcio == "27")
            {
                lote = "4";
            }

            DataTable dtSemaforo = db.ExecuteReaderQuery(string.Format(@"select Id,Cruzamento,Consorcio,Lote,Empresa,SemServico,latitude
from DNA  where Lote='{0}' and idPrefeitura ={1} order by cruzamento", lote, HttpContext.Current.Profile["idPrefeitura"]));

            foreach (DataRow dr in dtSemaforo.Rows)
            {
                lstDNAsbyEmpresa.Add(new DNA
                {
                    dna = dr["Id"].ToString(),
                    endereco = dr["Cruzamento"].ToString(),
                    consorcio = dr["Consorcio"].ToString(),
                    empresa = dr["Empresa"].ToString()
                });
            }


            return lstDNAsbyEmpresa;    
        }

        [WebMethod]
        public List<string> GetEmpresasbyConsorcio(string idConsorcio)
        {
            List<string> Lista_Empresa = new List<string>();

            string lote = "";

            if (idConsorcio == "0")
            {
                lote = "5";
            }
            else if (idConsorcio == "23")
            {
                lote = "3";
            }
            else if (idConsorcio == "24")
            {
                lote = "1";
            }
            else if (idConsorcio == "25")
            {
                lote = "2";
            }
            else if (idConsorcio == "27")
            {
                lote = "4";
            }

            DataTable dtSemaforo = db.ExecuteReaderQuery(string.Format(@"select Empresa 
from DNA  where Lote={0} and idPrefeitura ={1} and Empresa is not null group by Empresa", lote, HttpContext.Current.Profile["idPrefeitura"]));

            foreach (DataRow dr in dtSemaforo.Rows)
            {
                Lista_Empresa.Add(dr["Empresa"].ToString());
            }

            return Lista_Empresa;
        }

        [WebMethod]
        public List<DNA> GetDNAbyEmpresa(string empresa)
        {
      
            List<DNA> lstDNAsbyEmpresa = new List<DNA>();
          
            DataTable dtSemaforo = db.ExecuteReaderQuery(string.Format(@"select Id,Cruzamento,Consorcio,Lote,Empresa,SemServico,latitude
from DNA  where empresa='{0}' and idPrefeitura ={1} order by cruzamento", empresa, HttpContext.Current.Profile["idPrefeitura"]));

            foreach (DataRow dr in dtSemaforo.Rows)
            {
                lstDNAsbyEmpresa.Add(new DNA
                {
                    dna = dr["Id"].ToString(),
                    endereco = dr["Cruzamento"].ToString(),
                    consorcio = dr["Consorcio"].ToString(),
                    empresa = dr["Empresa"].ToString()
                });
            }


            return lstDNAsbyEmpresa;
        }


        [WebMethod]
        public List<DNA> GetDNAbyIdPonto(string IdPonto)
        {

            List<DNA> lstDNAsbyConsorcioSME = new List<DNA>();
            List<DNA> lstDNAsbyConsorcio = new List<DNA>();
            string lote = "", loteAntigo = "", consorcio = "", cruzamento = "", idDna = "", ConsorcioAntigo = "";
            string lat = "0", lon = "0";
            string empresa = "0";



            DataTable dtSemaforo = db.ExecuteReaderQuery(string.Format(@"select Id,Cruzamento,Consorcio,Lote,Empresa,SemServico,latitude
from DNA  where idPrefeitura ={0}", HttpContext.Current.Profile["idPrefeitura"]));

            string s = @"SELECT l.id_local, dbo.funcNomeiaLocal(l.id_local) Endereco, l.latitude, l.longitude, 
isnull(convert(varchar,d.id_empresa), 'CET') id_empresa
 FROM Local l
  LEFT JOIN DnaFase1 d
   ON d.id_local = l.id_local
  LEFT JOIN db_locais..distritos di
    ON di.id_distrito = l.id_distrito
  LEFT JOIN db_locais..decs de
    ON de.sigla = l.dec
  LEFT JOIN db_locais..gets ge
    ON ge.id_get = de.id_get
 LEFT JOIN Alteracao a
   ON l.id_local = a.id_local
	  WHERE a.id_familia = 1
  AND a.status in (0)
  AND a.id_alteracao = 
  (SELECT MAX(a1.id_alteracao) FROM Alteracao a1 WHERE a1.id_local = a.id_local AND a1.id_familia = a.id_familia)
  and l.id_local='" + IdPonto+"'";
            ServiceSME.ServiceClient svcSme = new ServiceSME.ServiceClient();
            string t = svcSme.GetExecuteReaderQuery(s);


            DataTable dtcet = (DataTable)JsonConvert.DeserializeObject(t, (typeof(DataTable)));
            //DataTable dtcet = dbCet.ExecuteReaderQuery(s);

            foreach (DataRow drCet in dtcet.Rows)
            {
                consorcio = "CET";
                if (drCet["id_empresa"].ToString() == "0" || drCet["id_empresa"].ToString() == "")
                {
                    lote = "5";
                    consorcio = "CET";
                }
                else if (drCet["id_empresa"].ToString() == "23")
                {
                    lote = "3";
                    consorcio = "CONSORCIO MCS";
                }
                else if (drCet["id_empresa"].ToString() == "24")
                {
                    lote = "1";
                    consorcio = "CONSORCIO SINAL PAULISTANO";
                }
                else if (drCet["id_empresa"].ToString() == "25")
                {
                    lote = "2";
                    consorcio = "CONSORCIO ONDAVERDE";
                }
                else if (drCet["id_empresa"].ToString() == "27")
                {
                    lote = "4";
                    consorcio = "CONSORCIO SEMAFORICO PAULISTANO";
                }

                DataView dv = new DataView(dtSemaforo);
                dv.RowFilter = "id='" + drCet["id_local"].ToString() + "'";
                cruzamento = drCet["endereco"].ToString();
                lat = drCet["latitude"].ToString();
                lon = drCet["longitude"].ToString();
                idDna = drCet["id_local"].ToString();

                if (dv.Count > 0)
                {
                    empresa = dv[0].Row["empresa"].ToString();
                    if (lote != dv[0].Row["lote"].ToString())
                    {
                        empresa = DBNull.Value.ToString();
                        loteAntigo = dv[0].Row["lote"].ToString();
                        ConsorcioAntigo = dv[0].Row["consorcio"].ToString();

                        db.ExecuteNonQuery(string.Format(@"UPDATE DNA SET Cruzamento='{0}', latitude='{1}', longitude='{2}', Consorcio='{4}', 
empresa=NULL, lote={5} where Id='{3}'", cruzamento, lat, lon, idDna, consorcio, lote));

                        db.ExecuteNonQuery(string.Format(@"INSERT INTO [HistoricoDNA] ([DNA],[ConsorcioIdAtual],[ConsorcioAtual],[DataHora],[ConsorcioIdAntigo],[ConsorcioAntigo])
     VALUES ('{0}',{1},'{2}','{3}',{4},'{5}')", idDna, lote, consorcio, DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"), loteAntigo, ConsorcioAntigo));

                    }

                }
                else
                {
                    db.ExecuteNonQuery(string.Format(@"INSERT INTO DNA (Id,Consorcio,Cruzamento,latitude,longitude,Lote,DataCadastro,Usuario,idPrefeitura)
VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}')", idDna, consorcio, cruzamento, lat, lon, lote,
DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"), User.Identity.Name, HttpContext.Current.Profile["idPrefeitura"]));
                }

                string permite_alterar = PermissaoConsorcio(consorcio);

                lstDNAsbyConsorcio.Add(new DNA
                {
                    dna = idDna,
                    endereco = cruzamento,
                    consorcio = consorcio,
                    empresa = empresa,
                    PermiteAlterar = permite_alterar
                });

            }

            var objetosEmOrdem = from o in lstDNAsbyConsorcio
                                 orderby o.empresa
                                 select o;
            return objetosEmOrdem.ToList();
        }



        [WebMethod]
        public void EditEmpresa(string dna, string empresa)
        {
            db.ExecuteNonQuery(string.Format("update dna set empresa='" + empresa + "' where id='{0}'", dna));
        }

        [WebMethod]
        public string PermissaoConsorcio(string Consorcio)
        {
            string Permissao = "SIM";
            string ConsorcioVerificar = "";

            if (Consorcio == "CONSORCIO SINAL PAULISTANO")
            {
                ConsorcioVerificar = "CONSORCIO SINALPAULISTANO";
            }
            else if (Consorcio == "CONSORCIO ONDAVERDE")
            {
                ConsorcioVerificar = "CONSORCIO ONDAVERDE";
            }
            else if (Consorcio == "CONSORCIO MCS")
            {
                ConsorcioVerificar = "CONSORCIO MCS";
            }
            else if (Consorcio == "CONSORCIO SEMAFORICO PAULISTANO")
            {
                ConsorcioVerificar = "CONSORCIO 4";
            }
            else if (Consorcio == "CET")
            {
                ConsorcioVerificar = "CONSORCIO CET";
            }

            if(User.IsInRole(ConsorcioVerificar))
            {
                Permissao = "SIM";
            }
            else
            {
                Permissao = "NAO";
            }

                return Permissao;
        }


        [WebMethod]
        public string qtdDna()
        {


            string s = @"        SELECT count(0) qtd
 FROM Local l
  LEFT JOIN DnaFase1 d
   ON d.id_local = l.id_local
 LEFT JOIN Alteracao a
   ON l.id_local = a.id_local

      WHERE a.id_familia = 1
  AND a.status in (0)
  AND a.id_alteracao = 
  (SELECT MAX(a1.id_alteracao) FROM Alteracao a1 WHERE a1.id_local = a.id_local AND a1.id_familia = a.id_familia)";
            ServiceSME.ServiceClient svcSme = new ServiceSME.ServiceClient();
            string t = svcSme.GetExecuteReaderQuery(s);


            DataTable dtcet = (DataTable)JsonConvert.DeserializeObject(t, (typeof(DataTable)));
            DataRow dr = dtcet.Rows[0];
            string qtd =dr["qtd"].ToString();
            return qtd;
        }

        public struct DNA
        {
            public string dna { get; set; }
            public string endereco { get; set; }
            public string Latitude { get; set; }
            public string Longitude { get; set; }
            public string consorcio { get; set; }
            public string empresa { get; set; }
            public string PermiteAlterar { get; set; }

        }
    }
}
