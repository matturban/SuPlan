using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public class BaseDAO
{
    protected SqlConnection conn;
    protected SqlCommand cmd;

    protected DataTable ReturnDataTable(string StoredProcedureName, SqlParameter[] parameters)
    {
        DataTable dt = new DataTable();
        try
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SuPlan"].ConnectionString);
            cmd = new SqlCommand(StoredProcedureName);
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            if (parameters != null)//(parameters.Length > 0)  
            {
                foreach (SqlParameter p in parameters)
                {
                    cmd.Parameters.AddWithValue(p.ParameterName, p.Value);
                }
            }
            dt.Load(cmd.ExecuteReader());

        }
        catch (SqlException ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        };

        cmd.Parameters.Clear();
        return dt;
    }

    protected int RunNonQuery(string StoredProcedureName, SqlParameter[] parameters)
    {
        int i = 0;
        try
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SuPlan"].ConnectionString);
            cmd = new SqlCommand(StoredProcedureName);
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            if (parameters.Length > 0)
            {
                foreach (SqlParameter p in parameters)
                {
                    cmd.Parameters.AddWithValue(p.ParameterName, p.Value);
                }
            }
            cmd.ExecuteNonQuery();

        }
        catch (SqlException ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        };

        cmd.Parameters.Clear();
        return i;
    }

    protected object ExecuteScalar(string StoredProcedureName, SqlParameter[] parameters)
    {
        object v;
        try
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SuPlan"].ConnectionString);
            cmd = new SqlCommand(StoredProcedureName);
            cmd.Connection = conn;
            conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            if (parameters.Length > 0)
            {
                foreach (SqlParameter p in parameters)
                {
                    cmd.Parameters.AddWithValue(p.ParameterName, p.Value);
                }
            }
            v = cmd.ExecuteScalar();
        }
        catch (SqlException ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        };

        cmd.Parameters.Clear();
        return v;
    }

    protected int CleanAndCopy(string destTable, DataTable dt, List<string> columnMappingFrom, List<string> columnMappingTo)
    {
        int rowcount = 0;
        try
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SuPlan"].ConnectionString);
            conn.Open();

            SqlCommand cmdTruncate = new SqlCommand("DELETE FROM " + destTable + ";",conn);
            
            cmdTruncate.ExecuteNonQuery();

            SqlBulkCopy bc = new SqlBulkCopy(conn);
            foreach (string f in columnMappingFrom)
            {
                int i = f.IndexOf(f);
                bc.ColumnMappings.Add(f.ToString(), columnMappingTo[i]);
            }
            
            bc.DestinationTableName = destTable;
            bc.WriteToServer(dt);

            SqlCommand cmdRowCount = new SqlCommand("SELECT COUNT(*) FROM " + destTable + ";", conn);

            rowcount = System.Convert.ToInt32(cmdRowCount.ExecuteScalar());
        }
        catch (SqlException ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        };

        return rowcount;
    }
}
