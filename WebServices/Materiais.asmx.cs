using Infortronics;
using RetiraAcento;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Web;
using System.Web.Hosting;
using System.Web.Services;
using System.Xml;

namespace GwCentral.WebServices
{
    /// <summary>
    /// Summary description for cadDna
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    public class Materiais : System.Web.Services.WebService
    {
        Banco db = new Banco("");
        DataTable dt;

        public struct ListaMateriais
        {
            public string idSub { get; set; }
            public string idDepartamento { get; set; }
            public string Subdivisao { get; set; }
            public string Endereco { get; set; }
            public string Modelo { get; set; }
            public string Produto { get; set; }
            public string idPatrimonio { get; set; }
            public string NmrPatrimonio { get; set; }
            public string idSubMestre { get; set; }
            public string EngResponsavel { get; set; }
            public string DtDeflagracao { get; set; }
            public string ResponsavelVistoria { get; set; }
            public string RegistroCREA { get; set; }
            public string RegistroCET { get; set; }
        }

        [WebMethod]
        public List<string> getMotivo(string idPrefeitura)
        {
            DataTable dt = db.ExecuteReaderQuery(
                " SELECT Id,Motivo FROM Motivo " +
                " where IdPrefeitura='" + idPrefeitura + "'");

            List<string> lst = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}", item["Motivo"].ToString(), item["Id"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> CarregarListaDatasImagem(string idLocal)
        {
            Banco dbStatic = new Banco("");
            string sql = @"Select SUBSTRING(DataHora,0,11) Data from ImagemDepartamento " +
                " WHERE IdSubDivisao=" + idLocal + " group by SUBSTRING(DataHora,0,11) " +
                " order by SUBSTRING(DataHora,0,11) desc";

            DataTable dt = dbStatic.ExecuteReaderQuery(sql);

            List<string> ListaData = new List<string>();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow item in dt.Rows)
                {
                    ListaData.Add(item["Data"].ToString());
                }
            }

