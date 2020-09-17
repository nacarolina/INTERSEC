using System;
using System.Data;
using System.Data.Common;
using System.Collections;
using System.Data.SqlClient;

namespace Infortronics
{
    public class Banco : Conexao
    {
        public  Banco(string connectionString)
        {
            StrConexao = connectionString;
        }
        /// <summary>
        /// Libera um DataTable que é passado como parametro
        /// </summary>
        /// <param name="dt"></param>
        public void DisposeDataTable(DataTable dt)
        {
            dt.Clear();
            dt.Dispose();
        }

        /// <summary>
        /// Libera um DataSet que é passado como parametro
        /// </summary>
        /// <param name="dt"></param>
        public void DisposeDataSet(DataSet ds)
        {
            ds.Clear();
            ds.Dispose();
            ds = new DataSet();
        }

        /// <summary>
        /// Lista de parâmetros para execução de instruções SQL
        /// </summary>
        public ArrayList SQLParams = new ArrayList();

        /// <summary>
        /// Limpa a lista de parâmetros SQL interna.
        /// </summary>
        public void ClearSQLParams()
        {
            this.SQLParams.Clear();
        }

        /// <summary>
        /// Obtém a contagem de parâmetros SQL
        /// </summary>
        /// <returns>Número indicador da contagem de parâmetros SQL</returns>
        public int CountSQLParams()
        {
            return this.SQLParams.Count;
        }

        /// <summary>
        /// Adiciona parâmetros à lista de Parâmetros SQL
        /// </summary>
        /// <param name="pNomeParam">Nome do Parâmetro</param>
        /// <param name="pValor">Valor do parâmetro</param>
        public void AddSQLParam(string pNomeParam, object pValor)
        {
            this.SQLParams.Add(new SqlParameter(pNomeParam, pValor));
        }

        /// <summary>
        /// bit de retorno dos metodos booleanos
        /// </summary> 

        /// <summary>
        /// Executa Stored Procedure usando ExecuteReader
        /// </summary>
        /// <param name="pNomeSP">Nome da Stored Procedure</param>
        /// <param name="bParams">bit que indica se a procedure necessita de parametros</param>
        /// <returns>retorna um DataTable com os dados consultado</returns>
        public DataTable ExecuteReaderStoredProcedure(string pNomeSP, bool bParams)
        {
            SqlCommand cmmd = new SqlCommand(pNomeSP, MySqlConnection);
            cmmd.CommandType = CommandType.StoredProcedure;

            DataTable dt = new DataTable();
            SqlDataReader reader;

            if (ConectarDb())
            {
                //Alimenta os parâmetros da stored procedure
                cmmd.Parameters.Clear();
                if (bParams)
                {
                    for (int i = 0; i < SQLParams.Count; i++)
                    {
                        cmmd.Parameters.Add((IDbDataParameter)this.SQLParams[i]);
                    }
                }
                try
                {
                    // executa o comando.
                    reader = cmmd.ExecuteReader();
                    dt.Load(reader);
                }
                catch (DbException)
                {
                    throw;
                }
                catch (Exception)
                {
                    throw;
                }
                finally
                {
                    cmmd.Dispose();
                    DesconectarDb();
                }
            }
            return dt;
        }

        public DataTable ExecuteReaderQuery(string sSql)
        {
            SqlCommand cmmd = new SqlCommand(sSql, MySqlConnection);
            cmmd.CommandType = CommandType.Text;

            DataTable dt = new DataTable();
            SqlDataReader reader;

            if (ConectarDb())
            {
                try
                {
                    // executa o comando.
                    reader = cmmd.ExecuteReader();
                    dt.Load(reader);
                }
                catch (Exception e)
                {
                    string erro = e.Message;
                }

                finally
                {
                    cmmd.Dispose();
                    DesconectarDb();
                }
            }
            return dt;
        }

        public string ExecuteScalarQuery(string sSql)
        {

            string str = "";
            SqlCommand cmmd = new SqlCommand(sSql, MySqlConnection);
            cmmd.CommandType = CommandType.Text;


            if (ConectarDb())
            {
                try
                {
                    // executa o comando.
                    str = cmmd.ExecuteScalar().ToString(); 
                }
                catch (Exception err)
                {
                   // throw;
                }

                finally
                {
                    cmmd.Dispose();
                    DesconectarDb();
                }
            }
            return str;
        } 

