using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Services;

namespace GwCentral.Register.ConfigModuloComunicacao
{
	public partial class Default : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			
		}

		public struct Configuracao
		{
			public string numeroSerie { get; set; }
			public string serial { get; set; }
			public string ipAddressServer1 { get; set; }
			public string portServer1 { get; set; }
			public string ipAddressServer2 { get; set; }
			public string DtHrAtualizacao { get; set; }
			public string portServer2 { get; set; }
			public string id { get; set; }
			public string operadoraSimm1 { get; set; }
			public string operadoraSimm2 { get; set; }
			public string portaIIS { get; set; }
			public string ipReset { get; set; }
			public string portaReset { get; set; }
			public string permiteReqImagens { get; set; }
			public string permiteReset { get; set; }
		}

		[WebMethod]
		public static List<Configuracao> BuscarConfiguracao(string nSerie, string serial)
		{
			
			List<Configuracao> lstConfiguracao = new List<Configuracao>();

			Banco db = new Banco("");

			string sql = @"SELECT isnull(numeroSerie, S.serial)numeroSerie,id, S.serial, ipAddressServer1, ipAddressServer2,portServer1, portServer2,
Atualizado, operadoraSimm1, operadoraSimm2, portaIIS, ipReset,PortaReset, permiteReqImagens, permiteReset 
FROM [Status] s
left JOIN Configuracao c on  s.Serial=c.serial WHERE S.serial like'%" + nSerie+"%'";

			DataTable dt = db.ExecuteReaderQuery(sql);
			foreach (DataRow item in dt.Rows)
			{
				string atualizado = item["atualizado"].ToString();
				lstConfiguracao.Add(new Configuracao
				{
					id = item["id"].ToString(),
					numeroSerie = item["numeroSerie"].ToString(),
					serial = item["serial"].ToString(),
					ipAddressServer1 = item["ipAddressServer1"].ToString(),
					portServer1 = item["portServer1"].ToString(),
					ipAddressServer2 = item["ipAddressServer2"].ToString(),
					portServer2 = item["portServer2"].ToString(),
					operadoraSimm1 = item["operadoraSimm1"].ToString(),
					operadoraSimm2 = item["operadoraSimm2"].ToString(),
					portaIIS = item["portaIIS"].ToString(),
					ipReset = item["ipReset"].ToString(),
					DtHrAtualizacao=atualizado,
					portaReset = item["portaReset"].ToString(),
					permiteReqImagens = item["permiteReqImagens"].ToString(),
					permiteReset = item["permiteReset"].ToString()
				});
			}

			return lstConfiguracao;

		}

		[WebMethod]
		public static string SalvarConfiguracao(string numeroSerie, string serial, string ipAddressServer1, string portServer1,
			string ipAddressServer2, string portServer2, string operadoraSimm1, string operadoraSimm2, string portaIIS, string ipReset,
			string portaReset, string permiteReqImagens, string permiteReset, string id)
		{
			Banco db = new Banco("");
			string sql = "";
			
			if (string.IsNullOrEmpty(id))
			{
				#region valida serial
				string existe = db.ExecuteScalarQuery("select serial from configuracao where serial='" + serial + "'");
				if (!string.IsNullOrEmpty(existe))
				{
					return "serial";
				}
				#endregion
				DataTable dt = db.ExecuteReaderQuery("SELECT Serial FROM Configuracao WHERE numeroSerie='" + numeroSerie + "'");
				if (dt.Rows.Count == 0)
				{
					sql = @"INSERT INTO Configuracao (numeroSerie, serial, ipAddressServer1, portServer1, ipAddressServer2, portServer2, " +
						"operadoraSimm1, operadoraSimm2, portaIIS, ipReset, portaReset, permiteReqImagens, permiteReset) VALUES ('" + numeroSerie +
						"','" + serial + "','" + ipAddressServer1 + "','" + portServer1 + "','" + ipAddressServer2 + "','" + portServer2 +
						"','" + operadoraSimm1 + "','" + operadoraSimm2 + "','" + portaIIS + "','" + ipReset + "','" + portaReset +
						"','" + permiteReqImagens + "','true') select SCOPE_IDENTITY()";

					 id=db.ExecuteScalarQuery(sql);

				
				}
				else
				{
					return "Numero Serie";
				}
			}
			else
			{

				#region valida serial
				string existe = db.ExecuteScalarQuery("select serial from configuracao where serial='" + serial + "' and id<>"+id);
				if (!string.IsNullOrEmpty(existe))
				{
					return "serial";
				}
				#endregion
				sql = @"UPDATE Configuracao SET  serial='" + serial + "', ipAddressServer1= '" + ipAddressServer1 +
					"', portServer1='" + portServer1 + "', ipAddressServer2='" + ipAddressServer2 + "', portServer2='" + portServer2 +
					"', operadoraSimm1='" + operadoraSimm1 + "', operadoraSimm2='" + operadoraSimm2 + "', portaIIS='" + portaIIS +
					"', ipReset='" + ipReset + "', portaReset='" + portaReset + "', permiteReqImagens='" + permiteReqImagens +
					"', permiteReset='true' WHERE id="+id;
				
				db.ExecuteNonQuery(sql);
			}

			return "SUCESSO";
		}

		[WebMethod]
		public static void ExcluirConfiguracao(string id)
		{
			Banco db = new Banco("");
			db.ExecuteNonQuery("DELETE FROM Configuracao WHERE id=" + id);
		}
	}
}
