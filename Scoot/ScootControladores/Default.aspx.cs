using Infortronics;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using static GwCentral.Admin.MapConfig;

namespace GwCentral.Register.ScootControladores
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hfUsuarioLogado.Value = User.Identity.Name;
            }
        }

        [WebMethod]
        public static ArrayList loadRegiao()
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco("");

            DataTable dt = db.ExecuteReaderQuery(@"select id, substring(scn,4,5)scn from ScootRegion");
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["scn"].ToString(), dr["id"].ToString()));
            }
            return lst;
        }

        public struct controladoresCad
        {
            public string qtdCaractereIdentificacaoControlador { get; set; }
            public string id { get; set; }
            public string scnControlador { get; set; }
            public string ipControlador { get; set; }
            public string cruzamento { get; set; }
            public string anel1 { get; set; }
            public string anel2 { get; set; }
            public string anel3 { get; set; }
            public string anel4 { get; set; }
            public string qtdEstagio1 { get; set; }
            public string qtdEstagio2 { get; set; }
            public string qtdEstagio3 { get; set; }
            public string qtdEstagio4 { get; set; }
            public string estagiosDesativarTMPE1 { get; set; }
            public string estagiosDesativarTMPE2 { get; set; }
            public string estagiosDesativarTMPE3 { get; set; }
            public string estagiosDesativarTMPE4 { get; set; }
            public string cruzamentoAnel1 { get; set; }
            public string cruzamentoAnel2 { get; set; }
            public string cruzamentoAnel3 { get; set; }
            public string cruzamentoAnel4 { get; set; }
            public string tempoEnvioEstagio { get; set; }
            public string modelo { get; set; }
        }

        public struct Junctions
        {
            public bool SlaveController { get; set; }
            public string ControllerType { get; set; }
            public string DelayToIntergreen { get; set; }
            public bool SignalStuckInhibit { get; set; }
            public bool SlBitMeaning { get; set; }
            public string MinGreenCyclicCheckSequence { get; set; }
            public string CyclicCheckSequence { get; set; }
            public string NonCyclicCheckSequence { get; set; }
            public bool SmoothPlanChange { get; set; }
            public string RoadGreens_Main { get; set; }
            public string RoadGreens_Side { get; set; }
            public string ScnRegiao { get; set; }
            public string MaxCycleTime { get; set; }
            public string QtdFases { get; set; }
            public string CyclicFixedTime { get; set; }
            public string NamedStage { get; set; }
            public bool DoubleCycling { get; set; }
            public bool ForceSingleOrDoubleCycling { get; set; }
            public string FirstRemovableStage { get; set; }
            public string SecondRemovableStage { get; set; }
            public bool FirstStageRemovedPlan1 { get; set; }
            public bool FirstStageRemovedPlan2 { get; set; }
            public bool FirstStageRemovedPlan3 { get; set; }
            public bool FirstStageRemovedPlan4 { get; set; }
            public bool FirstStageRemovedPlan5 { get; set; }
            public bool FirstStageRemovedPlan6 { get; set; }
            public bool SecondStageRemovedPlan1 { get; set; }
            public bool SecondStageRemovedPlan2 { get; set; }
            public bool SecondStageRemovedPlan3 { get; set; }
            public bool SecondStageRemovedPlan4 { get; set; }
            public bool SecondStageRemovedPlan5 { get; set; }
            public bool SecondStageRemovedPlan6 { get; set; }
        }

        [WebMethod]
        public static List<controladoresCad> carregarControladoresCad()
        {
            Banco db = new Banco("");
            List<controladoresCad> lst = new List<controladoresCad>();
            DataTable dt = db.ExecuteReaderQuery(
                @"SELECT id, scnControlador, ipControlador, cruzamento, scnAnel1, scnAnel2,
                scnAnel3, scnAnel4, qtdEstagioAnel1,qtdEstagioAnel2,qtdEstagioAnel3,
                qtdEstagioAnel4, estagiosDesativarTMPE1,estagiosDesativarTMPE2,
                estagiosDesativarTMPE3, estagiosDesativarTMPE4, cruzamentoAnel1,
                cruzamentoAnel2,cruzamentoAnel3,cruzamentoAnel4,tempoAntesEnvioEstagio,modelo 
                FROM scootControladores
                WHERE idPrefeitura='" + HttpContext.Current.Profile["idPrefeitura"] + "' "
                );

            foreach (DataRow item in dt.Rows)
            {
                lst.Add(new controladoresCad
                {
                    id = item["id"].ToString(),
                    scnControlador = item["scnControlador"].ToString(),
                    ipControlador = item["ipControlador"].ToString(),
                    cruzamento = item["cruzamento"].ToString(),
                    anel1 = item["scnAnel1"].ToString(),
                    anel2 = item["scnAnel2"].ToString(),
                    anel3 = item["scnAnel3"].ToString(),
                    anel4 = item["scnAnel4"].ToString(),
                    qtdEstagio1 = item["qtdEstagioAnel1"].ToString(),
                    qtdEstagio2 = item["qtdEstagioAnel2"].ToString(),
                    qtdEstagio3 = item["qtdEstagioAnel3"].ToString(),
                    qtdEstagio4 = item["qtdEstagioAnel4"].ToString(),
                    estagiosDesativarTMPE1 = item["estagiosDesativarTMPE1"].ToString(),
                    estagiosDesativarTMPE2 = item["estagiosDesativarTMPE2"].ToString(),
                    estagiosDesativarTMPE3 = item["estagiosDesativarTMPE3"].ToString(),
                    estagiosDesativarTMPE4 = item["estagiosDesativarTMPE4"].ToString(),
                    cruzamentoAnel1 = item["cruzamentoAnel1"].ToString(),
                    cruzamentoAnel2 = item["cruzamentoAnel2"].ToString(),
                    cruzamentoAnel3 = item["cruzamentoAnel3"].ToString(),
                    cruzamentoAnel4 = item["cruzamentoAnel4"].ToString(),
                    tempoEnvioEstagio = item["tempoAntesEnvioEstagio"].ToString(),
                    modelo = item["modelo"].ToString()
                });
            }

            return lst;
        }

        [WebMethod]
        public static List<Junctions> carregarDadosAnel(string junction)
        {
            Banco db = new Banco("");
            List<Junctions> lst = new List<Junctions>();

            DataTable dt = db.ExecuteReaderQuery("select * from scootJunction where Junction='" + junction + "'");
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new Junctions
                {
                    CyclicCheckSequence = dr["CyclicCheckSequence"].ToString(),
                    CyclicFixedTime = dr["CyclicFixedTime"].ToString(),
                    DelayToIntergreen = dr["DelayToIntergreen"].ToString(),
                    FirstRemovableStage = dr["FirstRemovableStage"].ToString(),
                    FirstStageRemovedPlan1 = Convert.ToBoolean(dr["FirstStageRemoved_Plano1"].ToString()),
                    FirstStageRemovedPlan2 = Convert.ToBoolean(dr["FirstStageRemoved_Plano2"].ToString()),
                    FirstStageRemovedPlan3 = Convert.ToBoolean(dr["FirstStageRemoved_Plano3"].ToString()),
                    FirstStageRemovedPlan4 = Convert.ToBoolean(dr["FirstStageRemoved_Plano4"].ToString()),
                    FirstStageRemovedPlan5 = Convert.ToBoolean(dr["FirstStageRemoved_Plano5"].ToString()),
                    FirstStageRemovedPlan6 = Convert.ToBoolean(dr["FirstStageRemoved_Plano6"].ToString()),
                    ForceSingleOrDoubleCycling = Convert.ToBoolean(dr["ForceSingleOrDoubleCycling"].ToString()),
                    MaxCycleTime = dr["MaxCycleTime"].ToString(),
                    MinGreenCyclicCheckSequence = dr["MinGreenCyclicCheckSequence"].ToString(),
                    NamedStage = dr["NamedStage"].ToString(),
                    NonCyclicCheckSequence = dr["NonCyclicCheckSequence"].ToString(),
                    RoadGreens_Main = dr["RoadGreens_Main"].ToString(),
                    RoadGreens_Side = dr["RoadGreens_Side"].ToString(),
                    SecondRemovableStage = dr["SecondRemovableStage"].ToString(),
                    SecondStageRemovedPlan1 = Convert.ToBoolean(dr["SecondStageRemoved_Plano1"].ToString()),
                    SecondStageRemovedPlan2 = Convert.ToBoolean(dr["SecondStageRemoved_Plano2"].ToString()),
                    SecondStageRemovedPlan3 = Convert.ToBoolean(dr["SecondStageRemoved_Plano3"].ToString()),
                    SecondStageRemovedPlan4 = Convert.ToBoolean(dr["SecondStageRemoved_Plano4"].ToString()),
                    SecondStageRemovedPlan5 = Convert.ToBoolean(dr["SecondStageRemoved_Plano5"].ToString()),
                    SecondStageRemovedPlan6 = Convert.ToBoolean(dr["SecondStageRemoved_Plano6"].ToString()),
                    SignalStuckInhibit = Convert.ToBoolean(dr["Signal_Stuck_Inhibit"].ToString()),
                    SlaveController = Convert.ToBoolean(dr["SlaveController"].ToString()),
                    SlBitMeaning = Convert.ToBoolean(dr["Sl_BitMeaning"].ToString()),
                    SmoothPlanChange = Convert.ToBoolean(dr["SmoothPlanChange"].ToString()),
                    DoubleCycling = Convert.ToBoolean(dr["DoubleCycling"].ToString()),
                    QtdFases = dr["QtdFases"].ToString()
                });
            }
            return lst;
        }
        [WebMethod]
        public static string salvar(string controladorScn,
            string ipControlador, string cruzamento, string usuarioLogado,
            string modelo, string anel1, string anel2, string anel3, string anel4, string lat,
            string lon, string qtdEstagio1, string qtdEstagio2, string qtdEstagio3,
            string qtdEstagio4, string tmpe1, string tmpe2, string tmpe3,
            string tmpe4, string cruzamentoAnel1, string cruzamentoAnel2,
            string cruzamentoAnel3, string cruzamentoAnel4, string tempoEnvioEstagio)
        {
            Banco db = new Banco("");
            string scnExistente = db.ExecuteScalarQuery(
                "SELECT id FROM scootControladores " +
                " WHERE scnControlador='" + controladorScn + "' " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " "
                );
            if (!string.IsNullOrEmpty(scnExistente))
            {
                return "Este controlador já está cadastrado";
            }

            string ipExistente = db.ExecuteScalarQuery(
                "SELECT id FROM scootControladores " +
                " WHERE ipControlador='" + ipControlador + "' " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " "
                );
            if (!string.IsNullOrEmpty(ipExistente))
            {
                return "Este IP já está cadastrado";
            }

            string idDepartamento = db.ExecuteScalarQuery(
               @"SELECT id FROM Departamento 
               WHERE idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " " +
               " AND nome='cruzamentos'"
               );

            db.ExecuteNonQuery(@"INSERT INTO Subdivisao_Departamento(Subdivisao,Endereco,cruzamento,idDepartamento,idPrefeitura)
                VALUES ('" + controladorScn + "','" + cruzamento + "','true','" + idDepartamento + "'," + HttpContext.Current.Profile["idPrefeitura"] + ")");

            //scootCONTROLADORES
            string id = db.ExecuteScalarQuery(
                @"INSERT INTO scootControladores (scnControlador,ipControlador,cruzamento,modelo, 
                  scnAnel1,scnAnel2,scnAnel3,scnAnel4,latitude,longitude,qtdEstagioAnel1,
                  qtdEstagioAnel2,qtdEstagioAnel3,qtdEstagioAnel4,estagiosDesativarTMPE1,
                  estagiosDesativarTMPE2,estagiosDesativarTMPE3,estagiosDesativarTMPE4,
                  idPrefeitura,cruzamentoAnel1,cruzamentoAnel2,cruzamentoAnel3,
                  cruzamentoAnel4,tempoAntesEnvioEstagio) 
                  VALUES ('" + controladorScn + "','" + ipControlador + "','" + cruzamento + "', " +
                " '" + modelo + "','" + anel1 + "','" + anel2 + "','" + anel3 + "','" + anel4 + "', " +
                " '" + lat + "','" + lon + "','" + qtdEstagio1 + "','" + qtdEstagio2 + "', " +
                " '" + qtdEstagio3 + "','" + qtdEstagio4 + "','" + tmpe1 + "', " +
                " '" + tmpe2 + "','" + tmpe3 + "','" + tmpe4 + "', " +
                " " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + cruzamentoAnel1 + "','" + cruzamentoAnel2 + "', " +
                " '" + cruzamentoAnel3 + "','" + cruzamentoAnel4 + "','" + tempoEnvioEstagio + "') " +
                " SELECT SCOPE_IDENTITY()"
                );

            string scnControladorE = db.ExecuteScalarQuery(
                "SELECT scnControlador FROM scootControladores WHERE id=" + id
                );

            //LOG
            db.ExecuteNonQuery(
                @"INSERT INTO LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) " +
                " VALUES ('" + usuarioLogado + "','Cadastro Controladores Scoot', " +
                HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "', " +
                " 'Salvou o scnControlador: " + controladorScn + ", " +
                " ipControlador: " + ipControlador + ",tempoEnvioEstagio: " + tempoEnvioEstagio + " " +
                " scnAnel1=" + anel1 + ", scnAnel2=" + anel2 + ", " +
                " scnAnel3=" + anel3 + ", scnAnel4=" + anel4 + " , " +
                " qtdEstagioAnel1=" + qtdEstagio1 + ", qtdEstagioAnel2=" + qtdEstagio2 + ", " +
                " qtdEstagioAnel3=" + qtdEstagio3 + ", qtdEstagioAnel4=" + qtdEstagio4 + ", " +
                " estagiosDesativarTMPE1=" + tmpe1 + ", estagiosDesativarTMPE2=" + tmpe2 + ", " +
                " estagiosDesativarTMPE3=" + tmpe3 + ", estagiosDesativarTMPE4=" + tmpe4 + " , " +
                " cruzamentoAnel1=" + cruzamentoAnel1 + ", cruzamentoAnel2=" + cruzamentoAnel2 + ", " +
                " cruzamentoAnel3=" + cruzamentoAnel3 + ", cruzamentoAnel4=" + cruzamentoAnel4 + "', " +
                " 'scootControladores')"
                );

            string idStatus = db.ExecuteScalarQuery(
                "SELECT ip FROM [status] " +
                " WHERE serial='" + controladorScn + "' " +
                " AND idPrefeitura is null"
                );
            if (idStatus != "")
            {
                db.ExecuteNonQuery(
                    "UPDATE [Status] SET  idDna ='" + controladorScn + "', " +
                    " idPrefeitura =" + HttpContext.Current.Profile["idPrefeitura"] +
                    " WHERE serial = '" + controladorScn + "' "
                    );
            }
            else
            {
                //STATUS
                db.ExecuteNonQuery(string.Format(
                    "INSERT INTO [Status] (Serial,IP,IdDna,IdPrefeitura,bRecebeIpTrap) " +
                    " VALUES ('{0}','{1}','{2}','{3}','true')", controladorScn, ipControlador,
                    controladorScn, HttpContext.Current.Profile["idPrefeitura"]
                    ));
            }

            //DNA
            db.ExecuteReaderQuery(string.Format(
                "INSERT INTO dna (Id,Cruzamento,latitude,longitude,Usuario,idPrefeitura, " +
                " datacadastro,habilitacaoCentral) " +
                " VALUES ('" + controladorScn + "','" + cruzamento + "','" + lat + "', " +
                " '" + lon + "','" + usuarioLogado + "', " +
                " " + HttpContext.Current.Profile["idPrefeitura"]) + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','true' )"
                );


            return "sucesso";
            //return id;
        }


        [WebMethod]
        public static void salvarAnel(string junction, string qtdFases, string SlaveController, string DelayToIntergreen, string Signal_Stuck_Inhibit,
            string MinGreenCyclickCheckSequence, string CyclicCheckSequence, string NonCyclicCheckSequence, string SL_BitMeaning, string SmoothPlanChange,
            string RoadGreens_Main, string RoadGreens_Side, string ScnRegion, string ScnNode, string MaxCycleTime, string NamedStage,
            string CyclicFixedTime, string DoubleCycling, string ForceSingleOrDoubleCycling, string FirstRemovableStage, string SecondRemovableStage,
            string FirstStageRemoved_Plano1, string FirstStageRemoved_Plano2, string FirstStageRemoved_Plano3, string FirstStageRemoved_Plano4, string FirstStageRemoved_Plano5,
            string FirstStageRemoved_Plano6, string SecondStageRemoved_Plano1, string SecondStageRemoved_Plano2, string SecondStageRemoved_Plano3, string SecondStageRemoved_Plano4,
            string SecondStageRemoved_Plano5, string SecondStageRemoved_Plano6, string usuarioLogado)
        {
            Banco db = new Banco("");
            string existe = db.ExecuteScalarQuery("select id from scootJunction where Junction='" + junction + "'");
            if (existe == "")
            {
                db.ExecuteNonQuery(@"insert into ScootJunction (QtdFases,SlaveController,DelayToIntergreen,Signal_Stuck_Inhibit,MinGreenCyclicCheckSequence,CyclicCheckSequence
,NonCyclicCheckSequence, SL_BitMeaning,SmoothPlanChange,RoadGreens_Main,RoadGreens_Side,ScnRegion,ScnNode,MaxCycleTime,NamedStage,CyclicFixedTime,DoubleCycling,
ForceSingleOrDoubleCycling,FirstRemovableStage,SecondRemovableStage,FirstStageRemoved_Plano1,FirstStageRemoved_Plano2,FirstStageRemoved_Plano3,FirstStageRemoved_Plano4,
FirstStageRemoved_Plano5,FirstStageRemoved_Plano6,SecondStageRemoved_Plano1,SecondStageRemoved_Plano2,SecondStageRemoved_Plano3,SecondStageRemoved_Plano4,
SecondStageRemoved_Plano5,SecondStageRemoved_Plano6,junction) values ('" + qtdFases + "','" + SlaveController + "','" + DelayToIntergreen +
                                "','" + Signal_Stuck_Inhibit + "','" + MinGreenCyclickCheckSequence + "','" + CyclicCheckSequence + "', '" + NonCyclicCheckSequence + "', '"
                                + SL_BitMeaning + "','" + SmoothPlanChange + "', '" + RoadGreens_Main + "','" + RoadGreens_Main + "', '" + ScnRegion + "','" + ScnNode +
                                "', '" + MaxCycleTime + "', '" + NamedStage + "', '" + CyclicFixedTime + "','" + DoubleCycling +
                                "', '" + ForceSingleOrDoubleCycling + "','" + FirstRemovableStage + "', '" + SecondRemovableStage + "', '" + FirstStageRemoved_Plano1 + "', '"
                                + FirstStageRemoved_Plano2 + "', '" + FirstStageRemoved_Plano3 + "','" + FirstStageRemoved_Plano4 + "', '" + FirstStageRemoved_Plano5 + "', '"
                                + FirstStageRemoved_Plano6 + "', '" + SecondStageRemoved_Plano1 + "', '" + SecondStageRemoved_Plano2 + "', '" + SecondStageRemoved_Plano3 + "', '"
                                + SecondStageRemoved_Plano4 + "', '" + SecondStageRemoved_Plano5 + "', '" + SecondStageRemoved_Plano6 + "','" + junction + "')");

                //LOG
                db.ExecuteNonQuery(
                    @"INSERT INTO LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) " +
                    " VALUES ('" + usuarioLogado + "','Cadastro Controladores Scoot', " +
                    HttpContext.Current.Profile["idPrefeitura"] + ", " +
                    " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "', " +
                    " 'Salvou os dados junction: " + junction + ", " +
                    " QtdFases=" + qtdFases + ",SlaveController=" + SlaveController + ", DelayToIntergreen=" + DelayToIntergreen +
                    ", Signal_Stuck_Inhibit=" + Signal_Stuck_Inhibit + ", MinGreenCyclicCheckSequence=" + MinGreenCyclickCheckSequence + ",CyclicCheckSequence="
                    + CyclicCheckSequence + ", NonCyclicCheckSequence=" + NonCyclicCheckSequence + ", SL_BitMeaning=" + SL_BitMeaning + ", SmoothPlanChange=" + SmoothPlanChange +
                    ", RoadGreens_Main=" + RoadGreens_Main + ",RoadGreens_Side=" + RoadGreens_Main + ", ScnRegion=" + ScnRegion + ", ScnNode='" + ScnNode +
                    ", MaxCycleTime=" + MaxCycleTime + ", NamedStage=" + NamedStage + ", CyclicFixedTime=" + CyclicFixedTime + ", DoubleCycling = " + DoubleCycling +
                    ", ForceSingleOrDoubleCycling = " + ForceSingleOrDoubleCycling + ", FirstRemovableStage = " + FirstRemovableStage + ", SecondRemovableStage = "
                    + SecondRemovableStage + ", FirstStageRemoved_Plano1 = " + FirstStageRemoved_Plano1 + ", FirstStageRemoved_Plano2 = " + FirstStageRemoved_Plano2 +
                    ", FirstStageRemoved_Plano3 = " + FirstStageRemoved_Plano3 + ", FirstStageRemoved_Plano4 = " + FirstStageRemoved_Plano4 +
                    ", FirstStageRemoved_Plano5 = " + FirstStageRemoved_Plano5 + ", FirstStageRemoved_Plano6 = " + FirstStageRemoved_Plano6 +
                    ", SecondStageRemoved_Plano1 = " + SecondStageRemoved_Plano1 + ", SecondStageRemoved_Plano2 = " + SecondStageRemoved_Plano2 +
                    ", SecondStageRemoved_Plano3 = " + SecondStageRemoved_Plano3 + ", SecondStageRemoved_Plano4 = " + SecondStageRemoved_Plano4 +
                    ", SecondStageRemoved_Plano5 = " + SecondStageRemoved_Plano5 + ", SecondStageRemoved_Plano6 =" + SecondStageRemoved_Plano6 + "', " +
                    " 'scootControladores')");
            }
            else
            {

                db.ExecuteNonQuery(@"update ScootJunction set QtdFases='" + qtdFases + "',SlaveController='" + SlaveController + "', DelayToIntergreen='" + DelayToIntergreen +
                    "', Signal_Stuck_Inhibit='" + Signal_Stuck_Inhibit + "', MinGreenCyclicCheckSequence='" + MinGreenCyclickCheckSequence + "',CyclicCheckSequence='"
                    + CyclicCheckSequence + "', NonCyclicCheckSequence='" + NonCyclicCheckSequence + "', SL_BitMeaning='" + SL_BitMeaning + "', SmoothPlanChange='" + SmoothPlanChange +
                    "', RoadGreens_Main='" + RoadGreens_Main + "',RoadGreens_Side='" + RoadGreens_Main + "', ScnRegion='" + ScnRegion + "', ScnNode='" + ScnNode +
                    "', MaxCycleTime='" + MaxCycleTime + "', NamedStage='" + NamedStage + "', CyclicFixedTime='" + CyclicFixedTime + "', DoubleCycling = '" + DoubleCycling +
                    "', ForceSingleOrDoubleCycling = '" + ForceSingleOrDoubleCycling + "', FirstRemovableStage = '" + FirstRemovableStage + "', SecondRemovableStage = '"
                    + SecondRemovableStage + "', FirstStageRemoved_Plano1 = '" + FirstStageRemoved_Plano1 + "', FirstStageRemoved_Plano2 = '" + FirstStageRemoved_Plano2 +
                    "', FirstStageRemoved_Plano3 = '" + FirstStageRemoved_Plano3 + "', FirstStageRemoved_Plano4 = '" + FirstStageRemoved_Plano4 +
                    "', FirstStageRemoved_Plano5 = '" + FirstStageRemoved_Plano5 + "', FirstStageRemoved_Plano6 = '" + FirstStageRemoved_Plano6 +
                    "', SecondStageRemoved_Plano1 = '" + SecondStageRemoved_Plano1 + "', SecondStageRemoved_Plano2 = '" + SecondStageRemoved_Plano2 +
                    "', SecondStageRemoved_Plano3 = '" + SecondStageRemoved_Plano3 + "', SecondStageRemoved_Plano4 = '" + SecondStageRemoved_Plano4 +
                    "', SecondStageRemoved_Plano5 = '" + SecondStageRemoved_Plano5 + "', SecondStageRemoved_Plano6 = '" + SecondStageRemoved_Plano6 + "' where junction = '" + junction + "'");

                //LOG
                db.ExecuteNonQuery(
                    @"INSERT INTO LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) " +
                    " VALUES ('" + usuarioLogado + "','Cadastro Controladores Scoot', " +
                    HttpContext.Current.Profile["idPrefeitura"] + ", " +
                    " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "', " +
                    " 'Alterou os dados junction: " + junction + ", " +
                    " QtdFases=" + qtdFases + ",SlaveController=" + SlaveController + ", DelayToIntergreen=" + DelayToIntergreen +
                    ", Signal_Stuck_Inhibit=" + Signal_Stuck_Inhibit + ", MinGreenCyclicCheckSequence=" + MinGreenCyclickCheckSequence + ",CyclicCheckSequence="
                    + CyclicCheckSequence + ", NonCyclicCheckSequence=" + NonCyclicCheckSequence + ", SL_BitMeaning=" + SL_BitMeaning + ", SmoothPlanChange=" + SmoothPlanChange +
                    ", RoadGreens_Main=" + RoadGreens_Main + ",RoadGreens_Side=" + RoadGreens_Main + ", ScnRegion=" + ScnRegion + ", ScnNode='" + ScnNode +
                    ", MaxCycleTime=" + MaxCycleTime + ", NamedStage=" + NamedStage + ", CyclicFixedTime=" + CyclicFixedTime + ", DoubleCycling = " + DoubleCycling +
                    ", ForceSingleOrDoubleCycling = " + ForceSingleOrDoubleCycling + ", FirstRemovableStage = " + FirstRemovableStage + ", SecondRemovableStage = "
                    + SecondRemovableStage + ", FirstStageRemoved_Plano1 = " + FirstStageRemoved_Plano1 + ", FirstStageRemoved_Plano2 = " + FirstStageRemoved_Plano2 +
                    ", FirstStageRemoved_Plano3 = " + FirstStageRemoved_Plano3 + ", FirstStageRemoved_Plano4 = " + FirstStageRemoved_Plano4 +
                    ", FirstStageRemoved_Plano5 = " + FirstStageRemoved_Plano5 + ", FirstStageRemoved_Plano6 = " + FirstStageRemoved_Plano6 +
                    ", SecondStageRemoved_Plano1 = " + SecondStageRemoved_Plano1 + ", SecondStageRemoved_Plano2 = " + SecondStageRemoved_Plano2 +
                    ", SecondStageRemoved_Plano3 = " + SecondStageRemoved_Plano3 + ", SecondStageRemoved_Plano4 = " + SecondStageRemoved_Plano4 +
                    ", SecondStageRemoved_Plano5 = " + SecondStageRemoved_Plano5 + ", SecondStageRemoved_Plano6 =" + SecondStageRemoved_Plano6 + "', " +
                    " 'scootControladores')");
            }
        }

        [WebMethod]
        public static string salvarAlteracoes(string controladorScn, string ipControlador,
            string modelo, string cruzamento, string usuarioLogado, string anel1, string anel2,
            string anel3, string anel4, string lat, string lon, string qtdEstagio1, string qtdEstagio2,
            string qtdEstagio3, string qtdEstagio4, string id, string tmpe1, string tmpe2,
            string tmpe3, string tmpe4, string cruzamentoAnel1, string cruzamentoAnel2,
            string cruzamentoAnel3, string cruzamentoAnel4, string tempoEnvioEstagio)
        {

            Banco db = new Banco("");
            string scnExistente = db.ExecuteScalarQuery(
                "SELECT id FROM scootControladores " +
                " WHERE scnControlador='" + controladorScn + "'" +
                " AND id<> " + id + " " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " "
                );
            if (!string.IsNullOrEmpty(scnExistente))
            {
                return "Este controlador já está cadastrado!";
            }

            string ipExistente = db.ExecuteScalarQuery(
                "SELECT id FROM scootControladores " +
                " WHERE ipControlador='" + ipControlador + "' " +
                " AND id<> " + id + " " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"] + " "
                );
            if (!string.IsNullOrEmpty(ipExistente))
            {
                return "Este IP já está cadastrado!";
            }

            db.ExecuteNonQuery(
                "UPDATE scootControladores SET ipControlador='" + ipControlador + "', modelo='" + modelo + "', " +
                " cruzamento='" + cruzamento + "', tempoAntesEnvioEstagio='" + tempoEnvioEstagio + "', " +
                " scnAnel1='" + anel1 + "', scnAnel2='" + anel2 + "', scnAnel3='" + anel3 + "', " +
                " scnAnel4='" + anel4 + "', latitude='" + lat + "', longitude='" + lon + "', " +
                " qtdEstagioAnel1='" + qtdEstagio1 + "', qtdEstagioAnel2='" + qtdEstagio2 + "', " +
                " qtdEstagioAnel3='" + qtdEstagio3 + "', qtdEstagioAnel4='" + qtdEstagio4 + "', " +
                " estagiosDesativarTMPE1='" + tmpe1 + "', estagiosDesativarTMPE2='" + tmpe2 + "', " +
                " estagiosDesativarTMPE3='" + tmpe3 + "', estagiosDesativarTMPE4='" + tmpe4 + "', " +
                " cruzamentoAnel1='" + cruzamentoAnel1 + "', cruzamentoAnel2='" + cruzamentoAnel2 + "', " +
                " cruzamentoAnel3='" + cruzamentoAnel3 + "', cruzamentoAnel4='" + cruzamentoAnel4 + "' " +
                " WHERE id=" + id
                );

            db.ExecuteNonQuery("UPDATE Subdivisao_Departamento set Endereco='" + cruzamento + "' where Subdivisao ='" + controladorScn + "' and idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);

            db.ExecuteNonQuery(
                "UPDATE [Status] SET ip='" + ipControlador + "' " +
                " WHERE serial='" + controladorScn + "' " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]
                );

            db.ExecuteNonQuery(
                "UPDATE DNA SET cruzamento='" + cruzamento + "', " +
                " latitude='" + lat + "', longitude='" + lon + "' " +
                " WHERE id='" + controladorScn + "' " +
                " AND idPrefeitura=" + HttpContext.Current.Profile["idPrefeitura"]
                );

            //LOG
            db.ExecuteNonQuery(
                @"INSERT INTO LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) " +
                " VALUES ('" + usuarioLogado + "','Cadastro Controladores Scoot', " +
                HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "', " +
                " 'Alterou o controlador scoot:" + controladorScn + ", " +
                " IP: " + ipControlador + ", tempoEnvioEstagio='" + tempoEnvioEstagio + "', " +
                " idDNA: " + controladorScn + ", " +
                " scnAnel1=" + anel1 + ", scnAnel2=" + anel2 + ", " +
                " scnAnel3=" + anel3 + ", scnAnel4=" + anel4 + " , " +
                " qtdEstagioAnel1=" + qtdEstagio1 + ", " +
                " qtdEstagioAnel2=" + qtdEstagio2 + ", " +
                " qtdEstagioAnel3=" + qtdEstagio3 + ", " +
                " qtdEstagioAnel4=" + qtdEstagio4 + ", " +
                " estagiosDesativarTMPE1=" + tmpe1 + ", " +
                " estagiosDesativarTMPE2=" + tmpe2 + ", " +
                " estagiosDesativarTMPE3=" + tmpe3 + ", " +
                " estagiosDesativarTMPE4=" + tmpe4 + ", " +
                " cruzamentoAnel1=" + cruzamentoAnel1 + ", " +
                " cruzamentoAnel2=" + cruzamentoAnel2 + ", " +
                " cruzamentoAnel3=" + cruzamentoAnel3 + ", " +
                " cruzamentoAnel4=" + cruzamentoAnel4 + "', " +
                " 'scootControladores')"
                );

            return "sucesso";
        }
         
        [WebMethod]
        public static string excluirControladorScoot(string idControlador, string anel1, string anel2, string anel3, string anel4, string usuarioLogado, string scnControlador)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery("delete scootControladores where scnControlador='" + scnControlador + "' ");
            db.ExecuteNonQuery("delete [Status] where Serial='" + scnControlador + "' ");
            db.ExecuteNonQuery("delete DNA where Id='" + scnControlador + "' ");
            db.ExecuteNonQuery("delete Subdivisao_Departamento where subdivisao='" + scnControlador + "' and idprefeitura=" + HttpContext.Current.Profile["idPrefeitura"]);
            db.ExecuteNonQuery("delete scootAgendas where scnControlador='" + scnControlador + "' ");

            if (anel1 != "")
            {
                db.ExecuteNonQuery("delete scootEntreverdes where scnAnel='" + anel1 + "' ");
                db.ExecuteNonQuery("delete scootEstagios where scnAnel='" + anel1 + "' ");
                db.ExecuteNonQuery("delete scootPlanos where scnAnel='" + anel1 + "' ");
                db.ExecuteNonQuery("delete scootJunction where junction='" + anel1 + "' ");
            }

            if (anel2 != "")
            {
                db.ExecuteNonQuery("delete scootEntreverdes where scnAnel='" + anel2 + "' ");
                db.ExecuteNonQuery("delete scootEstagios where scnAnel='" + anel2 + "' ");
                db.ExecuteNonQuery("delete scootPlanos where scnAnel='" + anel2 + "' ");
                db.ExecuteNonQuery("delete scootJunction where junction='" + anel2 + "' ");
            }

            if (anel3 != "")
            {
                db.ExecuteNonQuery("delete scootEntreverdes where scnAnel='" + anel3 + "' ");
                db.ExecuteNonQuery("delete scootEstagios where scnAnel='" + anel3 + "' ");
                db.ExecuteNonQuery("delete scootPlanos where scnAnel='" + anel3 + "' ");
                db.ExecuteNonQuery("delete scootJunction where junction='" + anel3 + "' ");
            }

            if (anel4 != "")
            {
                db.ExecuteNonQuery("delete scootEntreverdes where scnAnel='" + anel4 + "' ");
                db.ExecuteNonQuery("delete scootEstagios where scnAnel='" + anel4 + "' ");
                db.ExecuteNonQuery("delete scootPlanos where scnAnel='" + anel4 + "' ");
                db.ExecuteNonQuery("delete scootJunction where junction='" + anel4 + "' ");
            }

            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + usuarioLogado + "','Cadastro Controladores Scoot', " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','Excluiu o Controlador Scoot: " + scnControlador + ", idControladorScoot: " + idControlador + "','scootControladores')");

            return "sucesso";
        }

        [WebMethod]
        public static void ExcluirAnel(string junction, string usuarioLogado)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery("delete scootJunction where junction='" + junction + "' ");
            db.ExecuteNonQuery("insert into LogsSistema ([user],tela,idPrefeitura,DtHr,Dsc,Tabela) values ('" + usuarioLogado + "','Cadastro Controladores Scoot', " + HttpContext.Current.Profile["idPrefeitura"] + ", " +
                " '" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "','Excluiu a Junction: " + junction + "','scootJunction')");

        }

        //TRADUÇÃO ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬

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
    }
}