using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.Services;

namespace GwCentral.WebServices
{
    /// <summary>
    /// Summary description for Map
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

    [System.Web.Script.Services.ScriptService]
    public sealed class Map : WebService
    {
        Banco db = new Banco("");
        public struct Croqui
        {
            public string Id { get; set; }

            public string NomeArquivo { get; set; }
        }
        [WebMethod]
        public List<Croqui> CarregaArquivosCroqui(string idEqp)
        {
            DataTable dt;
            List<Croqui> lst = new List<Croqui>();
            dt = db.ExecuteReaderQuery("select NomeArquivo,id from CroquiEqp where idEQp='" + idEqp + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new Croqui
                {
                    NomeArquivo = dr["NomeArquivo"].ToString(),
                    Id = dr["id"].ToString()
                });
            }
            return lst;
        }

        [WebMethod]
        public List<string> CarregaImagensIterseccao(string idEqp)
        {

            List<string> lst = new List<string>();
            try
            {
                if (!Directory.Exists("C:\\inetpub\\wwwroot\\INTERSEC\\ImagemDepartamento\\Images\\" + idEqp))
                {
                    Directory.CreateDirectory("C:\\inetpub\\wwwroot\\INTERSEC\\ImagemDepartamento\\Images\\" + idEqp);
                }
                foreach (string item in Directory.GetFiles("C:\\inetpub\\wwwroot\\INTERSEC\\ImagemDepartamento\\Images\\" + idEqp, "*.png"))
                {
                    lst.Add(item.Replace("C:\\inetpub\\wwwroot\\INTERSEC\\", ""));
                }
                foreach (string item in Directory.GetFiles("C:\\inetpub\\wwwroot\\INTERSEC\\ImagemDepartamento\\Images\\" + idEqp, "*.jpg"))
                {
                    lst.Add(item.Replace("C:\\inetpub\\wwwroot\\INTERSEC\\", ""));
                }

            }
            catch
            {

            }


            return lst;
        }
        [WebMethod]
        public void SalveConfigMap(int zoom, string lat, string lng)
        {
            string idPrefBase = db.ExecuteScalarQuery(string.Format("select idPrefeitura from ConfigMap where idPrefeitura={0}", HttpContext.Current.Profile["idPrefeitura"]));

            if (HttpContext.Current.Profile["idPrefeitura"].ToString() == idPrefBase)
            {
                db.ExecuteNonQuery(string.Format("update ConfigMap set latitude='{0}',longitude='{1}',zoom={2} where idPrefeitura={3}", lat, lng, zoom, HttpContext.Current.Profile["idPrefeitura"]));
            }
            else
            {
                db.ExecuteNonQuery(string.Format("insert into ConfigMap (latitude,longitude,zoom,idPrefeitura) values ('{0}','{1}',{2},{3})", lat, lng, zoom, HttpContext.Current.Profile["idPrefeitura"]));
            }

        }

        [WebMethod]
        public void SalveConfigParamsMap(int tempoFalhaComunicacao, int tempoAtualizaMapa)
        {
            string idPrefBase = db.ExecuteScalarQuery(string.Format("select idPrefeitura from ConfigMap where idPrefeitura={0}", HttpContext.Current.Profile["idPrefeitura"]));

            if (HttpContext.Current.Profile["idPrefeitura"].ToString() == idPrefBase)
            {
                db.ExecuteNonQuery(string.Format("update ConfigMap set TempoFalhaComunicacao={0},TempoAtualizaMapa={1} where idPrefeitura={2}", tempoFalhaComunicacao, tempoAtualizaMapa, HttpContext.Current.Profile["idPrefeitura"]));
            }
            else
            {
                db.ExecuteNonQuery(string.Format("insert into ConfigMap (TempoFalhaComunicacao,TempoAtualizaMapa,idPrefeitura) values ({0},{1},{2})", tempoFalhaComunicacao, tempoAtualizaMapa, HttpContext.Current.Profile["idPrefeitura"]));
            }
        }

        [WebMethod]
        public string SolicitarFotoBB(string idPonto)
        {
            string idSolicitacao = "";
            string serialComunicacao = GetSerialComunicacao(idPonto);
            string ipCam = GetIpCam(idPonto);
            string dataHora = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
            string dataHoraFormated = dataHora;
            dataHoraFormated = dataHoraFormated.Replace("/", "").Replace(":", "").Replace(" ", "");
            idSolicitacao = db.ExecuteScalarQuery(@"Insert into FotosBB (NomeFoto,Serial,Flag,IdDna,DataHora,ipCamera,TipoFoto) 
Values('" + idPonto + " - " + dataHoraFormated + "','" + serialComunicacao + "','" + "N" + "','" + idPonto +
          "','" + dataHora + "','" + ipCam + "','Foto Solicitada Manualmente')SELECT SCOPE_IDENTITY()");
            return idSolicitacao;
        }

        public struct DataImagemBB
        {
            public string dataBB { get; set; }
        }

        public struct ConfigBB
        {
            public string solicitacaoSegBB { get; set; }
            public string obterImagemFalha { get; set; }
        }

        public struct ImagemBB
        {
            public string nomeFoto { get; set; }
            public string dataHora { get; set; }
            public string dataHoraFormatted { get; set; }
            public string falha { get; set; }
        }

        [WebMethod]
        public List<DataImagemBB> CarregarListaDatasImagemBB(string idPonto)
        {
            List<DataImagemBB> lst = new List<DataImagemBB>();
            string serialComunicacao = GetSerialComunicacao(idPonto);
            DataTable dt = db.ExecuteReaderQuery("Select distinct Convert(datetime,DataHora) DataHora from FotosBB where Serial='" + serialComunicacao + "' And IdDna='" + idPonto + "' And Flag = 'S' order by Convert(datetime,DataHora) desc");
            foreach (DataRow item in dt.Rows)
            {
                string dataHora = item["DataHora"].ToString();
                string[] result = dataHora.Split(' ');
                string data = result[0];

                lst.Add(new DataImagemBB
                {
                    dataBB = data
                });
            }
            return lst;
        }

        [WebMethod]
        public List<ConfigBB> ConfigImagemBB(string idPonto)
        {
            List<ConfigBB> lst = new List<ConfigBB>();
            DataTable dt = db.ExecuteReaderQuery("select solicitacaoSeg,obterImagemFalha from cameraconfig where idDna='" + idPonto + "' And IdPrefeitura=" + HttpContext.Current.Profile["IdPrefeitura"]);
            lst.Add(new ConfigBB
            {
                solicitacaoSegBB = dt.Rows[0]["solicitacaoSeg"].ToString(),
                obterImagemFalha = dt.Rows[0]["obterImagemFalha"].ToString()
            });
            return lst;
        }

        [WebMethod]
        public List<ImagemBB> CarregarImagensBBData(string idPonto, string Data, string type)
        {
            if (string.IsNullOrEmpty(Data)) Data = DateTime.Now.ToString("dd/MM/yyyy");

            switch (type)
            {
                case "Fotos por Tempo":
                    type = "Solicitação por tempo";
                    break;
                case "Fotos manuais":
                    type = "Foto Solicitada Manualmente";
                    break;
                case "Fotos por falha":
                    type = "Foto solicitada por falha";
                    break;
            }

            List<ImagemBB> lst = new List<ImagemBB>();
            string serialComunicacao = GetSerialComunicacao(idPonto);
            DataTable dt;
            if (!string.IsNullOrEmpty(type))
            {
                dt = db.ExecuteReaderQuery(@"Select NomeFoto,DataHora,Falha from FotosBB where Serial='" + serialComunicacao +
                "' And Flag = 'S' And DataHora like '%" + Data + "%' And IdDna='" + idPonto + "' And TipoFoto='" + type + "' order by DataHora desc");
            }
            else
            {
                dt = db.ExecuteReaderQuery(@"Select NomeFoto,DataHora,Falha from FotosBB where Serial='" + serialComunicacao +
                    "' And Flag = 'S' And DataHora like '%" + Data + "%' And IdDna='" + idPonto + "' order by DataHora desc");
            }

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new ImagemBB
                {
                    nomeFoto = item["NomeFoto"].ToString(),
                    dataHoraFormatted = item["DataHora"].ToString().Substring(0, 10).Replace("/", ""),
                    dataHora = item["DataHora"].ToString(),
                    falha = item["Falha"].ToString()
                });
            }