            return ListaData;
        }

        public class DadosArquivo
        {
            public DadosArquivo(string _id, string _nomeArquivo, string _idDepartamento, string _hora)
            {
                Id = _id;
                NomeArquivo = _nomeArquivo;
                IdDepartamento = _idDepartamento;
                Hora = _hora;
            }

            public string Id { get; set; }
            public string NomeArquivo { get; set; }
            public string IdDepartamento { get; set; }
            public string Hora { get; set; }
        }

        [WebMethod]
        public List<DadosArquivo> GetUploadImages(string idLocal, string Data)
        {
            Banco dbStatic = new Banco("");
            string sql = @"SELECT Id,Nome,IdDepartamento,SUBSTRING(DataHora,11,9) " +
                " Hora FROM ImagemDepartamento WHERE IdSubDivisao=" + idLocal + " " +
                " AND SUBSTRING(DataHora,0,11) = '" + Data + "'";

            DataTable dt = dbStatic.ExecuteReaderQuery(sql);

            List<DadosArquivo> ListaArquivos = new List<DadosArquivo>();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow item in dt.Rows)
                {
                    ListaArquivos.Add(new DadosArquivo(
                        item["Id"].ToString(),
                        item["Nome"].ToString(),
                        item["IdDepartamento"].ToString(),
                        item["Hora"].ToString()
                        ));
                }
            }

            return ListaArquivos;
        }

        [WebMethod]
        public List<DadosArquivo> GetUploadImages_Hora(string idLocal, string Data, string HoraInicio, string HoraFinal)
        {
            Banco dbStatic = new Banco("");
            string sql = @"SELECT Id,Nome,IdDepartamento,SUBSTRING(DataHora,11,9) " +
                " Hora FROM ImagemDepartamento WHERE IdSubDivisao=" + idLocal + " " +
                " AND SUBSTRING(DataHora,0,11) = '" + Data + "' " +
                " AND convert(datetime,DataHora,103) between '" + Data + " " +
                " " + HoraInicio + "' AND '" + Data + " " + HoraFinal + "' ";

            DataTable dt = dbStatic.ExecuteReaderQuery(sql);

            List<DadosArquivo> ListaArquivos = new List<DadosArquivo>();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow item in dt.Rows)
                {
                    ListaArquivos.Add(new DadosArquivo(
                        item["Id"].ToString(),
                        item["Nome"].ToString(),
                        item["IdDepartamento"].ToString(),
                        item["Hora"].ToString()
                        ));
                }
            }

            return ListaArquivos;
        }

        [WebMethod]
        public List<DadosArquivo> GetUploadProjetos(string idLocal)
        {
            Banco dbStatic = new Banco("");
            string sql = @"SELECT Id,Nome,IdDepartamento FROM ProjetoDepartamento
                         WHERE IdSubDivisao=" + idLocal;

            DataTable dt = dbStatic.ExecuteReaderQuery(sql);

            List<DadosArquivo> ListaArquivos = new List<DadosArquivo>();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow item in dt.Rows)
                {
                    ListaArquivos.Add(new DadosArquivo(
                        item["Id"].ToString(),
                        item["Nome"].ToString(),
                        item["IdDepartamento"].ToString(),
                        ""
                        ));
                }
            }

            return ListaArquivos;
        }

        [WebMethod]
        public List<DadosArquivo> GetUploadArquivos(string idLocal)
        {
            Banco dbStatic = new Banco("");
            string sql = @"SELECT Id,Nome,IdDepartamento FROM ArquivosDoc
                         WHERE IdSubDivisao=" + idLocal;

            DataTable dt = dbStatic.ExecuteReaderQuery(sql);

            List<DadosArquivo> ListaArquivos = new List<DadosArquivo>();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow item in dt.Rows)
                {
                    ListaArquivos.Add(new DadosArquivo(
                        item["Id"].ToString(),
                        item["Nome"].ToString(),
                        item["IdDepartamento"].ToString(),
                        ""
                        ));
                }
            }

            return ListaArquivos;
        }

        [WebMethod]
        public string SalvarImagemCruzamento(string base64, string NomeArquivo, string IdDepartamento, string IdSubDivisao)
        {
            try
            {
                NomeArquivo = NomeArquivo.RemoveAccents();
                base64 = base64.Replace("\"", "");
                byte[] bytes = Convert.FromBase64String(base64);
                string path = Server.MapPath(
                    "../ImagemDepartamento/Images/")
                    + IdDepartamento + "\\" + NomeArquivo;

                if (!Directory.Exists(Server.MapPath(
                    "../ImagemDepartamento/Images/") + IdDepartamento))
                {
                    Directory.CreateDirectory(Server.MapPath(
                        "../ImagemDepartamento/Images/") + IdDepartamento);
                }

                db.ExecuteNonQuery("INSERT INTO ImagemDepartamento " +
                    " (Nome,IdDepartamento,IdSubDivisao,DataHora) " +
                    " VALUES ('" + NomeArquivo + "'," + IdDepartamento + ", " +
                    " " + IdSubDivisao + ",'" + DateTime.Now + "')"
                    );

                File.WriteAllBytes(path, Convert.FromBase64String(base64));

                return "Arquivo foi salvo com sucesso";
            }
            catch (Exception e)
            {
                return "Erro ao Salvar - " + e.Message;
            }
        }

        [WebMethod]
        public string ExcluirImagem(string IdArquivo, string NomeArquivo, string IdDepartamento)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery(
                "DELETE FROM ImagemDepartamento" +
                " Where Id = " + IdArquivo);
            try
            {
                string path = Server.MapPath(
                    "../ImagemDepartamento/Images/")
                    + IdDepartamento + "\\" + NomeArquivo;

                File.Delete(path);
            }
            catch (Exception e)
            {

            }

            return "OK";
        }


        [WebMethod]
        public string SalvarProjetoCruzamento(string base64, string NomeArquivo, string IdDepartamento, string IdSubDivisao)
        {
            try
            {
                NomeArquivo = NomeArquivo.RemoveAccents();
                base64 = base64.Replace("\"", "");
                byte[] bytes = Convert.FromBase64String(base64);
                string path = Server.MapPath(
                    "../ProjetoDepartamento/arqs/")
                    + IdDepartamento + "\\" + NomeArquivo;

                if (!Directory.Exists(Server.MapPath(
                    "../ProjetoDepartamento/arqs/") + IdDepartamento))
                {
                    Directory.CreateDirectory(Server.MapPath(
                        "../ProjetoDepartamento/arqs/") + IdDepartamento);
                }

                db.ExecuteNonQuery(
                    "INSERT INTO ProjetoDepartamento (Nome,IdDepartamento,IdSubDivisao,DataHora) " +
                    "VALUES ('" + NomeArquivo + "'," + IdDepartamento + ", " + IdSubDivisao + ", " +
                    " '" + DateTime.Now + "') ");

                File.WriteAllBytes(path, Convert.FromBase64String(base64));

                return "Arquivo foi salvo com sucesso";
            }
            catch (Exception e)
            {
                return "Erro ao Salvar - " + e.Message;
            }
        }

        [WebMethod]
        public string ExcluirProjeto(string IdArquivo, string NomeArquivo, string IdDepartamento)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery(
                "DELETE FROM ProjetoDepartamento " +
                " Where Id = " + IdArquivo);
            try
            {
                string path = Server.MapPath(
                    "../ProjetoDepartamento/arqs/")
                    + IdDepartamento + "\\" + NomeArquivo;

                File.Delete(path);
            }
            catch (Exception e)
            {

            }

            return "OK";
        }


        [WebMethod]
        public string SalvarArquivoCruzamento(string base64, string NomeArquivo, string IdDepartamento, string IdSubDivisao)
        {
            try
            {
                NomeArquivo = NomeArquivo.RemoveAccents();
                base64 = base64.Replace("\"", "");
                byte[] bytes = Convert.FromBase64String(base64);
                string path = Server.MapPath(
                    "../ArquivosDoc/arqs/")
                    + IdDepartamento + "\\" + NomeArquivo;

                if (!Directory.Exists(Server.MapPath(
                    "../ArquivosDoc/arqs/") + IdDepartamento))
                {
                    Directory.CreateDirectory(Server.MapPath(
                        "../ArquivosDoc/arqs/") + IdDepartamento);
                }

                db.ExecuteNonQuery(
                    "INSERT INTO ArquivosDoc (Nome,IdDepartamento,IdSubDivisao,DataHora) " +
                    " VALUES ('" + NomeArquivo + "'," + IdDepartamento + ", " +
                    " " + IdSubDivisao + ",'" + DateTime.Now + "')");

                File.WriteAllBytes(path, Convert.FromBase64String(base64));

                return "Arquivo foi salvo com sucesso";
            }
            catch (Exception e)
            {
                return "Erro ao Salvar - " + e.Message;
            }
        }

        [WebMethod]
        public string ExcluirArquivo(string IdArquivo, string NomeArquivo, string IdDepartamento)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery(
                "DELETE FROM ArquivosDoc " +
                " Where Id = " + IdArquivo);
            try
            {
                string path = Server.MapPath(
                    "../ArquivosDoc/arqs/")
                    + IdDepartamento + "\\" + NomeArquivo;

                File.Delete(path);
            }
            catch (Exception e)
            {

            }

            return "OK";
        }

        [WebMethod]
        public List<string> getDepartament(string idPrefeitura)
        {
            DataTable dt = db.ExecuteReaderQuery(
                "SELECT distinct d.Nome,d.Id FROM Departamento " +
                " d join Subdivisao_departamento sd on sd.idDepartamento = d.id " +
                " where manutencao='true' and IdPrefeitura='" + idPrefeitura + "' ");

            List<string> lst = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}",
                    item["Id"].ToString(),
                    item["Nome"].ToString()
                    ));
            }

            return lst;
        }

        [WebMethod]
        public List<string> GetSub(string idDepartamento)
        {
            DataTable dt = db.ExecuteReaderQuery(
                @"select Id,Subdivisao Nome,Endereco,Telefone,Email,Responsavel,
                isnull(cruzamento,'False') cruz from Subdivisao_Departamento
                where  isnull(idSubDivisaoSuperior,'0')='0'
                and IdDepartamento= " + idDepartamento + " and manutencao='1'");

            List<string> lst = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}",
                    item["Id"].ToString(),
                    item["Nome"].ToString()
                    ));
            }

            return lst;
        }

        [WebMethod]
        public List<string> getSubChildren(string idSubdivisao)
        {
            DataTable dt = db.ExecuteReaderQuery(
                @"select Id,Subdivisao Nome,Endereco,Telefone,Email,Responsavel, 
                isnull(cruzamento,'False') cruz from Subdivisao_Departamento
                where idSubDivisaoSuperior='" + idSubdivisao + "' and manutencao='1'");

            List<string> lst = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}", item["Id"].ToString(), item["Nome"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<ListaMateriais> getSubdivisao(string idPrefeitura, string idLocal, string Endereco)
        {
            List<ListaMateriais> lstSub = new List<ListaMateriais>();
            if (idLocal != "")
            {
                dt = db.ExecuteReaderQuery(
                    @"select sd.Endereco,sd.Id,sd.idDepartamento,EngenheiroResponsavel,
                    DataDeflagracao,RegistroCET,RegistroCREA,ResponsavelVistoria from Subdivisao_DEpartamento
                    sd JOIN Departamento d on d.Id=sd.idDepartamento
                    where sd.Subdivisao='" + idLocal + "' " +
                    " and d.IdPrefeitura=" + idPrefeitura);

                foreach (DataRow item in dt.Rows)
                {
                    lstSub.Add(new ListaMateriais
                    {
                        idDepartamento = item["idDepartamento"].ToString(),
                        Endereco = item["Endereco"].ToString(),
                        idSub = item["Id"].ToString(),
                        EngResponsavel = item["EngenheiroResponsavel"].ToString(),
                        DtDeflagracao = item["DataDeflagracao"].ToString(),
                        ResponsavelVistoria = item["ResponsavelVistoria"].ToString(),
                        RegistroCET = item["RegistroCET"].ToString(),
                        RegistroCREA = item["RegistroCREA"].ToString()
                    });
                }
            }
            else if (Endereco != "")
            {
                dt = db.ExecuteReaderQuery(
                    @"select sd.Subdivisao,sd.Id,sd.idDepartamento,EngenheiroResponsavel,
                    DataDeflagracao,ResponsavelCET,ResponsavelCREA,ResponsavelVistoria from Subdivisao_DEpartamento
                    sd JOIN Departamento d on d.Id=sd.idDepartamento
                    where sd.Endereco='" + Endereco + "' and IdPrefeitura=" + idPrefeitura);

                foreach (DataRow item in dt.Rows)
                {
                    lstSub.Add(new ListaMateriais
                    {
                        Subdivisao = item["Subdivisao"].ToString(),
                        idDepartamento = item["idDepartamento"].ToString(),
                        idSub = item["Id"].ToString(),
                        EngResponsavel = item["EngenheiroResponsavel"].ToString(),
                        DtDeflagracao = item["DataDeflagracao"].ToString(),
                        ResponsavelVistoria = item["ResponsavelVistoria"].ToString(),
                        RegistroCET = item["RegistroCET"].ToString(),
                        RegistroCREA = item["RegistroCREA"].ToString()
                    });
                }
            }

            return lstSub;
        }

        [WebMethod]
        public void SalvarDetalhesDNA(string idSub, string EngResponsavel, string DtDeflagracao, string RegistroCREA, string RegistroCET, string ResponsavelVistoria)
        {
            db.ExecuteNonQuery(
                "update Subdivisao_departamento set EngenheiroResponsavel='" + EngResponsavel + "', " +
                " DataDeflagracao='" + DtDeflagracao + "',RegistroCREA='" + RegistroCREA + "', " +
                " RegistroCET='" + RegistroCET + "',ResponsavelVistoria='" + ResponsavelVistoria + "' " +
                " where id=" + idSub);
        }

        [WebMethod]
        public void SalvarProd(string idPrefeitura, string idPat, string SubdivisaoMov, string EnderecoMov, string idSub, string produto, string formaOperacional)
        {
            string idSubMov = db.ExecuteScalarQuery(
                "select id from Subdivisao_Departamento " +
                " where Subdivisao='" + SubdivisaoMov + "' " +
                " and Endereco='" + EnderecoMov + "' ");

            string idDepartamentoMov = db.ExecuteScalarQuery(
                "select idDepartamento from Subdivisao_Departamento " +
                " where id=" + idSubMov);

            string idDepartamento = db.ExecuteScalarQuery(
                "select idDepartamento from Subdivisao_Departamento " +
                " where id=" + idSub);

            dt = db.ExecuteReaderQuery(
                @"Select ROW_NUMBER() OVER(ORDER BY P.NomeProduto DESC) AS Row,NomeProduto, 
                count(0) Qtd,p.idProduto,NumeroSerie from Patrimonio P 
                left join Departamento D on P.IdDepartamento=D.Id 
                left join SUBDIVISAO_Departamento s on P.Idsubdivisao=s.Id
                where IdPatrimonio=" + idPat + " group by NomeProduto,NumeroSerie,idProduto");

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                string idProduto = dr["idProduto"].ToString();

                #region registra Movimentação
                string LogMovimento = "insert into LogMovimento (DataHora,Usuario,IdPatrimonio, " +
                    " IdDepartamento,IdSubdivisao,IdPrefeitura,IdDepAnterior,IdSubAnterior,Obs,QtdAtual,QtdMov) " +
                    " values ('" + DateTime.Now + "','" + User.Identity.Name + "'," + idPat + ", " +
                    " " + idDepartamento + "," + idSub + "," + idPrefeitura + "," + idDepartamentoMov + ", " +
                    " " + idSubMov + ",'Transferencia de Produto'" + ",'" + dr["Qtd"].ToString() + "','1')";

                db.ExecuteNonQuery(LogMovimento);
                #endregion

                #region transfer
                db.ExecuteNonQuery(
                    @"update Patrimonio set idSubdivisao=" + idSub + ",idDepartamento=" + idDepartamento + ", " +
                    " Dthr='" + DateTime.Now + "' where idPatrimonio=" + idPat);

                string idPatSem = db.ExecuteScalarQuery(
                    "select id from PatrimonioSemaforo" +
                    "where idPatrimonio=" + idPat + " " +
                    " and idSubdivisao=" + idSubMov);
                if (idPatSem != "")
                {
                    if (produto.ToUpper() == "GPRS NOBREAK" || produto.ToUpper() == "GPRS CONTROLADOR")
                    {
                        if (produto.ToUpper() == "GPRS NOBREAK")
                        {
                            db.ExecuteNonQuery(@"update PatrimonioSemaforo set idSubdivisao=" + idSub + ", " +
                                " idDepartamento=" + idDepartamento + ",PertencePatrimonio='NOBREAK' " +
                                " where id=" + idPatSem);
                        }
                        else
                        {
                            db.ExecuteNonQuery(@"update PatrimonioSemaforo set idSubdivisao=" + idSub + ", " +
                                " idDepartamento=" + idDepartamento + ",PertencePatrimonio='CONTROLADOR' " +
                                " where id=" + idPatSem);
                        }
                    }
                    else
                    {
                        if (produto.ToUpper() == "CONTROLADOR")
                            db.ExecuteNonQuery(@"update PatrimonioSemaforo set FormaOperacional='" + formaOperacional + "', " +
                                " idSubdivisao=" + idSub + ",idDepartamento=" + idDepartamento + " " +
                                " where id=" + idPatSem);
                        else
                            db.ExecuteNonQuery(@"update PatrimonioSemaforo set idSubdivisao=" + idSub + ", " +
                                " idDepartamento=" + idDepartamento + " " +
                                " where id=" + idPatSem);
                    }
                }
                else
                {
                    if (produto.ToUpper() == "GPRS NOBREAK" || produto.ToUpper() == "GPRS CONTROLADOR")
                    {
                        if (produto.ToUpper() == "GPRS NOBREAK")
                        {
                            idPatSem = db.ExecuteScalarQuery(
                                @"Insert into PatrimonioSemaforo (IdPatrimonio,IdDepartamento,IdSubdivisao,PertencePatrimonio) 
                                values (" + idPat + "," + idDepartamento + "," + idSub + ",'NOBREAK') SELECT SCOPE_IDENTITY()"
                                );
                        }
                        else
                        {
                            idPatSem = db.ExecuteScalarQuery(
                                @"Insert into PatrimonioSemaforo (IdPatrimonio,IdDepartamento,IdSubdivisao,PertencePatrimonio) 
                                values (" + idPat + "," + idDepartamento + "," + idSub + ",'CONTROLADOR') SELECT SCOPE_IDENTITY()"
                                );
                        }
                    }
                    else
                    {
                        if (produto.ToUpper() == "CONTROLADOR")
                            idPatSem = db.ExecuteScalarQuery(
                                @"Insert into PatrimonioSemaforo (IdPatrimonio,IdDepartamento,IdSubdivisao,FormaOperacional)
                                values(" + idPat + "," + idDepartamento + "," + idSub + ",'" + formaOperacional + "') " +
                                " SELECT SCOPE_IDENTITY()"
                                );
                        else
                            idPatSem = db.ExecuteScalarQuery(
                                @"Insert into PatrimonioSemaforo (IdPatrimonio,IdDepartamento,IdSubdivisao)
                                values(" + idPat + "," + idDepartamento + "," + idSub + ") " +
                                " SELECT SCOPE_IDENTITY()");
                    }
                }

                #region Gerencia Estoque

                #region Tira o Produto da Subdivisao Origem
                string Gerencia = db.ExecuteScalarQuery(
                    @"select GerenciarEstoque from Subdivisao_Departamento
                    where id=" + idDepartamentoMov);
                if (Gerencia == "True")
                {
                    dt = db.ExecuteReaderQuery(
                        @"SELECT id,Qtd FROM Estoque" +
                        "WHERE idProduto=" + idProduto + " " +
                        " AND idSubdivisao=" + idSubMov + " " +
                        " AND idPrefeitura=" + idPrefeitura
                        );
                    if (dt.Rows.Count > 0)
                    {
                        int qtd = Convert.ToInt32(dt.Rows[0]["Qtd"].ToString()) - 1;
                        db.ExecuteNonQuery(
                            @"UPDATE Estoque SET Qtd='" + qtd + "' " +
                            " WHERE id=" + dt.Rows[0]["Id"].ToString()
                            );
                    }
                }

                #endregion

                #region Adiciona Produto na Subdivisao Destino
                Gerencia = db.ExecuteScalarQuery(
                    @"SELECT  GerenciarEstoque FROM Subdivisao_Departamento " +
                    " WHERE id=" + idSub + " AND idPrefeitura=" + idPrefeitura
                    );
                if (Gerencia == "True")
                {
                    dt = db.ExecuteReaderQuery(
                        @"SELECT id,Qtd FROM Estoque " +
                        " WHERE idSubdivisao=" + idSub + " " +
                        " AND idProduto=" + idProduto + " " +
                        " AND idPrefeitura=" + idPrefeitura
                        );
                    if (dt.Rows.Count > 0)
                    {
                        int total = Convert.ToInt32(dt.Rows[0]["Qtd"].ToString()) + 1;
                        db.ExecuteNonQuery(
                            @"UPDATE Estoque SET Qtd='" + total + "' " +
                            " WHERE id=" + dt.Rows[0]["Id"].ToString()
                            );
                    }
                    else
                    {
                        db.ExecuteNonQuery(
                            @"insert into Estoque (IdPrefeitura,idDepartamento,idSubdivisao,idProduto,Qtd) 
                            values (" + idPrefeitura + "," + idDepartamento + "," + idSub + "," + idProduto + ",'1')");
                    }
                }

                #endregion

                #endregion

                #endregion
            }
        }

        [WebMethod]
        public List<ListaMateriais> FindNmrPatMov(string idPrefeitura, string text, string idSub, string Prod)
        {
            if (Prod.ToUpper() == "GPRS CONTROLADOR" || Prod.ToUpper() == "GPRS NOBREAK")
            {
                int n = Prod.IndexOf(" ");
                if (n > 0)
                {
                    Prod = Prod.Substring(0, n);
                }
            }


            if (Prod.ToUpper() == "SISTEMA DE ILUMINAÇÃO")
            {
                if (idSub == "")
                {
                    dt = db.ExecuteReaderQuery(
                        @"select(p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,
                        Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
                        JOIN Produto p on p.Id=pa.IdProduto
                        JOIN Categoria c on c.id =pa.idCategoria
                        JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
                        where categoria like'%ILUMINAÇÃO%' 
                        and NumeroPatrimonio='" + text + "' " +
                        " and pa.idPrefeitura=" + idPrefeitura + " " +
                        " or categoria like'%ILUMINACAO%' " +
                        " and NumeroPatrimonio='" + text + "' " +
                        " and pa.idPrefeitura=" + idPrefeitura + " order by Produto");
                }
                else
                {
                    if (text != "")
                    {
                        dt = db.ExecuteReaderQuery(
                            @"select (p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,
                            Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
                            JOIN Produto p on p.Id=pa.IdProduto
                            JOIN Categoria c on c.id =pa.idCategoria
                            JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
                            where categoria like'%ILUMINAÇÃO%' 
                            and NumeroPatrimonio='" + text + "' " +
                            " and pa.idPrefeitura=" + idPrefeitura + " " +
                            " and idSubdivisao=" + idSub + " " +
                            " or categoria like'%ILUMINACAO%' " +
                            " and NumeroPatrimonio='" + text + "' " +
                            " and pa.idPrefeitura=" + idPrefeitura + " " +
                            " and idSubdivisao=" + idSub + " order by Produto");
                    }
                    else
                    {
                        dt = db.ExecuteReaderQuery(
                            @"select (p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,
                            Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
                            JOIN Produto p on p.Id=pa.IdProduto
                            JOIN Categoria c on c.id =pa.idCategoria
                            JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
                            where categoria like'%ILUMINAÇÃO%' 
                            and pa.idPrefeitura=" + idPrefeitura + " " +
                            " and idSubdivisao=" + idSub + " " +
                            " or categoria like'%ILUMINACAO%' " +
                            " and pa.idPrefeitura=" + idPrefeitura + " " +
                            " and idSubdivisao=" + idSub + " order by Produto");
                    }
                }
            }
            else
            {
                if (idSub == "")
                {
                    dt = db.ExecuteReaderQuery(
                        @"select(p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,
                        Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
                        JOIN Produto p on p.Id=pa.IdProduto
                        JOIN Categoria c on c.id =pa.idCategoria
                        JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
                        where categoria='" + Prod.ToUpper() + "' " +
                        " and NumeroPatrimonio='" + text + "' " +
                        " and pa.idPrefeitura=" + idPrefeitura + " order by Produto");
                }
                else
                {
                    if (text != "")
                    {
                        dt = db.ExecuteReaderQuery(
                            @"select (p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,
                            Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
                            JOIN Produto p on p.Id=pa.IdProduto
                            JOIN Categoria c on c.id =pa.idCategoria
                            JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
                            where categoria='" + Prod.ToUpper() + "' " +
                            " and NumeroPatrimonio='" + text + "' " +
                            " and pa.idPrefeitura=" + idPrefeitura + " " +
                            " and idSubdivisao=" + idSub + " order by Produto");
                    }
                    else
                    {
                        dt = db.ExecuteReaderQuery(
                            @"select (p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,
                            Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
                            JOIN Produto p on p.Id=pa.IdProduto
                            JOIN Categoria c on c.id =pa.idCategoria
                            JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
                            where categoria='" + Prod.ToUpper() + "' " +
                            " and pa.idPrefeitura=" + idPrefeitura + " " +
                            " and idSubdivisao=" + idSub + " order by Produto");
                    }
                }
            }

            List<ListaMateriais> lstProd = new List<ListaMateriais>();
            foreach (DataRow item in dt.Rows)
            {
                lstProd.Add(new ListaMateriais
                {
                    idSub = item["IdSubdivisao"].ToString(),
                    idPatrimonio = item["IdPatrimonio"].ToString(),
                    Produto = item["Produto"].ToString(),
                    NmrPatrimonio = item["NumeroPatrimonio"].ToString(),
                    Subdivisao = item["Subdivisao"].ToString(),
                    Endereco = item["Endereco"].ToString()
                });
            }

            return lstProd;
        }

        [WebMethod]
        public List<ListaMateriais> FindSubdivisaoMov(string idPrefeitura, string text, string idSub, string Prod)
        {
            if (Prod.ToUpper() == "GPRS CONTROLADOR" || Prod.ToUpper() == "GPRS NOBREAK")
            {
                int n = Prod.IndexOf(" ");
                if (n > 0)
                {
                    Prod = Prod.Substring(0, n);
                }
            }


            if (Prod.ToUpper() == "SISTEMA DE ILUMINAÇÃO")
            {
                dt = db.ExecuteReaderQuery(
                    @"select(p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,
                    Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
                    JOIN Produto p on p.Id=pa.IdProduto
                    JOIN Categoria c on c.id =pa.idCategoria
                    JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
                    where (categoria like'%ILUMINAÇÃO%' 
                    or categoria like'%ILUMINACAO%') 
                    and s.Subdivisao='" + text + "' " +
                    " and pa.idPrefeitura=" + idPrefeitura + " order by Produto");
            }
            else
            {
                if (idSub == "")
                {
                    dt = db.ExecuteReaderQuery(
                        @"select(p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,
                        Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
                        JOIN Produto p on p.Id=pa.IdProduto
                        JOIN Categoria c on c.id =pa.idCategoria
                        JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
                        where categoria like '%" + Prod.ToUpper() + "%' " +
                        " and s.Subdivisao='" + text + "' " +
                        " and pa.idPrefeitura=" + idPrefeitura + " order by Produto");
                }
                else
                {
                    if (text != "")
                    {
                        dt = db.ExecuteReaderQuery(
                            @"select (p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,
                        Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
                        JOIN Produto p on p.Id=pa.IdProduto
                        JOIN Categoria c on c.id =pa.idCategoria
                        JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
                        where categoria='" + Prod.ToUpper() + "' " +
                        " and s.Subdivisao='" + text + "' " +
                        " and pa.idPrefeitura=" + idPrefeitura + " " +
                        " and idSubdivisao=" + idSub + " order by Produto");
                    }
                    else
                    {
                        dt = db.ExecuteReaderQuery(
                            @"select (p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,
                        Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
                        JOIN Produto p on p.Id=pa.IdProduto
                        JOIN Categoria c on c.id =pa.idCategoria
                        JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
                        where categoria='" + Prod.ToUpper() + "' " +
                        " and pa.idPrefeitura=" + idPrefeitura + " " +
                        " and idSubdivisao=" + idSub + " order by Produto");
                    }
                }
            }

            List<ListaMateriais> lstProd = new List<ListaMateriais>();
            foreach (DataRow item in dt.Rows)
            {
                lstProd.Add(new ListaMateriais
                {
                    idSub = item["IdSubdivisao"].ToString(),
                    idPatrimonio = item["IdPatrimonio"].ToString(),
                    Produto = item["Produto"].ToString(),
                    NmrPatrimonio = item["NumeroPatrimonio"].ToString(),
                    Subdivisao = item["Subdivisao"].ToString(),
                    Endereco = item["Endereco"].ToString()
                });
            }

            return lstProd;
        }

        [WebMethod]
        public List<ListaMateriais> getSubMestre(string idPrefeitura, string Endereco, string IdLocal, string text)
        {
            List<ListaMateriais> lstProdutos = new List<ListaMateriais>();
            if (IdLocal == "true")
            {
                dt = db.ExecuteReaderQuery(
                    @"Select s.Id,Subdivisao,s.Endereco,p.modelo from Subdivisao_Departamento s
                    join Departamento d on d.Id= s.IdDepartamento
                    JOIN PatrimonioSemaforo ps on ps.IdSubdivisao=s.Id
                    JOIN Patrimonio p on p.IdPatrimonio= ps.IdPatrimonio
                    where p.IdPrefeitura=" + idPrefeitura + " " +
                    " and s.Subdivisao='" + text + "' " +
                    " and ps.FormaOperacional='MESTRE'");
            }
            if (Endereco == "true")
            {
                dt = db.ExecuteReaderQuery(
                    @"Select s.Id,Subdivisao,s.Endereco,p.modelo from Subdivisao_Departamento s
                    join Departamento d on d.Id= s.IdDepartamento
                    JOIN PatrimonioSemaforo ps on ps.IdSubdivisao=s.Id
                    JOIN Patrimonio p on p.IdPatrimonio= ps.IdPatrimonio
                    where p.IdPrefeitura=" + idPrefeitura + " " +
                    " and s.Endereco='" + text + "' " +
                    " and ps.FormaOperacional='MESTRE'");
            }
            foreach (DataRow item in dt.Rows)
            {
                lstProdutos.Add(new ListaMateriais
                {
                    idSub = item["Id"].ToString(),
                    Subdivisao = item["Subdivisao"].ToString(),
                    Endereco = item["Endereco"].ToString(),
                    Modelo = item["Modelo"].ToString()
                });
            }

            return lstProdutos;
        }

        [WebMethod]
        public List<ListaMateriais> getIdDNA(string idPrefeitura, string Subdivisao, string end)
        {
            if (Subdivisao == "")
            {
                dt = db.ExecuteReaderQuery(
                    @"Select s.Id,Subdivisao,s.Endereco from Subdivisao_Departamento s
                    join Departamento d on d.Id= s.IdDepartamento
                    where IdPrefeitura=" + idPrefeitura + " and s.Endereco like '%"+end+"%'");
            }
            else
            {
                dt = db.ExecuteReaderQuery(
                    @"Select s.Id,Subdivisao,s.Endereco from Subdivisao_Departamento s
                    join Departamento d on d.Id= s.IdDepartamento
                    where IdPrefeitura=" + idPrefeitura + " " +
                    " and Subdivisao like'%" + Subdivisao + "%'");
            }

            List<ListaMateriais> lstProdutos = new List<ListaMateriais>();
            foreach (DataRow item in dt.Rows)
            {
                lstProdutos.Add(new ListaMateriais
                {
                    idSub = item["Id"].ToString(),
                    Subdivisao = item["Subdivisao"].ToString(),
                    Endereco = item["Endereco"].ToString()
                });
            }

            return lstProdutos;
        }

        [WebMethod]
        public List<ListaMateriais> getEndereco(string idPrefeitura)
        {
            List<ListaMateriais> lstProdutos = new List<ListaMateriais>();
            dt = db.ExecuteReaderQuery(
                @"Select s.Id,s.Endereco,s.Subdivisao from Subdivisao_Departamento s
                join Departamento d on d.Id= s.IdDepartamento
                where IdPrefeitura=" + idPrefeitura);
            foreach (DataRow item in dt.Rows)
            {
                lstProdutos.Add(new ListaMateriais
                {
                    idSub = item["Id"].ToString(),
                    Endereco = item["Endereco"].ToString(),
                    Subdivisao = item["Subdivisao"].ToString()
                });
            }

            return lstProdutos;
        }

        [WebMethod]
        public List<string> findControllers(string idPrefeitura, string idLocal, string Endereco, string idDepartamento, string idSub)
        {
            List<string> lst = new List<string>();

            string idSubMestre = db.ExecuteScalarQuery(
                @"select idSubControladorMestre from SUbdivisao_Departamento " +
                " where id=" + idSub);
            if (idSubMestre == "" || idSubMestre=="0")
            {
                string sql = @"select NumeroSerie,modelo,p.IdPatrimonio,ps.idMestre,s.idDepartamento, 
                             NumeroPatrimonio,FormaOperacional,ps.id idPatSem from Patrimonio p
                             JOIN PatrimonioSemaforo ps on ps.IdPatrimonio = p.IdPatrimonio
                             JOIN Subdivisao_Departamento s on ps.IdSubdivisao=s.Id and p.idSubDivisao=s.Id
                             JOIN Categoria c on p.idCategoria = c.id
                             where p.idPrefeitura=" + idPrefeitura + " " +
                             " and  categoria='CONTROLADOR' " +
                             " and s.Endereco='" + Endereco + "' " +
                             " and isnull(p.Status,'') NOT IN ('REMOVIDO','INATIVO') ";
                if (idLocal != "")
                {
                    sql += " and s.Subdivisao='" + idLocal + "'";
                }

                dt = db.ExecuteReaderQuery(sql);
                if (dt.Rows.Count > 0)
                {
                    DataRow drCtrl = dt.Rows[0];

                    if (drCtrl["FormaOperacional"].ToString() != "")
                    {
                        if (drCtrl["FormaOperacional"].ToString() == "CONJUGADO")
                        {
                            dt = db.ExecuteReaderQuery(
                                @"Select s.Id,Subdivisao,p.modelo from Subdivisao_Departamento s
                                join Departamento d on d.Id= s.IdDepartamento
                                JOIN PatrimonioSemaforo ps on ps.IdSubdivisao=s.Id
                                JOIN Patrimonio p on p.IdPatrimonio= ps.IdPatrimonio
                                where ps.Id=" + drCtrl["idMestre"].ToString());
                            if (dt.Rows.Count > 0)
                            {
                                DataRow drConj = dt.Rows[0];
                                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}",
                                    "Conjugado",
                                    drCtrl["IdPatrimonio"].ToString(),
                                    drCtrl["idDepartamento"].ToString(),
                                    drCtrl["NumeroSerie"].ToString(),
                                    drCtrl["NumeroPatrimonio"].ToString(),
                                    drCtrl["Modelo"].ToString(),
                                    drConj["Subdivisao"].ToString(),
                                    drConj["Modelo"].ToString()
                                    ));
                            }
                            else
                            {
                                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}",
                                    "Conjugado",
                                    drCtrl["IdPatrimonio"].ToString(),
                                    drCtrl["idDepartamento"].ToString(),
                                    drCtrl["NumeroSerie"].ToString(),
                                    drCtrl["NumeroPatrimonio"].ToString(),
                                    drCtrl["Modelo"].ToString()
                                    ));
                            }
                        }
                        else if (drCtrl["FormaOperacional"].ToString() == "MESTRE")
                        {
                            dt = db.ExecuteReaderQuery(
                                @"Select s.Id,Subdivisao,s.Endereco from Subdivisao_Departamento s
                                join Departamento d on d.Id= s.IdDepartamento
                                where s.idSubControladorMestre=" + idSub);
                            if (dt.Rows.Count > 0)
                            {
                                foreach (DataRow drMestre in dt.Rows)
                                {
                                    lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}",
                                        "Mestre",
                                        drCtrl["IdPatrimonio"].ToString(),
                                        drCtrl["idDepartamento"].ToString(),
                                        drCtrl["NumeroSerie"].ToString(),
                                        drCtrl["NumeroPatrimonio"].ToString(),
                                        drCtrl["Modelo"].ToString(),
                                        drMestre["Id"].ToString(),
                                        drMestre["Endereco"].ToString(),
                                        drMestre["Subdivisao"].ToString()
                                        ));
                                }
                            }
                            else
                            {
                                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}",
                                    "Mestre",
                                    drCtrl["IdPatrimonio"].ToString(),
                                    drCtrl["idDepartamento"].ToString(),
                                    drCtrl["NumeroSerie"].ToString(),
                                    drCtrl["NumeroPatrimonio"].ToString(),
                                    drCtrl["Modelo"].ToString()
                                    ));
                            }
                        }
                        else
                        {
                            lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}",
                                "Isolado",
                                drCtrl["IdPatrimonio"].ToString(),
                                drCtrl["idDepartamento"].ToString(),
                                drCtrl["NumeroSerie"].ToString(),
                                drCtrl["NumeroPatrimonio"].ToString(),
                                drCtrl["Modelo"].ToString()
                                ));
                        }
                    }
                }
            }
            else
            {
                dt = db.ExecuteReaderQuery(
                    @"SELECT (Subdivisao + ' - ' + Endereco)Mestre,IdDepartamento " +
                    " FROM Subdivisao_Departamento WHERE id=" + idSubMestre);

                if (dt.Rows.Count > 0)
                {
                    DataRow item = dt.Rows[0];
                    lst.Add(string.Format("{0}@{1}@{2}",
                        "Conjugado",
                        item["Mestre"].ToString(),
                        item["IdDepartamento"].ToString()
                        ));
                }
            }

            return lst;
        }

        [WebMethod]
        public List<string> findPlacaCtrl(string idDepartamento, string idSub)
        {
            List<string> lst = new List<string>();

            string sql = @"SELECT p.NomeProduto,p.IdPatrimonio Id,ps.id idsemaforo, 
                         p.modelo,t.Dsc,p.Fabricante,NumeroPatrimonio FROM Patrimonio 
                         p join TipoProduto t on p.IdTipoProduto = t.IdTipoProduto 
                         JOIN PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio 
                         JOIN Categoria c on p.idCategoria=c.id 
                         WHERE c.categoria like'%Placa%' 
                         AND p.IdDepartamento=" + idDepartamento + " " +
                         " AND p.idSubDivisao='" + idSub + "' " +
                         " AND isnull(p.Status,'') " +
                         " NOT IN ('REMOVIDO','INATIVO') " +
                         " order by Fabricante,Modelo,NumeroPatrimonio";

            dt = db.ExecuteReaderQuery(sql);

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}",
                    item["NomeProduto"].ToString(),
                    item["modelo"].ToString(),
                    item["Fabricante"].ToString(),
                    item["NumeroPatrimonio"].ToString(),
                    item["Id"].ToString(),
                    item["idsemaforo"].ToString()
                    ));
            }

            return lst;
        }

        [WebMethod]
        public List<string> findGprsCtrl(string idPrefeitura, string idSub)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(
                @"SELECT ps.IdPatrimonio,p.DataGarantia,ps.[DataInstalacao],p.Fabricante, 
                p.Modelo,ps.[NmrDaLinha],p.NumeroPatrimonio,
                p.NumeroSerie,ps.[EstadoOperacional],ps.[Operadora] FROM PatrimonioSemaforo ps
                LEFT JOIN  Patrimonio p on p.IdPatrimonio = ps.IdPatrimonio 
                JOIN produto pd on pd.id = p.idProduto
                WHERE ps.IdSubdivisao=" + idSub + " " +
                " AND p.idPrefeitura=" + idPrefeitura + " " +
                " AND isnull(Operadora,'')<>'' " +
                " AND isnull(p.Status,'') NOT IN ('REMOVIDO','INATIVO')");
            if (dt.Rows.Count > 0)
            {
                DataRow item = dt.Rows[0];
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}@{9}",
                    item["IdPatrimonio"].ToString(),
                    item["DataGarantia"].ToString(),
                    item["DataInstalacao"].ToString(),
                    item["Fabricante"].ToString(),
                    item["Modelo"].ToString(),
                    item["NmrDaLinha"].ToString(),
                    item["NumeroPatrimonio"].ToString(),
                    item["NumeroSerie"].ToString(),
                    item["EstadoOperacional"].ToString(),
                    item["Operadora"].ToString()
                    ));
            }

            return lst;
        }

        [WebMethod]
        public List<string> findNobreak(string idPrefeitura, string idSub)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(
                @"select NumeroPatrimonio,Fabricante,modelo,DiretorioNotaFiscal,
                p.idPatrimonio,DataInstalacao,DataGarantia,Autonomia,Potencia,
                Fixacao,EstadoOperacional,Monitoracao from Patrimonio p
                join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio
                join Categoria c on p.idCategoria=c.id 
                where c.categoria like'%NOBREAK%' 
                and ps.IdSubdivisao=" + idSub + " " +
                " and p.idPrefeitura=" + idPrefeitura + " " +
                " and isnull(p.Status,'') NOT IN ('REMOVIDO','INATIVO') " +
                " order by Fabricante,Modelo,NumeroPatrimonio");
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}@{9}@{10}", dr["IdPatrimonio"].ToString(),
                    dr["Autonomia"].ToString(), dr["DataGarantia"].ToString(), dr["Fabricante"].ToString(), dr["DataInstalacao"].ToString(),
                    dr["Modelo"].ToString(), dr["NumeroPatrimonio"].ToString(), dr["Potencia"].ToString(), dr["EstadoOperacional"].ToString(),
                    dr["Fixacao"].ToString(), dr["Monitoracao"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public List<string> findGprsNbrk(string idPrefeitura, string idSub)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NumeroPatrimonio,Fabricante,NumeroSerie,DataInstalacao,p.idPatrimonio,DataGarantia,NmrDaLinha,Modelo,Operadora,EstadoOperacional
 from Patrimonio p
join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio
join Categoria c on p.idCategoria=c.id where c.categoria like'%GPRS%' and PertencePatrimonio='NOBREAK' 
and ps.IdSubdivisao=" + idSub + " and p.idPrefeitura=" + idPrefeitura + " AND isnull(p.Status,'') NOT IN ('REMOVIDO','INATIVO') order by Fabricante,Modelo,NumeroPatrimonio");
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}", dr["IdPatrimonio"].ToString(),
                    dr["Fabricante"].ToString(), dr["NumeroPatrimonio"].ToString(), dr["NmrDaLinha"].ToString(), dr["DataGarantia"].ToString(),
                    dr["DataInstalacao"].ToString(), dr["Modelo"].ToString(), dr["Operadora"].ToString(), dr["EstadoOperacional"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public List<string> findColuna(string idPrefeitura, string idSub)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto,Modelo,EstadoOperacional,ps.id,NumeroPatrimonio from Patrimonio p
join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio
join Categoria c on p.idCategoria=c.id where c.categoria like'%COLUNA%' and ps.IdSubdivisao=" + idSub + " and p.idPrefeitura=" + idPrefeitura + " AND isnull(p.Status,'') <> 'REMOVIDO' order by NomeProduto,Fabricante,Modelo,NumeroPatrimonio");
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}", item["id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(),
                    item["EstadoOperacional"].ToString(), item["NumeroPatrimonio"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> findCabo(string idPrefeitura, string idSub)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto, Fabricante,Modelo,NumeroPatrimonio,p.QtdUni ,ps.id from Patrimonio p
join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio
join Categoria c on p.idCategoria=c.id where c.categoria like'%CABO%' and ps.IdSubdivisao=" + idSub + " and p.idPrefeitura=" + idPrefeitura + " AND isnull(p.Status,'') <> 'REMOVIDO' order by NomeProduto,Fabricante,Modelo,NumeroPatrimonio");
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}", item["id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(),
                    item["Fabricante"].ToString(), item["QtdUni"].ToString(), item["NumeroPatrimonio"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> findGrupoFocal(string idPrefeitura, string idSub)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto,p.Fabricante,Modelo,EstadoOperacional,NumeroPatrimonio,ps.id from Patrimonio p
join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio
join Categoria c on p.idCategoria=c.id where c.categoria like'%GRUPO FOCAL%' and ps.IdSubdivisao=" + idSub + " and p.idPrefeitura=" + idPrefeitura + " AND isnull(p.Status,'') <> 'REMOVIDO' order by NomeProduto,Fabricante,Modelo,NumeroPatrimonio");

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}", item["id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(),
                    item["Fabricante"].ToString(), item["EstadoOperacional"].ToString(), item["NumeroPatrimonio"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> findSistemaIlu(string idPrefeitura, string idSub)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto,p.Fabricante,Modelo,isnull(EstadoOperacional,'') EstadoOperacional,NumeroPatrimonio,ps.id from Patrimonio p
join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio
join Categoria c on p.idCategoria=c.id where c.categoria like'%Iluminação%' and ps.IdSubdivisao=" + idSub + " and p.idPrefeitura=" + idPrefeitura +
    " or categoria like '%Iluminacao%'  and ps.IdSubdivisao=" + idSub + " and p.idPrefeitura=" + idPrefeitura + " AND isnull(p.Status,'') <> 'REMOVIDO' order by  NomeProduto,Fabricante,Modelo,NumeroPatrimonio");

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}", item["id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(),
                    item["Fabricante"].ToString(), item["EstadoOperacional"].ToString(), item["NumeroPatrimonio"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> findAcessorio(string idPrefeitura, string idSub)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto, Fabricante,Modelo,NumeroPatrimonio,ps.id from Patrimonio p join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio
join Categoria c on p.idCategoria=c.id where c.categoria like'%Acessorio%' and ps.IdSubdivisao=" + idSub + " and p.idPrefeitura=" + idPrefeitura +
    " AND isnull(p.Status,'') <> 'REMOVIDO' order by NomeProduto,Fabricante,Modelo,NumeroPatrimonio");

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}", item["id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(),
                    item["Fabricante"].ToString(), item["NumeroPatrimonio"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> findTag(string EPC, string idPrefeitura, string idsubdivisao)
        {
            string sql = "";

            sql = "select Id,Tag from TagsCruzamento where idsubdivisao=" + idsubdivisao + " and idPrefeitura=" + idPrefeitura;
            if (!string.IsNullOrEmpty(EPC))
            {
                sql += " and Tag='" + EPC + "'";
            }
            dt = db.ExecuteReaderQuery(sql);
            List<string> lst = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}", item["Id"].ToString(), item["Tag"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> DetalhesCtrl(string idPrefeitura, string idsubdivisao,
            string Endereco, string IdLocal, string Detalhes)
        {
            string sql = "";
            List<string> lst = new List<string>();
            if (Detalhes == "Controlador")
            {
                #region Controlador
                sql = @"SELECT NomeProduto,NumeroSerie,modelo,marca,p.IdPatrimonio,ps.idMestre,
                      s.idDepartamento,NumeroPatrimonio,Fabricante,DataInstalacao,DataGarantia,
                      CapacidadeFasesSuportadas,CapacidadeFasesInstaladas,
                      Tipo=(select Dsc from tipoProduto tp where p.idTipoProduto=tp.IdTipoProduto),
                      modelo,Fixacao,TensaoEntrada,TensaoSaida,EstadoOperacional,FormaOperacional,ps.id idPatSem,
                      Fornecedor=(select RazaoSocial from Fornecedor f where f.id = p.idFornecedor) from patrimonio p 
                      JOIN PatrimonioSemaforo ps on ps.IdPatrimonio = p.IdPatrimonio
                      JOIN Subdivisao_Departamento s on ps.IdSubdivisao=s.Id and p.idSubDivisao=s.Id
                      JOIN Categoria c on p.idCategoria = c.id
                      WHERE p.idPrefeitura=" + idPrefeitura + " " +
                      " AND  categoria='CONTROLADOR' " +
                      " AND s.Endereco='" + Endereco + "' " +
                      " AND isnull(p.Status,'') NOT IN ('REMOVIDO','INATIVO')";
                if (IdLocal != "")
                {
                    sql += " and s.Subdivisao='" + IdLocal + "'";
                }
                dt = db.ExecuteReaderQuery(sql);
                if (dt.Rows.Count > 0)
                {
                    #region Dados Controlador
                    DataRow drCtrl = dt.Rows[0];
                    lst.Add(string.Format(
                        "{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}@{9}@{10}@{11}@{12}@{13}@{14}@{15}@{16}@{17}",
                         drCtrl["IdPatrimonio"].ToString(),
                         drCtrl["idDepartamento"].ToString(),
                         drCtrl["CapacidadeFasesSuportadas"].ToString(),
                         drCtrl["NomeProduto"].ToString(),
                         drCtrl["FormaOperacional"].ToString(),
                         drCtrl["Fixacao"].ToString(),
                         drCtrl["NumeroSerie"].ToString(),
                         drCtrl["NumeroPatrimonio"].ToString(),
                         drCtrl["DataGarantia"].ToString(),
                         drCtrl["DataInstalacao"].ToString(),
                         drCtrl["Fabricante"].ToString(),
                         drCtrl["Modelo"].ToString(),
                         drCtrl["Tipo"].ToString(),
                         drCtrl["TensaoEntrada"].ToString(),
                         drCtrl["TensaoSaida"].ToString(),
                         drCtrl["CapacidadeFasesSuportadas"].ToString(),
                         drCtrl["CapacidadeFasesInstaladas"].ToString(),
                         drCtrl["EstadoOperacional"].ToString()
                         ));

                    if (drCtrl["FormaOperacional"].ToString() != "")
                    {
                        if (drCtrl["FormaOperacional"].ToString() == "Conjugado")
                        {
                            dt = db.ExecuteReaderQuery(
                                @"SELECT s.Id,Subdivisao,p.modelo from Subdivisao_Departamento s
                                JOIN Departamento d on d.Id= s.IdDepartamento
                                JOIN PatrimonioSemaforo ps on ps.IdSubdivisao=s.Id
                                JOIN Patrimonio p on p.IdPatrimonio= ps.IdPatrimonio
                                WHERE ps.Id=" + drCtrl["idMestre"].ToString()
                                );

                            if (dt.Rows.Count > 0)
                            {
                                DataRow drCnj = dt.Rows[0];
                                lst.Clear();
                                lst.Add(string.Format(
                                    "{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}@{9}@{10}@{11}@{12}@{13}@{14}@{15}@{16}@{17}@{18}@{19}",
                                     drCtrl["IdPatrimonio"].ToString(),
                                     drCtrl["idDepartamento"].ToString(),
                                     drCtrl["CapacidadeFasesSuportadas"].ToString(),
                                     drCtrl["NomeProduto"].ToString(),
                                     drCtrl["FormaOperacional"].ToString(),
                                     drCtrl["Fixacao"].ToString(),
                                     drCtrl["NumeroSerie"].ToString(),
                                     drCtrl["NumeroPatrimonio"].ToString(),
                                     drCtrl["DataGarantia"].ToString(),
                                     drCtrl["DataInstalacao"].ToString(),
                                     drCtrl["Fabricante"].ToString(),
                                     drCtrl["Modelo"].ToString(),
                                     drCtrl["Tipo"].ToString(),
                                     drCtrl["TensaoEntrada"].ToString(),
                                     drCtrl["TensaoSaida"].ToString(),
                                     drCtrl["CapacidadeFasesSuportadas"].ToString(),
                                     drCtrl["CapacidadeFasesInstaladas"].ToString(),
                                     drCtrl["EstadoOperacional"].ToString(),
                                     drCnj["Subdivisao"].ToString(),
                                     drCnj["modelo"].ToString()
                                     ));
                            }
                        }
                        else if (drCtrl["FormaOperacional"].ToString() == "Mestre")
                        {

                            dt = db.ExecuteReaderQuery(
                                @"SELECT s.Id,Subdivisao,s.Endereco from Subdivisao_Departamento s
                                JOIN Departamento d on d.Id= s.IdDepartamento
                                JOIN PatrimonioSemaforo ps on ps.IdSubdivisao=s.Id
                                WHERE ps.IdMestre=" + drCtrl["idPatSem"].ToString() + " " +
                                " AND FormaOperacional='CONJUGADO'"
                                );

                            if (dt.Rows.Count > 0)
                            {
                                lst.Clear();
                                foreach (DataRow drMestre in dt.Rows)
                                {
                                    lst.Add(string.Format(
                                        "{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}@{9}@{10}@{11}@{12}@{13}@{14}@{15}@{16}@{17}@{18}@{19}@{20}",
                                         drCtrl["IdPatrimonio"].ToString(),
                                         drCtrl["idDepartamento"].ToString(),
                                         drCtrl["CapacidadeFasesSuportadas"].ToString(),
                                         drCtrl["NomeProduto"].ToString(),
                                         drCtrl["FormaOperacional"].ToString(),
                                         drCtrl["Fixacao"].ToString(),
                                         drCtrl["NumeroSerie"].ToString(),
                                         drCtrl["NumeroPatrimonio"].ToString(),
                                         drCtrl["DataGarantia"].ToString(),
                                         drCtrl["DataInstalacao"].ToString(),
                                         drCtrl["Fabricante"].ToString(),
                                         drCtrl["Modelo"].ToString(),
                                         drCtrl["Tipo"].ToString(),
                                         drCtrl["TensaoEntrada"].ToString(),
                                         drCtrl["TensaoSaida"].ToString(),
                                         drCtrl["CapacidadeFasesSuportadas"].ToString(),
                                         drCtrl["CapacidadeFasesInstaladas"].ToString(),
                                         drCtrl["EstadoOperacional"].ToString(),
                                         drMestre["Id"].ToString(),
                                         drMestre["Subdivisao"].ToString(),
                                         drMestre["Endereco"].ToString()
                                         ));
                                }
                            }
                        }
                    }
                    #endregion
                }
                #endregion
            }
            else
            {
                string modeloMestre = db.ExecuteScalarQuery(
                    "SELECT (Subdivisao + ' - ' + Endereco) " +
                    " FROM Subdivisao_Departamento " +
                    " WHERE id=" + idsubdivisao
                    );

                lst.Add(string.Format(
                    "{0}",
                    modeloMestre
                    ));
            }

            return lst;
        }

        [WebMethod]
        public List<string> getControllers(string idPrefeitura)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(
                @"select NomeProduto,Modelo,f.RazaoSocial Fabricante,p.Id from Produto p
                JOIN Fabricante f on p.IdFabricante = f.id
                JOIN Categoria c on c.id=p.IdCategoria
                where categoria='CONTROLADOR'");

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}",
                    item["Id"].ToString(),
                    item["NomeProduto"].ToString(),
                    item["Modelo"].ToString(),
                    item["Fabricante"].ToString()
                    ));
            }

            return lst;
        }

        [WebMethod]
        public List<string> SelectCadControllers(string idProduto)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(
                @"select p.NomeProduto,p.Modelo,p.NumeroSerie,f.RazaoSocial Fabricante,tp.Dsc from Produto p
                JOIN TipoProduto tp on p.IdTipoProduto = tp.IdTipoProduto
                JOIN Fabricante f on p.IdFabricante = f.id
                JOIN Categoria c on c.id = p.IdCategoria where p.Id=" + idProduto);

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}",
                    item["NomeProduto"].ToString(),
                    item["Modelo"].ToString(),
                    item["Fabricante"].ToString(),
                    item["NumeroSerie"].ToString(),
                    item["Dsc"].ToString()
                    ));
            }

            return lst;
        }

        [WebMethod]
        public List<string> SelectPlacaControllers(string idPatrimonio)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select p.NomeProduto,p.Modelo,fabricante,DataGarantia,DataInstalacao,EstadoOperacional,pd.id idProduto,p.NumeroSerie,p.NumeroPatrimonio,p.IdPatrimonio from Patrimonio p
