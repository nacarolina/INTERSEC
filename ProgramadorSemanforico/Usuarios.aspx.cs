using Infortronics;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI.WebControls;
using System.Xml;

namespace GwCentral.ProgramadorSemanforico
{
    public partial class Usuarios : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                hfIdiomaUpload.Value = idioma.IndexOf("es") != -1 ? "es" : idioma;
                hfIdiomaUpload.Value = idioma.IndexOf("en") != -1 ? "_LANG_" : idioma;
                hfIdiomaUpload.Value = idioma.IndexOf("pt") != -1 ? "pt-BR" : idioma;

                hfIdPrefeitura.Value = HttpContext.Current.Profile["idPrefeitura"].ToString();
            }
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
        public static ArrayList loadMunicipio(string idPrefeitura)
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery("select Id,Prefeitura from Prefeitura where Id=" + idPrefeitura);
            ArrayList lst = new ArrayList();
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["Prefeitura"].ToString(), dr["Id"].ToString()));
            }
            return lst;
        }


        [WebMethod]
        public static List<UsuariosInativos> GetUsuariosInativos(string idPrefeitura)
        {
            Banco db = new Banco("");
            List<UsuariosInativos> lst = new List<UsuariosInativos>();

            string Nome = "", Email = "", Telefone = "", Empresa = "", Municipio = "", VersaoProgramador = "", UltimaConexao = "", Chave = "", Ativo = "";

            DataTable dt = db.ExecuteReaderQuery("SELECT [Nome],[Email],[Telefone],[Empresa],Cidade,[Versao],[UltimaConexao],[UltimoUpdate],[ChaveAcesso],[Ativo] FROM [dbo].[ProgramadorUsuarios] pu " +
                "where Ativo is null order by [Nome]");
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new UsuariosInativos
                {
                    Nome = dr["Nome"].ToString(),
                    Email = dr["Email"].ToString(),
                    Telefone = dr["Telefone"].ToString(),
                    Empresa = dr["Empresa"].ToString(),
                    Municipio = dr["Cidade"].ToString(),
                    VersaoProgramador = dr["UltimaConexao"].ToString(),
                    UltimaConexao = dr["UltimaConexao"].ToString(),
                    Chave = dr["ChaveAcesso"].ToString(),
                    Ativo = dr["Ativo"].ToString()
                });
            }

            return lst;
        }


        public struct UsuariosInativos
        {
            public string Nome { get; set; }
            public string Email { get; set; }
            public string Telefone { get; set; }
            public string Empresa { get; set; }
            public string Municipio { get; set; }
            public string VersaoProgramador { get; set; }
            public string UltimaConexao { get; set; }
            public string Chave { get; set; }
            public string Ativo { get; set; }
        }


        [WebMethod]
        public static List<UsuariosAtivos> GetUsuariosAtivos(string idPrefeitura)
        {
            Banco db = new Banco("");
            List<UsuariosAtivos> lst = new List<UsuariosAtivos>();

            string Nome = "", Email = "", Telefone = "", Empresa = "", Municipio = "", VersaoProgramador = "", UltimaConexao = "", Chave = "", Ativo = "";

            DataTable dt = db.ExecuteReaderQuery("SELECT [Nome],[Email],[Telefone],[Empresa],Cidade,idPrefeitura,[Versao],[UltimaConexao],[UltimoUpdate],[ChaveAcesso],[Ativo] FROM [dbo].[ProgramadorUsuarios] pu  " +
                "where [Ativo] in('True','False') order by [Nome]");
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new UsuariosAtivos
                {
                    Nome = dr["Nome"].ToString(),
                    Email = dr["Email"].ToString(),
                    Telefone = dr["Telefone"].ToString(),
                    Empresa = dr["Empresa"].ToString(),
                    Municipio = dr["Cidade"].ToString(),
                    VersaoProgramador = dr["Versao"].ToString(),
                    UltimaConexao = dr["UltimaConexao"].ToString(),
                    Chave = dr["ChaveAcesso"].ToString(),
                    idPrefeitura = dr["idPrefeitura"].ToString(),
                    Ativo = dr["Ativo"].ToString()
                });
            }

            return lst;
        }


        public struct UsuariosAtivos
        {
            public string Nome { get; set; }
            public string Email { get; set; }
            public string idPrefeitura { get; set; }
            public string Telefone { get; set; }
            public string Empresa { get; set; }
            public string Municipio { get; set; }
            public string VersaoProgramador { get; set; }
            public string UltimaConexao { get; set; }
            public string Chave { get; set; }
            public string Ativo { get; set; }
        }


        [WebMethod]
        public static string SalvarSenha(string idPrefeitura, string usuario, string email, string senha)
        {
            Banco db = new Banco("");

            if (senha == "")
            {
                return getResource("informeSenha");
            }

            string[] roles = Roles.GetRolesForUser(email);
            Membership.DeleteUser(email);
            Membership.CreateUser(email, senha, email);

            foreach (var item in roles)
            {
                Roles.AddUserToRole(email, item);
            }

            db.ExecuteNonQuery("UPDATE [dbo].[ProgramadorUsuarios] SET [Senha] = '" + senha + "',PendenteAtualizacao='true' WHERE [Nome] = '" + usuario + "' and [Email] = '" + email + "'");

            return "SUCESSO";
        }


        [WebMethod]
        public static string ExcluirUsuario(string email, string nome)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery("DELETE FROM [dbo].[ProgramadorUsuarios] WHERE [email]='" + email + "' and [Nome] = '" + nome + "'");
            if (Membership.FindUsersByName(email).Count > 0)
            {
                Membership.DeleteUser(email);
            }
            return "SUCESSO";
        }


        [WebMethod]
        public static List<UserRoles> GetRoles(string idPrefeitura, string email)
        {
            Banco db = new Banco("");

            List<UserRoles> lst = new List<UserRoles>();
            DataTable dt = db.ExecuteReaderQuery("SELECT [Role] FROM [dbo].[ProgramadorUsuarioRoles] where [Email]='" + email + "'");
            string Roles = "";
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new UserRoles
                {
                    Roles = dr["Role"].ToString()
                });
            }

            return lst;
        }

        public struct UserRoles
        {
            public string Roles { get; set; }
        }

        [WebMethod]
        public static void setChaveAcesso(string email)
        {
            Banco db = new Banco("");
            int[] byte1 = DecimalToBinary(0);

            DataTable dt = db.ExecuteReaderQuery("select role from programadorUsuarioRoles where email='" + email + "'");
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["role"].ToString() == "Alterar_IP_Do_Equipamento")
                    byte1[0] = 1;

                if (dr["role"].ToString() == "Apaga_Logs_Falha_Restabelecimento")
                    byte1[1] = 1;

                if (dr["role"].ToString() == "Apaga_Logs_Operacao")
                    byte1[2] = 1;

                if (dr["role"].ToString() == "Criar_Login")
                    byte1[3] = 1;

                if (dr["role"].ToString() == "Envia_Programacao_Para_O_Equipamento")
                    byte1[4] = 1;

                if (dr["role"].ToString() == "Excluir_Login")
                    byte1[5] = 1;

                if (dr["role"].ToString() == "Excluir_Programacao")
                    byte1[6] = 1;
                //Manipula_Roles

                if (dr["role"].ToString() == "Manipula_Roles")
                    byte1[7] = 1;
            }
            Array.Reverse(byte1);
            string chaveAcesso = string.Join("", byte1);
            int decimalValue = Convert.ToInt32(chaveAcesso, 2);
            string keyCode = GetKeyCode(email);

            db.ExecuteNonQuery("Update ProgramadorUsuarios set ChaveAcesso='" + keyCode + "-" + decimalValue + "',PendenteAtualizacao='true' Where email='" + email + "'");
        }

        [WebMethod]
        public static string AlteraRegraAcesso(string email, string nomerole)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery("INSERT INTO [dbo].[ProgramadorUsuarioRoles] ([Email],[Role]) VALUES ('" + email + "', '" + nomerole + "' )");

            setChaveAcesso(email);
            return "SUCESSO";
        }

        [WebMethod]
        public static string ExcluiRegraAcesso(string email, string nomerole)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery("DELETE FROM [dbo].[ProgramadorUsuarioRoles] WHERE [Role] ='" + nomerole + "' and [Email] = '" + email + "'");
            setChaveAcesso(email);

            return "SUCESSO";
        }


        [WebMethod]
        public static string SalvarNovoUsuario(string idPrefeitura, string usuario, string email, string senha, string telefone, string versao,
            string mnc, string empresa, string chave)
        {
            Banco db = new Banco("");
            if (usuario == "")
            {
                return getResource("informeUsuario");
            }
            db.ExecuteNonQuery("INSERT INTO [dbo].[ProgramadorUsuarios] ([Nome],[Senha],[Empresa],[Versao],[UltimaConexao],[UltimoUpdate],[Ativo],[Email],[Telefone],[IdPrefeitura],[ChaveAcesso]) VALUES ('" + usuario + "','" + senha + "','" + empresa + "','" + versao + "','','','True','" + email + "','" + telefone + "'," + mnc + ",'" + chave + "')");

            return "SUCESSO";
        }

        [WebMethod]
        public static string GetKeyCode(string email)
        {
            if (email == "")
            {
                return getResource("emailInvalido");
            }
            string[] letras = new string[26] {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
                                        "K", "L", "M", "N", "O", "P", "Q","R","S","T",
                                        "U","V","X","W","Y","B"};
            try
            {
                byte[] hash1 = Encoding.ASCII.GetBytes("infortronics");
                string string64 = Convert.ToBase64String(hash1);
                int x1 = 0;
                foreach (var item in hash1)
                {
                    x1 += item;
                }

                byte[] hash2 = Encoding.ASCII.GetBytes(email.ToLower());
                int x2 = 0;
                foreach (var item in hash2)
                {
                    x2 += item;
                }
                int u1 = 0;
                while (x2 > 9999)
                {
                    x2 = x2 - x1;
                    u1++;
                    if (u1 > 25)
                        u1 = 0;
                }

                byte[] hash3 = hash1.Length >= hash2.Length ? hash1 : hash2;
                byte[] hash3i = hash1.Length >= hash2.Length ? hash2 : hash3;

                int x3 = 0;
                int p = 0;
                foreach (var item in hash3)
                {
                    if (p > hash3i.Length - 1)
                        p = 0;

                    x3 += item * hash3i[p];
                    p++;
                }
                int u2 = 0;
                while (x3 > 9999)
                {
                    x3 = x3 - x2;
                    u2++;

                    if (u2 > 25)
                        u2 = 0;
                }

                byte[] hash4 = Encoding.ASCII.GetBytes("greenwave");
                int x4 = 0;
                foreach (var item in hash4)
                {
                    x4 += item;
                }


                byte[] hash5 = hash4.Length >= hash2.Length ? hash4 : hash2;
                byte[] hash5i = hash4.Length >= hash2.Length ? hash2 : hash5;


                int x5 = 0;
                p = 0;
                foreach (var item in hash5)
                {
                    if (p > hash5i.Length - 1)
                        p = 0;
                    x5 += item * hash5i[p];
                    p++;
                }
                int u3 = 0;
                while (x5 > 9999)
                {
                    x5 = x5 - x3;
                    u3++;

                    if (u3 > 25)
                        u3 = 0;
                }


                string v1 = x2.ToString().PadLeft(5, '0');
                if (u1 > 0)
                    v1 = letras[u1] + v1.Substring(1);

                string v2 = x3.ToString().PadLeft(5, '0');
                if (u2 > 0)
                    v2 = letras[u2] + v2.Substring(1);

                string v3 = x5.ToString().PadLeft(5, '0');
                if (u3 > 0)
                    v3 = letras[u3] + v3.Substring(1);


                return $"{v1}-{v2}-{v3}";

            }
            catch (Exception err)
            {
                return "AAAAA-BBBBB-CCCCC";
            }
        }
        [WebMethod]

        public static string SalvarRegra(string idPrefeitura, string usuario, string email, string prefeitura, string chk)
        {
            Banco db = new Banco("");

            db.ExecuteNonQuery("update ProgramadorUsuarios set idprefeitura=" + idPrefeitura + " where email='" + email + "' and Nome='" + usuario + "'");
            if (Membership.FindUsersByName(email).Count == 0)
            {
                db.ExecuteNonQuery("UPDATE [dbo].[ProgramadorUsuarios] SET [Ativo] = '" + chk + "' WHERE [Nome]='" + usuario + "' and [Email]='" + email + "'");
                string senha = db.ExecuteScalarQuery("select senha from ProgramadorUsuarios where email='" + email + "' and Nome='" + usuario + "'");
                try
                {
                    Membership.CreateUser(email, senha, email);
                }
                catch
                {

                }
                try
                {
                    if (!Roles.IsUserInRole(email, "cliente: " + prefeitura))
                        Roles.AddUserToRole(email, "cliente: " + prefeitura);

                    if (!Roles.IsUserInRole(email, "central_mapa"))
                        Roles.AddUserToRole(email, "central_mapa");

                    chkAtivoInativo(idPrefeitura, usuario, email, "True");
                }
                catch (Exception e)
                {
                    return e.Message.Replace("username", "email");
                }

            }
            if (chk == "true")
            {
                db.ExecuteNonQuery("UPDATE [dbo].[ProgramadorUsuarios] SET [Ativo] = '" + chk + "' WHERE [Nome]='" + usuario + "' and [Email]='" + email + "'");
            }
            return "SUCESSO";
        }

        [WebMethod]
        public static List<Dispositivos> getDispositivos(string email)
        {
            Banco db = new Banco("");
            List<Dispositivos> lst = new List<Dispositivos>();
            DataTable dt = db.ExecuteReaderQuery("select Convert(varchar,HardwareId)+'/'+MachineName+' - '+OSName nome,ativo,id from UsuarioDispositivo where Email ='" + email + "' order by ativo desc");
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new Dispositivos
                {
                    Dispositivo = dr["nome"].ToString(),
                    Id = dr["Id"].ToString(),
                    Ativo = dr["Ativo"].ToString()
                });
            }
            return lst;
        }
        [WebMethod]
        public static void Desativar(string id)
        {
            Banco db = new Banco("");
            db.ExecuteNonQuery("update UsuarioDispositivo set ativo='False' where id=" + id);
        }

        public struct Dispositivos
        {
            public string Id { get; set; }
            public string Dispositivo { get; set; }
            public string Ativo { get; set; }

        }
        public static int[] DecimalToBinary(int number)
        {
            int[] binaryNum = new int[8];

            int i = 0;
            while (number > 0)
            {
                binaryNum[i] = number % 2;
                number = number / 2;
                i++;
            }
            return binaryNum;
        }
        [WebMethod]
        public static ArrayList getPrefeituras()
        {
            Banco db = new Banco("");
            DataTable dt = db.ExecuteReaderQuery("select id,prefeitura from prefeitura");
            ArrayList lst = new ArrayList();
            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(dr["prefeitura"].ToString(), dr["Id"].ToString()));
            }

            return lst;
        }

        [WebMethod]
        public static string chkAtivoInativo(string idPrefeitura, string usuario, string email, string chk)
        {
            Banco db = new Banco("");
            if (Membership.FindUsersByEmail(email).Count == 0)
            {
                return getResource("erro");
            }
            db.ExecuteNonQuery("UPDATE [dbo].[ProgramadorUsuarios] SET [Ativo] = '" + chk + "' WHERE [Nome]='" + usuario + "' and [Email]='" + email + "'");
            return "SUCESSO";
        }

        [WebMethod]
        public static string NewUserOffline(string base64, string NomeArquivo)
        {
            Banco db = new Banco("");
            Crypt crypt = new Crypt();

            base64 = base64.Replace("\"", "");
            byte[] data = Convert.FromBase64String(base64);
            string decodedString = Encoding.UTF8.GetString(data);
            string arquivodecrypt = crypt.Decrypt(decodedString, "infortronicsGW");
            string[] info = arquivodecrypt.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
            string email = info[0];
            DataTable dt = db.ExecuteReaderQuery("SELECT * FROM [semaforo].[dbo].[ProgramadorUsuarios] where Email='" + email + "'");
            if (dt.Rows.Count != 0)
            {
                return getResource("erro");
            }
            else
            {
                string queryUsuarioDispositivo = info[1];
                db.ExecuteNonQuery(queryUsuarioDispositivo);

                string queryProgramadorUsuarios = info[2];
                db.ExecuteNonQuery(queryProgramadorUsuarios);

                return "SUCESSO";
            }

        }
    }
}