using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using Infortronics;

namespace GwCentral.WebServices
{
    /// <summary>
    /// Summary description for ProgSemaforica
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class ProgSemaforica : System.Web.Services.WebService
    {
        [WebMethod]
        public List<string> FindHoursProg(string hoursInitial, string hoursEnd)
        {
            Banco db = new Banco("");
            string sql = "";
            DataTable dt;
            if (string.IsNullOrEmpty(hoursInitial) && string.IsNullOrEmpty(hoursEnd))
            {
                sql = @"select distinct HrInicio,HrFim from progAmarelopiscante where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"];
            }
            else
            {
                sql = @"select distinct HrInicio,HrFim from progAmarelopiscante where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] +
                " and HrInicio='" + hoursInitial + "' and HrFim ='" + hoursEnd + "'";
            }
            dt = db.ExecuteReaderQuery(sql);

            List<string> lst = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}", item["HrInicio"].ToString(), item["HrFim"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> FindControllers(string Id)
        {
            Banco db = new Banco("");
            string sql = "";
            DataTable dt;

            sql = @"select distinct d.Id,d.Cruzamento,Serial from status s join Dna d on s.IdDna=d.Id
where d.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and d.Id='" + Id + "'";
            dt = db.ExecuteReaderQuery(sql);

            List<string> lst = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}", item["Id"].ToString(), item["Cruzamento"].ToString(), item["Serial"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> FindSetControllers(string Id)
        {
            Banco db = new Banco("");
            string sql = "";
            DataTable dt;

            sql = @"select p.Serial,d.Id from status s join Dna d on s.IdDna=d.Id
join ProgAmareloPiscante p on p.Serial=s.Serial
where d.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and d.Id='" + Id + "'";
            dt = db.ExecuteReaderQuery(sql);

            List<string> lst = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}", item["Id"].ToString(), item["Serial"].ToString()));
            }

            return lst;

        }

        [WebMethod]
        public List<string> ControllersProg(string hoursInitial, string hoursEnd)
        {
            Banco db = new Banco("");
            string sql = "";
            DataTable dt;

            sql = @"select distinct d.Id,d.Cruzamento,p.Serial from status s join Dna d on s.IdDna=d.Id
join ProgAmareloPiscante p on p.Serial=s.Serial
where d.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " and HrInicio='" + hoursInitial + "' and HrFim='" + hoursEnd + "'";
            dt = db.ExecuteReaderQuery(sql);

            List<string> lst = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}", item["Id"].ToString(), item["Cruzamento"].ToString(), item["Serial"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public List<string> ListControllers()
        {
            Banco db = new Banco("");
            string sql = "";
            DataTable dt;
            sql = @"select distinct d.Id,d.Cruzamento,Serial from status s join Dna d on s.IdDna=d.Id
where d.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"];
            dt = db.ExecuteReaderQuery(sql);

            List<string> lst = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}@{2}", item["Id"].ToString(), item["Cruzamento"].ToString(), item["Serial"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public void InsertHoursProg(string hoursInitial, string hoursEnd, string serial, string iddna)
        {
            Banco db = new Banco("");
            string sql = "";
            sql = @"Insert Into progAmarelopiscante (HrInicio,HrFim,Serial,IdPrefeitura,IdDna) 
            values ('" + hoursInitial + "','" + hoursEnd + "','" + serial + "','" + HttpContext.Current.Profile["idPrefeitura"] + "','" + iddna + "')";
            db.ExecuteNonQuery(sql);


        }

        [WebMethod]
        public void EditHoursProg(string hoursInitial, string hoursEnd, string serial, string hriniSave, string hrfimSave, string iddna)
        {
            Banco db = new Banco("");
            string sql = "";
            DataTable dt;
            sql = @"Update progAmarelopiscante set HrInicio='" + hoursInitial + "',HrFim='" + hoursEnd +
                "' where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] +
                " and HrInicio='" + hriniSave + "' and HrFim='" + hrfimSave + "'";
            db.ExecuteNonQuery(sql);
            if (!string.IsNullOrEmpty(serial))
            {
                sql = "select * from progAmarelopiscante where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] +
    " and HrInicio='" + hoursInitial + "' and HrFim ='" + hoursEnd +
    "' and serial='" + serial + "'";
                dt = db.ExecuteReaderQuery(sql);
                if (dt.Rows.Count > 0)
                {
                    sql = @"Delete from progAmarelopiscante where serial='" + serial + "' and IdPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] +
                    " and HrInicio='" + hoursInitial + "' and HrFim='" + hoursEnd + "'";
                    db.ExecuteNonQuery(sql);
                }
                else
                {
                    sql = @"Insert Into progAmarelopiscante (HrInicio,HrFim,Serial,IdPrefeitura,IdDna) 
            values ('" + hoursInitial + "','" + hoursEnd + "','" + serial + "','" + HttpContext.Current.Profile["idPrefeitura"] + "','" + iddna + "')";
                    db.ExecuteNonQuery(sql);
                }
            }

        }

        [WebMethod]
        public List<string> SetControllers(string hoursInitial, string hoursEnd)
        {
            Banco db = new Banco("");
            string sql = "";
            DataTable dt;

            sql = @"select d.Id,p.Serial from status s join Dna d on s.IdDna=d.Id
join ProgAmareloPiscante p on p.Serial=s.Serial where p.idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] +
            " and HrInicio='" + hoursInitial + "' and HrFim ='" + hoursEnd + "'";
            dt = db.ExecuteReaderQuery(sql);

            List<string> lst = new List<string>();
            foreach (DataRow item in dt.Rows)
            {
                lst.Add(string.Format("{0}@{1}", item["Id"].ToString(), item["Serial"].ToString()));
            }

            return lst;

        }

        [WebMethod]
        public void DeleteHoursProg(string hoursInitial, string hoursEnd)
        {
            Banco db = new Banco("");
            string sql = "";

            sql = @"delete from progAmarelopiscante where idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] +
            " and HrInicio='" + hoursInitial + "' and HrFim='" + hoursEnd + "'";
            db.ExecuteNonQuery(sql);

        }
    }
}