JOIN Produto pd on pd.id = p.IdProduto 
JOIN Categoria c on c.id=p.IdCategoria
JOIN PatrimonioSemaforo ps on ps.IdPatrimonio = p.IdPatrimonio
where categoria='PLACA' and p.IdPatrimonio=" + idPatrimonio);

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}", item["idProduto"].ToString(), item["fabricante"].ToString(), item["Modelo"].ToString(),
                    item["DataInstalacao"].ToString(), item["DataGarantia"].ToString(), item["NumeroPatrimonio"].ToString(), item["EstadoOperacional"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> getPlacaControllers(string idPrefeitura, string IdPatrimonio)
        {
            List<string> lst = new List<string>();

            string IdProduto = db.ExecuteScalarQuery(
                "SELECT IdProduto FROM Patrimonio " +
                " WHERE IdPatrimonio = " + IdPatrimonio
                );

            dt = db.ExecuteReaderQuery(
                @"Select NomeProduto,Modelo,f.RazaoSocial Fabricante,p.Id 
                FROM PlacasControlador Pc
                JOIN Produto p ON P.Id = Pc.idProdutoPlaca
                JOIN Fabricante f on p.IdFabricante = f.Id
                WHERE IdProdutoControlador = " + IdProduto + " " +
                " order by Fabricante,Modelo");

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format(
                    "{0}@{1}@{2}@{3}",
                    item["Id"].ToString(),
                    item["NomeProduto"].ToString(),
                    item["Modelo"].ToString(),
                    item["Fabricante"].ToString()
                    ));
            }

            return lst;
        }

        [WebMethod]
        public List<string> verificaNrPat(string idPrefeitura, string nmrPatrimonio, string NmrPat)
        {
            List<string> lst = new List<string>();
            dt = db.ExecuteReaderQuery(
                "SELECT idPatrimonio FROM Patrimonio " +
                " WHERE NumeroPatrimonio BETWEEN " + nmrPatrimonio + " " +
                " AND " + (int.Parse(NmrPat) - 1) + " " +
                " AND idPrefeitura=" + idPrefeitura
                );
            if (dt.Rows.Count > 0)
            {
                lst.Add(string.Format(
                    "{0}",
                    "alert"
                    ));
            }

            return lst;
        }

        [WebMethod]
        public void InsertPlacaCtrl(string idPrefeitura, string idProduto, string NmrPat,
            int quantidade, string DataGarantia, string Fabricante, string IdDepartamento,
            string idSubDivisao, string modelo, string NumeroSerie, string idPatrimonio,
            string DataInstalacao, string EstadoOperacional)
        {
            int i = 0;

            dt = db.ExecuteReaderQuery(
                @"SELECT p.*,tp.Dsc from Produto p
                JOIN TipoProduto tp on p.IdTipoProduto = tp.IdTipoProduto
                JOIN Categoria c on c.id = p.IdCategoria
                WHERE p.Id=" + idProduto
                );
            if (NmrPat != "")
            {
                int numeroPat = int.Parse(NmrPat);
                while (quantidade > i)
                {
                    if (dt.Rows.Count > 0)
                    {
                        DataRow dr = dt.Rows[0];
                        idPatrimonio = db.ExecuteScalarQuery(
                            @"INSERT INTO Patrimonio (DataGarantia,Fabricante,idCategoria,
                            IdDepartamento,idPrefeitura,IdProduto,idSubDivisao,IdTipoProduto,
                            modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,Dthr) 
                            VALUES ('" + DataGarantia + "','" + Fabricante + "', " +
                            " " + dr["idCategoria"].ToString() + "," + IdDepartamento + ", " +
                            " " + idPrefeitura + "," + idProduto + ",'" + idSubDivisao + "', " +
                            " " + dr["idtipoProduto"].ToString() + ",'" + modelo + "', " +
                            " '" + dr["NomeProduto"].ToString() + "','" + NumeroSerie + "', " +
                            " '" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "', " +
                            " '" + numeroPat + "','" + DateTime.Now + "') " +
                            " SELECT SCOPE_IDENTITY()"
                            );

                        db.ExecuteNonQuery(
                            @"INSERT INTO PatrimonioSemaforo(IdPatrimonio,IdDepartamento,
                            IdSubdivisao,DataInstalacao,EstadoOperacional)
                            VALUES(" + idPatrimonio + ",'" + IdDepartamento + "', " +
                            " '" + idSubDivisao + "','" + DataInstalacao + "', " +
                            " '" + EstadoOperacional + "')"
                            );
                    }

                    i++;
                    numeroPat++;
                }
            }
            else
            {
                while (quantidade > i)
                {
                    if (dt.Rows.Count > 0)
                    {
                        DataRow dr = dt.Rows[0];
                        idPatrimonio = db.ExecuteScalarQuery(
                            @"INSERT INTO Patrimonio (DataGarantia,Fabricante,idCategoria,
                            IdDepartamento,idPrefeitura,IdProduto,idSubDivisao,IdTipoProduto,
                            modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,Dthr)
                            VALUES ('" + DataGarantia + "','" + Fabricante + "', " +
                            " " + dr["idCategoria"].ToString() + "," + IdDepartamento + ", " +
                            " " + idPrefeitura + "," + idProduto + ",'" + idSubDivisao + "', " +
                            " " + dr["idtipoProduto"].ToString() + ",'" + modelo + "', " +
                            " '" + dr["NomeProduto"].ToString() + "','" + NumeroSerie + "', " +
                            " '" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "', " +
                            " '','" + DateTime.Now + "') " +
                            " SELECT SCOPE_IDENTITY()"
                            );

                        db.ExecuteNonQuery(
                            @"INSERT INTO PatrimonioSemaforo(IdPatrimonio,IdDepartamento,
                            IdSubdivisao,DataInstalacao,EstadoOperacional)
                            VALUES(" + idPatrimonio + ",'" + IdDepartamento + "', " +
                            " '" + idSubDivisao + "','" + DataInstalacao + "', " +
                            " '" + EstadoOperacional + "')"
                            );
                    }

                    i++;
                }
            }
        }

        [WebMethod]
        public void EditPlacaCtrl(string idPrefeitura, string NumeroPatrimonio,
            string DataGarantia, string idPatrimonio, string DataInstalacao,
            string EstadoOperacional)
        {

            db.ExecuteNonQuery(
                @"UPDATE Patrimonio SET NumeroPatrimonio='" + NumeroPatrimonio + "', " +
                " DataGarantia='" + DataGarantia + "', DtHr='" + DateTime.Now + "' " +
                " WHERE idPatrimonio=" + idPatrimonio
                );

            db.ExecuteNonQuery(
                @"UPDATE PatrimonioSemaforo SET DataInstalacao='" + DataInstalacao + "', " +
                " EstadoOperacional='" + EstadoOperacional + "' " +
                " WHERE IdPatrimonio=" + idPatrimonio
                );
        }

        [WebMethod]
        public List<string> validaNrPat(string idPrefeitura, string nmrPatrimonio,
            string idPatrimonio, string value)
        {
            List<string> lst = new List<string>();
            if (nmrPatrimonio != "")
            {
                if (value == "Salvar Alterações")
                {
                    dt = db.ExecuteReaderQuery(
                        @"select IdPatrimonio from Patrimonio 
                        where NumeroPatrimonio='" + nmrPatrimonio + "' " +
                        " and idPrefeitura=" + idPrefeitura + " " +
                        " and IdPatrimonio <>" + idPatrimonio
                        );
                }
                else
                {
                    dt = db.ExecuteReaderQuery(
                        @"select IdPatrimonio from Patrimonio 
                        where NumeroPatrimonio='" + nmrPatrimonio + "' " +
                        " and idPrefeitura=" + idPrefeitura
                        );
                }

                if (dt.Rows.Count > 0)
                {
                    DataRow item = dt.Rows[0];

                    lst.Add(string.Format("{0}", "Alert"));
                }
            }

            return lst;
        }

        [WebMethod]
        public void EditCtrl(string idPrefeitura, string nmrPatrimonio, string DataGarantia,
            string idPatriomonio, string Fixacao, string DataInstalacao, string TensaoEntrada,
            string TensaoSaida, string CapacidadeFasesSuportadas, string CapacidadeFasesInstaladas,
            string EstadoOperacional, string FormaOperacional, string IdDepartamento, string IdSubdivisao)
        {

            db.ExecuteNonQuery(
                @"update Patrimonio set NumeroPatrimonio='" + nmrPatrimonio + "', " +
                " DataGarantia='" + DataGarantia + "',DtHr='" + DateTime.Now + "' " +
                " where idPatrimonio=" + idPatriomonio
                );

            if (IdSubdivisao != "")
            {
                db.ExecuteNonQuery(
                    @"Update PatrimonioSemaforo set Fixacao='" + Fixacao + "', " +
                    " DataInstalacao='" + DataInstalacao + "', " +
                    " TensaoEntrada='" + TensaoEntrada + "', " +
                    " TensaoSaida='" + TensaoSaida + "', " +
                    " CapacidadeFasesSuportadas='" + CapacidadeFasesSuportadas + "', " +
                    " CapacidadeFasesInstaladas='" + CapacidadeFasesInstaladas + "', " +
                    " EstadoOperacional='" + EstadoOperacional + "', " +
                    " FormaOperacional='" + FormaOperacional + "', " +
                    " IdDepartamento='" + IdDepartamento + "', " +
                    " IdSubdivisao='" + IdSubdivisao + "' " +
                    " where IdPatrimonio=" + idPatriomonio
                    );
            }
            else
            {
                db.ExecuteNonQuery(
                    @"Update PatrimonioSemaforo set Fixacao='" + Fixacao + "', " +
                    " DataInstalacao='" + DataInstalacao + "', " +
                    " TensaoEntrada='" + TensaoEntrada + "', " +
                    " TensaoSaida='" + TensaoSaida + "', " +
                    " CapacidadeFasesSuportadas='" + CapacidadeFasesSuportadas + "', " +
                    " CapacidadeFasesInstaladas='" + CapacidadeFasesInstaladas + "', " +
                    " EstadoOperacional='" + EstadoOperacional + "', " +
                    " FormaOperacional='" + FormaOperacional + "', " +
                    " IdDepartamento='" + IdDepartamento + "' " +
                    " where IdPatrimonio=" + idPatriomonio
                    );
            }
        }

        [WebMethod]
        public List<string> InsertProdPatrimonio(string DataGarantia, string Fabricante,
            string IdDepartamento, string idPrefeitura, string IdProduto,
            string idSubDivisao, string modelo, string NumeroSerie, string NumeroPatrimonio)
        {
            List<string> lst = new List<string>();
            string idPatrimonio = "";
            dt = db.ExecuteReaderQuery(
                @"select p.*,tp.Dsc from Produto p
                JOIN TipoProduto tp on p.IdTipoProduto = tp.IdTipoProduto
                JOIN Categoria c on c.id = p.IdCategoria 
                where p.Id=" + IdProduto
                );

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                idPatrimonio = db.ExecuteScalarQuery(
                    @"insert into Patrimonio (DataGarantia,Fabricante,idCategoria, 
                    IdDepartamento,idPrefeitura,IdProduto,idSubDivisao,IdTipoProduto, 
                    modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,DtHr) 
                    values ('" + DataGarantia + "','" + Fabricante + "', " +
                    " " + dr["idCategoria"].ToString() + "," + IdDepartamento + ", " +
                    " " + idPrefeitura + "," + IdProduto + ",'" + idSubDivisao + "', " +
                    " " + dr["idtipoProduto"].ToString() + ",'" + modelo + "', " +
                    " '" + dr["NomeProduto"].ToString() + "','" + NumeroSerie + "', " +
                    " '" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "', " +
                    " '" + NumeroPatrimonio + "','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()"
                    );
            }

            lst.Add(string.Format("{0}", idPatrimonio));
            return lst;
        }

        [WebMethod]
        public void InsertCtrl(string idPrefeitura, string nmrPatrimonio, string DataGarantia,
            string idPatriomonio, string Fixacao, string DataInstalacao, string TensaoEntrada,
            string TensaoSaida, string CapacidadeFasesSuportadas, string CapacidadeFasesInstaladas,
            string EstadoOperacional, string FormaOperacional, string IdDepartamento, string IdSubdivisao)
        {
            db.ExecuteNonQuery(
                @"update Patrimonio set NumeroPatrimonio='" + nmrPatrimonio +
                "',DataGarantia='" + DataGarantia + "',DtHr='" + DateTime.Now + "' " +
                " where idPatrimonio=" + idPatriomonio
                );

            dt = db.ExecuteReaderQuery(
                "select * from PatrimonioSemaforo " +
                " where IdPatrimonio=" + idPatriomonio
                );

            if (dt.Rows.Count == 0)
            {
                if (IdSubdivisao != "")
                {
                    db.ExecuteNonQuery(
                        @"Insert into PatrimonioSemaforo (Fixacao,DataInstalacao,TensaoEntrada,
                        TensaoSaida,CapacidadeFasesSuportadas,CapacidadeFasesInstaladas,
                        EstadoOperacional,FormaOperacional,IdPatrimonio,IdDepartamento,IdSubdivisao) 
                        values('" + Fixacao + "','" + DataInstalacao + "','" + TensaoEntrada + "', " +
                        " '" + TensaoSaida + "','" + CapacidadeFasesSuportadas + "', " +
                        " '" + CapacidadeFasesInstaladas + "','" + EstadoOperacional + "', " +
                        " '" + FormaOperacional + "'," + idPatriomonio + ", " +
                        " " + IdDepartamento + "," + IdSubdivisao + ")"
                        );
                }
                else
                {
                    db.ExecuteNonQuery(
                        @"Insert into PatrimonioSemaforo (Fixacao,DataInstalacao,TensaoEntrada,
                        TensaoSaida,CapacidadeFasesSuportadas,CapacidadeFasesInstaladas,
                        EstadoOperacional,FormaOperacional,IdPatrimonio,IdDepartamento)
                        values ('" + Fixacao + "','" + DataInstalacao + "','" + TensaoEntrada + "', " +
                        " '" + TensaoSaida + "','" + CapacidadeFasesSuportadas + "', " +
                        " '" + CapacidadeFasesInstaladas + "','" + EstadoOperacional + "', " +
                        " '" + FormaOperacional + "'," + idPatriomonio + "," + IdDepartamento + ")"
                        );
                }
            }
            else
            {
                if (IdSubdivisao != "")
                {
                    db.ExecuteNonQuery(
                        @"Update PatrimonioSemaforo set Fixacao='" + Fixacao + "', " +
                        " DataInstalacao='" + DataInstalacao + "', " +
                        " TensaoEntrada='" + TensaoEntrada + "', " +
                        " TensaoSaida='" + TensaoSaida + "', " +
                        " CapacidadeFasesSuportadas='" + CapacidadeFasesSuportadas + "', " +
                        " CapacidadeFasesInstaladas='" + CapacidadeFasesInstaladas + "', " +
                        " EstadoOperacional='" + EstadoOperacional + "', " +
                        " FormaOperacional='" + FormaOperacional + "', " +
                        " IdDepartamento='" + IdDepartamento + "', " +
                        " IdSubdivisao='" + IdSubdivisao + "' " +
                        " where IdPatrimonio=" + idPatriomonio
                        );
                }
                else
                {
                    db.ExecuteNonQuery(
                        @"Update PatrimonioSemaforo set Fixacao='" + Fixacao + "', " +
                        " DataInstalacao='" + DataInstalacao + "', " +
                        " TensaoEntrada='" + TensaoEntrada + "', " +
                        " TensaoSaida='" + TensaoSaida + "', " +
                        " CapacidadeFasesSuportadas='" + CapacidadeFasesSuportadas + "', " +
                        " CapacidadeFasesInstaladas='" + CapacidadeFasesInstaladas + "', " +
                        " EstadoOperacional='" + EstadoOperacional + "', " +
                        " FormaOperacional='" + FormaOperacional + "', " +
                        " IdDepartamento='" + IdDepartamento + "' " +
                        " where IdPatrimonio=" + idPatriomonio
                        );
                }
            }
        }

        [WebMethod]
        public List<string> EditMestreCtrl(string idPrefeitura, string idLocalMestre, string idsubdivisao)
        {
            List<string> lst = new List<string>();

            string subMestre = db.ExecuteScalarQuery("select id from Subdivisao_Departamento where Subdivisao='" + idLocalMestre + "'");
            if (subMestre == "")
            {
                lst.Add(string.Format("{0}", "Alert"));
            }
            else
            {
                db.ExecuteNonQuery("update Subdivisao_Departamento set idSubControladorMestre=" + subMestre + " where Id=" + idsubdivisao);
            }
            return lst;
        }

        [WebMethod]
        public void DeleteControllers(string idSubdivisao, string idPatrimonio, string formaOperacional, string idPrefeitura, string idOcorrencia, string idDnaGSS)
        {
            DataTable dt;
            string marca = "";
            string modelo = "";
            string idPatrimonioSemaforo = "";

            if (formaOperacional == "CONJUGADO")
            {
                db.ExecuteNonQuery("update Subdivisao_DEpartamento set idSubControladorMEstre=NULL where id=" + idSubdivisao);

                dt = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    marca = dr["marca"].ToString();
                    modelo = dr["modelo"].ToString();
                    idPatrimonioSemaforo = dr["Id"].ToString();
                    if (idOcorrencia != "")
                    {
                        db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'CONTROLADOR', '" + idPatrimonioSemaforo + "', '1', '" + marca + " - " + modelo + "', 'Remocao de Material')");
                    }
                }
            }
            else
            {
                //db.ExecuteNonQuery("delete from Patrimonio where idPatrimonio=" + idPatrimonio);
                //db.ExecuteNonQuery("delete from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);

                db.ExecuteNonQuery("UPDATE [dbo].[Patrimonio] SET [Status] = 'Removido' WHERE [IdPatrimonio]=" + idPatrimonio + " and [idPrefeitura]=" + idPrefeitura);

                dt = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    marca = dr["marca"].ToString();
                    modelo = dr["modelo"].ToString();
                    idPatrimonioSemaforo = dr["Id"].ToString();

                    if (idOcorrencia != "")
                    {
                        db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'CONTROLADOR', '" + idPatrimonioSemaforo + "', '1', '" + marca + " - " + modelo + "', 'Remocao de Material')");
                    }
                }
            }
        }

        [WebMethod]
        public void DeletePlacaControllers(string idPatrimonio, string idPrefeitura, int quantidade, string idOcorrencia, string idDnaGSS)
        {
            //db.ExecuteNonQuery("delete from Patrimonio where idPatrimonio=" + idPatrimonio);
            //db.ExecuteNonQuery("delete from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);


            string marca = "";
            string modelo = "";
            string idPatrimonioSemaforo = "";

            db.ExecuteNonQuery("UPDATE [dbo].[Patrimonio] SET [Status] = 'Removido' WHERE [IdPatrimonio]=" + idPatrimonio + " and [idPrefeitura]=" + idPrefeitura);

            DataTable dt = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                marca = dr["marca"].ToString();
                modelo = dr["modelo"].ToString();
                idPatrimonioSemaforo = dr["Id"].ToString();

                if (idOcorrencia != "")
                {
                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'PLACA', '" + idPatrimonioSemaforo + "', '1', '" + marca + " - " + modelo + "', 'Remocao de Material')");
                }
            }
        }

        [WebMethod]
        public void ApagarGprsControl(string idPatrimonio, string idPrefeitura, string idOcorrencia, string idDnaGSS)
        {
            //db.ExecuteNonQuery("delete from Patrimonio where idPatrimonio=" + idPatrimonio);
            //db.ExecuteNonQuery("delete from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);

            string marca = "";
            string modelo = "";
            string idPatrimonioSemaforo = "";

            db.ExecuteNonQuery(
                @"UPDATE [dbo].[Patrimonio] SET [Status] = 'Removido' 
                WHERE [IdPatrimonio]=" + idPatrimonio + " " +
                " AND [idPrefeitura]=" + idPrefeitura
                );

            DataTable dt = db.ExecuteReaderQuery(
                @"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	            JOIN [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] 
                WHERE p.[idPrefeitura] ='" + idPrefeitura + "' AND ps.[IdPatrimonio]=" + idPatrimonio
                );

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                marca = dr["marca"].ToString();
                modelo = dr["modelo"].ToString();
                idPatrimonioSemaforo = dr["Id"].ToString();

                if (idOcorrencia != "")
                {
                    db.ExecuteNonQuery(
                        @"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],
                        [idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
                        VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', " +
                        " 'GPRS CONTROLADOR', '" + idPatrimonioSemaforo + "', '1', " +
                        " '" + marca + " - " + modelo + "', 'Remocao de Material')"
                        );
                }
            }
        }

        [WebMethod]
        public List<string> getGprsCtrl(string idPrefeitura)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto,Modelo,f.RazaoSocial Fabricante,p.Id from Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