            return lst;
        }


        [WebMethod]
        public string VerificaImagemBB(string idPonto, string idSolicitacao)
        {
            string retorno = "";
            string serialComunicacao = GetSerialComunicacao(idPonto);
            string dataHora = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
            dataHora = dataHora.Replace("/", "").Replace(":", "").Replace(" ", "");

            DataTable dt = db.ExecuteReaderQuery(@"Select top 1 NomeFoto from FotosBB Where Serial='" + serialComunicacao + "' And IdDna='" + idPonto +
                "' And Flag='S' And TipoFoto='Foto Solicitada Manualmente' And Id=" + idSolicitacao + " order by id desc");
            if (dt.Rows.Count > 0) retorno = "Imagem sincronizada";
            else
            {
                dt = db.ExecuteReaderQuery(@"Select top 1 RecebeuRequisicao from FotosBB Where Serial='" + serialComunicacao + "' And IdDna='" + idPonto +
                    "' And RecebeuRequisicao='SIM' And TipoFoto='Foto Solicitada Manualmente' And Id=" + idSolicitacao + " order by id desc");
                if (dt.Rows.Count > 0) retorno = "Solicitação de imagem enviada! Aguardando Sincronização...";
                else retorno = "A imagem solicitada não foi enviada! Verifique a conexão da sua câmera.";
            }
            return retorno;
        }

        [WebMethod]
        public void ResetApp(string idPonto)
        {
            string serialComunicacao = GetSerialComunicacao(idPonto);
            string dataHora = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");

            db.ExecuteNonQuery(@"Insert Into resetMMBB (idPrefeitura,flag,DataHora,serial) 
Values (" + HttpContext.Current.Profile["IdPrefeitura"] + ",'N','" + dataHora + "','" + serialComunicacao + "')");
        }

        public string GetSerialComunicacao(string idponto)
        {
            string serialComunicacao = db.ExecuteScalarQuery("Select SerialComunicacao from CameraConfig Where IdDna='" + idponto + "' And IdPrefeitura=" + HttpContext.Current.Profile["IdPrefeitura"]);
            return serialComunicacao;
        }

        public string GetIpCam(string idPonto)
        {
            string ipCam = db.ExecuteScalarQuery("Select hostName from CameraConfig Where IdDna='" + idPonto + "' And IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
            return ipCam;
        }

        [WebMethod]
        public void SalvarSolicitacaoTempo(string idPonto, string segundos, string obterImagemFalha)
        {
            string serialComunicacao = GetSerialComunicacao(idPonto);
            string ipCam = GetIpCam(idPonto);
            string dataHora = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
            string dataHoraFormated = dataHora;
            dataHoraFormated = dataHoraFormated.Replace("/", "").Replace(":", "").Replace(" ", "");

            string Id = db.ExecuteScalarQuery("SELECT Id FROM FotosBB WHERE IdDna = '" + idPonto + "' and Serial = '" + serialComunicacao +
                "' And TipoFoto='Solicitação por tempo'");
            if (string.IsNullOrEmpty(Id))
            {
                db.ExecuteNonQuery(@"Insert into FotosBB (NomeFoto,Serial,Flag,IdDna,DataHora,ipCamera,TipoFoto) 
Values('" + idPonto + " - " + dataHoraFormated + "','" + serialComunicacao + "','" + "N" + "','" + idPonto +
           "','" + dataHora + "','" + ipCam + "','Solicitação por tempo')");
            }

            if (!string.IsNullOrEmpty(segundos))
                db.ExecuteNonQuery(@"Update CameraConfig set solicitacaoSeg=" + int.Parse(segundos) + ", obterImagemFalha='" + obterImagemFalha + "' Where IdDna='" + idPonto +
                    "' And IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
            else
            {
                db.ExecuteNonQuery(@"Update CameraConfig set solicitacaoSeg=0, obterImagemFalha='" + obterImagemFalha + "' Where IdDna='" + idPonto +
                   "' And IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

            }

        }

        [WebMethod]
        public string ExcluirImagemBB(string NomeFoto)
        {
            db.ExecuteNonQuery("DELETE FROM FotosBB Where NomeFoto='" + NomeFoto + "'");
            try
            {
                string path = Server.MapPath("../ImagesBeagleBone/") + NomeFoto + ".jpg";
                File.Delete(path);
            }
            catch (Exception e)
            {
            }
            return "OK";
        }

        [WebMethod]
        public List<string> GetConfigParams()
        {
            List<string> lstParams = new List<string>();

            DataTable dt = db.ExecuteReaderQuery(string.Format("select TempoFalhaComunicacao,TempoAtualizaMapa from ConfigMap where idPrefeitura={0}", HttpContext.Current.Profile["idPrefeitura"]));

            foreach (DataRow dr in dt.Rows)
            {
                lstParams.Add(dr["TempoAtualizaMapa"].ToString());
                lstParams.Add(dr["TempoFalhaComunicacao"].ToString());
            }



            return lstParams;
        }

        [WebMethod]
        public List<Dna> GetDetailsDna(string idPonto, string idPrefeitura)
        {
            if (string.IsNullOrEmpty(HttpContext.Current.Profile["idPrefeitura"].ToString()))
            {
                HttpContext.Current.Profile["idPrefeitura"] = idPrefeitura;
            }
            DataTable dt;
            // string idClienteSemaforoSicapp = db.ExecuteScalarQuery(@"select idClienteSicappSemaforo from Prefeitura where id=" + HttpContext.Current.Profile["idPrefeitura"]);
            db.ClearSQLParams();
            db.AddSQLParam("idPrefeitura", HttpContext.Current.Profile["idPrefeitura"]);
            db.AddSQLParam("idDna", idPonto);

            //if (!string.IsNullOrEmpty(idClienteSemaforoSicapp) && idClienteSemaforoSicapp != "0")
            //{
            //    db.AddSQLParam("@idPrefeituraSicapp", idClienteSemaforoSicapp);
            //    dt = db.ExecuteReaderStoredProcedure("GetDetailsDnaSicapp", true);
            //}
            //else
            //{
            //    dt = db.ExecuteReaderStoredProcedure("GetDetailsDna", true);
            //}
            dt = db.ExecuteReaderStoredProcedure("GetDetailsDna", true);
            List<Dna> lstDetailsDna = new List<Dna>();
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];

                string falha = "", portaAberta = "", semComunicacao = "", estado = "", tensao = "", temp = "", estadofunc = "", serialMestre = "", linkmap = "";
                string idDnaMestre = "";

                if (!string.IsNullOrEmpty(idDnaMestre))
                {
                    List<DetailsControladorMestre> lst = GetDetailsConjugadoDNA(int.Parse(idDnaMestre));

                    falha = lst[0].Falha;
                    portaAberta = lst[0].PortaAberta;
                    semComunicacao = lst[0].SemComunicacao;
                    estado = lst[0].Estado;
                }
                else
                {
                    falha = dr["Falha"].ToString();
                    portaAberta = dr["PortaAberta"].ToString();
                    semComunicacao = dr["SemComunicacao"].ToString();
                    estado = dr["comunicaControll"].ToString();
                }

                lstDetailsDna.Add(
                    new Dna
                    {
                        serialMestre = dr["SerialMestre"].ToString(),
                        linkmap = dr["linkmap"].ToString(),
                        tensao = dr["tensaoctrl"].ToString(),
                        temperatura = dr["tempctrl"].ToString(),
                        estadofunc = dr["estadoctrl"].ToString(),
                        semComunicacao = semComunicacao,
                        falha = falha,
                        porta = portaAberta,
                        statusComunicacao = estado,
                        cruzamento = dr["Cruzamento"].ToString(),
                        consorcio = dr["Consorcio"].ToString(),
                        empresa = dr["Empresa"].ToString(),
                        tipoCtrl = dr["Tipo"].ToString(),
                        modeloCtrl = dr["Modelo"].ToString(),
                        nrFasesSuportCtrl = dr["NrFasesSuportadas"].ToString(),
                        dtManutencaoCtrl = dr["dataManutencao"].ToString(),
                        causaManutencaoCtrl = dr["causa"].ToString(),
                        atualizadoCtrl = dr["Atualizado"].ToString(),
                        hostNameCam = dr["hostName"].ToString(),
                        userNameCam = dr["userName"].ToString(),
                        passwordCam = dr["password"].ToString(),
                        serialCtrl = dr["Serial"].ToString(),
                        ipCtrl = dr["IP"].ToString(),
                        ddnsCtrl = dr["Ddns"].ToString(),
                        ipPorTrapCtrl = dr["bRecebeIpTrap"].ToString(),
                        portaSnmpCtrl = dr["PortSnmp"].ToString(),
                        portaSnmpResetCtrl = dr["PortSnmpReset"].ToString(),
                        portaSnmpTrapCtrl = dr["PortSnmpTraps"].ToString(),
                        horarioVeraoEqp = dr["HorarioVeraoEqp"].ToString(),
                        nobItem = new Nobreak
                        {
                            modelo = dr["modelNob"].ToString(),
                            tensao = dr["Tensao"].ToString(),
                            potencia = dr["Potencia"].ToString(),
                            fabricante = dr["Fabricante"].ToString(),
                            dtAtualizacao = dr["atualiNob"].ToString(),
                            ip = dr["ipNob"].ToString(),
                            estado = dr["estadoNobreak"].ToString(),
                            nivelBateria = dr["NivelBat"].ToString(),
                            potenciaCarga = dr["PotenciaCarga"].ToString(),
                            serial = dr["serialNob"].ToString(),
                            temperatura = dr["Temperatura"].ToString(),
                            tensaoBateria = dr["TensaoBat"].ToString(),
                            tensaoIn = dr["TensaoIn"].ToString(),
                            tensaoMaxIn = dr["TensaoMaxIn"].ToString(),
                            tensaoMinIn = dr["TensaoMinIn"].ToString(),
                            tensaoOut = dr["TensaoOut"].ToString(),
                            ipPorTrap = dr["bRecebeIpTrap1"].ToString(),
                            ddns = dr["Ddns1"].ToString(),
                            portaSnmp = dr["portSnmp1"].ToString(),
                            portaSnmpTrap = dr["portSnmpTraps1"].ToString(),
                            tempoNaBateria = dr["TempoNaBateria"].ToString()
                        }
                    });
            }

            return lstDetailsDna;

        }

        [WebMethod]
        public List<Dna> LoadFilterMap(string consorcio, string empresa, string idPonto, string idPrefeitura, string endereco)
        {
            if (string.IsNullOrEmpty(HttpContext.Current.Profile["idPrefeitura"].ToString()))
            {
                HttpContext.Current.Profile["idPrefeitura"] = idPrefeitura;
            }
            StringBuilder detalhesPonto = new StringBuilder();

            detalhesPonto.AppendFormat(@"select d.id,d.latitude,d.longitude,Falha,PortaAberta,ISNULL(SemComunicacao,0) as SemComunicacao,n.serial, isnull((case when (DATEDIFF(minute,convert(datetime,s.atualizado),getdate()) < isnull(tempofalhacomunicacao,15))
then 'True' else 'False' end),'False') estado,isnull((case when (DATEDIFF(minute,n.atualizado,getdate()) > isnull(tempofalhacomunicacao,15))
then 'SC' else n.estado end),'') estadoNobreak,isnull((SELECT TOP(1) [statusAtual] FROM AbrirOrdemServico aos WHERE aos.iddna=s.IdDna and processado=0 
and idPrefeitura=d.idPrefeitura order by id desc),'-1') emManutencao,ISNULL(hostName,'')Camera
from DNA d join Status s on s.IdDna=d.id and s.idprefeitura=d.idprefeitura
left join nobreaks n on n.Iddna = s.IdDna  and s.idprefeitura=n.idprefeitura join ConfigMap cm on cm.idprefeitura=d.idPrefeitura 
left join CameraConfig cmf on cmf.idDna=d.Id and cmf.idPrefeitura = d.idPrefeitura
where  len(d.latitude)>3 and  ISNUMERIC(d.latitude)=1 and HabilitacaoCentral=1 
and d.idPrefeitura={0}", HttpContext.Current.Profile["idPrefeitura"]);

            if (!string.IsNullOrEmpty(consorcio)) detalhesPonto.AppendFormat(" and d.Consorcio='{0}' ", consorcio);
            if (!string.IsNullOrEmpty(empresa)) detalhesPonto.AppendFormat(" and d.Empresa='{0}' ", empresa);
            if (!string.IsNullOrEmpty(idPonto)) detalhesPonto.AppendFormat(" and d.Id='{0}'", idPonto);
            if (!string.IsNullOrEmpty(endereco)) detalhesPonto.AppendFormat(" and d.Cruzamento like '%{0}%'", endereco);

            DataTable dt = db.ExecuteReaderQuery(detalhesPonto.ToString());
            List<Dna> lstDna = new List<Dna>();

            string falha = "", portaAberta = "", semComunicacao = "", estado = "";

            foreach (DataRow dr in dt.Rows)
            {
                string idDnaMestre = "";//GetConjugadoDNA(int.Parse(dr["id"].ToString()));

                if (!string.IsNullOrEmpty(idDnaMestre))
                {
                    List<DetailsControladorMestre> lst = GetDetailsConjugadoDNA(int.Parse(idDnaMestre));

                    falha = lst[0].Falha;
                    portaAberta = lst[0].PortaAberta;
                    semComunicacao = lst[0].SemComunicacao;
                    estado = lst[0].Estado;
                }
                else
                {
                    falha = dr["Falha"].ToString();
                    portaAberta = dr["PortaAberta"].ToString();
                    semComunicacao = dr["SemComunicacao"].ToString();
                    estado = dr["estado"].ToString();
                }

                lstDna.Add(new Dna
                {
                    idDna = dr["id"].ToString(),
                    latitude = dr["latitude"].ToString().Replace(",", "."),
                    longitude = dr["longitude"].ToString().Replace(",", "."),
                    falha = falha,
                    statusComunicacao = estado,
                    semComunicacao = semComunicacao,
                    porta = portaAberta,
                    statusManutencao = dr["emManutencao"].ToString(),
                    estadoNobreak = dr["EstadoNobreak"].ToString(),
                    Camera = dr["Camera"].ToString()
                });
            }

            return lstDna;
        }

        [WebMethod]
        public void OpenOs(string idFalha, string idPonto, string causa, string complemento)
        {
            string idConsorcio = db.ExecuteScalarQuery(string.Format(@"select lote
from DNA d where d.Id='{0}' and idprefeitura={1}", idPonto, HttpContext.Current.Profile["idPrefeitura"]));
            string talao = db.ExecuteScalarQuery("(SELECT MAX(ID)+1 FROM AbrirOrdemServico)");
            db.ExecuteNonQuery(string.Format(@"insert into AbrirOrdemServico  (idDna,idConsorcio,idFalha,complemento,causa,dataHora,processado,nmrTalao,idPrefeitura)
values ('{0}','{1}','{2}','{3}','{4}','{5}',0,'{6}',{7})", idPonto, idConsorcio, idFalha, complemento, causa, DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"), talao, HttpContext.Current.Profile["idPrefeitura"]));
        }

        [WebMethod]
        public List<string> GetAvisosControlador(string dtInicial, string dtFinal)
        {
            List<string> lstProblems = new List<string>();
            DataTable dt = new DataTable();

            if (dtInicial == "" && dtFinal == "")
            {
                dt = db.ExecuteReaderQuery(string.Format(@"select top 100 l.idEqp,l.Falha,l.DataHora from Status s
JOIN LogsControlador l on l.idEqp=serial where IdPrefeitura={0} and FalhaSolucionada='N' order by l.DataHora desc", HttpContext.Current.Profile["idPrefeitura"]));
            }
            else
            {
                dtInicial = dtInicial.Substring(6, 4) + dtInicial.Substring(3, 2) + dtInicial.Substring(0, 2);
                dtFinal = dtFinal.Substring(6, 4) + dtFinal.Substring(3, 2) + dtFinal.Substring(0, 2);
                dt = db.ExecuteReaderQuery(@"select l.idEqp,l.Falha,l.DataHora from Status s
JOIN LogsControlador l on l.idEqp = serial where IdPrefeitura =" + HttpContext.Current.Profile["idPrefeitura"] +
" and CONVERT(bigint,l.dataHora,103)>=CONVERT(bigint,'" + dtInicial + "000000',103) and  CONVERT(bigint,l.dataHora,103)<=CONVERT(bigint,'" + dtFinal + "235959',103) and FalhaSolucionada = 'N' order by l.DataHora desc");
            }
            string DtHr = "";
            foreach (DataRow item in dt.Rows)
            {
                string ano = item["DataHora"].ToString().Substring(0, 4);
                string mes = item["DataHora"].ToString().Substring(4, 2);
                string dia = item["DataHora"].ToString().Substring(6, 2);
                string hr = item["DataHora"].ToString().Substring(8, 2);
                string min = item["DataHora"].ToString().Substring(10, 2);
                string seg = item["DataHora"].ToString().Substring(12, 2);
                DtHr = dia + "/" + mes + "/" + ano + " " + hr + ":" + min + ":" + seg;
                lstProblems.Add(string.Format("{0}@{1}@{2}", item["idEqp"].ToString(), item["Falha"].ToString(), DtHr));
            }

            return lstProblems;
        }

        [WebMethod]
        public List<string> GetProblems()
        {
            List<string> lstProblems = new List<string>();

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"select IdDna,Falha,Atualizado,isnull(PortSnmpTraps,0) PortSnmpTraps,isnull(PortaAberta,0) as PortaAberta,ISNULL(SemComunicacao,0) as SemComunicacao
from Status where IdDna <> '' and IdPrefeitura={0} ", HttpContext.Current.Profile["idPrefeitura"]));

            string porta = "", statusComunicacao = "True";
            foreach (DataRow item in dt.Rows)
            {
                porta = SetStatusPorta(item["PortaAberta"].ToString());

                //string processado = db.ExecuteScalarQuery(string.Format("select processado from AbrirOrdemServico where processado=0 and idDna={0}", item["IdDna"].ToString()));
                string existCameraId = "0";// db.ExecuteScalarQuery(string.Format("select id from CameraConfig where idDna = {0}", item["idDna"].ToString()));

                //if (string.IsNullOrEmpty(item["processado"].ToString()))
                //{
                //statusComunicacao = VerificaComunicacao(item["Atualizado"].ToString());
                //if (statusComunicacao == "False")
                //{
                //    if (item["PortSnmpTraps"].ToString() != "0" && item["PortSnmpTraps"].ToString() != "")
                //    {
                //        InsertLogSemComunicacao(int.Parse(item["IdDna"].ToString()), int.Parse(item["PortSnmpTraps"].ToString()), 1);
                //    }
                //}
                //else
                //{
                //    HabilitarSemComunicacao(item["IdDna"].ToString(), "0");
                //}
                //}

                lstProblems.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}", item["IdDna"].ToString(), item["Falha"].ToString(), item["Atualizado"].ToString(),
                                statusComunicacao, porta, item["SemComunicacao"].ToString(), existCameraId, ""));
            }

            return lstProblems;
        }

        [WebMethod]
        public string GetConjugadoDNA(int idPonto)
        {
            string IdDNAMEstre = "";
            string SerialMestre = db.ExecuteScalarQuery("select SerialMestre from Status where idDNA='" + idPonto + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
            if (!string.IsNullOrEmpty(SerialMestre))
            {
                IdDNAMEstre = db.ExecuteScalarQuery("select IdDNA from Status where Serial='" + SerialMestre + "'");
            }
            return IdDNAMEstre;
        }

        public struct DetailsControladorMestre
        {
            public string Falha { get; set; }
            public string PortaAberta { get; set; }
            public string SemComunicacao { get; set; }
            public string Estado { get; set; }
        }

        [WebMethod]
        public List<DetailsControladorMestre> GetDetailsConjugadoDNA(int idPonto)
        {
            DataTable dt = db.ExecuteReaderQuery(@"select Falha,PortaAberta,ISNULL(SemComunicacao,0) as SemComunicacao, 
isnull((case when (DATEDIFF(minute,convert(datetime,s.atualizado),getdate()) < isnull(tempofalhacomunicacao,15))
then 'True' else 'False' end),'False') estado from DNA d join Status s on s.IdDna=d.id and s.IdPrefeitura=d.idPrefeitura  
join ConfigMap cm on cm.idprefeitura=d.idPrefeitura where d.id='" + idPonto + "' and d.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

            List<DetailsControladorMestre> lst = new List<DetailsControladorMestre>();

            lst.Add(new DetailsControladorMestre
            {
                Falha = dt.Rows[0]["Falha"].ToString(),
                PortaAberta = dt.Rows[0]["PortaAberta"].ToString(),
                SemComunicacao = dt.Rows[0]["SemComunicacao"].ToString(),
                Estado = dt.Rows[0]["Estado"].ToString()
            });

            return lst;
        }

        [WebMethod]
        public List<string> GetConfigCamera(int idPonto)
        {
            List<string> lstCamera = new List<string>();

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"Select hostName,userName,password,Cruzamento,c.SerialComunicacao,c.Servico
from CameraConfig c join dna d on c.iddna=d.id  and c.idPrefeitura=d.idPrefeitura
where c.idDna = '{0}' and c.idPrefeitura={1}", idPonto, HttpContext.Current.Profile["idPrefeitura"]));

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                lstCamera.Add(dr["hostName"].ToString());
                lstCamera.Add(dr["userName"].ToString());
                lstCamera.Add(dr["password"].ToString());
                lstCamera.Add(dr["Cruzamento"].ToString());
                lstCamera.Add(dr["SerialComunicacao"].ToString());
                lstCamera.Add(dr["Servico"].ToString());
            }

            return lstCamera;
        }

        [WebMethod]
        public List<Dna> GetDna()
        {
            DataTable dt = db.ExecuteReaderQuery(@"select d.id,d.latitude,d.longitude,Falha,PortaAberta,ISNULL(hostName,'')Camera,
ISNULL(SemComunicacao,0) as SemComunicacao,n.serial, 
isnull((case when (DATEDIFF(minute,convert(datetime,s.atualizado),getdate()) < isnull(tempofalhacomunicacao,15))
then 'True' else 'False' end),'False') estado,
isnull((case when (DATEDIFF(minute,n.atualizado,getdate()) > isnull(tempofalhacomunicacao,15))
then 'SC' else n.estado end),'') estadoNobreak,
isnull((SELECT TOP(1) [statusAtual] FROM AbrirOrdemServico aos WHERE aos.iddna=s.IdDna and processado=0 and aos.idPrefeitura=d.idPrefeitura order by id desc),'-1') 
emManutencao
 from DNA d join Status s on s.IdDna=d.id and s.IdPrefeitura=d.idPrefeitura left join nobreaks n on n.Iddna = s.IdDna and n.idPrefeitura=s.IdPrefeitura  
join ConfigMap cm on cm.idprefeitura=d.idPrefeitura 
left join CameraConfig cmf on cmf.idDna=d.Id and cmf.idPrefeitura = d.idPrefeitura where  len(d.latitude)>3 and  ISNUMERIC(d.latitude)=1 and HabilitacaoCentral=1 
and d.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

            List<Dna> lstDna = new List<Dna>();

            string falha = "", portaAberta = "", semComunicacao = "", estado = "";
            foreach (DataRow dr in dt.Rows)
            {
                string idDnaMestre = "";//GetConjugadoDNA(int.Parse(dr["id"].ToString()));

                if (!string.IsNullOrEmpty(idDnaMestre))
                {
                    List<DetailsControladorMestre> lst = GetDetailsConjugadoDNA(int.Parse(idDnaMestre));

                    falha = lst[0].Falha;
                    portaAberta = lst[0].PortaAberta;
                    semComunicacao = lst[0].SemComunicacao;
                    estado = lst[0].Estado;
                }
                else
                {
                    falha = dr["Falha"].ToString();
                    portaAberta = dr["PortaAberta"].ToString();
                    semComunicacao = dr["SemComunicacao"].ToString();
                    estado = dr["estado"].ToString();
                }

                lstDna.Add(new Dna
                {
                    idDna = dr["id"].ToString(),
                    latitude = dr["latitude"].ToString().Replace(",", "."),
                    longitude = dr["longitude"].ToString().Replace(",", "."),
                    falha = falha,
                    statusComunicacao = estado,
                    semComunicacao = semComunicacao,
                    porta = portaAberta,
                    statusManutencao = dr["emManutencao"].ToString(),
                    estadoNobreak = dr["EstadoNobreak"].ToString(),
                    Camera = dr["Camera"].ToString(),
                    idControladorMestre = idDnaMestre
                });
            }
            return lstDna;
        }

        [WebMethod]
        public List<Cameras> GetCameras(string idDna)
        {

            string sql = @"select idDna,hostName,userName,password,d.latitude,d.longitude from CameraConfig cmf 
join Dna d on cmf.idDna=d.Id where cmf.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"];
            if (!string.IsNullOrEmpty(idDna))
            {
                sql += " and idDna='" + idDna + "'";
            }
            DataTable dt = db.ExecuteReaderQuery(sql);

            List<Cameras> lst = new List<Cameras>();

            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new Cameras
                {
                    idDna = dr["idDna"].ToString(),
                    hostName = dr["hostName"].ToString(),
                    userName = dr["userName"].ToString(),
                    password = dr["password"].ToString(),
                    latitude = dr["latitude"].ToString().Replace(",", "."),
                    longitude = dr["longitude"].ToString().Replace(",", ".")
                });
            }
            return lst;
        }

        public struct Cameras
        {
            public string idDna { get; set; }
            public string hostName { get; set; }
            public string userName { get; set; }
            public string password { get; set; }
            public string latitude { get; set; }
            public string longitude { get; set; }
        }

        private string VerificaComunicacao(string ultimaAtualizacao)
        {
            string statusComunicacao = "True";

            string tempoComunicacao = db.ExecuteScalarQuery(string.Format("select TempoFalhaComunicacao from ConfigMap where idPrefeitura={0}", HttpContext.Current.Profile["idPrefeitura"]));
            if (string.IsNullOrEmpty(tempoComunicacao))
            {
                tempoComunicacao = "15";
            }
            if (string.IsNullOrEmpty(ultimaAtualizacao))
            {
                statusComunicacao = "False";
            }
            else
            {
                if (DateTime.Now.Subtract(Convert.ToDateTime(ultimaAtualizacao)).TotalMinutes >= int.Parse(tempoComunicacao))
                    statusComunicacao = "False";
                else
                    statusComunicacao = "True";
            }
            return statusComunicacao;
        }

        private void InsertLogSemComunicacao(int idPonto, int porta, int semComunicacao)
        {

            db.ExecuteNonQuery(string.Format("insert into LogSemComunicacao (IdDna,Data,Porta,SemComunicacao,idPrefeitura) values ('{0}','{1}',{2},{3},{4})", idPonto, DateTime.Now.ToString("dd/MM/yyyy"), porta, semComunicacao, HttpContext.Current.Profile["idPrefeitura"]));

        }

        [WebMethod]
        public List<string> SearchFailureControlador(string dataIni, string dataFinal, int idPonto)
        {
            List<string> lstHistoricoFalhas = new List<string>();

            string serial = ReturnSerial(idPonto);

            StringBuilder consultaFalha = new StringBuilder();

            consultaFalha.Append(string.Format("select Falha,Data,PortaAberta from LogFalhas where serial='{0}'", serial));

            if (!string.IsNullOrEmpty(dataIni) && !string.IsNullOrEmpty(dataFinal))
            {
                consultaFalha.Append(string.Format("and CONVERT(Date,Data,103) between CONVERT(Date,'{0}',103) and CONVERT(Date,'{1}',103)", dataIni, dataFinal));
            }

            DataTable dt = db.ExecuteReaderQuery(consultaFalha.ToString());
            string statusPorta = "";

            foreach (DataRow item in dt.Rows)
            {
                statusPorta = SetStatusPorta(item["PortaAberta"].ToString());
                lstHistoricoFalhas.Add(string.Format("{0}@{1}@{2}", item["Falha"].ToString(), item["Data"].ToString(), statusPorta));
            }

            return lstHistoricoFalhas;
        }

        [WebMethod]
        public List<string> HistorFailureControlador(int idPonto)
        {
            List<string> lstHistoricoFalhas = new List<string>();
            string serial = ReturnSerial(idPonto);

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"select Falha,Data,PortaAberta from LogFalhas where serial='{0}'
order by id desc", serial));
            string statusPorta = "";

            foreach (DataRow item in dt.Rows)
            {
                statusPorta = SetStatusPorta(item["PortaAberta"].ToString());
                lstHistoricoFalhas.Add(string.Format("{0}@{1}@{2}", item["Falha"].ToString(), item["Data"].ToString(), statusPorta));
            }

            return lstHistoricoFalhas;
        }

        [WebMethod]
        public List<string> HistorComunicacao(int idPonto, string Data, string retorno)
        {
            List<string> lstHistoricoComunicacao = new List<string>();
            string serial = ReturnSerial(idPonto);

            DataTable dt;
            if (retorno == "Load")
            {
                dt = db.ExecuteReaderQuery(string.Format(@"select top(50) s.iddna,CONVERT(char(20), Atualizado,113) 'UltimaComunicacao',
  CONVERT(char(20), convert(datetime, lsc.data, 103) ,113) TentativaConexao,
    CONVERT(varchar, (DATEDIFF(HOUR, convert(datetime, atualizado,103), GETDATE()) / 24)) + ' Dia(s) ' +
     CONVERT(varchar, CONVERT(varchar(5), DATEADD(minute, DATEDIFF(MINUTE, convert(datetime, atualizado,103), GETDATE()), 0), 114)) TempoSemComunicar
  from status s left
  join LogSemComunicacao lsc on lsc.Serial = s.Serial 
  where DATEDIFF(MINUTE, convert(char(11), atualizado,103), GETDATE()) > 20 and lsc.IdDna is not null
and s.serial = '{0}'
order by DATEDIFF(HOUR, convert(char(11), atualizado,103), GETDATE()) desc", serial));
            }
            else
            {
                dt = db.ExecuteReaderQuery(string.Format(@"select top(50) s.iddna,CONVERT(char(20), Atualizado,113) 'UltimaComunicacao',
  CONVERT(char(20), convert(datetime, lsc.data, 103) ,113) TentativaConexao,
    CONVERT(varchar, (DATEDIFF(HOUR, convert(datetime, atualizado,103), GETDATE()) / 24)) + ' Dia(s) ' +
     CONVERT(varchar, CONVERT(varchar(5), DATEADD(minute, DATEDIFF(MINUTE, convert(datetime, atualizado,103), GETDATE()), 0), 114)) TempoSemComunicar
  from status s left
  join LogSemComunicacao lsc on lsc.Serial = s.Serial 
  where DATEDIFF(MINUTE, convert(char(11), atualizado,103), GETDATE()) > 20 and lsc.IdDna is not null
and s.serial = '{0}'  and convert(char(11), lsc.data, 103) = '{1}'
order by DATEDIFF(HOUR, convert(char(11), atualizado,103), GETDATE()) desc", serial, Data));
            }


            foreach (DataRow item in dt.Rows)
            {
                lstHistoricoComunicacao.Add(string.Format("{0}@{1}@{2}", item["UltimaComunicacao"].ToString(), item["TentativaConexao"].ToString(), item["TempoSemComunicar"].ToString()));
            }

            return lstHistoricoComunicacao;
        }

        [WebMethod]
        public string HistorComunicacao_QtdFalhas(int idPonto, string Data)
        {
            string serial = ReturnSerial(idPonto);
            string QtdFalhas = db.ExecuteScalarQuery(@"select COUNT(0) from LogSemComunicacao where  IdDna is not null and serial = '" + serial +
"'  and convert(char(11), data, 103) = '" + Data + "'and SemComunicacao=1");

            return QtdFalhas;
        }

        [WebMethod]
        public string CamerasInst_Qtd()
        {
            string QtdCameras = db.ExecuteScalarQuery(@"select count(0) Qtd from CameraConfig where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

            return QtdCameras;
        }

        [WebMethod]
        public List<HistoricoReset> GetLastResets(string idPonto)
        {
            List<HistoricoReset> lstResets = new List<HistoricoReset>();
            DataTable dt = db.ExecuteReaderQuery(@"select top(50) DataHora,
case when Resposta = 'Resposta: 1' and MIB = '.1.3.6.1.4.1.13267.3.2.5.1.1.7' then 'Resetando' 
when Resposta = 'Resposta: 0' and MIB = '.1.3.6.1.4.1.13267.3.2.5.1.1.7' then 'Desligado'
when Resposta = 'Resposta: 1' and MIB = '.1.3.6.1.4.1.13267.3.2.4.2.1.6' then 'Comando recebido' 
when Resposta = 'Resposta: 0' and MIB = '.1.3.6.1.4.1.13267.3.2.4.2.1.6' then 'Sem resposta' else Resposta end resposta ,Usuario,
case(MIB) when '.1.3.6.1.4.1.13267.3.2.5.1.1.7' then 'Estado do reset' 
when '.1.3.6.1.4.1.13267.3.2.4.2.1.6' then 'Solicitação' else MIB end MIB from logReseteControlador  where idDna='" + idPonto + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " order by id desc");
            foreach (DataRow item in dt.Rows)
            {
                lstResets.Add(new HistoricoReset
                {
                    dtResetCtrl = item["DataHora"].ToString(),
                    mib = item["mib"].ToString(),
                    RetornoReset = item["Resposta"].ToString(),
                    usuario = item["Usuario"].ToString()
                });
            }
            return lstResets;
        }

        [WebMethod]
        public void ResetaControlador(string idPonto, string userPermReset)
        {
            string statusReset = db.ExecuteScalarQuery(string.Format("select Reset from Status where IdDna='{0}' and idPrefeitura={1}", idPonto, HttpContext.Current.Profile["idPrefeitura"]));
            if (statusReset != "True")
            {
                db.ExecuteNonQuery(string.Format("update Status set Reset=1,UserReset='{1}' where IdDna='{0}' and idPrefeitura={2}",
                    idPonto, string.IsNullOrEmpty(userPermReset) ? User.Identity.Name : userPermReset, HttpContext.Current.Profile["idPrefeitura"]));
            }
        }

        [WebMethod]
        public string ValidaUserReset(string user, string password)
        {
            string valid = "";

            if (Membership.ValidateUser(user, password))
            {
                if (Roles.FindUsersInRole("ResetaControlador", user).Length > 0)
                {
                    valid = "True";
                }
            }

            return valid;
        }

        [WebMethod]
        public void HabilitarSemComunicacao(string idPonto, string statusSemComunicacao)
        {
            string status = db.ExecuteScalarQuery(string.Format("select SemComunicacao from Status where IdDna='{0}' and idPrefeitura={1}"
                , idPonto, HttpContext.Current.Profile["idPrefeitura"]));
            if (status != statusSemComunicacao)
            {
                db.ExecuteNonQuery(string.Format("update Status set SemComunicacao={1} where IdDna='{0}' and idPrefeitura={2}"
                    , idPonto, statusSemComunicacao, HttpContext.Current.Profile["idPrefeitura"]));
            }
        }

        private string SetStatusPorta(string porta)
        {
            string statusPorta = "";

            switch (porta)
            {
                case "1":
                    statusPorta = "Aberta";
                    break;

                case "0":
                    statusPorta = "Fechada";
                    break;
            }

            return statusPorta;
        }

        [WebMethod]
        public List<NobreakEventos> GetEventsNobreak(string idPonto, string tipo)
        {
            List<NobreakEventos> lstEventos = new List<NobreakEventos>();

            StringBuilder query = new StringBuilder();

            query.Append(string.Format(@"select MIB,Valor,Descricao,Data
from LogStatusNobreak
where Tipo='{0}'
and idDna='{1}'", tipo, idPonto));

            if (tipo == "ping")
            {
                query.Replace("select", "select top(10) ");
                query.Append(" and MIB='upsStatusOperacional' order by Data desc");
            }
            else
            {
                query.Replace("select", "select top(100) ");
                query.Append(" order by id desc");
            }

            DataTable dt = db.ExecuteReaderQuery(query.ToString());

            foreach (DataRow item in dt.Rows)
            {
                lstEventos.Add(new NobreakEventos
                {
                    MIB = item["MIB"].ToString(),
                    data = item["Data"].ToString(),
                    descricao = item["Descricao"].ToString(),
                    valor = item["Valor"].ToString()
                });
            }

            return lstEventos;
        }

        [WebMethod]
        public List<Nobreak> GetAllNobreak(string idPonto)
        {
            List<Nobreak> lstNobreaks = new List<Nobreak>();

            StringBuilder query = new StringBuilder();

            query.Append(string.Format(@"select  n.serial,n.Estado,n.Atualizado,d.Id,
isnull((case when (DATEDIFF(minute,n.atualizado,getdate()) > isnull(tempofalhacomunicacao,15))
then 'SC' else n.estado end),'SC') estadoNobreak 
from nobreaks n
join Status s
on n.Iddna = s.IdDna
join semaforo.dbo.DNA d
join ConfigMap cm on cm.idprefeitura=d.idPrefeitura
on s.IdDna = d.Id
where d.HabilitacaoCentral=1
and d.idPrefeitura={0}", HttpContext.Current.Profile["idPrefeitura"]));

            if (!string.IsNullOrEmpty(idPonto))
            {
                query.Append(string.Format(" and d.Id='{0}'", idPonto));
            }

            DataTable dt = db.ExecuteReaderQuery(query.ToString());

            string status = "", falhaComunicao = "";

            foreach (DataRow item in dt.Rows)
            {
                //if (string.IsNullOrEmpty(item["Atualizado"].ToString()) || string.IsNullOrEmpty(item["Estado"].ToString()))
                //{
                //    status = "SC";
                //}
                //else
                //{
                //    falhaComunicao = VerificaComunicacao(item["Atualizado"].ToString());
                //    if (falhaComunicao == "False")
                //    {
                //        status = "SC";
                //    }
                //    else
                //    {
                //        status = item["Estado"].ToString();
                //    }
                //}
                status = item["estadonobreak"].ToString();
                lstNobreaks.Add(new Nobreak
                {
                    idDna = item["Id"].ToString(),
                    estado = status,
                    dtAtualizacao = item["Atualizado"].ToString(),
                    serial = item["serial"].ToString()
                });

            }

            return lstNobreaks;
        }



        #region SMEEE

        [WebMethod]
        public List<string> GetTaloes(int idPonto)
        {
            List<string> lstaloes = new List<string>();

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"SELECT isnull(nmrTalao,'ID'+convert(varchar,id) ) Talao
  FROM [AbrirOrdemServico] where processado = 0 AND idDna = '{0}' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " order by id", idPonto));

            foreach (DataRow item in dt.Rows)
            {
                lstaloes.Add(item[0].ToString());
            }

            return lstaloes;
        }
        [WebMethod]
        public string GetDetalheTalao(string Talao)
        {
            StringBuilder sb = new StringBuilder();

            string sql = "";

            if (Talao.ToString().Contains("ID"))
                sql = @"SELECT Falha=(convert(varchar,[idFalha])+' - '+(SELECT Nome FROM [semaforo].[dbo].[Falha] f WHERE f.ID=[idFalha])),
[causa],[complemento],[nmrTalao],Prioridade =(Convert(varchar,[prioridadeFalha])+'/'+[prioridadeLocal]), 
Estado=(CASE WHEN [statusAtual]=0 THEN 'Não Atribuido' ELSE 'Atribuido' END), [dataHora],[Obs]
FROM [AbrirOrdemServico] where [id]=" + Talao.ToString().Replace("ID", "") + " and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"];
            else
                sql = string.Format(@"SELECT Falha=(convert(varchar,[idFalha])+' - '+(SELECT Nome FROM [semaforo].[dbo].[Falha] f WHERE f.ID=[idFalha])),
[causa],[complemento],[nmrTalao],Prioridade =(Convert(varchar,[prioridadeFalha])+'/'+[prioridadeLocal]), 
Estado=(CASE WHEN [statusAtual]=0 THEN 'Não Atribuido' ELSE 'Atribuido' END), [dataHora],[Obs]
FROM [AbrirOrdemServico] where [nmrTalao]='{0}' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"], Talao);

            DataTable dt = db.ExecuteReaderQuery(sql);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                sb.Append(dr[0].ToString());//Falha
                sb.Append("@");               //
                sb.Append(dr[1].ToString());//causa
                sb.Append("@");               //
                sb.Append(dr[2].ToString());//complemento
                sb.Append("@");               //
                sb.Append(dr[3].ToString());//nmrTalao
                sb.Append("@");               //
                sb.Append(dr[4].ToString());//Prioridade
                sb.Append("@");               //
                sb.Append(dr[5].ToString());//Estado
                sb.Append("@");               //
                sb.Append(dr[6].ToString());//dataHora
                sb.Append("@");               //
                sb.Append(dr[7].ToString());//Obs 

                DataTable dtEquipes = db.ExecuteReaderQuery(string.Format(@"SELECT [Empresa],[Equipe],[DataHora] FROM [dbo].[AtribuicoesTalao] 
where [Talao]='{0}' order by id", dr[3].ToString()));

                if (dtEquipes.Rows.Count > 0)
                {

                    foreach (DataRow item in dtEquipes.Rows)
                    {
                        sb.Append("|");
                        sb.Append(item[0].ToString());//Empresa
                        sb.Append("@");               //
                        sb.Append(item[1].ToString());//Equipe
                        sb.Append("@");               //
                        sb.Append(item[2].ToString());//DataHora 
                    }
                }
            }

            return sb.ToString();
        }
        #endregion

        [WebMethod]
        public List<string> GetAvisoFalha(int idPonto)
        {
            List<string> lstLog = new List<string>();


            DataTable dt = db.ExecuteReaderQuery(string.Format(@"SELECT Para=(SELECT [nomeOperador] FROM [dbo].[avisoFalhasOperador] o WHERE o.[Id]=[idOperador])
,[CanalAviso],[Endereco],[Falha],[DtHrAviso]  FROM [LogAvisoFalhas]WHERE [idLocal]={0}  and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " order by id desc", idPonto));

            foreach (DataRow item in dt.Rows)
            {
                lstLog.Add(item[0].ToString() + "|" + item[1].ToString() + "|" + item[2].ToString() + "|" + item[3].ToString() + "|" + item[4].ToString());
            }

            return lstLog;
        }

        public string ReturnSerial(int idPonto)
        {
            DataTable dtConsulta = db.ExecuteReaderQuery(@"select serial from status where iddna='" + idPonto + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
            DataRow dr = dtConsulta.Rows[0];
            string serial = "";
            if (dr["serial"].ToString().Contains("-"))
            {
                int Length = dr["serial"].ToString().Length - 1;
                int p = dr["serial"].ToString().IndexOf("-");
                serial = dr["serial"].ToString().Substring(p, Length);
                serial = serial.Replace("-", "");
            }
            else
            {
                serial = dr["serial"].ToString();
            }

            return serial;
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
        public List<ListaGrupos> GetListaGrupos(string idEqp)
        {
            Banco db = new Banco("");
            string serial = db.ExecuteScalarQuery(" select serial from [Status] where idDna='" + idEqp + "'");
            List<ListaGrupos> lst = new List<ListaGrupos>();
            DataTable dt = db.ExecuteReaderQuery(@"select 'Anel: ' + convert(varchar,anel,102) +' - '+convert(varchar,grupoLogico,102)grupoLogico,TipoGrupo,
endereco=(select endereco from LocaisGruposLogicos l where l.id=gl.idlocal)
 from GruposLogicos gl where ideqp='" + serial + "' and idPrefeitura="+ HttpContext.Current.Profile["idPrefeitura"] + " order by anel,convert(int,grupologico,103)");
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListaGrupos
                {
                    Grupo = dr["grupoLogico"].ToString(),
                    Tipo = dr["TipoGrupo"].ToString(),
                    Endereco = dr["endereco"].ToString()
                });
            }
            return lst;
        }

        [WebMethod]
        public List<ListaLogs> GetLogsOperacaoCentral(string idEqp)
        {
            Banco db = new Banco("");
            List<ListaLogs> lst = new List<ListaLogs>();

            string sql = "select DISTINCT TOP 500 ''Funcao,''Valor,Convert(varchar, Falha)Falha,Alarme,''Usuario,[Data] DataHora from LogFalhas where Serial='" + idEqp + "' order by dataHora desc";
            DataTable dt = db.ExecuteReaderQuery(sql);
            //            DataTable dt = db.ExecuteReaderQuery(@"Select top (50) Tipo,Funcao,Usuario,Convert(char,DataHora,103) DataHora from logs where idEqp='" + idEqp +
            //                @"' UNION Select top (50) Tipo,Funcao, case Usuario when 'Central Tempo Fixo' then 'Controlador' end Usuario, 
            //Convert(char,DataHora,103) DataHora from logsControlador where idEqp='" + idEqp + "'  order by Convert(char,DataHora,103) desc");
            string valor, falha, usuario = "";
            foreach (DataRow dr in dt.Rows)
            {
                //string ano = dr["DataHora"].ToString().Substring(6, 4);
                //string mes = dr["DataHora"].ToString().Substring(3, 2);
                //string dia = dr["DataHora"].ToString().Substring(0, 2);
                //string hr = dr["DataHora"].ToString().Substring(11, 2);
                //string min = dr["DataHora"].ToString().Substring(14, 2);
                //string seg = dr["DataHora"].ToString().Substring(17, 2);
                usuario = dr["Usuario"].ToString();
                if (usuario == "null")
                    usuario = "";
                valor = dr["Valor"].ToString();
                if (valor == "null")
                    valor = "";
                falha = dr["Falha"].ToString();
                if (falha == "null")
                    falha = "";

                lst.Add(new ListaLogs
                {
                    funcao = dr["Funcao"].ToString(),
                    Alarme = dr["Alarme"].ToString(),
                    usuario = dr["Usuario"].ToString(),
                    Falha = falha,
                    dataHora = dr["DataHora"].ToString()
                });
            }

            return lst;
        }

        [WebMethod]
        public List<DadosProgramacao> GetProgramacaoEqp(string idEqp)
        {
            Banco db = new Banco("");
            List<DadosProgramacao> lst = new List<DadosProgramacao>();
            string tarefas = "";
            string ultComunicacao = db.ExecuteScalarQuery("select atualizado from [Status] where serial='" + idEqp + "'");

            DataTable dt = db.ExecuteReaderQuery(@"select nome,DtHrAtualizacaoProgramacao,Byte1,Byte2
 from Programacao p left JOIN TarefasImposicao ti on ti.idControlador = p.idEqp where idEqp='" + idEqp + "'");
            foreach (DataRow dr in dt.Rows)
            {
                string valor = dr["Byte1"].ToString();
                int[] byte1 = DecimalToBinary(int.Parse(valor));
                valor = dr["Byte2"].ToString();
                int[] byte2 = DecimalToBinary(int.Parse(valor));
                if (byte1[0] == 1)
                    tarefas = "Reset; ";
                if (byte1[1] == 1)
                    tarefas += "Imposição de Plano; ";
                if (byte1[2] == 1)
                    tarefas += "Cancelamento Plano Imposto; ";
                if (byte1[3] == 1)
                    tarefas += "Enviar Programação; ";
                if (byte1[4] == 1)
                    tarefas += "Enviar Agenda; ";
                if (byte1[5] == 1)
                    tarefas += "Enviar Horario de Verão";
                if (byte1[6] == 1)
                    tarefas += "Enviar Imagem; ";
                if (byte1[7] == 1)
                    tarefas += "Centralizar;";

                if (byte2[0] == 1)
                    tarefas += "Reset Anel 1; ";
                if (byte2[1] == 1)
                    tarefas += "Reset Anel 2; ";
                if (byte2[2] == 1)
                    tarefas += "Reset Anel 3; ";
                if (byte2[3] == 1)
                    tarefas += "Reset Anel 4; ";

                if (tarefas == "")
                    tarefas = "Nenhuma.";
                lst.Add(new DadosProgramacao
                {
                    Programacao = dr["Nome"].ToString(),
                    DtHrAtualizacaoProg = dr["DtHrAtualizacaoProgramacao"].ToString(),
                    Tarefas = tarefas,
                    ultComunicacao = ultComunicacao
                });
            }
            return lst;
        }

        public struct ListaGrupos
        {
            public string Grupo { get; set; }
            public string Endereco { get; set; }
            public string Tipo { get; set; }
        }

        public struct ListaLogs
        {
            public string Falha { get; set; }
            public string Alarme { get; set; }
            public string tipo { get; set; }
            public string funcao { get; set; }
            public string usuario { get; set; }
            public string dataHora { get; set; }
        }

        public struct DadosProgramacao
        {
            public string Programacao { get; set; }
            public string DtHrAtualizacaoProg { get; set; }
            public string Tarefas { get; set; }
            public string ultComunicacao { get; set; }
        }
        public struct NobreakEventos
        {
            public string MIB { get; set; }
            public string valor { get; set; }
            public string descricao { get; set; }
            public string data { get; set; }
        }
        public struct Dna
        {
            public Nobreak nobItem;
            public string idDna { get; set; }
            public string latitude { get; set; }
            public string longitude { get; set; }
            public string falha { get; set; }
            public string statusComunicacao { get; set; }
            public string semComunicacao { get; set; }
            public string porta { get; set; }
            public string statusManutencao { get; set; }
            public string estadoNobreak { get; set; }
            public string cruzamento { get; set; }
            public string consorcio { get; set; }
            public string empresa { get; set; }
            public string tipoCtrl { get; set; }
            public string modeloCtrl { get; set; }
            public string nrFasesSuportCtrl { get; set; }
            public string atualizadoCtrl { get; set; }
            public string dtManutencaoCtrl { get; set; }
            public string causaManutencaoCtrl { get; set; }
            public string dtResetCtrl { get; set; }
            public string RetornoReset { get; set; }
            public string hostNameCam { get; set; }
            public string userNameCam { get; set; }
            public string passwordCam { get; set; }
            public string serialCtrl { get; set; }
            public string ipCtrl { get; set; }
            public string ddnsCtrl { get; set; }
            public string ipPorTrapCtrl { get; set; }
            public string portaSnmpCtrl { get; set; }
            public string portaSnmpResetCtrl { get; set; }
            public string portaSnmpTrapCtrl { get; set; }
            public string Camera { get; set; }
            public string idControladorMestre { get; set; }
            public string horarioVeraoEqp { get; set; }
            public string tensao { get; set; }
            public string temperatura { get; set; }
            public string estadofunc { get; set; }
            public string serialMestre { get; set; }
            public string linkmap { get; set; }
        }
        public struct HistoricoReset
        {
            public string mib { get; set; }
            public string dtResetCtrl { get; set; }
            public string RetornoReset { get; set; }
            public string usuario { get; set; }
        }
        public struct Nobreak
        {
            public string tempoNaBateria { get; set; }
            public string idDna { get; set; }
            public string serial { get; set; }
            public string estado { get; set; }
            public string modelo { get; set; }
            public string tensao { get; set; }
            public string potencia { get; set; }
            public string dtAtualizacao { get; set; }
            public string ip { get; set; }
            public string tensaoBateria { get; set; }
            public string tensaoIn { get; set; }
            public string tensaoMinIn { get; set; }
            public string tensaoMaxIn { get; set; }
            public string tensaoOut { get; set; }
            public string temperatura { get; set; }
            public string potenciaCarga { get; set; }
            public string nivelBateria { get; set; }
            public string fabricante { get; set; }
            public string ddns { get; set; }
            public string ipPorTrap { get; set; }
            public string portaSnmp { get; set; }
            public string portaSnmpTrap { get; set; }
        }

    }
}
