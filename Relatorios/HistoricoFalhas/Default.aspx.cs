using Infortronics;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GwCentral.Relatorios.HistoricoFalhas
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetLogCityHall();
            }
        }

        #region SetLogCityHall

        private void SetLogCityHall()
        {
            Banco db = new Banco("");

            foreach (string role in Roles.GetRolesForUser())
            {
                DataTable dt = db.ExecuteReaderQuery(string.Format("SELECT Prefeitura,logoCaminho FROM Prefeitura Where Prefeitura ='{0}'", role.Replace("cliente: ", "")));
                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    lblNomePrefeitura.Text = dr["Prefeitura"].ToString();

                    if (!string.IsNullOrEmpty(dr["logoCaminho"].ToString()))
                    {
                        imgPrefeitura.ImageUrl = dr["logoCaminho"].ToString();
                    }
                }
            }

        }

        #endregion


        [ScriptMethod()]
        [WebMethod]
        public static List<string> GetDna(string prefixText)
        {
            Banco db = new Banco("");

            HistoFalha hf = new HistoFalha();

            long idPrefeitura = hf.GetIdCityHall();

            db.ClearSQLParams();
            db.AddSQLParam("Cruzamento", prefixText);
            db.AddSQLParam("idPrefeitura", idPrefeitura);
            DataTable dt = db.ExecuteReaderStoredProcedure("GetDna", true);

            List<string> lstDna = new List<string>();

            foreach (DataRow item in dt.Rows)
            {
                lstDna.Add(string.Format("{0}@{1}", item["Id"].ToString(), item["Cruzamento"].ToString()));
            }

            return lstDna;
        }
    }
}