JOIN Categoria c on c.id=p.IdCategoria
where categoria='GPRS' order by Fabricante,Modelo");

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}", item["Id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(), item["Fabricante"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public void EditGprsCtrl(string idPrefeitura, string NumeroPatrimonio,
            string idPatrimonio, string DataGarantia, string DataInstalacao,
            string NmrDaLinha, string Operadora, string EstadoOperacional)
        {

            db.ExecuteNonQuery(
                @"UPDATE Patrimonio SET NumeroPatrimonio='" + NumeroPatrimonio + "', " +
                " DataGarantia='" + DataGarantia + "', " +
                " DtHr='" + DateTime.Now + "' " +
                " WHERE idpatrimonio=" + idPatrimonio
                );

            db.ExecuteNonQuery(
                @"UPDATE PatrimonioSemaforo SET DataInstalacao='" + DataInstalacao + "', " +
                " NmrDaLinha='" + NmrDaLinha + "', " +
                " Operadora='" + Operadora + "', " +
                " EstadoOperacional='" + EstadoOperacional + "', " +
                " PertencePatrimonio='CONTROLADOR' " +
                " WHERE IdPatrimonio=" + idPatrimonio
                );
        }

        [WebMethod]
        public void InsertGprsCtrl(string idPrefeitura, string NumeroPatrimonio, string idPatrimonio,
            string DataGarantia, string Fabricante, string IdDepartamento, string idProduto,
            string idSubDivisao, string modelo, string NumeroSerie, string NmrDaLinha, string Operadora,
            string DataInstalacao, string EstadoOperacional)
        {

            dt = db.ExecuteReaderQuery(
                @"SELECT p.*,tp.Dsc FROM Produto p
                JOIN TipoProduto tp on p.IdTipoProduto = tp.IdTipoProduto
                JOIN Categoria c on c.id = p.IdCategoria 
                WHERE p.Id=" + idProduto
                );
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];

                idPatrimonio = db.ExecuteScalarQuery(
                    @"INSERT INTO Patrimonio (DataGarantia,Fabricante,idCategoria,IdDepartamento,
                    idPrefeitura,IdProduto,idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie,
                    TipoUni,Marca,NumeroPatrimonio,DtHr)
                    VALUES ('" + DataGarantia + "','" + Fabricante + "'," + dr["idCategoria"].ToString() + ", " +
                    " " + IdDepartamento + "," + idPrefeitura + "," + idProduto + ",'" + idSubDivisao + "', " +
                    " " + dr["idtipoProduto"].ToString() + ",'" + modelo + "','" + dr["NomeProduto"].ToString() + "', " +
                    " '" + NumeroSerie + "','" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "', " +
                    " '" + NumeroPatrimonio + "','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()"
                    );
            }

            db.ExecuteNonQuery(
                @"INSERT INTO PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao,NmrDaLinha,
                Operadora,DataInstalacao,EstadoOperacional,PertencePatrimonio)
                VALUES (" + idPatrimonio + ",'" + IdDepartamento + "','" + idSubDivisao + "', " +
                " '" + NmrDaLinha + "','" + Operadora + "','" + DataInstalacao + "', " +
                " '" + EstadoOperacional + "','CONTROLADOR')"
                );
        }

        [WebMethod]
        public List<string> SelectGprsCtrlCad(string idProduto)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select Modelo,f.RazaoSocial Fabricante,p.NumeroSerie from Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
