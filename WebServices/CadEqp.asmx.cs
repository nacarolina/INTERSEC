using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace GwCentral.Register.Controller
{
    /// <summary>
    /// Summary description for CadEqp
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    public class CadEqp : System.Web.Services.WebService
    {
        Banco db = new Banco("");
        //Banco dbCet = new Banco(System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionStringCET"].ConnectionString);

        [WebMethod]
        public List<Equipamento> GetControls(string disponivel)
        {
            List<Equipamento> lstControladores = new List<Equipamento>();

            string sql = @"select Serial,IdDna,IP,Atualizado,
case ISNULL(idDna,'0') when '0' then 'Off-line' 
else 'Online' end as disponivel, case when isnull(resetporrequisicao,'0')=0 then 'Desativado' else 'Ativado' end resetPorRequisicao
from Status
where ISNULL(IdPrefeitura,'') in (" + HttpContext.Current.Profile["idPrefeitura"] + ",'')";
            if (disponivel == "Off-line")
            {
                sql += " and (IdDna is null or IdDna='')";
            }
            else if (disponivel == "Online")
            {
                sql += " and (IdDna is not null or IdDna <> '')";
            }
            sql += "order by serial";
            DataTable dt = db.ExecuteReaderQuery(sql);

            foreach (DataRow item in dt.Rows)
            {
                lstControladores.Add(new Equipamento
                {
                    serial = item["Serial"].ToString(),
                    idDna = item["IdDna"].ToString(),
                    resetPorRequisicao = item["resetPorRequisicao"].ToString(),
                    disponivel = item["disponivel"].ToString(),
                    ip = item["IP"].ToString(),
                    dtAtualizacao = item["Atualizado"].ToString()
                });
            }

            return lstControladores;
        }

        public struct Camera
        {
            public string idCamera { get; set; }
            public string hostName { get; set; }
            public string user { get; set; }
            public string idPonto { get; set; }
            public string senha { get; set; }
            public string servico { get; set; }
            public string serial { get; set; }
        }

        [WebMethod]
        public List<Camera> VisualCamera(string idDna)
        {
            List<Camera> lstCamera = new List<Camera>();

            string sql = @"select id,hostName,userName,idDna,SerialComunicacao,Servico from CameraConfig 
where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and iddna='" + idDna + "' order by hostName";
            DataTable dt = db.ExecuteReaderQuery(sql);

            foreach (DataRow item in dt.Rows)
            {
                lstCamera.Add(new Camera
                {
                    idCamera = item["id"].ToString(),
                    hostName = item["hostName"].ToString(),
                    user = item["userName"].ToString(),
                    idPonto = item["idDna"].ToString(),
                    serial = item["SerialComunicacao"].ToString(),
                    servico = item["Servico"].ToString()
                });
            }

            return lstCamera;
        }

        [WebMethod]
        public List<Camera> SelectCamera(string idCamera)
        {
            List<Camera> lstCamera = new List<Camera>();

            string sql = @"select id,hostName,userName,idDna,password,SerialComunicacao,Servico from CameraConfig 
where id=" + idCamera;
            DataTable dt = db.ExecuteReaderQuery(sql);

            foreach (DataRow item in dt.Rows)
            {
                lstCamera.Add(new Camera
                {
                    idCamera = item["id"].ToString(),
                    hostName = item["hostName"].ToString(),
                    user = item["userName"].ToString(),
                    idPonto = item["idDna"].ToString(),
                    senha = item["password"].ToString(),
                    serial = item["SerialComunicacao"].ToString(),
                    servico = item["Servico"].ToString()
                });
            }

            return lstCamera;
        }

        [WebMethod]
        public string DesabilitarEquipamento(string serial, string chk, string idDna)
        {
            string Status = "OK";

            string verifica = db.ExecuteScalarQuery("select HabilitacaoCentral from Dna where id ='" + idDna + "'");
            if (!string.IsNullOrEmpty(verifica))
            {
                return Status = "H";
            }

            bool Alterou = db.ExecuteNonQuery("Update [Status] set Desabilitado = '" + chk + "' WHERE serial='" + serial + "'");
            if (Alterou == false)
            {
                Status = "N";
            }

            return Status;
        }

        [WebMethod]
        public string DesabilitarNobreak(string serial, string chk)
        {
            string Status = "OK";

            bool Alterou = db.ExecuteNonQuery("Update nobreaks set Desabilitado = '" + chk + "' WHERE serial='" + serial + "'");
            if (Alterou == false)
            {
                Status = "N";
            }

            return Status;
        }

        [WebMethod]
        public List<string> GetDadosConjugado(string idDNA)
        {
            List<string> lst = new List<string>();
            string SerialMestre = db.ExecuteScalarQuery("select SerialMestre from Status s where IdDna ='" + idDNA + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
            if (!string.IsNullOrEmpty(SerialMestre))
            {
                lst.Add(SerialMestre);
                DataTable dt = db.ExecuteReaderQuery(@"select d.Cruzamento,d.Id from Status s
join dna d on d.id = s.iddna where s.Serial = '" + SerialMestre + "'");
                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    lst.Add(string.Format("{0}@{1}", dr["Cruzamento"].ToString(), dr["Id"].ToString()));
                }
            }
            else
            {
                lst.Add("NULL");
            }
            return lst;
        }

        [WebMethod]
        public List<string> GetConjugadosMestre(string idDNA)
        {
            List<string> lst = new List<string>();
            string Serial = db.ExecuteScalarQuery("select Serial from Status s where IdDna ='" + idDNA + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
            if (!string.IsNullOrEmpty(Serial))
            {
                DataTable dt = db.ExecuteReaderQuery(@"select d.Cruzamento,d.Id from Status s
join dna d on d.id = s.iddna and d.idprefeitura=s.idprefeitura where s.SerialMestre = '" + Serial + "' and s.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
                foreach (DataRow dr in dt.Rows)
                {
                    lst.Add(string.Format("{0}@{1}", dr["Cruzamento"].ToString(), dr["Id"].ToString()));
                }
            }
            else
            {
                lst.Add("NULL");
            }
            return lst;
        }


        [WebMethod]
        public string ExcluirControladores()
        {
            db.ExecuteNonQuery("delete from status where iddna is null");
            return "SUCESSO";

        }

        [WebMethod]
        public string DeleteEqp(string tipo, string serial, string idDna)
        {
            string status = "ok";

            switch (tipo)
            {
                case "controller":

                    string verifica = db.ExecuteScalarQuery("select HabilitacaoCentral from Dna where serial ='" + serial + "'");
                    if (verifica == "True")
                    {
                        return status = "H";
                    }
                    db.ExecuteNonQuery("delete from [DNA] where idDNA='" + serial + "'");
                    db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User.Identity.Name + "','Cadastro Equipamento'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                        "','Excluiu o idDNA: " + serial + "','DNA')");

                    db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User.Identity.Name + "','Cadastro Equipamento'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                        "','Excluiu o controlador serial: " + serial + ", idDNA: " + idDna + "','Status')");

                    db.ExecuteNonQuery("delete from [Status] where Serial='" + serial + "'");

                    db.ExecuteNonQuery("delete from CameraConfig where idDna='" + idDna + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
                    break;
                case "nobreak":
                    db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User.Identity.Name + "','Cadastro Equipamento'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                        "','Excluiu o nobreak serial: " + serial + ", idDNA: " + idDna + "','nobreaks')");
                    db.ExecuteNonQuery("delete from nobreaks where serial='" + serial + "'");
                    break;
            }

            return status;
        }

        [WebMethod]
        public string SaveEqp(string SerialMestre, string tipoEqp, string tipoCad, string idDna, string serial, string ddns, string ip, string portaSnmpMib, string portaSnmpTrap, string portaSnmpReset, string ipPorTrap, bool habilitaCentral, string empresa, string semServico, string resetPorRequisicao, string cruzamento, string lat, string lon, string modelo)
        {
            idDna = serial;
            portaSnmpReset = "1620";
            if (semServico == "true")
            {
                semServico = "1";
            }
            else
            {
                semServico = "0";
            }
            string status = "ok", verificar = "";
            if (tipoCad == "insert")
            {
                if (string.IsNullOrEmpty(db.ExecuteScalarQuery(
                    @"SELECT Id FROM dna WHERE id='" + idDna + "'")))
                {
                    db.ExecuteReaderQuery(string.Format(
                        @"INSERT INTO DNA (Id,Consorcio,Cruzamento,latitude,longitude,Lote,
                        DataCadastro,Usuario,idPrefeitura)
                        VALUES ('{0}','','{1}','{2}','{3}','','{4}','{5}','{6}')",
                        idDna, cruzamento, lat, lon, DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"),
                        User.Identity.Name, HttpContext.Current.Profile["idPrefeitura"]
                        ));

                    db.ExecuteNonQuery(string.Format(
                        @"INSERT INTO [HistoricoDNA] ([DNA],[ConsorcioIdAtual],[ConsorcioAtual],[DataHora])
                        VALUES ('{0}',NULL,'','{3}')", idDna, DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss")
                        ));
                }
                //return status = "Este Dna não existe";
            }

            switch (tipoEqp)
            {
                case "controller":
                    if (string.IsNullOrEmpty(empresa) || empresa.Trim() == "Selecione...")
                    {
                        db.ExecuteNonQuery(string.Format(
                            @"UPDATE DNA SET HabilitacaoCentral='{0}',Cruzamento='" + cruzamento + "' " +
                            " where id='{1}' and idPrefeitura={2}", habilitaCentral, idDna,
                            HttpContext.Current.Profile["idPrefeitura"]
                            ));

                        db.ExecuteNonQuery(
                            @"INSERT INTO LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) 
                            VALUES ('" + User.Identity.Name + "','Cadastro Equipamento', " +
                            " " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                            " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "', " +
                            " 'Alterou o HabilitacaoCentral: " + habilitaCentral + ", " +
                            " cruzamento: " + cruzamento + " do idDNA: " + idDna + "','DNA')"
                            );
                    }
                    else
                    {
                        db.ExecuteNonQuery(string.Format(
                            @"UPDATE DNA SET HabilitacaoCentral='{0}',empresa='{3}' 
                            WHERE id='{1}' 
                            AND idPrefeitura={2}", habilitaCentral, idDna,
                            HttpContext.Current.Profile["idPrefeitura"], empresa
                            ));

                        db.ExecuteNonQuery(
                            @"INSERT INTO LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) 
                            VALUES ('" + User.Identity.Name + "','Cadastro Equipamento', " +
                            " " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                            " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "', " +
                            " 'Alterou o HabilitacaoCentral: " + habilitaCentral + ", " +
                            " empresa: " + empresa + " do idDNA: " + idDna + "','DNA')"
                            );
                    }
                    if (tipoCad == "insert")
                    {

                        #region Verifica cad

                        verificar = db.ExecuteScalarQuery(string.Format(
                            @"SELECT idDna FROM [Status] WHERE IdDna ='{0}' 
                            AND IdPrefeitura={1}", idDna, HttpContext.Current.Profile["idPrefeitura"]
                            ));

                        if (!string.IsNullOrEmpty(verificar))
                        {
                            return status = "Este Id do Dna ja foi vinculado";
                        }
                        verificar = db.ExecuteScalarQuery(string.Format(
                            @"SELECT prefeitura FROM [Status] s 
                            JOIN Prefeitura p on p.id = s.idPrefeitura 
                            WHERE Serial = '{0}' 
                            AND idPrefeitura is not null", serial
                            ));

                        if (!string.IsNullOrEmpty(verificar))
                        {
                            return status = "Este Serial ja existe na prefeitura: " + verificar;
                        }
                        #endregion
                        string idStatus = db.ExecuteScalarQuery(
                            @"SELECT IP FROM [status] WHERE serial='" + serial + "' " +
                            " AND idPrefeitura is null"
                            );
                        if (idStatus != "")
                        {
                            db.ExecuteNonQuery(
                                @"UPDATE [Status] SET  idDna = '" + idDna + "', " +
                                " idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                                " semcomunicacao =" + semServico + ", " +
                                " resetPorRequisicao= '" + resetPorRequisicao + "' " +
                                " WHERE serial = '" + serial + "' "
                                );
                        }
                        else
                        {
                            db.ExecuteNonQuery(string.Format(
                                @"INSERT INTO [Status] (Serial,Ddns,IP,PortSnmp,PortSnmpTraps,
                                PortSnmpReset,bRecebeIpTrap,IdDna,IdPrefeitura,semcomunicacao,SerialMestre)
                                VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}',{8},{9},'{10}')",
                                serial, ddns, ip, portaSnmpMib, portaSnmpTrap, portaSnmpReset, ipPorTrap,
                                idDna, HttpContext.Current.Profile["idPrefeitura"], semServico,
                                SerialMestre
                                ));
                        }

                        string idDepartamento = db.ExecuteScalarQuery(
                            @"SELECT id FROM Departamento 
                           WHERE idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " " +
                            " AND nome='cruzamentos'"
                            );

                        db.ExecuteNonQuery(
                            @"INSERT INTO Subdivisao_Departamento(Subdivisao,Endereco,cruzamento,idDepartamento,idPrefeitura)
                            VALUES ('" + serial + "','" + cruzamento + "','true','" + idDepartamento + "',"+ HttpContext.Current.Profile["idPrefeitura"] + ")"
                            );

                        db.ExecuteNonQuery(
                            @"INSERT INTO LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela)
                            VALUES ('" + User.Identity.Name + "','Cadastro Equipamento', " +
                            " " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                            " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "', " +
                            " 'Cadastrou o controlador serial: " + serial + ", IP: " + ip + ", " +
                            " semComunicacao: " + semServico + ", bRecebeIpTrap: " + ipPorTrap + ", " +
                            " serialMestre: " + SerialMestre + ", idDNA: " + idDna + "','Status')"
                            );
                    }
                    else
                    {
                        db.ExecuteNonQuery(string.Format(
                            @"UPDATE [Status] SET Ddns='{0}',IP='{1}',PortSnmp = '{2}',
                            PortSnmpTraps='{3}',PortSnmpReset='{4}',bRecebeIpTrap='{5}',
                            idDna='{7}',idPrefeitura={8},semcomunicacao={9},SerialMestre='{10}',
                            resetPorRequisicao='{11}',HabilitacaoCentral='true'
                            WHERE serial = '{6}'", ddns, ip, portaSnmpMib, portaSnmpTrap,
                            portaSnmpReset, ipPorTrap, serial, idDna,
                            HttpContext.Current.Profile["idPrefeitura"], semServico, SerialMestre,
                            resetPorRequisicao
                            ));

                        db.ExecuteNonQuery("UPDATE Subdivisao_Departamento set Endereco='" + cruzamento + "' where Subdivisao ='" + serial + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);


                        db.ExecuteNonQuery(
                            @"INSERT INTO LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) 
                            VALUES ('" + User.Identity.Name + "','Cadastro Equipamento', " +
                            " " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                            " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "', " +
                            " 'Alterou o controlador serial: " + serial + ", IP: " + ip + ", " +
                            " semComunicacao: " + semServico + ", HabilitacaoCentral: true, " +
                            " bRecebeIpTrap: " + ipPorTrap + ", serialMestre: " + SerialMestre + ", " +
                            " idDNA: " + idDna + "','Status')"
                            );
                    }

                    break;
            }

            return status;
        }

        [WebMethod]
        public List<Equipamento> GetEqpOff(string serial)
        {
            List<Equipamento> lstEqp = new List<Equipamento>();

            DataTable dt = db.ExecuteReaderQuery(string.Format(@"select IP,Ddns,PortSnmp,PortSnmpTraps,PortSnmpReset,bRecebeIpTrap
from [Status] where Serial='{0}' and ISNULL(IdDna,'0') = '0'", serial));

            if (dt.Rows.Count > 0)
            {
                DataRow item = dt.Rows[0];
                lstEqp.Add(new Equipamento
                {
                    ip = item["IP"].ToString(),
                    ddns = item["Ddns"].ToString(),
                    portaSnmpMib = item["PortSnmp"].ToString(),
                    portaSnmpTrap = item["PortSnmpTraps"].ToString(),
                    portaReset = item["PortSnmpReset"].ToString(),
                    bRecebeIpTrap = item["bRecebeIpTrap"].ToString()
                });
            }

            return lstEqp;
        }

        private void VerificaDna(string idDna)
        {
            string semServico = "", lote = "", loteAtual = "", consorcio = "", cruzamento = "";
            string lat = "0", lon = "0";


            DataTable dt = db.ExecuteReaderQuery(string.Format(@"select Id,Cruzamento,Consorcio,Lote,Empresa,SemServico,latitude
from DNA  where Id='{0}' and idPrefeitura ={1}", idDna, HttpContext.Current.Profile["idPrefeitura"]));

            if (dt.Rows.Count > 0)
            {
                semServico = dt.Rows[0]["SemServico"].ToString();
                loteAtual = dt.Rows[0]["Lote"].ToString();
                consorcio = dt.Rows[0]["Consorcio"].ToString();
                bool alterou = false;
                if (RetiraAcento.Acentos.RemoveAccents(dt.Rows[0]["Cruzamento"].ToString().ToUpper()) != RetiraAcento.Acentos.RemoveAccents(cruzamento.ToUpper()) || loteAtual != lote)
                {
                    db.ExecuteNonQuery(
                        string.Format(@"UPDATE DNA SET Cruzamento='{0}', latitude='{1}', longitude='{2}', Consorcio='{4}', empresa=NULL, lote={5} 
                        where Id='{3}' and IdPrefeitura={6}", cruzamento, lat, lon, idDna, consorcio, lote, HttpContext.Current.Profile["idPrefeitura"]));

                    db.ExecuteNonQuery(string.Format(@"INSERT INTO [HistoricoDNA] ([DNA],[ConsorcioIdAtual],[ConsorcioAtual],[DataHora],[ConsorcioIdAntigo],[ConsorcioAntigo])
     VALUES ('{0}',{1},'{2}','{3}',{4},'{5}')", idDna, lote, consorcio, DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"), dt.Rows[0]["Lote"], dt.Rows[0]["Consorcio"]));
                    alterou = true;
                }
                if (lat != dt.Rows[0]["latitude"].ToString() && alterou == false)
                {
                    db.ExecuteNonQuery(
                        string.Format("UPDATE DNA SET  latitude='{0}', longitude='{1}' where Id='{2}' and IdPrefeitura={3}", lat, lon, idDna, HttpContext.Current.Profile["idPrefeitura"]));
                }
            }
            else
            {
                db.ExecuteReaderQuery(string.Format(@"INSERT INTO DNA (Id,Consorcio,Cruzamento,latitude,longitude,Lote,DataCadastro,Usuario,idPrefeitura)
VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}')", idDna, consorcio, cruzamento, lat, lon, lote,
DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"), User.Identity.Name, HttpContext.Current.Profile["idPrefeitura"]));

                db.ExecuteNonQuery(string.Format(@"INSERT INTO [HistoricoDNA] ([DNA],[ConsorcioIdAtual],[ConsorcioAtual],[DataHora])
     VALUES ('{0}',{1},'{2}','{3}')", idDna, lote, consorcio, DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss")));
            }

        }

        [WebMethod]
        public List<Equipamento> GetEqp(string idDna)
        {

            VerificaDna(idDna);

            List<Equipamento> lstEqp = new List<Equipamento>();
            DataTable dt = db.ExecuteReaderQuery(string.Format(@"select d.Consorcio,d.Lote,d.SemServico,s.Modelo,SerialMestre,
d.Cruzamento,isnull(d.HabilitacaoCentral,0) as HabilitacaoCentral,d.Id,s.Serial,s.Ddns,s.IP,s.PortSnmp,
s.PortSnmpTraps,s.PortSnmpReset,s.bRecebeIpTrap,s.Desabilitado,s.SemComunicacao,
n.serial,n.Ddns,n.IP,n.portSnmp portSnmpN,n.portSnmpTraps portSnmpTrapsN,n.bRecebeIpTrap,n.Desabilitado,
c.hostName,c.userName,c.password,c.SerialComunicacao,c.Servico,
case d.Consorcio when 'CONSORCIO SINAL PAULISTANO' then '1'
when 'CONSORCIO ONDAVERDE' then '2'
when 'CONSORCIO MCS' then '3'
when 'CONSORCIO SEMAFORICO PAULISTANO' then '4' else '0' end as idConsorcio,isnull(TempoNaBateria,'')TempoNaBateria,
 case when isnull(resetporrequisicao,'0')=0 then 'Desativado' else 'Ativado' end resetPorRequisicao
from DNA d
left join nobreaks n
on d.Id = n.idDna
left join Status s
on s.IdDna = d.Id and s.idprefeitura=d.idprefeitura
left join semaforo.dbo.CameraConfig c
on c.idDna = d.Id and c.idPrefeitura=d.IdPrefeitura
where d.IdPrefeitura={0} and s.serial='{1}'", HttpContext.Current.Profile["idPrefeitura"], idDna));


            if (dt.Rows.Count > 0)
            {
                DataRow item = dt.Rows[0];
                lstEqp.Add(new Equipamento
                {
                    cruzamento = item["Cruzamento"].ToString(),
                    resetPorRequisicao = item["resetPorRequisicao"].ToString(),
                    idConsorcio = item["idConsorcio"].ToString(),
                    idDna = item["Id"].ToString(),
                    modelo = item["Modelo"].ToString(),
                    mestre = item["SerialMestre"].ToString(),
                    serial = item["Serial"].ToString(),
                    ddns = item["Ddns"].ToString(),
                    ip = item["IP"].ToString(),
                    portaSnmpMib = item["PortSnmp"].ToString(),
                    portaSnmpTrap = item["PortSnmpTraps"].ToString(),
                    portaReset = item["PortSnmpReset"].ToString(),
                    bRecebeIpTrap = item["bRecebeIpTrap"].ToString(),
                    desabilitado = item["Desabilitado"].ToString(),
                    habilitaCentral = item["HabilitacaoCentral"].ToString(),
                    hostNameCam = item["hostName"].ToString(),
                    userCamera = item["userName"].ToString(),
                    passwordCam = item["password"].ToString(),
                    serialComunicacao = item["SerialComunicacao"].ToString(),
                    servico = item["Servico"].ToString(),
                    SemComunicacao = item["SemComunicacao"].ToString()
                });
                lstEqp.Add(new Equipamento
                {
                    idConsorcio = item["idConsorcio"].ToString(),
                    idDna = item["Id"].ToString(),
                    serial = item["Serial"].ToString(),
                    ddns = item["Ddns"].ToString(),
                    ip = item["IP"].ToString(),
                    portaSnmpMib = item["PortSnmpN"].ToString(),
                    portaSnmpTrap = item["PortSnmpTrapsN"].ToString(),
                    portaReset = item["PortSnmpReset"].ToString(),
                    bRecebeIpTrap = item["bRecebeIpTrap"].ToString(),
                    desabilitado = item["Desabilitado"].ToString(),
                    habilitaCentral = item["HabilitacaoCentral"].ToString(),
                    TempoNaBateria = item["TEmpoNaBAteria"].ToString(),
                    SemComunicacao = item["SemComunicacao"].ToString()
                });
            }

            return lstEqp;
        }

        [WebMethod]
        public string SaveConfigCamera(string idDna, string idCamera, string hostName, string userName, string password, string statusCamera, bool servico, string serialComunicacao)
        {
            string retorno = "";
            if (string.IsNullOrEmpty(db.ExecuteScalarQuery("select * from CameraConfig where idDna='" + idDna + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"])))
            {
                if (statusCamera == "Habilitado")
                {
                    retorno = validacaoSerialCamera(serialComunicacao, hostName, null);
                    if (!string.IsNullOrEmpty(retorno)) return retorno;

                    string id = db.ExecuteScalarQuery(string.Format("insert into CameraConfig (idDna,hostName,userName,password,data,idPrefeitura,serialComunicacao,servico) values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}') select SCOPE_IDENTITY();", idDna, hostName, userName, password, DateTime.Now, HttpContext.Current.Profile["idPrefeitura"], serialComunicacao, servico));
                    db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User.Identity.Name + "','Cadastro Equipamento - Cadastro Camera'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Cadastrou a camera hostName: " + hostName + ", idDNA: " + idDna + ", userName: " + userName + ", password: " + password + ", serialComunicacao: " + serialComunicacao + ", servico: " + servico + ", idCamera: " + id + "','CameraConfig')");
                }
            }
            else if (!string.IsNullOrEmpty(idCamera))
            {
                if (statusCamera == "Habilitado")
                {
                    retorno = validacaoSerialCamera(serialComunicacao, hostName, idCamera);
                    if (!string.IsNullOrEmpty(retorno)) return retorno;

                    db.ExecuteNonQuery(string.Format("update CameraConfig set hostName='{0}',userName='{1}',password='{2}', data='{4}', serialComunicacao='{5}', servico='{6}' where id={3}", hostName, userName, password, idCamera, DateTime.Now, serialComunicacao, servico));
                    db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User.Identity.Name + "','Cadastro Equipamento - Cadastro Camera'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                   "','Alterou a camera hostName: " + hostName + ", idDNA: " + idDna + ", userName: " + userName + ", password: " + password + ", serialComunicacao: " + serialComunicacao + ", servico: " + servico + " do id: " + idCamera + "','CameraConfig')");
                }
                else
                {
                    db.ExecuteNonQuery(string.Format("delete from CameraConfig where id={0}", idCamera));
                    db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User.Identity.Name + "','Cadastro Equipamento - Cadastro Camera'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                   "','Excluiu a camera hostName: " + hostName + ", idDNA: " + idDna + ", userName: " + userName + ", password: " + password + ", serialComunicacao: " + serialComunicacao + ", servico: " + servico + " do id: " + idCamera + "','CameraConfig')");
                }
            }
            else
            {
                idCamera = db.ExecuteScalarQuery("Select Id from CameraConfig Where IdDna='" + idDna + "' And IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
                if (statusCamera == "Habilitado")
                {
                    retorno = validacaoSerialCamera(serialComunicacao, hostName, idCamera);
                    if (!string.IsNullOrEmpty(retorno)) return retorno;

                    db.ExecuteNonQuery(string.Format(@"update CameraConfig set hostName='{0}',userName='{1}',password='{2}', data='{4}', serialComunicacao='{5}', servico='{6}'
where id={3}", hostName, userName, password, idCamera, DateTime.Now, serialComunicacao, servico));
                }
                else db.ExecuteNonQuery(string.Format("delete from CameraConfig where id={0}", idCamera));
            }

            return retorno;
        }

        public string validacaoSerialCamera(string serial, string ipCam, string idCam)
        {
            string retorno = "";

            string sql = "Select id from CameraConfig Where serialComunicacao='" + serial + "' And hostName='" + ipCam + "'";
            if (!string.IsNullOrEmpty(idCam)) sql += " And Id <> " + idCam;

            DataTable dt = db.ExecuteReaderQuery(sql);

            if (dt.Rows.Count > 0) retorno = "A serial configurada já está vinculada ao mesmo IP";

            return retorno;
        }

        [WebMethod]
        public List<Chip> GetChipDna(string idDna)
        {
            List<Chip> lstChips = new List<Chip>();

            DataTable dt = db.ExecuteReaderQuery(@"select id,idDna,tipo,empresa,operadora,hexa,numero,plano,consorcio,infoConsorcio,empresaInsta
from ChipDna
where idDna='" + idDna + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

            foreach (DataRow item in dt.Rows)
            {
                lstChips.Add(new Chip
                {
                    id = item["id"].ToString(),
                    idDna = item["idDna"].ToString(),
                    tipo = item["tipo"].ToString(),
                    empresa = item["empresa"].ToString(),
                    operadora = item["operadora"].ToString(),
                    hexa = item["hexa"].ToString(),
                    numero = item["numero"].ToString(),
                    plano = item["plano"].ToString(),
                    consorcio = item["consorcio"].ToString(),
                    infoConsorcio = item["infoConsorcio"].ToString(),
                    empresaInsta = item["empresaInsta"].ToString()
                });
            }

            return lstChips;
        }

        [WebMethod]
        public void DeleteChip(string idChip)
        {
            DataTable dt = db.ExecuteReaderQuery("select tipo,idDNA,empresa,operadora, numero, plano from ChipDNA where id=" + idChip);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                string tipo = dr["tipo"].ToString();
                string idPonto = dr["idDNA"].ToString();
                string empresa = dr["empresa"].ToString();
                string operadora = dr["operadora"].ToString();
                string numero = dr["numero"].ToString();
                string plano = dr["plano"].ToString();

                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User.Identity.Name + "','Cadastro Equipamento - Cadastro Chip'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                "','Excluiu o Chip tipo: " + tipo + ", idDNA: " + idPonto + ", empresa: " + empresa + ", operadora: " + operadora + ", numero: " + numero + ", plano: " + plano + "','ChipDna')");
                db.ExecuteNonQuery("delete from ChipDna where id=" + idChip);
            }
        }


        [WebMethod]
        public void SaveChipControlador(string idPonto, string idChip, string empresa, string operadora, string hexa, string numero, string plano, string tipo, string local, string comandChip, string consorcio, string infoConsorcio, string empresaInsta)
        {
            if (comandChip == "insert")
            {
                string id = db.ExecuteScalarQuery(string.Format(@"insert into ChipDna(idDna, tipo, empresa, operadora, hexa, numero, plano, local, data,consorcio,idPrefeitura,infoConsorcio,empresaInsta)
values('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}') select SCOPE_IDENTITY();", idPonto, tipo, empresa, operadora, hexa, numero, plano, local, DateTime.Now, consorcio, HttpContext.Current.Profile["idPrefeitura"], infoConsorcio, empresaInsta));

                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User.Identity.Name + "','Cadastro Equipamento - Cadastro Chip'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Cadastrou o Chip id: " + id + " tipo: " + tipo + ", idDNA: " + idPonto + ", empresa: " + empresa + ", operadora: " + operadora + ", hexa: " + hexa + ", numero: " + numero + ", plano: " + plano + ", local: " + local + ", consorcio: " + consorcio + ", infoConsorcio: " + infoConsorcio + ", empresaInsta: " + empresaInsta + "','ChipDna')");
            }
            else
            {
                db.ExecuteNonQuery(string.Format(@"update ChipDna set tipo='{0}',empresa='{1}',operadora='{2}',hexa='{3}',
numero = '{4}', plano = '{5}', data = '{6}',consorcio='{8}',infoConsorcio='{9}',empresaInsta='{10}' where id ={7}", tipo, empresa, operadora, hexa, numero, plano, DateTime.Now, idChip, consorcio, infoConsorcio, empresaInsta));

                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User.Identity.Name + "','Cadastro Equipamento - Cadastro Chip'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                "','Alterou o Chip id: " + idChip + " tipo: " + tipo + ", idDNA: " + idPonto + ", empresa: " + empresa + ", operadora: " + operadora + ", hexa: " + hexa + ", numero: " + numero + ", plano: " + plano + ", consorcio: " + consorcio + ", infoConsorcio: " + infoConsorcio + ", empresaInsta: " + empresaInsta + "','ChipDna')");
            }
        }

        public struct Equipamento
        {
            public string modelo { get; set; }
            public string mestre { get; set; }
            public string TempoNaBateria { get; set; }
            public string cruzamento { get; set; }
            public string idDna { get; set; }
            public string idConsorcio { get; set; }
            public string resetPorRequisicao { get; set; }
            public string serial { get; set; }
            public string ddns { get; set; }
            public string ip { get; set; }
            public string portaSnmpMib { get; set; }
            public string portaSnmpTrap { get; set; }
            public string portaReset { get; set; }
            public string bRecebeIpTrap { get; set; }
            public string desabilitado { get; set; }
            public string habilitaCentral { get; set; }
            public string disponivel { get; set; }
            public string dtAtualizacao { get; set; }
            public string hostNameCam { get; set; }
            public string userCamera { get; set; }
            public string passwordCam { get; set; }
            public string SemComunicacao { get; set; }
            public string serialComunicacao { get; set; }
            public string servico { get; set; }
        }

        public struct Chip
        {
            public string id { get; set; }
            public string idDna { get; set; }
            public string tipo { get; set; }
            public string empresa { get; set; }
            public string operadora { get; set; }
            public string hexa { get; set; }
            public string numero { get; set; }
            public string plano { get; set; }
            public string consorcio { get; set; }
            public string infoConsorcio { get; set; }
            public string empresaInsta { get; set; }
        }
    }
}