        public bool ExecuteNonQuery(string sSql)
        {
            bool b = false;
            SqlCommand cmmd = new SqlCommand(sSql, MySqlConnection);
            cmmd.CommandType = CommandType.Text;


            if (ConectarDb())
            {
                try
                {
                    // executa o comando.
                    cmmd.ExecuteNonQuery();
                    b = true;
                }
                catch (DbException dbErr)
                {
                    b = false;
                }
                catch (Exception err)
                {
                    b = false;
                }
                finally
                {
                    cmmd.Dispose();
                    DesconectarDb();
                }
                if (b)
                {
                    string sql = sSql.Replace("'", "\"");
                    ExecuteNonQueryAsync(@"Insert Into Sincronizacao (Query,CentralCet,Banco)
values('" + sql + "','" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss.fff") + "','Central')");
                }
            }
            return b;
        }

        public bool ExecuteNonQueryNoUpper(string sSql)
        {
            bool b = false;
            string query = sSql;
            SqlCommand cmmd = new SqlCommand(query, MySqlConnection);
            cmmd.CommandType = CommandType.Text;


            if (ConectarDb())
            {
                try
                {
                    // executa o comando.
                    cmmd.ExecuteNonQuery();
                    b = true;

                }
                catch (DbException)
                {
                    b = false;
                }
                catch (Exception)
                {
                    b = false;
                }
                finally
                {
                    cmmd.Dispose();
                    DesconectarDb();
                }
            }
            if (b)
            {
                string sql = sSql.Replace("'", "\"");
                //ExecuteNonQueryAsync(@"Insert Into Sincronizacao (Query,CentralCobrasin,Banco)
                //values('" + sql + "','" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss.fff") + "','Cobrasin')");
            }
            return b;
        }

        private void ExecuteNonQueryAsync(string sSql)
        {   
        SqlCommand cmmd = new SqlCommand(sSql, MySqlConnection);
        cmmd.CommandType = CommandType.Text;


            if (ConectarDb())
            {
                try
                {
                    // executa o comando.
                    cmmd.ExecuteNonQuery(); 
                }
                catch (DbException dbErr)
                {
                   throw;
                }
                catch (Exception err)
                {
                    throw;
                }
                finally
                {
                    cmmd.Dispose();
                    DesconectarDb();
                }
            } 
        }

        /// <summary>
        /// Executa Stored Procedure usando ExecuteNonQuery
        /// </summary>
        /// <param name="pNomeSP">Nome da Stored Procedure</param>
        /// <param name="bParams">bit que indica se a procedure necessita de parametros</param>
        /// <returns>Retorta true para operação concluidada com sucesso ou false para erro</returns>
        public bool ExecuteNonQueryStoredProcedure(string pNomeSP, bool bParams)
        {
            bool b = false;
            SqlCommand cmmd = new SqlCommand(pNomeSP, MySqlConnection);
            cmmd.CommandType = CommandType.StoredProcedure;

            if (ConectarDb())
            {

                //Alimenta os parâmetros da stored procedure
                cmmd.Parameters.Clear();
                if (bParams)
                {
                    for (int i = 0; i < SQLParams.Count; i++)
                    {
                        cmmd.Parameters.Add((IDbDataParameter)this.SQLParams[i]);
                    }
                }
                try
                {
                    // executa o comando.
                    cmmd.ExecuteNonQuery();

                    b = true;
                }
                catch (DbException dbErr)
                {
                    b = false;
                    throw;
                }
                catch (Exception Err)
                {
                    b = false;
                    throw;
                }
                finally
                {
                    cmmd.Dispose();
                    DesconectarDb();
                }
            }
            return b;
        }

        /// <summary>
        /// Executa Stored Procedure usando ExecuteScalar
        /// </summary>
        /// <param name="pNomeSP">Nome da Stored Procedure</param>
        /// <param name="bParams">bit que indica se a procedure necessita de parametros</param>
        /// <returns>Retorta um object referente ao ExecuteScalar</returns>
        public object ExecuteScalarStoredProcedure(string pNomeSP, bool bParams)
        {
            SqlCommand cmmd = new SqlCommand(pNomeSP, MySqlConnection);
            cmmd.CommandType = CommandType.StoredProcedure;
            object o = null;

            if (ConectarDb())
            {

                //Alimenta os parâmetros da stored procedure
                cmmd.Parameters.Clear();
                if (bParams)
                {
                    for (int i = 0; i < SQLParams.Count; i++)
                    {
                        cmmd.Parameters.Add((IDbDataParameter)this.SQLParams[i]);
                    }
                }
                cmmd.Parameters.Add("@RETURN_VALUE", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;

                try
                {
                    // executa o comando.
                    o = cmmd.ExecuteScalar();
                    if (o == null)
                        o = cmmd.Parameters["@RETURN_VALUE"].Value.ToString();


                }
                catch (DbException)
                {
                    throw;
                }
                catch (Exception)
                {
                    throw;
                }
                finally
                {
                    cmmd.Dispose();
                    DesconectarDb();
                }
            }
            return o;
        }



    }
}
