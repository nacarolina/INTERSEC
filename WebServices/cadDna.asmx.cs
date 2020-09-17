using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Web;
using System.Web.Hosting;
using System.Web.Services;

namespace GwCentral.WebServices
{
	/// <summary>
	/// Summary description for cadDna
	/// </summary>
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.Web.Script.Services.ScriptService]
	public class cadDna : System.Web.Services.WebService
	{

		string sql = "";
		Banco db = new Banco("");
		DataTable dt;

		[WebMethod]
		public List<string> PesqDna(string idDna, string Dna)
		{
			sql = "select Id,Cruzamento,latitude,longitude,Empresa from Dna where IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"];
			if (idDna != "")
			{
				sql += " and Id='" + idDna + "'";
			}
			dt = db.ExecuteReaderQuery(sql);

			List<string> lst = new List<string>();
			if (dt.Rows.Count > 0)
			{
				DataRow item = dt.Rows[0];
				lst.Add(string.Format("{0}@{1}@{2}@{3}@{4}", item["Id"].ToString(), item["Cruzamento"].ToString(), item["latitude"].ToString(),
				item["longitude"].ToString(), item["Empresa"].ToString()));
			}


			return lst;
		}

		[WebMethod]
		public string Salvar(string idDna, string Dna, string Latitude, string Longitude, string User, string modelo, string serialMestre)
		{
           string verificar = db.ExecuteScalarQuery(string.Format("select idDna from [Status] where IdDna ='{0}' and IdPrefeitura={1}", idDna, HttpContext.Current.Profile["idPrefeitura"]));

            if (!string.IsNullOrEmpty(verificar))
            {
                return "Este Id do Dna ja foi vinculado";
            }

            sql = "select * from Dna where Id='" + idDna + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"];
			dt = db.ExecuteReaderQuery(sql);

			if (dt.Rows.Count == 0)
			{
				sql = @"Insert Into Dna (Id,Cruzamento,Latitude,Longitude,Usuario,Idprefeitura)
            values ('" + idDna + "','" + Dna + "','" + Latitude + "','" + Longitude + "','" + User +
			"','" + HttpContext.Current.Profile["idPrefeitura"] + "')";
				db.ExecuteNonQuery(sql);

				db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User + "','Cadastro Cruzamento'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
					"','Cadastrou o Cruzamento: " + Dna + ", latitude: " + Latitude + ", longitude: " + Longitude + ", idDna: " + idDna + "','DNA')");
			}
			string existe = db.ExecuteScalarQuery("select serial from [status] where serial='" + idDna + "' and idPrefeitura="+ HttpContext.Current.Profile["idPrefeitura"]);

			if (string.IsNullOrEmpty(existe))
            {
                existe = db.ExecuteScalarQuery("select serial from [status] where serial='" + idDna + "'");
                if (existe != "")
                {
                    return Resources.Resource.serialExistente;
                }
                db.ExecuteNonQuery(string.Format(@"insert into [Status] (Serial,IdDna,IdPrefeitura,Modelo,SerialMestre)
values ('{0}','{1}','{2}','{3}','{4}')", idDna, idDna, HttpContext.Current.Profile["idPrefeitura"],modelo,serialMestre));

				db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User + "','Cadastro Cruzamento'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
					"','Alterou o Cruzamento: " + Dna + ", latitude: " + Latitude + ", longitude: " + Longitude + ",modelo:"+modelo+", serialMestre:"+serialMestre+" do idDna: " + idDna + "','DNA')");
			}
			else
			{
                db.ExecuteNonQuery(string.Format(@"update [Status] set idDna='{0}',idPrefeitura={1},modelo='{2}',serialMestre='{3}'
where serial = '{0}'", idDna, HttpContext.Current.Profile["idPrefeitura"],modelo,serialMestre));

				db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User + "','Cadastro Equipamento'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
					"','Alterou o controlador serial: " + idDna + ", HabilitacaoCentral: true,modelo:" + modelo + ", serialMestre:" + serialMestre + ", idDNA: " + idDna + "','Status')");
			}
            return "SUCESSO";
		}
		[WebMethod]
		public List<Croqui> CarregaArquivosCroqui(string idEqp)
		{
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
		public void ExcluirArquivo(string Id, string NomeArquivo)
		{
			db.ExecuteNonQuery("delete from CroquiEqp where id=" + Id);
			try
			{
				File.Delete(HostingEnvironment.MapPath("~/Register/Controller/ArquivoCroqui/" + NomeArquivo));
			}
			catch (Exception e)
			{
			}
		}

		public struct Croqui
		{
			public string Id { get; set; }
			public string NomeArquivo { get; set; }
		}

		[WebMethod]
		public void Editar(string idDna, string Dna, string Latitude, string Longitude, string User, string modelo, string serialMestre)
		{
			string existe = db.ExecuteScalarQuery("select serial from [status] where serial='" + idDna + "'");

            if (string.IsNullOrEmpty(existe))
            {
                db.ExecuteNonQuery(string.Format(@"insert into [Status] (Serial,IdDna,IdPrefeitura,Modelo,SerialMestre)
values ('{0}','{1}','{2}','{3}','{4}')", idDna, idDna, HttpContext.Current.Profile["idPrefeitura"], modelo, serialMestre));

                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User + "','Cadastro Cruzamento'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Alterou o Cruzamento: " + Dna + ", latitude: " + Latitude + ", longitude: " + Longitude + ",modelo:" + modelo + ", serialMestre:" + serialMestre + " do idDna: " + idDna + "','DNA')");
            }
            else
            {
                db.ExecuteNonQuery(string.Format(@"update [Status] set idDna='{0}',idPrefeitura={1},modelo='{2}',serialMestre='{3}'
where serial = '{0}'", idDna, HttpContext.Current.Profile["idPrefeitura"], modelo, serialMestre));

                db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User + "','Cadastro Equipamento'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
                    "','Alterou o controlador serial: " + idDna + ", HabilitacaoCentral: true,modelo:" + modelo + ", serialMestre:" + serialMestre + ", idDNA: " + idDna + "','Status')");
            }
            sql = @"Update Dna set cruzamento='" + Dna + "',Latitude='" + Latitude + "',Longitude='" + Longitude +
			"' where Id='" + idDna + "' and Idprefeitura=" + HttpContext.Current.Profile["idPrefeitura"];
			db.ExecuteNonQuery(sql);

			db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User + "','Cadastro Cruzamento'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
				"','Alterou o Cruzamento: " + Dna + ", latitude: " + Latitude + ", longitude: " + Longitude + " do idDna: " + idDna + "','DNA')");
		}

		[WebMethod]
		public List<string> Excluir(string idDna)
		{
			sql = "select * from controladordna cd join dna d on cd.iddna=d.id where iddna='" + idDna + "' and idprefeitura=" + HttpContext.Current.Profile["idPrefeitura"];
			dt = db.ExecuteReaderQuery(sql);
			string controlador = "true";
			if (dt.Rows.Count == 0)
			{
				string cruzamento = db.ExecuteScalarQuery("select cruzamento from DNA where id='" + idDna + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
				controlador = "false";

				sql = @"delete from Dna where Id='" + idDna + "' and IdPrefeitura = " + HttpContext.Current.Profile["idPrefeitura"];
				db.ExecuteNonQuery(sql);

				db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User.Identity.Name + "','Cadastro Cruzamento'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
					"','Excluiu o Cruzamento idDNA: " + idDna + "','DNA')");

				sql = @"delete from Status where IdDna='" + idDna + "' and IdPrefeitura = " + HttpContext.Current.Profile["idPrefeitura"];
				db.ExecuteNonQuery(sql);

				db.ExecuteNonQuery(@"insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + User.Identity.Name + "','Cadastro Cruzamento'," + HttpContext.Current.Profile["idPrefeitura"] + ",'" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") +
					"','Excluiu a serial: " + idDna + "','STATUS')");

				dt = db.ExecuteReaderQuery("select NomeArquivo from CroquiEqp where idEqp='" + idDna + "'");
				foreach (DataRow dr in dt.Rows)
				{
					try
					{
						File.Delete(HostingEnvironment.MapPath("~/Register/Controller/ArquivoCroqui/" + dr["NomeArquivo"].ToString()));
					}
					catch (Exception e)
					{
					}
				}
				db.ExecuteNonQuery("delete from CroquiEqp where idEqp='" + idDna + "'");
			}
			List<string> lst = new List<string>();
			lst.Add(string.Format("{0}", controlador));
			return lst;

		}

		/* ============== Locais Grupos Lógicos ======================= */

		public struct Locais
		{
			public string id { get; set; }
			public string endereco { get; set; }
			public string latitude { get; set; }
			public string longitude { get; set; }
			public string tipoMarcador { get; set; }
		}

		[WebMethod]
		public List<Locais> listarLocais(string idEqp)
		{
			sql = "select * from LocaisGruposLogicos where IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and IdEqp='" + idEqp + "' order by endereco ";
			dt = db.ExecuteReaderQuery(sql);

			List<Locais> lst = new List<Locais>();

			foreach (DataRow item in dt.Rows)
			{
				lst.Add(new Locais
				{
					id = item["Id"].ToString(),
					endereco = item["endereco"].ToString(),
					latitude = item["latitude"].ToString(),
					longitude = item["longitude"].ToString(),
					tipoMarcador = item["tipoMarcador"].ToString()
				});
			}


			return lst;
		}

		public struct GruposSemaforicos
		{
			public string idEqp { get; set; }
			public string tipo { get; set; }
			public string grupo { get; set; }
			public string tipoMarcador { get; set; }
			public string anel { get; set; }
            public string modelo { get; set; }
            public string idModelo { get; set; }
		}

		[WebMethod]
		public List<GruposSemaforicos> ListarGruposSemaforicos(string idLocal, string idEqp)
		{
            if (string.IsNullOrEmpty(idLocal))
                sql = "Select GrupoLogico,TipoGrupo,IdEqp,tipoMarcador,Anel,Modelo,mgs.id idModelo from GruposLogicos gl left join ModeloGrupoSemaforico mgs on gl.idModeloGrupoSemaforico = mgs.id " +
                    " where (IdLocal is null or IdLocal='') And idEqp='" + idEqp + "' order by GrupoLogico";

            else
                sql = "Select GrupoLogico,TipoGrupo,IdEqp,tipoMarcador,Anel,Modelo,mgs.id idModelo from GruposLogicos gl left join ModeloGrupoSemaforico mgs on gl.idModeloGrupoSemaforico = mgs.id " +
                    " where IdLocal=" + idLocal + " And idEqp='" + idEqp + "' order by GrupoLogico";

            dt = db.ExecuteReaderQuery(sql);

            List<GruposSemaforicos> lst = new List<GruposSemaforicos>();

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new GruposSemaforicos
                {
                    idEqp = item["IdEqp"].ToString(),
                    tipo = item["TipoGrupo"].ToString(),
                    grupo = item["GrupoLogico"].ToString(),
                    tipoMarcador = item["tipoMarcador"].ToString(),
                    anel = item["Anel"].ToString(),
                    modelo = item["Modelo"].ToString(),
                    idModelo=item["idModelo"].ToString()
                });
            }
            return lst;
		}

		[WebMethod]
		public void VincularGrupoSemaforico(string idLocal, string grupo, string idEqp, string tipoMarcador)
		{
			db.ExecuteNonQuery(@"Update GruposLogicos set idLocal=" + idLocal + ", tipoMarcador='" + tipoMarcador +
				"' Where GrupoLogico=" + grupo + " and IdEqp='" + idEqp + "'");
		}

		[WebMethod]
		public void ExcluirVinculoGrupoSemaforico(string idLocal, string grupo, string idEqp)
		{
			db.ExecuteNonQuery("Update GruposLogicos set idLocal=null Where GrupoLogico=" + grupo + " and IdEqp='" + idEqp + "'");
		}

		[WebMethod]
		public string SalvarLocalGrupoLogico(string local, string latitude, string longitude, string grupo, string idEqp, string tipoMarcador)
		{
			int grupoSemaforico = 0;

			string idLocal = "";
			if (int.TryParse(grupo, out grupoSemaforico))
			{
				DataTable dt = db.ExecuteReaderQuery(@"Select IdLocal from GruposLogicos WHERE GrupoLogico=" + grupo + " AND idEqp='" + idEqp + "'");
				if (dt.Rows.Count > 0) idLocal = dt.Rows[0]["IdLocal"].ToString();

				sql = @"Update LocaisGruposLogicos set endereco='" + local + "',latitude='" + latitude + "',longitude='" + longitude +
			"' where Id=" + idLocal;
				db.ExecuteNonQuery(sql);
			}
			else
			{
				sql = "select id from LocaisGruposLogicos where latitude='" + latitude + "' and longitude='" + longitude + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and IdEqp='" + idEqp + "'";
				idLocal = db.ExecuteScalarQuery(sql);

				if (string.IsNullOrEmpty(idLocal))
				{
					sql = @"Insert Into LocaisGruposLogicos (endereco,Latitude,Longitude,IdPrefeitura,idEqp,tipoMarcador)
            values ('" + local + "','" + latitude + "','" + longitude + "','" + HttpContext.Current.Profile["idPrefeitura"] + "','" + idEqp + "','" + tipoMarcador + "') SELECT SCOPE_IDENTITY()";
					idLocal = db.ExecuteScalarQuery(sql);
				}
			}

			return idLocal;

		}

		[WebMethod]
		public void EditarLocalGrupoLogico(string id, string local, string latitude, string longitude, string grupo, string idEqp)
		{
			int grupoSemaforico = 0;

			if (int.TryParse(grupo, out grupoSemaforico))
			{
				DataTable dt = db.ExecuteReaderQuery(@"Select IdLocal from GruposLogicos WHERE GrupoLogico=" + grupo + " AND idEqp='" + idEqp + "'");
				if (dt.Rows.Count > 0) id = dt.Rows[0]["IdLocal"].ToString();
			}
			sql = @"Update LocaisGruposLogicos set endereco='" + local + "',latitude='" + latitude + "',longitude='" + longitude +
			"' where Id=" + id;
			db.ExecuteNonQuery(sql);
		}

		public struct GruposLocais
		{
			public string grupo { get; set; }
			public string tipo { get; set; }
			public string Endereco { get; set; }
			public string lat { get; set; }
			public string lng { get; set; }
			public string tipoMarcador { get; set; }
			public string idLocal { get; set; }
			public string anel { get; set; }
		}

		[WebMethod]
		public List<GruposLocais> getGruposLocais(string idEqp, string idLocal)
		{
			List<GruposLocais> lst = new List<GruposLocais>();

			string sql = @"Select GrupoLogico, TipoGrupo, Endereco, latitude, longitude, lg.tipoMarcador,lg.Id IdLocal,g.Anel
From LocaisGruposLogicos lg left Join GruposLogicos g on lg.Id = g.IdLocal
Where lg.IdEqp='" + idEqp + "'";
			DataTable dt = db.ExecuteReaderQuery(sql);
			foreach (DataRow item in dt.Rows)
			{
				lst.Add(new GruposLocais
				{
					grupo = item["GrupoLogico"].ToString(),
					tipo = item["TipoGrupo"].ToString(),
					Endereco = item["Endereco"].ToString(),
					lat = item["latitude"].ToString(),
					lng = item["longitude"].ToString(),
					tipoMarcador = item["tipoMarcador"].ToString(),
					idLocal = item["IdLocal"].ToString(),
					anel = item["Anel"].ToString()
				});
			}
			return lst;
		}

		/*[WebMethod]
        public List<GruposLocais> getGrupoLocal(string idEqp, string idLocal)
        {
            List<GruposLocais> lst = new List<GruposLocais>();
            DataTable dt = db.ExecuteReaderQuery(@"Select GrupoLogico,TipoGrupo,Endereco,latitude,longitude,lg.tipoMarcador,lg.Id IdLocal,g.Anel
From LocaisGruposLogicos lg left Join GruposLogicos g on lg.Id = g.IdLocal Where lg.IdEqp='" + idEqp + "' and lg.Id =" + idLocal);
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new GruposLocais
                {
                    grupo = item["GrupoLogico"].ToString(),
                    tipo = item["TipoGrupo"].ToString(),
                    Endereco = item["Endereco"].ToString(),
                    lat = item["latitude"].ToString(),
                    lng = item["longitude"].ToString(),
                    tipoMarcador = item["tipoMarcador"].ToString(),
                    idLocal = item["IdLocal"].ToString(),
                    anel = item["Anel"].ToString()
                });
            }
            return lst;
        }*/

		[WebMethod]
		public void deleteLocal(string idLocal)
		{
			db.ExecuteNonQuery("delete from locaisGruposLogicos Where id=" + idLocal + "; Update GruposLogicos set IdLocal=null, tipoMarcador=null Where IdLocal=" + idLocal);
		}
	}
}