JOIN Categoria c on c.id=p.IdCategoria where p.id=" + idProduto);

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}", item["Modelo"].ToString(), item["Fabricante"].ToString(), item["NumeroSerie"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public void EditNobreak(string idPrefeitura, string NumeroPatrimonio, string idPatrimonio, string DataGarantia, string Fabricante,
        string IdDepartamento, string idSubDivisao, string modelo, string Fixacao, string DataInstalacao, string EstadoOperacional,
            string Autonomia, string Potencia, string Monitoracao, string idProduto, string value, string idLocal, string idOcorrencia, string idDnaGSS)
        {

            string idPatrimonioSemaforo = "";
            if (value == "Salvar")
            {
                dt = db.ExecuteReaderQuery(@"select p.*,tp.Dsc from Produto p
JOIN TipoProduto tp on p.IdTipoProduto = tp.IdTipoProduto
JOIN Categoria c on c.id = p.IdCategoria where p.Id=" + idProduto);
                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    idPatrimonio = db.ExecuteScalarQuery(@"insert into Patrimonio (DataGarantia,Fabricante,idCategoria,IdDepartamento,idPrefeitura,IdProduto,
idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,DtHr) values ('" + DataGarantia + "','" + Fabricante + "'," + dr["idCategoria"].ToString() + ","
            + IdDepartamento + "," + idPrefeitura + "," + idProduto + ",'" + idSubDivisao + "'," + dr["idtipoProduto"].ToString() + ",'" + modelo + "','"
            + dr["NomeProduto"].ToString() + "','" + dr["NumeroSerie"].ToString() + "','" + dr["TipoUni"].ToString() +
            "','" + dr["Marca"].ToString() + "','" + NumeroPatrimonio + "','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()");
                }
            }

            dt = db.ExecuteReaderQuery(@"select * from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);
            if (dt.Rows.Count == 0)
            {
                idPatrimonioSemaforo = db.ExecuteScalarQuery(@"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao,Fixacao,DataInstalacao,
EstadoOperacional,Autonomia,Potencia,Monitoracao) Values(" + idPatrimonio + ",'" + IdDepartamento + "','" + idSubDivisao + "','" + Fixacao + "','" + DataInstalacao
    + "','" + EstadoOperacional + "','" + Autonomia + "','" + Potencia + "','" + Monitoracao + "') SELECT SCOPE_IDENTITY()");

                DataTable datap = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

                if (datap.Rows.Count > 0)
                {
                    DataRow dr = datap.Rows[0];

                    if (idOcorrencia != "")
                    {
                        db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'NOBREAK', '" + idPatrimonioSemaforo + "', '1', '" + dr["marca"].ToString() + " - " + dr["modelo"].ToString() + "', 'INCLUSAO DE MATERIAL')");
                    }
                }
            }
            else
            {
                db.ExecuteNonQuery(@"update Patrimonio set DataGarantia='" + DataGarantia + "',DiretorioNotaFiscal='',NumeroPatrimonio='"
    + NumeroPatrimonio + "',DtHr='" + DateTime.Now + "' where idPatrimonio=" + idPatrimonio);

                db.ExecuteNonQuery(@"Update PatrimonioSemaforo set DataInstalacao='" + DataInstalacao + "',Fixacao='" + Fixacao + "',EstadoOperacional='" + EstadoOperacional +
    "',Autonomia='" + Autonomia + "',Potencia='" + Potencia + "',Monitoracao='" + Monitoracao + "' where IdPatrimonio=" + idPatrimonio);
            }
        }

        [WebMethod]
        public void ApagarNobreak(string idPatrimonio, string idPrefeitura, string idOcorrencia, string idDnaGSS)
        {
            //db.ExecuteNonQuery("delete from Patrimonio where idPatrimonio=" + idPatrimonio);
            //db.ExecuteNonQuery("delete from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);

            string marca = "";
            string modelo = "";
            string idPatrimonioSemaforo = "";

            db.ExecuteNonQuery("UPDATE [dbo].[Patrimonio] SET [Status] = 'Removido' WHERE [IdPatrimonio]=" + idPatrimonio + " and [idPrefeitura]=" + idPrefeitura);

            DataTable dt = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                marca = dr["marca"].ToString();
                modelo = dr["modelo"].ToString();
                idPatrimonioSemaforo = dr["Id"].ToString();

                if (idOcorrencia != "")
                {
                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'NOBREAK', '" + idPatrimonioSemaforo + "', '1', '" + marca + " - " + modelo + "', 'Remocao de Material')");
                }
            }

        }

        [WebMethod]
        public List<string> ImplantacaoNbrk(string idPrefeitura)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto,Modelo,f.RazaoSocial Fabricante,p.Id from Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
JOIN Categoria c on c.id=p.IdCategoria
where categoria='NOBREAK'");
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}", item["Id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(), item["Fabricante"].ToString()));
            }
            return lst;

        }

        [WebMethod]
        public List<string> DetailsNbr(string idPrefeitura, string idSubdivisao)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NumeroPatrimonio,Fabricante,modelo,DiretorioNotaFiscal,p.idPatrimonio,DataInstalacao,DataGarantia,Autonomia,Potencia,Fixacao,EstadoOperacional,Monitoracao
 from Patrimonio p join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio join Categoria c on p.idCategoria=c.id where c.categoria like'%NOBREAK%' and ps.IdSubdivisao=" +
    idSubdivisao + " and p.idPrefeitura=" + idPrefeitura + " AND isnull(p.Status,'') NOT IN ('REMOVIDO','INATIVO')");

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];

                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}@{9}@{10}", dr["IdPatrimonio"].ToString(), dr["Autonomia"].ToString(), dr["DataGarantia"].ToString()
                    , dr["Fabricante"].ToString(), dr["DataInstalacao"].ToString(), dr["Modelo"].ToString(), dr["NumeroPatrimonio"].ToString(),
                    dr["Potencia"].ToString(), dr["EstadoOperacional"].ToString(), dr["Fixacao"].ToString(), dr["Monitoracao"].ToString()));
            }

            return lst;

        }

        [WebMethod]
        public List<string> ImplantacaoGprsNbk(string idPrefeitura)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto,Modelo,f.RazaoSocial Fabricante,p.Id from Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
JOIN Categoria c on c.id=p.IdCategoria
where categoria='GPRS'");
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}", item["Id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(), item["Fabricante"].ToString()));
            }
            return lst;

        }

        [WebMethod]
        public List<string> SelectGprsNbrkCad(string idProduto)
        {
            List<string> lst = new List<string>();

            string nrSerie = db.ExecuteScalarQuery("select NumeroSerie from Produto where id=" + idProduto);

            lst.Add(string.Format("{0}", nrSerie));
            return lst;

        }

        [WebMethod]
        public List<string> DetailsNbrGprs(string idPrefeitura, string idSubdivisao)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NumeroPatrimonio,Fabricante,NumeroSerie,DataInstalacao,p.idPatrimonio,DataGarantia,NmrDaLinha,Modelo,Operadora,EstadoOperacional
 from Patrimonio p
