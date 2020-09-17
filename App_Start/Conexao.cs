using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Infortronics
{
    /// <summary>
    /// Classe de conexão com DB
    /// </summary>
    public class Conexao
    {
        /// <summary>
        /// Conexão com o banco de dados
        /// </summary>
        public SqlConnection MySqlConnection = new SqlConnection();

        /// <summary>
        /// Método que conecta o Banco de Dados
        /// </summary>
        /// <returns>Retorna True se conectou, ou False se deu erro.</returns>
        public bool ConectarDb()
        {
            try
            {
                MySqlConnection.ConnectionString = StrConexao;
                MySqlConnection.Open();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        string _StrConexao = "";
        public string StrConexao
        {
            get
            {
                if (_StrConexao.Length > 15)
                    return _StrConexao;
                else
                    //return Properties.Settings.Default.ConnectionString;//
                return ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString ;
            }
            set { _StrConexao = value; }
        }

        /// <summary>B
        /// Desconecta o Banco de Dados.
        /// </summary>
        /// <returns></returns>
        public bool DesconectarDb()
        {
            MySqlConnection.Close();
            MySqlConnection.Dispose();
            return true;
        }
    }
}