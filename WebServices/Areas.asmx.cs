using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace GwCentral.Register.Areas
{
    /// <summary>
    /// Descrição resumida de Areas
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que esse serviço da web seja chamado a partir do script, usando ASP.NET AJAX, remova os comentários da linha a seguir. 
    [System.Web.Script.Services.ScriptService]
    public class Areas : System.Web.Services.WebService
    {

        public struct AllRoutes
        {
            public string Id { get; set; }
            public string Area { get; set; }
            public string Coordinates { get; set; }
        }

        [WebMethod]
        public List<AllRoutes> ListAllArea()
        {
            DataTable dt;
            Banco db = new Banco("");
            List<AllRoutes> lst = new List<AllRoutes>();

            dt = db.ExecuteReaderQuery("select id,NomeArea,Replace(AreaCoordenadas,'(','')AreaCoordenadas from area Where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);


            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new AllRoutes
                {
                    Area = item["NomeArea"].ToString(),
                    Coordinates = item["AreaCoordenadas"].ToString(),
                    Id = item["Id"].ToString()
                });
            }

            return lst;
        }

        public class AreaProperties
        {
            public string coords { get; set; }
            public string NomeArea { get; set; }
            public string id { get; set; }
        }

        [WebMethod(EnableSession = true)]
        public string Salvar(List<AreaProperties> AreaCollection)
        {
            string id = "";
            Banco db = new Banco("");
            foreach (var item in AreaCollection)
            {
                #region InsertArea
                if (string.IsNullOrEmpty(item.id))
                {
                    DataTable dt = db.ExecuteReaderQuery("Select id from Area Where NomeArea='" + item.NomeArea + "' and IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

                    if (dt.Rows.Count == 0) id = db.ExecuteScalarQuery(@"INSERT INTO Area (NomeArea,AreaCoordenadas,IdPrefeitura)
VALUES('" + item.NomeArea + "','" + item.coords + "'," + HttpContext.Current.Profile["idPrefeitura"] + ")SELECT SCOPE_IDENTITY()");
                    else id = "";
                }
                else
                {
                    id = item.id;
                    DataTable dt = db.ExecuteReaderQuery("Select id from Area Where NomeArea='" + item.NomeArea + "' And id <>" + item.id +
                        " and IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

                    if (dt.Rows.Count == 0) db.ExecuteNonQuery("Update Area set NomeArea='" + item.NomeArea + "', AreaCoordenadas='" + item.coords +
                        "' where id=" + item.id);
                    else id = "";
                }

                #endregion
            }
            return id;
        }

        public class VinculoGrupoArea
        {
            public string idLocal { get; set; }
            public string idArea { get; set; }
        }

        [WebMethod(EnableSession = true)]
        public void VincularGruposArea(List<VinculoGrupoArea> gruposVinculados)
        {
            Banco db = new Banco("");
            foreach (var item in gruposVinculados)
            {
                db.ExecuteNonQuery("Update GruposLogicos set idArea=" + item.idArea + " WHERE IdLocal=" + item.idLocal);
            }
        }

        [WebMethod]
        public void Excluir(string id)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery(@"Delete from Area where id=" + id + "; Update Trajetos set idArea=null Where idArea=" + id);
        }

        public struct LoadAneis
        {
            public string anel { get; set; }
            public string idLocal { get; set; }
            public string idEqp { get; set; }
            public string lat { get; set; }
            public string lng { get; set; }
        }

        [WebMethod]
        public List<LoadAneis> LoadAnel(string anel)
        {
            Banco db = new Banco("");
            List<LoadAneis> lst = new List<LoadAneis>();

            DataTable dt = db.ExecuteReaderQuery(@"SELECT idLocal,lg.idEqp,latitude,longitude,anel FROM LocaisGruposLogicos lg JOIN GruposLogicos g ON 
lg.Id=g.IdLocal WHERE Anel=" + anel + " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " order by idEqp");

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new LoadAneis
                {
                    idLocal = item["idLocal"].ToString(),
                    idEqp = item["idEqp"].ToString(),
                    lat = item["latitude"].ToString(),
                    lng = item["longitude"].ToString(),
                    anel = item["anel"].ToString()
                });

            }

            return lst;
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
            public string idEqp { get; set; }
        }

        [WebMethod]
        public List<GruposLocais> getGrupoSemaforico()
        {
            Banco db = new Banco("");
            List<GruposLocais> lst = new List<GruposLocais>();

            string sql = @"Select GrupoLogico, TipoGrupo, Endereco, latitude, longitude, lg.tipoMarcador,lg.Id IdLocal, g.Anel, g.IdEqp
From LocaisGruposLogicos lg left Join GruposLogicos g on lg.Id = g.IdLocal WHERE idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] +
" and GrupoLogico is not null order by idEqp";

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
                    anel = item["Anel"].ToString(),
                    idEqp = item["idEqp"].ToString()
                });
            }
            return lst;
        }

        [WebMethod]
        public List<GruposLocais> getGruposArea(string idArea)
        {
            Banco db = new Banco("");
            List<GruposLocais> lst = new List<GruposLocais>();

            DataTable dt = db.ExecuteReaderQuery(@"Select GrupoLogico,TipoGrupo,Endereco,latitude,longitude,lg.tipoMarcador,lg.Id IdLocal,g.Anel,g.IdEqp
From LocaisGruposLogicos lg left Join GruposLogicos g on lg.Id = g.IdLocal Where lg.IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]
+ " and g.idArea=" + idArea);

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
                    anel = item["Anel"].ToString(),
                    idEqp = item["IdEqp"].ToString()
                });

            }

            return lst;
        }

        [WebMethod]
        public void ExcluirVinculoGrupoArea(string grupo, string idLocal, string idArea)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery("Update GruposLogicos set idArea=null Where GrupoLogico=" + grupo + " and idLocal=" + idLocal + " And idArea=" + idArea);
        }
    }
}