join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio
join Categoria c on p.idCategoria=c.id where c.categoria like'%GPRS%' and PertencePatrimonio='NOBREAK' and ps.IdSubdivisao=" + idSubdivisao + " and p.idPrefeitura=" + idPrefeitura);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];

                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}", dr["IdPatrimonio"].ToString(), dr["Fabricante"].ToString(), dr["NumeroPatrimonio"].ToString()
                    , dr["NmrDaLinha"].ToString(), dr["DataGarantia"].ToString(), dr["DataInstalacao"].ToString(), dr["Modelo"].ToString(),
                    dr["Operadora"].ToString(), dr["EstadoOperacional"].ToString()));

            }

            return lst;

        }

        [WebMethod]
        public void EditGprsNobreak(string idPrefeitura, string NumeroPatrimonio, string idPatrimonio, string idProduto, string DataGarantia, string Fabricante,
        string IdDepartamento, string idSubDivisao, string modelo, string NumeroSerie, string NmrDaLinha, string Operadora, string DataInstalacao,
            string EstadoOperacional, string value, string idLocal, string idOcorrencia, string idDnaGSS)
        {
            string idPatrimonioSemaforo = "";
            if (value == "Salvar")
            {
                dt = db.ExecuteReaderQuery(@"select p.*,tp.Dsc from Produto p
JOIN TipoProduto tp on p.IdTipoProduto = tp.IdTipoProduto
JOIN Categoria c on c.id = p.IdCategoria where p.Id=" + idProduto);
                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    idPatrimonio = db.ExecuteScalarQuery(@"insert into Patrimonio (DataGarantia,Fabricante,idCategoria,IdDepartamento,idPrefeitura,IdProduto,
idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,DtHr) values ('" + DataGarantia + "','" + Fabricante + "'," + dr["idCategoria"].ToString() + ","
            + IdDepartamento + "," + idPrefeitura + "," + idProduto + ",'" + idSubDivisao + "'," + dr["idtipoProduto"].ToString() + ",'" + modelo + "','"
            + dr["NomeProduto"].ToString() + "','" + NumeroSerie + "','" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "','" + NumeroPatrimonio + "','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()");

                }
            }

            dt = db.ExecuteReaderQuery(@"select * from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);
            if (dt.Rows.Count == 0)
            {
                idPatrimonioSemaforo = db.ExecuteScalarQuery(@"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao,NmrDaLinha,Operadora,DataInstalacao,EstadoOperacional,PertencePatrimonio)
Values(" + idPatrimonio + ",'" + IdDepartamento + "','" + idSubDivisao + "','" + NmrDaLinha + "','" + Operadora + "','" + DataInstalacao + "','" + EstadoOperacional + "','NOBREAK') SELECT SCOPE_IDENTITY()");

                DataTable datap = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

                if (datap.Rows.Count > 0)
                {
                    DataRow dr = datap.Rows[0];
                    if (idOcorrencia != "")
                    {
                        db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'GPRS NOBREAK', '" + idPatrimonioSemaforo + "', '1', '" + dr["marca"].ToString() + " - " + dr["modelo"].ToString() + "', 'INCLUSAO DE MATERIAL')");
                    }
                }
            }
            else
            {
                db.ExecuteNonQuery(@"update Patrimonio set DataGarantia='" + DataGarantia +
                    "',NumeroPatrimonio='" + NumeroPatrimonio + "',DtHr='" + DateTime.Now + "' where idPatrimonio=" + idPatrimonio);

                db.ExecuteNonQuery(@"Update PatrimonioSemaforo set DataInstalacao='" + DataInstalacao +
                "',NmrDaLinha='" + NmrDaLinha + "',Operadora='" + Operadora + "',EstadoOperacional='" + EstadoOperacional +
                "',PertencePatrimonio='NOBREAK' where IdPatrimonio=" + idPatrimonio);
            }
        }

        [WebMethod]
        public void ExcluirGprsNbk(string idPatrimonio, string idPrefeitura, string idOcorrencia, string idDnaGSS)
        {
            //db.ExecuteNonQuery("delete from Patrimonio where idPAtrimonio=" + idPatrimonio);
            //db.ExecuteNonQuery("delete from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);

            string marca = "";
            string modelo = "";
            string idPatrimonioSemaforo = "";

            db.ExecuteNonQuery("UPDATE [dbo].[Patrimonio] SET [Status] = 'Removido' WHERE [IdPatrimonio]=" + idPatrimonio + " and [idPrefeitura]=" + idPrefeitura);

            DataTable dt = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                marca = dr["marca"].ToString();
                modelo = dr["modelo"].ToString();
                idPatrimonioSemaforo = dr["Id"].ToString();
                if (idOcorrencia != "")
                {
                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'GPRS NOBREAK', '" + idPatrimonioSemaforo + "', '1', '" + marca + " - " + modelo + "', 'Remocao de Material')");
                }
            }

        }

        [WebMethod]
        public List<string> ImplantacaoColuna(string idPrefeitura)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto,Modelo,f.RazaoSocial Fabricante,p.Id from Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
JOIN Categoria c on c.id=p.IdCategoria
where categoria like'%COLUNA%'");
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}", item["Id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(), item["Fabricante"].ToString()));
            }
            return lst;

        }

        [WebMethod]
        public List<string> SelectNewCols(string idProduto)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select p.*, f.RazaoSocial Fabricante from  Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
where p.Id=" + idProduto);

            DataRow item = dt.Rows[0];
            lst.Add(string.Format("{0}@{1}@{2}", item["NumeroSerie"].ToString(), item["Fabricante"].ToString(), item["modelo"].ToString()));
            return lst;

        }

        [WebMethod]
        public void EditCols(string idPrefeitura, string NumeroPatrimonio, string idPatrimonio, string idProduto, string DataGarantia,
            string DataInstalacao, string Fixacao, string EstadoOperacional)
        {

            db.ExecuteNonQuery(@"update Patrimonio set DataGarantia='" + DataGarantia +
                "',DiretorioNotaFiscal='',NumeroPatrimonio='" + NumeroPatrimonio + "',DtHr='" + DateTime.Now +
                "' where idPatrimonio=" + idPatrimonio);


            db.ExecuteNonQuery(@"Update PatrimonioSemaforo set DataInstalacao='" + DataInstalacao +
                    "',Fixacao='" + Fixacao +
                    "',EstadoOperacional='" + EstadoOperacional +
                    "' where IdPatrimonio=" + idPatrimonio);

        }

        [WebMethod]
        public List<string> SaveCols(string idPrefeitura, string NumeroPatrimonio, string idPatrimonio, string idProduto, int quantidade, string DataGarantia,
    string Fabricante, string IdDepartamento, string idSubDivisao, string modelo, string Fixacao, string DataInstalacao, string EstadoOperacional, string idLocal, string idOcorrencia, string idDnaGSS)
        {
            List<string> lst = new List<string>();

            string idPatrimonioSemaforo = "";

            int i = 0;
            int NmrPat = 0;
            if (NumeroPatrimonio != "")
            {
                NmrPat = Convert.ToInt32(NumeroPatrimonio);
                while (quantidade > i)
                {
                    i++;
                    NmrPat++;
                }
                dt = db.ExecuteReaderQuery(@"select idPatrimonio from Patrimonio where NumeroPatrimonio BETWEEN " + NumeroPatrimonio +
                    " AND " + (NmrPat - 1) + " and idPrefeitura=" + idPrefeitura);
                if (dt.Rows.Count > 0)
                {
                    string msg = "Existem Nºs de Patrimonios sendo usado no intervalo de " + NumeroPatrimonio + " a " + (NmrPat - 1) + "!";
                    lst.Add(string.Format("{0}", msg));
                }
                NmrPat = Convert.ToInt32(NumeroPatrimonio);
                i = 0;
            }
            if (lst.Count == 0)
            {
                dt = db.ExecuteReaderQuery(@"select p.*,tp.Dsc from Produto p
JOIN TipoProduto tp on p.IdTipoProduto = tp.IdTipoProduto
JOIN Categoria c on c.id = p.IdCategoria where p.Id=" + idProduto);
                if (NmrPat != 0)
                {
                    while (quantidade > i)
                    {
                        if (dt.Rows.Count > 0)
                        {
                            DataRow dr = dt.Rows[0];
                            idPatrimonio = db.ExecuteScalarQuery(@"insert into Patrimonio (DataGarantia,Fabricante,idCategoria,IdDepartamento,
idPrefeitura,IdProduto,
idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,DiretorioNotaFiscal,DtHr) 
values ('" + DataGarantia + "','" + Fabricante + "'," + dr["idCategoria"].ToString() + ","
                + IdDepartamento + "," + idPrefeitura + "," + idProduto +
                ",'" + idSubDivisao + "'," + dr["idtipoProduto"].ToString() + ",'" + modelo + "','"
                + dr["NomeProduto"].ToString() + "','" + dr["NumeroSerie"].ToString() + "','" + dr["TipoUni"].ToString() +
                "','" + dr["Marca"].ToString() + "','" + NmrPat + "','','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()");

                            idPatrimonioSemaforo = db.ExecuteScalarQuery(@"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao,Fixacao,DataInstalacao,EstadoOperacional)
Values(" + idPatrimonio + ",'" + IdDepartamento + "','" + idSubDivisao + "','" + Fixacao + "','" + DataInstalacao + "','" + EstadoOperacional + "') SELECT SCOPE_IDENTITY()");

                            if (idOcorrencia != "")
                            {
                                db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'COLUNAS', '" + idPatrimonioSemaforo + "', " + quantidade + ", '" + dr["Marca"].ToString() + " - " + dr["Modelo"].ToString() + "', 'INCLUSAO DE MATERIAL')");
                            }
                        }
                        i++;
                        NmrPat++;
                    }
                }
                else
                {
                    while (quantidade > i)
                    {
                        if (dt.Rows.Count > 0)
                        {
                            DataRow dr = dt.Rows[0];
                            idPatrimonio = db.ExecuteScalarQuery(@"insert into Patrimonio (DataGarantia,Fabricante,idCategoria,IdDepartamento,idPrefeitura,IdProduto,
idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,DiretorioNotaFiscal,DtHr) 
values ('" + DataGarantia + "','" + Fabricante + "'," + dr["idCategoria"].ToString() + ","
               + IdDepartamento + "," + idPrefeitura + "," + idProduto + ",'" + idSubDivisao + "'," + dr["idtipoProduto"].ToString() + ",'" + modelo + "','"
               + dr["NomeProduto"].ToString() + "','" + dr["NumeroSerie"].ToString() + "','" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "','','','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()");

                            idPatrimonioSemaforo = db.ExecuteScalarQuery(@"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao,Fixacao,DataInstalacao,EstadoOperacional)
Values(" + idPatrimonio + ",'" + IdDepartamento + "','" + idSubDivisao + "','" + Fixacao + "','" + DataInstalacao + "','" + EstadoOperacional + "') SELECT SCOPE_IDENTITY()");

                            if (idOcorrencia != "")
                            {
                                db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'COLUNAS', '" + idPatrimonioSemaforo + "', " + quantidade + ", '" + dr["Marca"].ToString() + " - " + dr["Modelo"].ToString() + "', 'INCLUSAO DE MATERIAL')");
                            }
                        }
                        i++;
                    }
                }
            }
            return lst;

        }

        [WebMethod]
        public void ApagarColuna(string idPatrimonio, string idPrefeitura, int quantidade, string idOcorrencia, string idDnaGSS)
        {
            //db.ExecuteNonQuery("delete from Patrimonio where idPatrimonio=" + idPatrimonio);
            //db.ExecuteNonQuery("delete from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);

            string marca = "";
            string modelo = "";
            string idPatrimonioSemaforo = "";

            db.ExecuteNonQuery("UPDATE [dbo].[Patrimonio] SET [Status] = 'Removido' WHERE [IdPatrimonio]=" + idPatrimonio + " and [idPrefeitura]=" + idPrefeitura);

            DataTable dt = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                marca = dr["marca"].ToString();
                modelo = dr["modelo"].ToString();
                idPatrimonioSemaforo = dr["Id"].ToString();

                if (idOcorrencia != "")
                {
                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'COLUNA', '" + idPatrimonioSemaforo + "', " + quantidade + ", '" + marca + " - " + modelo + "', 'Remocao de Material')");
                }
            }
        }

        [WebMethod]
        public List<string> SelectColuna(string idPatrimonio)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select p.NumeroPatrimonio,p.IdPatrimonio,pd.id,Fabricante,p.NumeroSerie,DataInstalacao,DataGarantia,
p.Modelo,EstadoOperacional,Fixacao,DiretorioNotaFiscal from Patrimonio p
join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio
JOIN PRODUTO pd on pd.id=p.idProduto
join Categoria c on p.idCategoria=c.id where c.categoria like'%COLUNA%' and ps.Id=" + idPatrimonio);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}@{9}", dr["NumeroPatrimonio"].ToString(), dr["Fabricante"].ToString(), dr["NUmeroSerie"].ToString(),
                    dr["DataGarantia"].ToString(), dr["DataInstalacao"].ToString(), dr["Id"].ToString(), dr["Modelo"].ToString(), dr["EstadoOperacional"].ToString(),
                    dr["Fixacao"].ToString(), dr["IdPatrimonio"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public List<string> ImplantacaoCabo(string idPrefeitura)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto,Modelo,f.RazaoSocial Fabricante,p.Id from Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
JOIN Categoria c on c.id=p.IdCategoria
where categoria like'%CABO%'");
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}", item["Id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(), item["Fabricante"].ToString()));
            }
            return lst;

        }

        [WebMethod]
        public List<string> SelectNewCabo(string idProduto)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select p.*, f.RazaoSocial Fabricante from  Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
where p.Id=" + idProduto);

            DataRow item = dt.Rows[0];
            lst.Add(string.Format("{0}@{1}@{2}", item["NumeroSerie"].ToString(), item["Fabricante"].ToString(), item["modelo"].ToString()));
            return lst;

        }

        [WebMethod]
        public List<string> SaveCabos(string idPrefeitura, string NumeroPatrimonio, string idPatrimonio, string idProduto, int quantidade, string DataGarantia,
            string Fabricante, string idDepartamento, string idSubDivisao, string modelo, string QtdUni, string DataInstalacao, string EstadoOperacional,
            string TipoInstalacao, string MeioInstalacao, string value, string idLocal, string idOcorrencia, string idDnaGSS)
        {
            List<string> lst = new List<string>();

            string idPatrimonioSemaforo = "";

            int i = 0;
            int NmrPat = 0;
            if (NumeroPatrimonio != "")
            {
                NmrPat = Convert.ToInt32(NumeroPatrimonio);
            }

            if (value == "Salvar")
            {
                while (quantidade > i)
                {
                    dt = db.ExecuteReaderQuery(
                        @"select p.*,tp.Dsc from Produto p
                        JOIN TipoProduto tp on p.IdTipoProduto = tp.IdTipoProduto
                        JOIN Categoria c on c.id = p.IdCategoria where p.Id=" + idProduto);
                    if (dt.Rows.Count > 0)
                    {
                        DataRow dr = dt.Rows[0];
                        if (NmrPat == 0)
                        {
                            idPatrimonio = db.ExecuteScalarQuery(
                                @"insert into Patrimonio (DataGarantia,Fabricante,idCategoria,IdDepartamento, 
                                idPrefeitura,IdProduto,idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie, 
                                TipoUni,Marca,NumeroPatrimonio,DiretorioNotaFiscal,QtdUni,DtHr) 
                                values ('" + DataGarantia + "','" + Fabricante + "', " +
                                " " + dr["idCategoria"].ToString() + "," + idDepartamento + ", " +
                                " " + idPrefeitura + "," + idProduto + ",'" + idSubDivisao + "', " +
                                " " + dr["idtipoProduto"].ToString() + ",'" + modelo + "', " +
                                " '" + dr["NomeProduto"].ToString() + "','" + dr["NumeroSerie"].ToString() + "', " +
                                " '" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "', " +
                                " '" + NumeroPatrimonio + "','','" + QtdUni + "','" + DateTime.Now + "') " +
                                " SELECT SCOPE_IDENTITY()");


                            idPatrimonioSemaforo = db.ExecuteScalarQuery(
                                @"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao, 
                                DataInstalacao,EstadoOperacional,TipoInstalacao,MeioInstalacao)
                                Values(" + idPatrimonio + ",'" + idDepartamento + "','" + idSubDivisao + "', " +
                                " '" + DataInstalacao + "','" + EstadoOperacional + "','" + TipoInstalacao + "', " +
                                " '" + MeioInstalacao + "') " +
                                " SELECT SCOPE_IDENTITY()");

                            if (idOcorrencia != "")
                            {
                                db.ExecuteNonQuery(
                                    @"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura], 
                                    [idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd], 
                                    [DscMaterial],[Operacao]) 
                                    values ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', " +
                                    " 'CABOS', '" + idPatrimonioSemaforo + "', " + quantidade + ", " +
                                    " '" + dr["Marca"].ToString() + " - " + dr["Modelo"].ToString() + "', " +
                                    " 'INCLUSAO DE MATERIAL')");
                            }
                        }
                        else
                        {
                            idPatrimonio = db.ExecuteScalarQuery(
                                @"insert into Patrimonio (DataGarantia,Fabricante,idCategoria,IdDepartamento, 
                                idPrefeitura,IdProduto,idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie, 
                                TipoUni,Marca,NumeroPatrimonio,DiretorioNotaFiscal,QtdUni,DtHr) 
                                values ('" + DataGarantia + "','" + Fabricante + "', " +
                                " " + dr["idCategoria"].ToString() + "," + idDepartamento + ", " +
                                " " + idPrefeitura + "," + idProduto + ",'" + idSubDivisao + "', " +
                                " " + dr["idtipoProduto"].ToString() + ",'" + modelo + "', " +
                                " '" + dr["NomeProduto"].ToString() + "','" + dr["NumeroSerie"].ToString() + "', " +
                                " '" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "', " +
                                " '" + NmrPat + "','','" + QtdUni + "','" + DateTime.Now + "') " +
                                " SELECT SCOPE_IDENTITY()");


                            idPatrimonioSemaforo = db.ExecuteScalarQuery(
                                @"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao, 
                                DataInstalacao,EstadoOperacional,TipoInstalacao,MeioInstalacao)
                                values(" + idPatrimonio + ",'" + idDepartamento + "','" + idSubDivisao + "', " +
                                " '" + DataInstalacao + "','" + EstadoOperacional + "','" + TipoInstalacao + "', " +
                                " '" + MeioInstalacao + "') " +
                                " SELECT SCOPE_IDENTITY()");

                            if (idOcorrencia != "")
                            {
                                db.ExecuteNonQuery(
                                    @"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],
                                    [idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
                                    values ('" + idPrefeitura + "','" + idOcorrencia + "','" + idDnaGSS + "', " +
                                    " 'CABOS', '" + idPatrimonioSemaforo + "', " + quantidade + ", " +
                                    " '" + dr["Marca"].ToString() + " - " + dr["Modelo"].ToString() + "', " +
                                    " 'INCLUSAO DE MATERIAL')");
                            }
                        }
                    }

                    NmrPat++;
                    i++;
                }
            }
            else
            {
                db.ExecuteNonQuery(
                    @"update Patrimonio set DataGarantia='" + DataGarantia + "',QtdUni='" + QtdUni + "', " +
                    " NumeroPatrimonio='" + NumeroPatrimonio + "',DiretorioNotaFiscal='',DtHr='" + DateTime.Now + "' " +
                    " where idPatrimonio=" + idPatrimonio);

                db.ExecuteNonQuery(
                    @"Update PatrimonioSemaforo set DataInstalacao='" + DataInstalacao + "', " +
                    " EstadoOperacional='" + EstadoOperacional + "',TipoInstalacao='" + TipoInstalacao + "', " +
                    " MeioInstalacao='" + MeioInstalacao + "' " +
                    " where IdPatrimonio=" + idPatrimonio);
            }

            return lst;
        }

        [WebMethod]
        public void ApagarCabos(string idPatrimonio, string idPrefeitura, int quantidade, string idOcorrencia, string idDnaGSS)
        {
            //db.ExecuteNonQuery("delete from Patrimonio where idPatrimonio=" + idPatrimonio);
            //db.ExecuteNonQuery("delete from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);

            string marca = "";
            string modelo = "";
            string idPatrimonioSemaforo = "";

            db.ExecuteNonQuery("UPDATE [dbo].[Patrimonio] SET [Status] = 'Removido' WHERE [IdPatrimonio]=" + idPatrimonio + " and [idPrefeitura]=" + idPrefeitura);

            DataTable dt = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                marca = dr["marca"].ToString();
                modelo = dr["modelo"].ToString();
                idPatrimonioSemaforo = dr["Id"].ToString();

                if (idOcorrencia != "")
                {
                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'CABOS', '" + idPatrimonioSemaforo + "', " + quantidade + ", '" + marca + " - " + modelo + "', 'Remocao de Material')");
                }
            }
        }

        [WebMethod]
        public List<string> SelectCabo(string idPatrimonio)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(
                @"select NumeroPatrimonio,Fabricante,QtdUni,p.NumeroSerie,p.IdPatrimonio,
                DataInstalacao,pd.id,DataGarantia,p.Modelo,EstadoOperacional,DiretorioNotaFiscal, 
                TipoInstalacao,MeioInstalacao from Patrimonio p
                join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio
                JOIN Produto pd on pd.id = p.idProduto
                where ps.Id=" + idPatrimonio);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}@{9}@{10}@{11}",
                    dr["NumeroSerie"].ToString(),
                    dr["Fabricante"].ToString(),
                    dr["modelo"].ToString(),
                    dr["id"].ToString(),
                    dr["DataInstalacao"].ToString(),
                    dr["DataGarantia"].ToString(),
                    dr["NumeroPatrimonio"].ToString(),
                    dr["IdPatrimonio"].ToString(),
                    dr["TipoInstalacao"].ToString(),
                    dr["MeioInstalacao"].ToString(),
                    dr["QtdUni"].ToString(),
                    dr["EstadoOperacional"].ToString()
                    ));
            }

            return lst;
        }

        [WebMethod]
        public List<string> ImplantacaoGF(string idPrefeitura)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto,Modelo,f.RazaoSocial Fabricante,p.Id from Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
