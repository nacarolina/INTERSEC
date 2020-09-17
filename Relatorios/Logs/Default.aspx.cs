using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace GwCentral.Relatorios.Logs
{
	public partial class Default : System.Web.UI.Page
	{
		public static string idioma = "pt-BR";
		public static CultureInfo cultureInfo;
		Banco db = new Banco("");
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
		public struct localesResource
		{
			public string name { get; set; }
			public string value { get; set; }
		}

		[WebMethod]
		public static object requestResource()
		{
			List<localesResource> resource = new List<localesResource>();
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
				resource.Add(new localesResource
				{
					name = resourceKey,
					value = HttpContext.GetGlobalResourceObject("Resource", resourceKey, cultureInfo).ToString()
				});
			}
			var json = JsonConvert.SerializeObject(new { resource });
			return json;
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

		protected void Page_Load(object sender, EventArgs e)
		{
			hfIdPrefeitura.Value = HttpContext.Current.Profile["idPrefeitura"].ToString();
		}
		[WebMethod]
		public static List<string> FiltraUser(string prefixText, string IdPrefeitura)
		{
			Banco db = new Banco("");
			DataTable dt = db.ExecuteReaderQuery(string.Format(@"select [Email], Protocolo=(select [Protocolo] from [dbo].[HabilitacaoFuncionario] hf where hf.[FuncId] = f.[Id]) from [dbo].[CadFuncionario] f where [IdPrefeitura] = " + IdPrefeitura + " and [Email] like '%{0}%' order by [Email]", prefixText));

			List<string> lstEstablishments = new List<string>();
			foreach (DataRow item in dt.Rows)
			{
				lstEstablishments.Add(item[0].ToString() + " - " + item[1].ToString());
			}
			return lstEstablishments;
		}

		[WebMethod]
		public static List<FilterParameters> loadTela(string idPrefeitura)
		{
			List<FilterParameters> lst = new List<FilterParameters>();
			Banco db = new Banco("");
			DataTable dt = db.ExecuteReaderQuery("select distinct [Tela] from [dbo].[LogsSistema] where [idPrefeitura] = " + idPrefeitura + " order by [Tela]");

			foreach (DataRow item in dt.Rows)
			{
				lst.Add(new FilterParameters
				{
					Tela = item["Tela"].ToString()
				});
			}
			return lst;
		}

		public struct FilterParameters
		{
			public string Tela { get; set; }
		}

		[WebMethod]
		public static List<Logs> GetLogs(string dtIni, string dtFim, string Tipo, string IdPrefeitura, string user, string Tela, string tag)
		{
			Banco db = new Banco("");
			DataTable dt;
			List<Logs> lst = new List<Logs>();
			StringBuilder query = new StringBuilder();

			query.Append("select [id],[idPrefeitura],[DtHr],[user],[Tabela] log,[Dsc],[Tela] from [dbo].[LogsSistema] where [idPrefeitura] =" + IdPrefeitura);

			if (user != "")
			{
				query.Append(string.Format("and ([user] = '{0}' or [Dsc] like '%{0}%')", user.Trim()));
			}

			if (Tela != "TODAS")
			{
				query.Append(" and [Tela]= '" + Tela + "'");
			}

			if (Tipo == "Mensal")
				query.Append(" and substring([DtHr],4,7)= '" + dtIni + "'");
			else if (Tipo == "Periodo")
				query.Append(string.Format(" and convert(date,[DtHr]) >= convert(date,'{0}') AND convert(date, [DtHr]) <= Convert(date,'{1}')", dtIni, dtFim));
			else
				query.Append(string.Format(" and convert(date,[DtHr]) = convert(date,'{0}')", dtIni));

			if (tag.Trim() != "")
			{
				query.Append(" and [Dsc] like '%" + tag + "%'");
			}
			query.Append(" ORDER BY convert(datetime, [DtHr])desc");
			string consulta = query.ToString();
			dt = db.ExecuteReaderQuery(query.ToString());
			foreach (DataRow dr in dt.Rows)
			{
				if (dr["Tela"].ToString() == "ALTERAR SENHA DO USUARIO")
				{
					string senha = dr["Dsc"].ToString().Replace("ALTEROU A SENHA PARA=", "").Replace("DO USUARIO", "").Split(':')[0];
					lst.Add(new Logs()
					{
						DtHr = dr["DtHr"].ToString(),
						user = dr["user"].ToString(),
						Log = dr["Log"].ToString(),
						Descricao = dr["Dsc"].ToString().Replace("PARA=" + senha, ""),
						Tela = dr["Tela"].ToString()
					});
				}
				else
				{
					lst.Add(new Logs()
					{
						DtHr = dr["DtHr"].ToString(),
						user = dr["user"].ToString(),
						Log = dr["Log"].ToString(),
						Descricao = dr["Dsc"].ToString(),
						Tela = dr["Tela"].ToString()
					});
				}
			}
			return lst;
		}

		public struct Logs
		{
			public string DtHr { get; set; }
			public string user { get; set; }
			public string Log { get; set; }
			public string Descricao { get; set; }
			public string Tela { get; set; }
		}
	}
}