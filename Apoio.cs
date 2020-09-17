using Infortronics;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace GwCentral
{
    public class Apoio
    {
        Banco db = new Banco("");
        public List<GruposLogicos> lstGruposLogicos = new List<GruposLogicos>();
        public List<VerdesConflitantes> lstVerdesConflitantes = new List<VerdesConflitantes>();
        public List<Estagio> lstEstagios = new List<Estagio>();
        public List<Estado> lstEstados = new List<Estado>();


        public void CarregaConfigGrupos(string idProgramacao, string anel, string IdPlano)
        {
            anel = anel.Replace("Anel 0", "");

            lstGruposLogicos.Clear();
            DataTable dt = db.ExecuteReaderQuery(@"SELECT GrupoLogico, TipoGrupo, VerdeSeguranca FROM  GruposLogicos" +
                 " WHERE  Anel = " + anel + "  AND IdProgramacao = " + idProgramacao + " ORDER BY GrupoLogico");
            foreach (DataRow dr in dt.Rows)
            {
                GruposLogicos gl = new GruposLogicos(Convert.ToInt32(dr[0].ToString()), dr[1].ToString(), Convert.ToInt32(dr[2].ToString()));
                lstGruposLogicos.Add(gl);
            }

            lstVerdesConflitantes.Clear();
            dt = db.ExecuteReaderQuery("SELECT G1, G2 FROM  VerdesConflitantes  WHERE  Anel = " + anel + "  AND IdProgramacao =" + idProgramacao + " ORDER BY G1");
            foreach (DataRow dr in dt.Rows)
            {
                VerdesConflitantes vc = new VerdesConflitantes(Convert.ToInt32(dr[0].ToString()), Convert.ToInt32(dr[1].ToString()));
                lstVerdesConflitantes.Add(vc);
            }


            lstEstados.Clear();
            dt = db.ExecuteReaderQuery("SELECT id, Estado, GrupoLogico, Cor, COALESCE(TempoVerde,0) TempoVerde, COALESCE(Amarelo,0) Amarelo, COALESCE(VermelhoIntermitente,0) VermelhoIntermitente, COALESCE(VermelhoLimpeza,0) VermelhoLimpeza, COALESCE(TempoVerdeDemanda,0) TempoVerdeDemanda FROM  Estados" +
                 " WHERE  Anel = " + anel + "  AND IdPlano = " + IdPlano + " ORDER BY Estado, GrupoLogico");
            foreach (DataRow dr in dt.Rows)
            {
                Estado e = new Estado(Convert.ToInt32(dr["id"].ToString()), Convert.ToInt32(dr["Estado"].ToString()),
                    Convert.ToInt32(dr["GrupoLogico"].ToString()), dr["Cor"].ToString(),
                    Convert.ToInt32(dr["TempoVerde"]),
                    Convert.ToInt32(dr["AMARELO"]),
                    Convert.ToInt32(dr["VermelhoLimpeza"]),
                    Convert.ToInt32(dr["VermelhoIntermitente"]),
                    Convert.ToInt32(dr["TempoVerdeDemanda"]));
                lstEstados.Add(e);
            }

            lstEstagios.Clear();
            dt = db.ExecuteReaderQuery("SELECT id, NomePlano, Sequencia, Estado, Estagio, Laco, ExtensaoVerde, MinimoVerde, MaximoVerde, TempoFalhaDetector, Botoeira, " +
                "EstagioDemanda, EstagioDemandado, TempoVerdeIntermediario, TMPE, TempoVerde, COALESCE(Prioridade, 0) Prioridade, COALESCE(ExtensaoVerdeCoordenado,'0')ExtensaoVerdeCoordenado, COALESCE(ExtensaoSinc,'0')ExtensaoSinc FROM  PlanoEstagios WHERE  Anel = " + anel + "  AND IdPlano = " + IdPlano + " ORDER BY Estagio");
            foreach (DataRow dr in dt.Rows)
            {
                Estagio e = new Estagio(
                    Convert.ToInt32(dr["id"]),
                    dr["NomePlano"].ToString(),
                    Convert.ToInt32(dr["Sequencia"]),
                    Convert.ToInt32(dr["Estado"]),
                    dr["Estagio"].ToString(),
                    (dr["Laco"] is DBNull ? 0 : Convert.ToInt32(dr["Laco"])),
                    (dr["ExtensaoVerde"] is DBNull ? 0 : Convert.ToInt32(dr["ExtensaoVerde"])),
                    (dr["MinimoVerde"] is DBNull ? 0 : Convert.ToInt32(dr["MinimoVerde"])),
                    (dr["MaximoVerde"] is DBNull ? 0 : Convert.ToInt32(dr["MaximoVerde"])),
                    (dr["TempoFalhaDetector"] is DBNull ? 0 : Convert.ToInt32(dr["TempoFalhaDetector"])),
                    (dr["Botoeira"] is DBNull ? "0" : dr["Botoeira"].ToString()),
                    Convert.ToInt32(dr["EstagioDemanda"]),
                    dr["EstagioDemandado"].ToString(),
                    (dr["TempoVerdeIntermediario"] is DBNull ? 0 : Convert.ToInt32(dr["TempoVerdeIntermediario"])),
                    Convert.ToInt32(dr["TMPE"].ToString()),
                Convert.ToInt32(dr["TempoVerde"].ToString()),
                Convert.ToInt32(dr["Prioridade"].ToString()),
                Convert.ToInt32(dr["ExtensaoVerdeCoordenado"].ToString()),
                Convert.ToInt32(dr["ExtensaoSinc"].ToString()));
                lstEstagios.Add(e);


            }
        }

        /// <summary>
        /// Retorna o domingo de páscoa de um determinado ano
        /// </summary>
        public DateTime DomingoDePascoa(int ano)
        {
            Int32 a = ano % 19;
            Int32 b = ano / 100;
            Int32 c = ano % 100;
            Int32 d = b / 4;
            Int32 e = b % 4;
            Int32 f = (b + 8) / 25;
            Int32 g = (b - f + 1) / 3;
            Int32 h = (19 * a + b - d - g + 15) % 30;
            Int32 i = c / 4;
            Int32 k = c % 4;
            Int32 L = (32 + 2 * e + 2 * i - h - k) % 7;
            Int32 m = (a + 11 * h + 22 * L) / 451;
            Int32 mes = (h + L - 7 * m + 114) / 31;
            Int32 dia = ((h + L - 7 * m + 114) % 31) + 1;
            return new DateTime(ano, mes, dia);
        }

        /// <summary>
        /// Retorna o domingo de carnaval de um determinado ano
        /// </summary>
        public DateTime DomingoDeCarnaval(int ano)
        {
            return DomingoDePascoa(ano).AddDays(-49);
        }

        /// <summary>
        /// Retorna a data de início do horário de verão de um determinado ano
        /// </summary>
        public DateTime InicioHorarioVerao(Int32 ano)
        {
            // terceiro domingo de outubro
            DateTime primeiroDeNovembro = new DateTime(ano, 10, 1);
            DateTime primeiroDomingoDeNovembro = primeiroDeNovembro.AddDays((7 - (Int32)primeiroDeNovembro.DayOfWeek) % 7);
            //  DateTime terceiroDomingoDeOutubro = primeiroDomingoDeNovembro.AddDays(14);
            return primeiroDomingoDeNovembro;
        }

        /// <summary>
        /// Retorna a data de término do horário de verão de um determinado ano
        /// </summary>
        public DateTime TerminoHorarioVerao(Int32 ano)
        {
            DateTime primeiroDeFevereiro = new DateTime(ano + 1, 2, 1);
            DateTime primeiroDomingoDeFevereiro = primeiroDeFevereiro.AddDays((7 - (Int32)primeiroDeFevereiro.DayOfWeek) % 7);
            DateTime terceiroDomingoDeFevereiro = primeiroDomingoDeFevereiro.AddDays(14);

            if (terceiroDomingoDeFevereiro != DomingoDeCarnaval(ano))
            {
                return terceiroDomingoDeFevereiro;
            }
            else
            {
                return terceiroDomingoDeFevereiro.AddDays(7);
            }
        }
    }
    public class ComboboxItem
    {
        public ComboboxItem(string text, object value)
        {
            Text = text;
            Value = value;
        }
        public string Text { get; set; }
        public object Value { get; set; }

        public override string ToString()
        {
            return Text;
        }
    }
    public class VerdesConflitantes
    {
        public VerdesConflitantes(int g1, int g2)
        {
            G1 = g1;
            G2 = g2;
        }
        public int G1 { get; set; }
        public int G2 { get; set; }
    }
    public class GruposLogicos
    {
        public GruposLogicos(int grupo, string tipo, int verdeSeguranca)
        {
            Grupo = grupo;
            Tipo = tipo;
            VerdeSeguranca = verdeSeguranca;
        }
        public int Grupo { get; set; }
        public string Tipo { get; set; }
        public int VerdeSeguranca { get; set; }
        public bool VerificaVermelhoPedestre { get; set; }
    }
    public class Estado
    {
        public Estado(int id, int _estado, int grupo, string cor, int tempoVerde, int amarelo, int vermelhoLimpeza,
            int vermelhoIntermitente, int tempoVerdeDemanda)
        {
            this.Id = id;
            this.estado = _estado;
            this.GrupoLogico = grupo;
            this.Cor = cor;
            TempoVerde = tempoVerde;
            Amarelo = amarelo;
            VermelhoIntermitente = vermelhoIntermitente;
            VermelhoLimpeza = vermelhoLimpeza;
            TempoVerdeDemanda = tempoVerdeDemanda;
        }

        public int Id { get; set; }
        public int estado { get; set; }
        public int GrupoLogico { get; set; }
        public string Cor { get; set; }
        public int TempoVerde { get; set; }
        public int Amarelo { get; set; }
        public int VermelhoIntermitente { get; set; }
        public int VermelhoLimpeza { get; set; }
        public int TempoVerdeDemanda { get; set; }



    }
    public class Estagio
    {
        public Estagio(int _id, string nomePlano, int sequencia, int estado, string _estagio, int laco, int extensaoVerde, int minVerde, int maxVerde,
            int tempoFalhaDetector, string botoeira, int estagioDemanda, string estagioDemandado, int tempoVerdeIntermediario, int tmpe,
            int tempoVerde, int prioridade, int extensaoCoordenado, int extensaoSinc)
        {
            id = _id;
            NomePlano = nomePlano;
            Sequencia = sequencia;
            Estado = estado;
            estagio = _estagio;
            Laco = laco;
            ExtensaoVerde = extensaoVerde;
            MinimoVerde = minVerde;
            MaximoVerde = maxVerde;
            TempoFalhaDetector = tempoFalhaDetector;
            Botoeira = botoeira;
            EstagioDemanda = estagioDemanda;
            EstagioDemandado = estagioDemandado;
            TempoVerdeIntermediario = tempoVerdeIntermediario;
            this.TMPE = tmpe;
            TempoVerde = tempoVerde;
            Prioridade = prioridade;
            ExtensaoCoordenado = extensaoCoordenado;
            ExtensaoSinc = extensaoSinc;
        }
        //public Estagio(int _id, string nomePlano, int sequencia, int estado, string _estagio)
        //{
        //    id = _id;
        //    NomePlano = nomePlano;
        //    Sequencia = sequencia;
        //    Estado = estado;
        //    estagio = _estagio;
        //    this.TMPE = 0;
        //    Laco = 0;
        //    ExtensaoVerde = 0;
        //    MinimoVerde = 0;
        //    MaximoVerde = 0;
        //    TempoFalhaDetector = 0;
        //    Botoeira = "0";
        //    EstagioDemanda = 0;
        //    EstagioDemandado = "";
        //    TempoVerdeIntermediario = 0;
        //}
        public int id { get; set; }
        public string NomePlano { get; set; }
        public int Sequencia { get; set; }
        public int Estado { get; set; }
        public string estagio { get; set; }
        public int Laco { get; set; }
        public int ExtensaoVerde { get; set; }
        public int ExtensaoCoordenado { get; set; }
        public int MinimoVerde { get; set; }
        public int MaximoVerde { get; set; }
        public int TempoFalhaDetector { get; set; }
        public string Botoeira { get; set; }
        public string EstagioDemandado { get; set; }
        public int TempoVerdeIntermediario { get; set; }
        public int TMPE { get; set; }
        public int TempoVerde { get; set; }
        public int Prioridade { get; set; }
        private int _EstagioDemanda;
        public int EstagioDemanda
        {
            get { return _EstagioDemanda; }
            set
            {
                _EstagioDemanda = value;
                Prioridade = value == 3 ? 1 : 0;
            }
        }

        public int ExtensaoSinc { get; set; }

        public int EntreVerde1 { get; set; }
        public int EntreVerde2 { get; set; }
    }
    public class ConversaoProibida
    {
        public ConversaoProibida(string e1, string e2)
        {
            E1 = e1;
            E2 = e2;
        }
        public string E1 { get; set; }
        public string E2 { get; set; }
    }
    public static class StringApoio
    {
        public static Int64 ToIntDatetime(this string BrDate)
        {
            try
            {
                return Convert.ToInt64(Convert.ToDateTime(BrDate).ToString("yyyyMMddHHmmss"));
            }
            catch
            {
                return 0;
            }

        }
        public static string ToStringNumberDatetime(this string BrDate)
        {
            try
            {
                return Convert.ToInt64(Convert.ToDateTime(BrDate).ToString("yyyyMMddHHmmss")).ToString();
            }
            catch
            {
                return "";
            }

        }
        public static string ToBrDatetime(this Int64 intDate)
        {
            string str = intDate.ToString();
            try
            {
                if (str.Length < 12)
                    return $"{str.Substring(6, 2)}/{str.Substring(4, 2)}/{str.Substring(0, 4)}";
                else
                {
                    str = intDate.ToString().PadLeft(16, '0');
                    return $"{str.Substring(6, 2)}/{str.Substring(4, 2)}/{str.Substring(0, 4)} {str.Substring(8, 2)}:{str.Substring(10, 2)}:{str.Substring(12)}";
                }//2018043019120000
            }
            catch
            {
                return "";
            }

        }
        public static string ToBrDatetime(this string stringNumberDate)
        {
            try
            {
                if (stringNumberDate.Length < 14)
                    return $"{stringNumberDate.Substring(6, 2)}/{stringNumberDate.Substring(4, 2)}/{stringNumberDate.Substring(0, 4)}";
                else
                {
                    return $"{stringNumberDate.Substring(6, 2)}/{stringNumberDate.Substring(4, 2)}/{stringNumberDate.Substring(0, 4)} {stringNumberDate.Substring(8, 2)}:{stringNumberDate.Substring(10, 2)}:{stringNumberDate.Substring(12)}";
                }//2018043019120000
            }
            catch
            {
                return "";
            }

        }
        public static string ToBrTime(this string stringNumberTime)
        {
            try
            {
                stringNumberTime = stringNumberTime.PadLeft(6, '0');

                return $"{stringNumberTime.Substring(0, 2)}:{stringNumberTime.Substring(2, 2)}:{stringNumberTime.Substring(4)}";
            }
            catch
            {
                return "";
            }

        }
        public static bool TemPermissao(this string user, Role role)
        {
            Banco db = new Banco("");
            try
            {
                string temP = db.ExecuteScalarQuery("SELECT Count(0) FROM UserInRole WHERE Login='" + user + "' AND role='" + role.ToString() + "'");
                if (temP != "" & temP != "0")
                    return true;
                else
                    return false;
            }
            catch
            {
                return false;
            }

        }
    }
    public static class DataTableExtensions
    {
        public static void SetColumnsOrder(this DataTable table, params String[] columnNames)
        {
            int columnIndex = 0;
            foreach (var columnName in columnNames)
            {
                table.Columns[columnName].SetOrdinal(columnIndex);
                columnIndex++;
            }
        }
    }
    public enum Role
    {
        Apaga_Logs_Falha_Restabelecimento,
        Apaga_Logs_Operacao,
        Criar_Login,
        Envia_Programacao_Para_O_Equipamento,
        Excluir_Login,
        Manipula_Roles,
        Excluir_Programacao,
        Alterar_IP_Do_Equipamento
    }

}