JOIN Categoria c on c.id=p.IdCategoria
where categoria like'%GRUPO FOCAL%'");
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}", item["Id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(), item["Fabricante"].ToString()));
            }
            return lst;

        }

        [WebMethod]
        public List<string> SelectNewGf(string idProduto)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select p.*, f.RazaoSocial Fabricante from  Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
where p.Id=" + idProduto);

            DataRow item = dt.Rows[0];
            lst.Add(string.Format("{0}@{1}@{2}", item["NumeroSerie"].ToString(), item["Fabricante"].ToString(), item["modelo"].ToString()));
            return lst;

        }

        [WebMethod]
        public List<string> EditGrupoFocal(string idPrefeitura, string NumeroPatrimonio, string idPatrimonio, string idProduto, int quantidade, string DataGarantia,
            string Fabricante, string idDepartamento, string idSubDivisao, string modelo, string DataInstalacao, string EstadoOperacional, string value, string idLocal, string idOcorrencia, string idDnaGSS)
        {
            List<string> lst = new List<string>();
            if (value == "Salvar Alterações")
            {
                #region Salvar Alteraçoes


                db.ExecuteNonQuery("update Patrimonio set DataGarantia='" + DataGarantia + "',NumeroPatrimonio='" + NumeroPatrimonio +
                    "',DiretorioNotaFiscal='',DtHr='" + DateTime.Now + "' where idPatrimonio=" + idPatrimonio);

                db.ExecuteNonQuery(@"Update PatrimonioSemaforo set DataInstalacao='" + DataInstalacao +
                  "',EstadoOperacional='" + EstadoOperacional +
                  "' where IdPatrimonio=" + idPatrimonio);
                #endregion
            }
            else
            {
                string idPatrimonioSemaforo = "";
                int i = 0;
                int NmrPat = 0;
                if (NumeroPatrimonio != "")
                {
                    NmrPat = Convert.ToInt32(NumeroPatrimonio);
                    while (quantidade > i)
                    {
                        i++;
                        NmrPat++;
                    }
                    dt = db.ExecuteReaderQuery(@"select idPatrimonio from Patrimonio where NumeroPatrimonio BETWEEN " + NumeroPatrimonio +
                    " AND " + (NmrPat - 1) + " and idPrefeitura=" + idPrefeitura);
                    if (dt.Rows.Count > 0)
                    {
                        string msg = "Existem Nºs de Patrimonios sendo usado no intervalo de " + NumeroPatrimonio + " a " + (NmrPat - 1) + "!";
                        lst.Add(string.Format("{0}", msg));
                    }

                    NmrPat = Convert.ToInt32(NumeroPatrimonio);
                    i = 0;
                }
                if (lst.Count == 0)
                {
                    dt = db.ExecuteReaderQuery(@"select p.*,tp.Dsc from Produto p
JOIN TipoProduto tp on p.IdTipoProduto = tp.IdTipoProduto
JOIN Categoria c on c.id = p.IdCategoria where p.Id=" + idProduto);
                    if (NmrPat != 0)
                    {
                        while (quantidade > i)
                        {

                            if (dt.Rows.Count > 0)
                            {
                                DataRow dr = dt.Rows[0];
                                idPatrimonio = db.ExecuteScalarQuery(@"insert into Patrimonio (DataGarantia,Fabricante,idCategoria,IdDepartamento,idPrefeitura,IdProduto,
idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,DiretorioNotaFiscal,DtHr) values ('" + DataGarantia + "','" + Fabricante + "',"
                   + dr["idCategoria"].ToString() + "," + idDepartamento + "," + idPrefeitura + ","
                   + idProduto + ",'" + idSubDivisao + "'," + dr["idtipoProduto"].ToString() + ",'" + modelo + "','"
                   + dr["NomeProduto"].ToString() + "','" + dr["NumeroSerie"].ToString() + "','" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() +
                   "','" + NmrPat + "','','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()");

                                //GRUPOFOCAL
                                idPatrimonioSemaforo = db.ExecuteScalarQuery(@"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao,DataInstalacao,EstadoOperacional)
Values(" + idPatrimonio + ",'" + idDepartamento + "','" + idSubDivisao + "','" + DataInstalacao + "','" + EstadoOperacional + "') SELECT SCOPE_IDENTITY()");

                                if (idOcorrencia != "")
                                {
                                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'GRUPOFOCAL', '" + idPatrimonioSemaforo + "', " + quantidade + ", '" + dr["Marca"].ToString() + " - " + dr["Modelo"].ToString() + "', 'INCLUSAO DE MATERIAL')");
                                }
                            }
                            i++;
                            NmrPat++;
                        }
                    }
                    else
                    {
                        while (quantidade > i)
                        {

                            if (dt.Rows.Count > 0)
                            {
                                DataRow dr = dt.Rows[0];
                                idPatrimonio = db.ExecuteScalarQuery(@"insert into Patrimonio (DataGarantia,Fabricante,idCategoria,IdDepartamento,idPrefeitura,IdProduto,
idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,DiretorioNotaFiscal,DtHr) values ('" + DataGarantia + "','" + Fabricante + "'," + dr["idCategoria"].ToString() + ","
                   + idDepartamento + "," + idPrefeitura + "," + idProduto + ",'" + idSubDivisao + "'," + dr["idtipoProduto"].ToString() + ",'" + modelo + "','"
                   + dr["NomeProduto"].ToString() + "','" + dr["NumeroSerie"].ToString() + "','" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "','','','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()");

                                //GRUPOFOCAL
                                idPatrimonioSemaforo = db.ExecuteScalarQuery(@"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao,DataInstalacao,EstadoOperacional)
Values(" + idPatrimonio + ",'" + idDepartamento + "','" + idSubDivisao + "','" + DataInstalacao + "','" + EstadoOperacional + "') SELECT SCOPE_IDENTITY()");

                                if (idOcorrencia != "")
                                {
                                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'GRUPOFOCAL', '" + idPatrimonioSemaforo + "', " + quantidade + ", '" + dr["Marca"].ToString() + " - " + dr["Modelo"].ToString() + "', 'INCLUSAO DE MATERIAL')");
                                }
                            }
                            i++;
                        }
                    }
                }

            }
            return lst;

        }

        [WebMethod]
        public void ApagarGrupoFocal(string idPatrimonio, string idPrefeitura, int quantidade, string idOcorrencia, string idDnaGSS)
        {
            //db.ExecuteNonQuery("delete from Patrimonio where idPatrimonio=" + idPatrimonio);
            //db.ExecuteNonQuery("delete from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);

            string marca = "";
            string modelo = "";
            string idPatrimonioSemaforo = "";

            db.ExecuteNonQuery("UPDATE [dbo].[Patrimonio] SET [Status] = 'Removido' WHERE [IdPatrimonio]=" + idPatrimonio + " and [idPrefeitura]=" + idPrefeitura);

            DataTable dt = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                marca = dr["marca"].ToString();
                modelo = dr["modelo"].ToString();
                idPatrimonioSemaforo = dr["Id"].ToString();

                if (idOcorrencia != "")
                {
                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'GRUPOFOCAL', '" + idPatrimonioSemaforo + "', " + quantidade + ", '" + marca + " - " + modelo + "', 'Remocao de Material')");
                }
            }
        }

        [WebMethod]
        public List<string> SelectGrupoFocal(string idPatrimonio)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NumeroPatrimonio,Fabricante,p.NumeroSerie,p.IdPatrimonio,
DataInstalacao,pd.id,DataGarantia,p.Modelo,EstadoOperacional,DiretorioNotaFiscal,TipoInstalacao,MeioInstalacao from Patrimonio p
join PatrimonioSemaforo ps on p.IdPatrimonio=ps.IdPatrimonio
JOIN Produto pd on pd.id = p.idProduto
where ps.Id=" + idPatrimonio);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}", dr["Modelo"].ToString(), dr["Fabricante"].ToString(), dr["EstadoOperacional"].ToString(),
                    dr["NumeroPatrimonio"].ToString(), dr["id"].ToString(), dr["DataGarantia"].ToString(), dr["DataInstalacao"].ToString(), dr["IdPatrimonio"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> ImplantacaoIlu(string idPrefeitura)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto,Modelo,f.RazaoSocial Fabricante,p.Id from Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
JOIN Categoria c on c.id=p.IdCategoria
where categoria like'%Iluminação%' or categoria like '%Iluminacao%'");
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}", item["Id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(), item["Fabricante"].ToString()));
            }
            return lst;

        }

        [WebMethod]
        public List<string> SelectNewIlu(string idProduto)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select p.*, f.RazaoSocial Fabricante from  Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
where p.Id=" + idProduto);

            DataRow item = dt.Rows[0];
            lst.Add(string.Format("{0}@{1}@{2}", item["NumeroSerie"].ToString(), item["Fabricante"].ToString(), item["modelo"].ToString()));
            return lst;

        }

        [WebMethod]
        public List<string> SalvarIlu(string idPrefeitura, string NumeroPatrimonio, string idPatrimonio, string idProduto, int quantidade, string DataGarantia,
            string Fabricante, string idDepartamento, string idSubDivisao, string modelo, string DataInstalacao, string EstadoOperacional, string TensaoInstalada,
            string value, string idOcorrencia, string idDnaGSS)
        {
            List<string> lst = new List<string>();
            if (value == "Salvar Alterações")
            {
                #region Salvar Alteraçoes

                db.ExecuteNonQuery(@"update Patrimonio set NumeroPatrimonio='" + NumeroPatrimonio + "',DataGarantia='" + DataGarantia +
                    "',DiretorioNotaFiscal='',DtHr='" + DateTime.Now + "' where idPatrimonio=" + idPatrimonio);

                db.ExecuteNonQuery(@"Update PatrimonioSemaforo set DataInstalacao='" + DataInstalacao +
                "',EstadoOperacional='" + EstadoOperacional +
                "',TensaoInstalada='" + TensaoInstalada +
                "' where IdPatrimonio=" + idPatrimonio);
                #endregion
            }
            else
            {
                #region Salvar

                string idPatrimonioSemaforo = "";

                int i = 0;
                int NmrPat = 0;
                if (NumeroPatrimonio != "")
                {
                    NmrPat = Convert.ToInt32(NumeroPatrimonio);
                    while (quantidade > i)
                    {
                        i++;
                        NmrPat++;
                    }
                    dt = db.ExecuteReaderQuery("select idPatrimonio from Patrimonio where NumeroPatrimonio BETWEEN " + NumeroPatrimonio + " AND " + (NmrPat - 1) + " and idPrefeitura=" + idPrefeitura);
                    if (dt.Rows.Count > 0)
                    {
                        string msg = "Existem Nºs de Patrimonios sendo usado no intervalo de " + NumeroPatrimonio + " a " + (NmrPat - 1) + "!";
                        lst.Add(string.Format("{0}", msg));
                    }

                    NmrPat = Convert.ToInt32(NumeroPatrimonio);
                    i = 0;
                }
                if (lst.Count == 0)
                {


                    dt = db.ExecuteReaderQuery(@"select p.*,tp.Dsc from Produto p
JOIN TipoProduto tp on p.IdTipoProduto = tp.IdTipoProduto
JOIN Categoria c on c.id = p.IdCategoria where p.Id=" + idProduto);
                    if (NmrPat != 0)
                    {
                        while (quantidade > i)
                        {

                            if (dt.Rows.Count > 0)
                            {
                                DataRow dr = dt.Rows[0];
                                idPatrimonio = db.ExecuteScalarQuery(@"insert into Patrimonio (DataGarantia,Fabricante,idCategoria,IdDepartamento,idPrefeitura,IdProduto,
idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,DiretorioNotaFiscal,DtHr) values ('" + DataGarantia + "','" +
    Fabricante + "'," + dr["idCategoria"].ToString() + "," + idDepartamento + "," + idPrefeitura + "," +
    idProduto + ",'" + idSubDivisao + "'," + dr["idtipoProduto"].ToString() + ",'" + modelo + "','"
    + dr["NomeProduto"].ToString() + "','" + dr["NumeroSerie"].ToString() + "','" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "','" + NmrPat + "','','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()");


                                idPatrimonioSemaforo = db.ExecuteScalarQuery(@"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao,DataInstalacao,EstadoOperacional,TensaoInstalada)
Values(" + idPatrimonio + ",'" + idDepartamento + "','" + idSubDivisao + "','" + DataInstalacao + "','" + EstadoOperacional + "','" + TensaoInstalada + "') SELECT SCOPE_IDENTITY()");


                                if (idOcorrencia != "")
                                {
                                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],
[Qtd],[DscMaterial],[Operacao]) VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'SISTEMAILUMINACAO', '" + idPatrimonioSemaforo + "', " + quantidade +
    ", '" + dr["Marca"].ToString() + " - " + dr["Modelo"].ToString() + "', 'INCLUSAO DE MATERIAL')");
                                }

                            }
                            i++;
                            NmrPat++;
                        }
                    }
                    else
                    {
                        while (quantidade > i)
                        {

                            if (dt.Rows.Count > 0)
                            {
                                DataRow dr = dt.Rows[0];
                                idPatrimonio = db.ExecuteScalarQuery(@"insert into Patrimonio (DataGarantia,Fabricante,idCategoria,IdDepartamento,idPrefeitura,IdProduto,
idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,DiretorioNotaFiscal,DtHr) values ('" + DataGarantia + "','" +
    Fabricante + "'," + dr["idCategoria"].ToString() + "," + idDepartamento + "," + idPrefeitura + "," +
    idProduto + ",'" + idSubDivisao + "'," + dr["idtipoProduto"].ToString() + ",'" + modelo + "','"
    + dr["NomeProduto"].ToString() + "','" + dr["NumeroSerie"].ToString() + "','" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "','','','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()");


                                idPatrimonioSemaforo = db.ExecuteScalarQuery(@"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao,DataInstalacao,EstadoOperacional,TensaoInstalada)
Values(" + idPatrimonio + ",'" + idDepartamento + "','" + idSubDivisao + "','" + DataInstalacao + "','" + EstadoOperacional + "','" + TensaoInstalada + "') SELECT SCOPE_IDENTITY()");

                                if (idOcorrencia != "")
                                {
                                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],
[Qtd],[DscMaterial],[Operacao]) VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'SISTEMAILUMINACAO', '" + idPatrimonioSemaforo + "', " + quantidade +
    ", '" + dr["Marca"].ToString() + " - " + dr["Modelo"].ToString() + "', 'INCLUSAO DE MATERIAL')");
                                }

                            }
                            i++;
                        }
                    }
                }
                #endregion
            }
            return lst;

        }

        [WebMethod]
        public void ApagarSistemaIlu(string idPatrimonio, string idPrefeitura, int quantidade, string idOcorrencia, string idDnaGSS)
        {
            //db.ExecuteNonQuery("delete from Patrimonio where idPatrimonio=" + idPatrimonio);
            //db.ExecuteNonQuery("delete from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);

            string marca = "";
            string modelo = "";
            string idPatrimonioSemaforo = "";

            db.ExecuteNonQuery("UPDATE [dbo].[Patrimonio] SET [Status] = 'Removido' WHERE [IdPatrimonio]=" + idPatrimonio + " and [idPrefeitura]=" + idPrefeitura);

            DataTable dt = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                marca = dr["marca"].ToString();
                modelo = dr["modelo"].ToString();
                idPatrimonioSemaforo = dr["Id"].ToString();

                if (idOcorrencia != "")
                {
                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'SISTEMAILUMINACAO', '" + idPatrimonioSemaforo + "', " + quantidade + ", '" + marca + " - " + modelo + "', 'Remocao de Material')");
                }
            }
        }

        [WebMethod]
        public List<string> SelectIlum(string idPatrimonio)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"Select p.*,f.RazaoSocial,ps.* from Patrimonio p 
        left join Fornecedor f on p.idFornecedor = f.id  
        join PatrimonioSemaforo ps on p.IdPatrimonio = ps.IdPatrimonio
        where ps.Id =" + idPatrimonio);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}@{7}@{8}", dr["IdPatrimonio"].ToString(), dr["NumeroSerie"].ToString(), dr["Fabricante"].ToString(),
                    dr["modelo"].ToString(), dr["DataInstalacao"].ToString(), dr["DataGarantia"].ToString(), dr["NumeroPatrimonio"].ToString(),
                    dr["EstadoOperacional"].ToString(), dr["TensaoInstalada"].ToString()));
            }
            return lst;
        }

        [WebMethod]
        public List<string> ImplantacaoAcess(string idPrefeitura)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select NomeProduto,Modelo,f.RazaoSocial Fabricante,p.Id from Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
JOIN Categoria c on c.id=p.IdCategoria
where categoria like'%Acessorio%'");
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}@{3}", item["Id"].ToString(), item["NomeProduto"].ToString(), item["Modelo"].ToString(), item["Fabricante"].ToString()));
            }
            return lst;

        }

        [WebMethod]
        public List<string> SelectNewAcess(string idProduto)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"select p.*, f.RazaoSocial Fabricante from  Produto p
