using Infortronics;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;
using System.Xml;

namespace GwCentral.Register.Corredor
{
	public partial class Default : System.Web.UI.Page
	{
		public static string idioma = "pt-BR";
		public static CultureInfo cultureInfo;
		protected override void InitializeCulture()
		{
			idioma = Request.UserLanguages != null ? Request.UserLanguages[0] : "pt-BR";
			if (HttpContext.Current.Profile["idioma"].Equals(idioma) || string.IsNullOrEmpty(HttpContext.Current.Profile["idioma"].ToString()))
			{
				cultureInfo = new CultureInfo(idioma);
				HttpContext.Current.Profile["idioma"] = idioma;
				Thread.CurrentThread.CurrentCulture = cultureInfo;
				Thread.CurrentThread.CurrentUICulture = cultureInfo;
			}
			else
			{
				idioma = HttpContext.Current.Profile["idioma"].ToString();
				cultureInfo = new CultureInfo(idioma);
				Thread.CurrentThread.CurrentCulture = cultureInfo;
				Thread.CurrentThread.CurrentUICulture = cultureInfo;
			}
		}

		[WebMethod]
		public static void changeLanguage(string idioma)
		{
			HttpContext.Current.Profile["idioma"] = idioma;
		}

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		public static string getResource(string nameResource)
		{
			string valueResource = "";
			string file = getFileResource(idioma);
			string folder = "App_GlobalResources";

			string filePath = HttpContext.Current.Server.MapPath(@"~\" + folder + @"\" + file);
			XmlDocument document = new XmlDocument();
			document.Load(filePath);

			XmlNodeList nodes = document.SelectNodes("//data");
			foreach (XmlNode node in nodes)
			{
				XmlAttribute attr = node.Attributes["name"];
				string resourceKey = attr.Value;
				if (resourceKey == nameResource)
				{
					valueResource = HttpContext.GetGlobalResourceObject("Resource", resourceKey, cultureInfo).ToString();
					break;
				}
			}
			return valueResource;
		}

		public static string getFileResource(string idioma)
		{
			string file = "Resource.resx";
			if (!string.IsNullOrEmpty(idioma))
			{
				file = idioma.IndexOf("es") != -1 ? "Resource.es.resx" : file; //espanhol
				file = idioma.IndexOf("en") != -1 ? "Resource.en.resx" : file; //ingles
			}
			return file;
		}

		[WebMethod]
		public static List<CorredorAnel> GetCorredorAneis(string idCorredor)
		{
			Banco db = new Banco("");
			List<CorredorAnel> lst = new List<CorredorAnel>();
			DataTable dt = db.ExecuteReaderQuery(@"select cruzamento=(select endereco from LocaisGruposLogicos lgl where lgl.id=gl.idLocal),
(convert(varchar,a.idEqp))idEqp,a.anel,Distancia,tempoentrecruzamentos,ca.id,a.idArea,ca.grupologico,indice
 from CorredorAneis ca
 JOIN GruposLogicos gl on gl.GrupoLogico = ca.GrupoLogico and gl.idEqp=ca.idEqp
 JOIN AreaAneis a on a.id=ca.idAreaAneis where idCorredor=" + idCorredor);
			foreach (DataRow dr in dt.Rows)
			{
				lst.Add(new CorredorAnel
				{

					TempoEntreCruzamento = dr["tempoentrecruzamentos"].ToString(),
					Distancia = dr["distancia"].ToString(),
					idEqp = dr["idEqp"].ToString(),
					Cruzamento = dr["cruzamento"].ToString(),
					Anel = dr["Anel"].ToString(),
					GrupoLogico = dr["GrupoLogico"].ToString(),
					idCorredorAnel = dr["id"].ToString(),
					idSubArea = dr["idArea"].ToString(),
					indice = dr["indice"].ToString()
				});
			}
			return lst;
		}

		[WebMethod]
		public static void ExcluirAnel(string idCorredorAnel)
		{
			Banco db = new Banco("");
			db.ExecuteNonQuery("delete CorredorAneis where id=" + idCorredorAnel);
		}

		[WebMethod]
		public static List<CorredorAnel> loadCorredor()
		{
			Banco db = new Banco("");
			DataTable dt = db.ExecuteReaderQuery(@"select id,Corredor,idSubArea from Corredor where idPrefeitura= " + HttpContext.Current.Profile["idPrefeitura"].ToString());
			List<CorredorAnel> lst = new List<CorredorAnel>();
			foreach (DataRow dr in dt.Rows)
			{
				lst.Add(new CorredorAnel
				{
					Corredor = dr["Corredor"].ToString(),
					idCorredor = dr["Id"].ToString(),
					idSubArea = dr["Idsubarea"].ToString()
				});
			}

			return lst;
		}

		[WebMethod]
		public static List<CorredorAnel> GetCorredoresCad()
		{
			Banco db = new Banco("");
			DataTable dt = db.ExecuteReaderQuery(@"select c.id,Corredor,idSubArea,tempoPercurso,((select nome from Area_SubArea aa where aa.id=a.idarea)+' - '+nome)Subarea,
(select count(0) from CorredorAneis ca where ca.idCorredor=c.id)qtdAneis from Corredor c
JOIN Area_SubArea a on a.id=c.idSubArea where c.idPrefeitura= " + HttpContext.Current.Profile["idPrefeitura"].ToString());
			List<CorredorAnel> lst = new List<CorredorAnel>();
			foreach (DataRow dr in dt.Rows)
			{
				lst.Add(new CorredorAnel
				{
					Corredor = dr["Corredor"].ToString(),
					idCorredor = dr["Id"].ToString(),
					qtdAneis = dr["qtdAneis"].ToString(),
					idSubArea = dr["Idsubarea"].ToString(),
					SubArea = dr["SubArea"].ToString(),
					TempoPercurso = dr["TempoPercurso"].ToString()
				});
			}

			return lst;
		}

		[WebMethod]
		public static ArrayList loadSubarea()
		{
			Banco db = new Banco("");
			DataTable dt = db.ExecuteReaderQuery(@" select aa.Nome+ ' - '+a.Nome Nome,a.id from Area_SubArea a  JOIN Area_SubArea aa on aa.id=a.idArea
where a.idPrefeitura= " + HttpContext.Current.Profile["idPrefeitura"].ToString() + " and a.tipo='subArea'");
			ArrayList lst = new ArrayList();
			foreach (DataRow dr in dt.Rows)
			{
				lst.Add(new ListItem(dr["Nome"].ToString(), dr["Id"].ToString()));
			}

			return lst;
		}

		[WebMethod]
		public static List<CorredorAnel> getAneisSubArea(string idCorredor)
		{
			Banco db = new Banco("");
			List<CorredorAnel> lst = new List<CorredorAnel>();
			string sql = @"select a.id,a.idEqp,anel,subarea=(select nome from Area_SubArea aa where aa.id=a.idArea) from AreaAneis a 
JOIN DNA d on d.Id=convert(varchar,a.idEqp)
JOIN Corredor c on c.idSubArea=a.idArea where c.id=" + idCorredor;

			DataTable dt = db.ExecuteReaderQuery(sql);
			foreach (DataRow dr in dt.Rows)
			{
				lst.Add(new CorredorAnel
				{
					idAreaAneis = dr["id"].ToString(),
					Anel = dr["anel"].ToString(),
					idEqp = dr["idEqp"].ToString()
				});
			}
			return lst;
		}

		[WebMethod]
		public static ArrayList getSubAreaCorredor(string idCorredor)
		{
			Banco db = new Banco("");
			ArrayList lst = new ArrayList();
			DataTable dt = db.ExecuteReaderQuery(@"select ((select nome from Area_SubArea aa where aa.id=a.idarea)+' - '+nome)Subarea,c.idSubArea from Corredor c
JOIN Area_SubArea a on a.id=c.idSubArea where c.id=" + idCorredor);
			if (dt.Rows.Count > 0)
			{
				lst.Add(new ListItem(dt.Rows[0]["subarea"].ToString(), dt.Rows[0]["idSubarea"].ToString()));
			}
			return lst;
		}

		[WebMethod]
		public static string getTrajeto(string idSubarea)
		{
			Banco db = new Banco("");
			string id = db.ExecuteScalarQuery("select id from trajetos where idArea=" + idSubarea);
			return id;
		}

		[WebMethod]
		public static ArrayList GetGrupoLogico(string idEqp, string anel)
		{
			Banco db = new Banco("");
			ArrayList lst = new ArrayList();
			DataTable dt = db.ExecuteReaderQuery("select GrupoLogico ,TipoGrupo from GruposLogicos where idEqp='" + idEqp + "' and anel='" + anel + "'");
			foreach (DataRow dr in dt.Rows)
			{
				lst.Add(new ListItem(dr["GrupoLogico"].ToString(), dr["TipoGrupo"].ToString()));
			}
			return lst;
		}

		[WebMethod]
		public static string SalvarCorredor(string idSubArea, string corredor, string tempoPercurso)
		{
			Banco db = new Banco("");
			string idArea = db.ExecuteScalarQuery("select idArea from Area_SubArea where id=" + idSubArea);
			string existe = db.ExecuteScalarQuery("select id from Corredor where corredor='" + corredor + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
			if (!string.IsNullOrEmpty(existe))
			{
				return "ATENÇÃO:" + getResource("corredorExisteMesmoNome") + "!";
			}
			string id = db.ExecuteScalarQuery(@"insert into Corredor (Corredor,idArea,idSubArea,idPrefeitura,TempoPercurso)
values('" + corredor + "'," + idArea + "," + idSubArea + "," + HttpContext.Current.Profile["idPrefeitura"].ToString() + ",'" + tempoPercurso + "') SELECT SCOPE_IDENTITY()");
			return id;
		}

		[WebMethod]
		public static string AlterarCorredor(string idSubArea, string corredor, string tempoPercurso, string idCorredor)
		{
			Banco db = new Banco("");
			string idArea = db.ExecuteScalarQuery("select idArea from Area_SubArea where id=" + idSubArea);
			string existe = db.ExecuteScalarQuery("select id from Corredor where corredor='" + corredor + "' and id<>" + idCorredor + " and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"].ToString());
			if (!string.IsNullOrEmpty(existe))
			{
				return getResource("corredorExisteMesmoNome") + "!";
			}

			db.ExecuteNonQuery("update Corredor set corredor='" + corredor + "',tempoPercurso='" + tempoPercurso + "',idSubArea=" + idSubArea + ",idArea=" + idArea + " where id=" + idCorredor);

			return "SUCESSO";
		}

		[WebMethod]
		public static string AlterarCorredorAnel(string idCorredorAnel, string distancia, string tempoEntreCruzamentos, string grupoLogico, string indice, string idEqp, string idCorredor)
		{
			Banco db = new Banco("");
			string existe = db.ExecuteScalarQuery("select id from corredorAneis where grupoLogico=" + grupoLogico + " and idEqp='" + idEqp + "' and id<>" + idCorredorAnel);
			if (!string.IsNullOrEmpty(existe))
			{
				return getResource("grupo") + ":" + grupoLogico + " " + getResource("grupoJaEstaSendoUsadoNoCorredor") + "!";
			}
			existe = db.ExecuteScalarQuery("select id from corredorAneis where indice=" + indice + " and idCorredor=" + idCorredor + " and id<>" + idCorredorAnel);
			if (!string.IsNullOrEmpty(existe))
			{
				return getResource("indiceCorredor") + ":" + indice + " " + getResource("jaEstaCadastrado") + "!";
			}

			db.ExecuteNonQuery("update CorredorAneis set distancia='" + distancia + "',tempoEntreCruzamentos='" + tempoEntreCruzamentos + "',indice=" + indice + ",grupoLogico=" + grupoLogico + " where id=" + idCorredorAnel);

			return "SUCESSO";
		}

		[WebMethod]
		public static void ExcluirCorredor(string idCorredor)
		{
			Banco db = new Banco("");
			db.ExecuteNonQuery("delete corredorAneis where idCorredor=" + idCorredor);
			db.ExecuteNonQuery("delete corredor where id=" + idCorredor);
		}

		[WebMethod]
		public static string SalvarCorredorAneis(string idCorredor, string idAreaAneis, string distancia, string tempoEntreCruzamentos, string grupoLogico, string idEqp, string anel, string indice)
		{
			Banco db = new Banco("");
			#region valida
			string existe = db.ExecuteScalarQuery("select id from CorredorAneis where idEqp='" + idEqp + "' and GrupoLogico='" + grupoLogico + "' and idCorredor<>" + idCorredor);
			if (!string.IsNullOrEmpty(existe))
			{
				return "ATENÇÃO: " + getResource("grupo") + ": " + grupoLogico + " - " + getResource("anel") + ": " + idEqp + " - " + anel + " " + getResource("grupoJaEstaSendoUsadoNoCorredor");
			}
			existe = db.ExecuteScalarQuery("select id from CorredorAneis where idEqp='" + idEqp + "' and GrupoLogico='" + grupoLogico + "' and idCorredor=" + idCorredor);
			if (!string.IsNullOrEmpty(existe))
			{
				return "ATENÇÃO: " + getResource("grupo") + ": " + grupoLogico + " " + getResource("grupoJaEstaSendoUsadoNoCorredor");
			}

			existe = db.ExecuteScalarQuery("select id from corredorAneis where indice=" + indice + " and idCorredor=" + idCorredor);
			if (!string.IsNullOrEmpty(existe))
			{
				return "ATENÇÃO: " + getResource("indiceCorredor") + ":" + indice + " " + getResource("JaExisteNoCorredor") + "!";
			}
			#endregion
			string idCorredorAnterior = "NULL";
			string qtd = db.ExecuteScalarQuery("select COUNT(0) from CorredorAneis where idCorredor=" + idCorredor);
			if (qtd != "0")
			{
				idCorredorAnterior = db.ExecuteScalarQuery("select top 1 id from CorredorAneis where idcorredor=" + idCorredor + " order by id desc");
			}
			string id = db.ExecuteScalarQuery(@"insert into CorredorAneis (idCorredor,idAreaAneis,Distancia,TempoEntreCruzamentos,idPrefeitura,idEqp,GrupoLogico,idCorredorAnterior,indice)
values(" + idCorredor + "," + idAreaAneis + ",'" + distancia + "','" + tempoEntreCruzamentos + "'," + HttpContext.Current.Profile["idPrefeitura"].ToString() +
		 ",'" + idEqp + "'," + grupoLogico + "," + idCorredorAnterior + "," + indice + ") SELECT SCOPE_IDENTITY()");
			return id;
		}

		public struct CorredorAnel
		{
			public string GrupoLogico { get; set; }
			public string TempoPercurso { get; set; }
			public string idCorredor { get; set; }
			public string idCorredorAnel { get; set; }
			public string Corredor { get; set; }
			public string idSubArea { get; set; }
			public string Cruzamento { get; set; }
			public string idEqp { get; set; }
			public string qtdAneis { get; set; }

			public string SubArea { get; set; }
			public string idAreaAneis { get; set; }
			public string indice { get; set; }
			public string Anel { get; set; }
			public string Distancia { get; set; }
			public string TempoEntreCruzamento { get; set; }
		}
	}
}