JOIN Fabricante f on p.IdFabricante = f.Id
where p.Id=" + idProduto);

            DataRow item = dt.Rows[0];
            lst.Add(string.Format("{0}@{1}@{2}", item["NumeroSerie"].ToString(), item["Fabricante"].ToString(), item["NomeProduto"].ToString()));
            return lst;

        }

        [WebMethod]
        public List<string> AdicionarAcessorio(string idPrefeitura, string NumeroPatrimonio, string idPatrimonio, string idProduto, int quantidade,
            string Fabricante, string idDepartamento, string idSubDivisao, string DataInstalacao, string Fixacao, string value,
            string idLocal, string idOcorrencia, string idDnaGSS)
        {
            List<string> lst = new List<string>();
            if (value == "Salvar Alterações")
            {
                #region Salvar Alteraçoes

                db.ExecuteNonQuery("update Patrimonio set NumeroPatrimonio='" + NumeroPatrimonio + "',DiretorioNotaFiscal='',DtHr='" + DateTime.Now + "' where idPatrimonio=" + idPatrimonio);

                db.ExecuteNonQuery(@"Update PatrimonioSemaforo set DataInstalacao='" + DataInstalacao +
                   "',Fixacao='" + Fixacao +
                   "' where IdPatrimonio=" + idPatrimonio);

                #endregion
            }
            else
            {
                #region Salvar

                string idPatrimonioSemaforo = "";

                int i = 0;
                int NmrPat = 0;
                if (NumeroPatrimonio != "")
                {
                    NmrPat = Convert.ToInt32(NumeroPatrimonio);
                    while (quantidade > i)
                    {
                        i++;
                        NmrPat++;
                    }
                    dt = db.ExecuteReaderQuery("select idPatrimonio from Patrimonio where NumeroPatrimonio BETWEEN " + NumeroPatrimonio + " AND " + (NmrPat - 1) + " and idPrefeitura=" + idPrefeitura);
                    if (dt.Rows.Count > 0)
                    {
                        string msg = "Existem Nºs de Patrimonios sendo usado no intervalo de " + NumeroPatrimonio + " a " + (NmrPat - 1) + "!";
                        lst.Add(string.Format("{0}", msg));
                    }

                    NmrPat = Convert.ToInt32(NumeroPatrimonio);
                    i = 0;
                }
                if (lst.Count == 0)
                {

                    dt = db.ExecuteReaderQuery(@"select p.*,tp.Dsc from Produto p
JOIN TipoProduto tp on p.IdTipoProduto = tp.IdTipoProduto
JOIN Categoria c on c.id = p.IdCategoria where p.Id=" + idProduto);
                    if (NmrPat != 0)
                    {
                        while (quantidade > i)
                        {

                            if (dt.Rows.Count > 0)
                            {
                                DataRow dr = dt.Rows[0];
                                idPatrimonio = db.ExecuteScalarQuery(@"insert into Patrimonio (Fabricante,idCategoria,IdDepartamento,idPrefeitura,IdProduto,
idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,DiretorioNotaFiscal,DtHr) values ('" + Fabricante + "'," +
      dr["idCategoria"].ToString() + "," + idDepartamento + "," + idPrefeitura + "," +
     idProduto + ",'" + idSubDivisao + "'," + dr["idtipoProduto"].ToString() + ",'" + dr["Modelo"].ToString() + "','"
     + dr["NomeProduto"].ToString() + "','" + dr["NumeroSerie"].ToString() + "','" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "','" + NmrPat + "','','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()");


                                idPatrimonioSemaforo = db.ExecuteScalarQuery(@"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao,DataInstalacao,Fixacao)
Values(" + idPatrimonio + ",'" + idDepartamento + "','" + idSubDivisao + "','" + DataInstalacao + "','" + Fixacao + "') SELECT SCOPE_IDENTITY()");

                                if (idOcorrencia != "")
                                {
                                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'ACESSORIO', '" + idPatrimonioSemaforo + "', " + quantidade + ", '" + dr["Marca"].ToString() + " - " + dr["Modelo"].ToString() + "', 'INCLUSAO DE MATERIAL')");
                                }
                            }
                            i++;
                            NmrPat++;
                        }
                    }
                    else
                    {
                        while (quantidade > i)
                        {

                            if (dt.Rows.Count > 0)
                            {
                                DataRow dr = dt.Rows[0];
                                idPatrimonio = db.ExecuteScalarQuery(@"insert into Patrimonio (Fabricante,idCategoria,IdDepartamento,idPrefeitura,IdProduto,
idSubDivisao,IdTipoProduto,modelo,NomeProduto,NumeroSerie,TipoUni,Marca,NumeroPatrimonio,DiretorioNotaFiscal,DtHr) values ('" + Fabricante + "'," +
      dr["idCategoria"].ToString() + "," + idDepartamento + "," + idPrefeitura + "," +
     idProduto + ",'" + idSubDivisao + "'," + dr["idtipoProduto"].ToString() + ",'" + dr["Modelo"].ToString() + "','"
     + dr["NomeProduto"].ToString() + "','" + dr["NumeroSerie"].ToString() + "','" + dr["TipoUni"].ToString() + "','" + dr["Marca"].ToString() + "','','','" + DateTime.Now + "') SELECT SCOPE_IDENTITY()");

                                idPatrimonioSemaforo = db.ExecuteScalarQuery(@"insert into PatrimonioSemaforo(IdPatrimonio,IdDepartamento,IdSubdivisao,DataInstalacao,Fixacao)
            Values(" + idPatrimonio + ",'" + idDepartamento + "','" + idSubDivisao + "','" + DataInstalacao + "','" + Fixacao + "') SELECT SCOPE_IDENTITY()");

                                if (idOcorrencia != "")
                                {
                                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'ACESSORIO', '" + idPatrimonioSemaforo + "', " + quantidade + ", '" + dr["Marca"].ToString() + " - " + dr["Modelo"].ToString() + "', 'INCLUSAO DE MATERIAL')");
                                }
                            }
                            i++;
                        }
                    }

                }
                #endregion
            }
            return lst;

        }

        [WebMethod]
        public void DeleteAcessorios(string idPatrimonio, string idPrefeitura, int quantidade, string idOcorrencia, string idDnaGSS)
        {
            //db.ExecuteNonQuery("delete from Patrimonio where idPatrimonio=" + idPatrimonio);
            //db.ExecuteNonQuery("delete from PatrimonioSemaforo where IdPatrimonio=" + idPatrimonio);
            string marca = "";
            string modelo = "";
            string idPatrimonioSemaforo = "";

            db.ExecuteNonQuery("UPDATE [dbo].[Patrimonio] SET [Status] = 'Removido' WHERE [IdPatrimonio]=" + idPatrimonio + " and [idPrefeitura]=" + idPrefeitura);

            DataTable dt = db.ExecuteReaderQuery(@"SELECT ps.[Id], p.[marca], p.[modelo] FROM [Sicapp].[dbo].[PatrimonioSemaforo] ps
	  join [dbo].[Patrimonio] p on p.[IdPatrimonio] = ps.[IdPatrimonio] where p.[idPrefeitura] ='" + idPrefeitura + "' and ps.[IdPatrimonio]=" + idPatrimonio);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                marca = dr["marca"].ToString();
                modelo = dr["modelo"].ToString();
                idPatrimonioSemaforo = dr["Id"].ToString();

                if (idOcorrencia != "")
                {
                    db.ExecuteNonQuery(@"USE [semaforo] INSERT INTO [dbo].[TalaoMateriais]([idPrefeitura],[idTalao],[idDna],[TipoMaterial],[idPatrimonioSemaforo],[Qtd],[DscMaterial],[Operacao]) 
VALUES ('" + idPrefeitura + "','" + idOcorrencia + "', '" + idDnaGSS + "', 'ACESSORIO', '" + idPatrimonioSemaforo + "', " + quantidade + ", '" + marca + " - " + modelo + "', 'Remocao de Material')");
                }
            }
        }

        [WebMethod]
        public List<string> SelectAcessorio(string idPatrimonio)
        {
            List<string> lst = new List<string>();

            dt = db.ExecuteReaderQuery(@"Select p.*,f.RazaoSocial,ps.* from Patrimonio p 
        left join Fornecedor f on p.idFornecedor = f.id  
        join PatrimonioSemaforo ps on p.IdPatrimonio = ps.IdPatrimonio
        where ps.Id=" + idPatrimonio);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}@{5}@{6}", dr["IdPatrimonio"].ToString(), dr["NumeroSerie"].ToString(), dr["Fabricante"].ToString(),
                    dr["DataInstalacao"].ToString(), dr["NomeProduto"].ToString(), dr["NumeroPatrimonio"].ToString(),
                    dr["Fixacao"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public string InsertTag(string EPC, string idPrefeitura, string idsubdivisao)
        {
            string sql = "";
            DataTable dt;
            Banco db = new Banco("");

            if (db.ExecuteReaderQuery(
                "SELECT Id FROM TagsCruzamento "+
                " WHERE Tag = '" + EPC + "' "+
                " AND idprefeitura = " + idPrefeitura).Rows.Count > 0)
            {
                return "REPETIDO";
            }

            sql = "INSERT INTO TagsCruzamento (Tag,idsubdivisao,idprefeitura) "+
                " VALUES ('" + EPC + "'," + idsubdivisao + "," + idPrefeitura + ")";
            db.ExecuteNonQuery(sql);
            return "OK";
        }

        [WebMethod]
        public string EditTag(string EPC, string Id, string idsubdivisao, string idPrefeitura)
        {
            string sql = "";
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery(
                "SELECT Id FROM TagsCruzamento WHERE Tag = '" + EPC + "' "+
                " AND idPrefeitura = " + idPrefeitura
                );

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                if (Id != dr["Id"].ToString())
                {
                    return "REPETIDO";
                }
            }

            sql = "UPDATE TagsCruzamento SET Tag='" + EPC + "' WHERE Id=" + Id;
            db.ExecuteNonQuery(sql);
            return "OK";
        }

        [WebMethod]
        public void DeleteTag(string Id)
        {
            string sql = "";
            DataTable dt;
            Banco db = new Banco("");

            sql = "Delete from TagsCruzamento where Id=" + Id;
            db.ExecuteNonQuery(sql);
        }

        [WebMethod]
        public List<string> ValidNmrPatParametro(string idPrefeitura, int quantidade, string NumeroPatrimonio)
        {
            List<string> lst = new List<string>();
            int i = 0;
            int nmrPat = int.Parse(NumeroPatrimonio);
            while (quantidade > i)
            {
                dt = db.ExecuteReaderQuery(@"select NumeroPatrimonio from Patrimonio 
where NumeroPatrimonio='" + nmrPat + "' and idPrefeitura=" + idPrefeitura);

                if (dt.Rows.Count > 0)
                {
                    string msg = "O número de patrimonio " + nmrPat + " por parametro já esta vinculado a um produto";
                    lst.Add(string.Format("{0}", msg));
                }
                i++;
                nmrPat++;
            }
            return lst;
        }

        [WebMethod]
        public List<ListaMateriais> ProcurarProdutoSub(string idPrefeitura, string idSub, string Prod)
        {

            if (Prod.ToUpper() == "GPRS CONTROLADOR" || Prod.ToUpper() == "GPRS NOBREAK")
            {
                int n = Prod.IndexOf(" ");
                if (n > 0)
                {
                    Prod = Prod.Substring(0, n);
                }
            }

            if (Prod.ToUpper() == "SISTEMA DE ILUMINAÇÃO")
            {
                dt = db.ExecuteReaderQuery(@"select (p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
JOIN Produto p on p.Id=pa.IdProduto
JOIN Categoria c on c.id =pa.idCategoria
JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
where (categoria like'%ILUMINAÇÃO%' or categoria like'%ILUMINACAO%') and s.Id = " + idSub + " and pa.idPrefeitura=" + idPrefeitura + " order by Produto");

            }
            else
            {
                dt = db.ExecuteReaderQuery(@"select (p.NomeProduto+' - '+ p.Modelo+' - ' + Fabricante)Produto,pa.idSubdivisao,Subdivisao,s.Endereco,IdPatrimonio,NumeroPatrimonio from Patrimonio pa
JOIN Produto p on p.Id=pa.IdProduto
JOIN Categoria c on c.id =pa.idCategoria
JOIN Subdivisao_Departamento s on s.Id=pa.idSubDivisao
where categoria like '%" + Prod.ToUpper() + "%' and s.Id = " + idSub + " and pa.idPrefeitura=" + idPrefeitura + " order by Produto");
            }
            List<ListaMateriais> lstProd = new List<ListaMateriais>();
            foreach (DataRow item in dt.Rows)
            {
                lstProd.Add(new ListaMateriais
                {
                    idSub = item["IdSubdivisao"].ToString(),
                    idPatrimonio = item["IdPatrimonio"].ToString(),
                    Produto = item["Produto"].ToString(),
                    NmrPatrimonio = item["NumeroPatrimonio"].ToString(),
                    Subdivisao = item["Subdivisao"].ToString(),
                    Endereco = item["Endereco"].ToString()
                });
            }
            return lstProd;
        }
        [WebMethod]
        public List<ListaMateriais> Almoxarifado(string idPrefeitura)
        {
            dt = db.ExecuteReaderQuery(@"Select s.Id,Subdivisao,s.Endereco from Subdivisao_Departamento s
join Departamento d on d.Id= s.IdDepartamento
where IdPrefeitura=" + idPrefeitura + " and s.ALMOXARIFADO='true'");
            List<ListaMateriais> lstSub = new List<ListaMateriais>();
            foreach (DataRow item in dt.Rows)
            {
                lstSub.Add(new ListaMateriais
                {
                    idSub = item["Id"].ToString(),
                    Subdivisao = item["Subdivisao"].ToString(),
                    Endereco = item["Endereco"].ToString()
                });
            }
            return lstSub;
        }

        [WebMethod]
        public List<ListaMateriais> Manutencao(string idPrefeitura)
        {
            dt = db.ExecuteReaderQuery(@"Select s.Id,Subdivisao,s.Endereco from Subdivisao_Departamento s
join Departamento d on d.Id= s.IdDepartamento
where IdPrefeitura=" + idPrefeitura + " and s.manutencao='true'");
            List<ListaMateriais> lstSub = new List<ListaMateriais>();
            foreach (DataRow item in dt.Rows)
            {
                lstSub.Add(new ListaMateriais
                {
                    idSub = item["Id"].ToString(),
                    Subdivisao = item["Subdivisao"].ToString(),
                    Endereco = item["Endereco"].ToString()
                });
            }
            return lstSub;
        }

        [WebMethod]
        public void salvarManutencao(string idPatrimonio, string idSubdivisaoMov, string idPrefeitura, string motivo, string ocorrencia, string produto)
        {
            string idDepartamento = db.ExecuteScalarQuery(@"select IdDepartamento from Subdivisao_Departamento where id=" + idSubdivisaoMov);

            produto = produto.Replace("ç", "c");
            produto = produto.Replace("ã", "a");
            produto = produto.Replace("ó", "o");

            dt = db.ExecuteReaderQuery(@"select p.idPatrimonio,ps.PertencePatrimonio from PatrimonioSemaforo ps
join patrimonio p on p.idPatrimonio=ps.idPatrimonio
join categoria c on c.id=p.idcategoria
where ps.id=" + idPatrimonio + " and p.idPrefeitura=" + idPrefeitura + " and categoria='" + produto.ToUpper() + "'");
            string idPat = "";
            if (dt.Rows.Count == 0)
            {
                idPat = idPatrimonio;
                dt = db.ExecuteReaderQuery(@"select PertencePatrimonio from PatrimonioSemaforo ps
where ps.idPatrimonio=" + idPatrimonio);
                if (dt.Rows.Count == 0)
                {
                    DataRow item = dt.Rows[0];
                    produto = produto + " " + item["PertencePatrimonio"].ToString();
                }
            }
            else
            {
                DataRow item = dt.Rows[0];
                idPat = item["idPatrimonio"].ToString();
                produto = produto + " " + item["PertencePatrimonio"].ToString();
            }

            if (produto.ToUpper() == "GPRS NOBREAK" || produto.ToUpper() == "GPRS CONTROLADOR")
            {
                if (produto.ToUpper() == "GPRS NOBREAK")
                {
                    db.ExecuteNonQuery(@"update PatrimonioSemaforo 
                set idSubdivisao=" + idSubdivisaoMov + ",idDepartamento=" + idDepartamento + ",PertencePatrimonio='NOBREAK' where idPatrimonio=" + idPat);
                }
                else
                {
                    db.ExecuteNonQuery(@"update PatrimonioSemaforo 
                set idSubdivisao=" + idSubdivisaoMov + ",idDepartamento=" + idDepartamento + ",PertencePatrimonio='CONTROLADOR' where idPatrimonio=" + idPat);
                }
            }
            else
            {
                db.ExecuteNonQuery(@"update PatrimonioSemaforo set idSubdivisao=" + idSubdivisaoMov +
                    ",idDepartamento=" + idDepartamento + " where idPatrimonio=" + idPat);
            }

            db.ExecuteNonQuery(@"insert into Ocorrencia (Data,IdPatrimonio,IdDepartamento,Ocorrencia,IdMotivo)
values('" + DateTime.Now.ToString("dd/MM/yyyy") + "'," + idPat + "," + idDepartamento +
              ",'" + ocorrencia + "','" + motivo + "')");

            dt = db.ExecuteReaderQuery(@"select IdDepartamento,idSubDivisao from Patrimonio where IdPatrimonio=" + idPat);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                db.ExecuteNonQuery(@"Insert into LogMovimento (DataHora,Usuario,IdPatrimonio,IdDepartamento,
                IdSubdivisao,IdPrefeitura,IdDepAnterior,IdSubAnterior)Values
                ('" + DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss") + "','" + User.Identity.Name.ToString() +
            "'," + idPat + ",'" + idDepartamento + "','" + idSubdivisaoMov +
            "'," + idPrefeitura + ",'" + dr["IdDepartamento"].ToString() + "','" + dr["IdSubdivisao"].ToString() + "')");
            }

            db.ExecuteNonQuery(@"update Patrimonio set DtHr='" + DateTime.Now + "',IdDepartamento=" + idDepartamento +
                ",IdSubdivisao=" + idSubdivisaoMov + " where IdPatrimonio = " + idPat);
        }
    }
}

