using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Data.OleDb;
using System.Configuration;

namespace SuPlan
{
    public class UploadDAO : BaseDAO
    {
        protected string connStr;

        public string ImportFile(string filePath, string extension, string user)
        {
            string output;

            switch (extension)
            {
                case ".xls": //Excel 97-03
                    connStr = ConfigurationManager.ConnectionStrings["Excel03ConnString"]
                             .ConnectionString;
                    break;
                case ".xlsx": //Excel 07
                    connStr = ConfigurationManager.ConnectionStrings["Excel07ConnString"]
                              .ConnectionString;
                    break;
            }

            connStr = String.Format(connStr, filePath,"True");
                        
            OleDbConnection connExcel = new OleDbConnection(connStr);
            OleDbCommand cmdExcel = new OleDbCommand();
            OleDbDataAdapter oda = new OleDbDataAdapter();

            DataTable dt = new DataTable();
            cmdExcel.Connection = connExcel;

            //Get the name of first sheet
            connExcel.Open();
            DataTable dtExcelSchema;

            dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();

            connExcel.Close();

            //read data from first sheet

            connExcel.Open();
            cmdExcel.CommandText = "SELECT * From [" + SheetName + "]";
            oda.SelectCommand = cmdExcel;
            oda.Fill(dt);
            connExcel.Close();

            importData(dt, user);

            output = "import complete by " + user ;
            return output;
        }

        protected void importData(DataTable dtImport, string user)
        {
            //grab the names of columns we need from the spreadsheet data
            string importColumnList = ConfigurationManager.AppSettings["ImportColumns"];
            //these will be the actual columns we use to import
            string fromColumnList = ConfigurationManager.AppSettings["FromColumns"];
            string toColumnList = ConfigurationManager.AppSettings["ToColumns"];

            List<string> columnsToImport = importColumnList.Split(',').ToList();
            List<string> columnsFrom = fromColumnList.Split(',').ToList();
            List<string> columnsTo = toColumnList.Split(',').ToList();
            List<string> columnsToDelete = new List<string>();
            
            foreach (DataColumn c in dtImport.Columns)
            {
                int i = columnsToImport.FindIndex(item => item.ToLower() == c.ColumnName.ToLower());
                if (i == -1)
                {
                    //build a list of columns we don't need
                    columnsToDelete.Add(c.ColumnName);
                }
            }
            foreach (string col in columnsToDelete)
            {
                //remove the columns we don't need
                dtImport.Columns.Remove(col);
            }

            runCustomTransformation(dtImport, user);

            //Employee ID   Name    Hire Date       Locations   Job Title   Job Code    Sub Team code   InsertedBy
            //TMID          Name    LastHireDate    Location    JobTitle    JobCode     TeamCode        InsertedBy

            CleanAndCopy("TeamMembersImport", dtImport,columnsFrom, columnsTo);
        }

        protected void runCustomTransformation(DataTable dt, string user)
        {
            dt.Columns.Add("Name");
            dt.Columns.Add("InsertedBy");

            try
            {
                for (int rowIndex = 0; rowIndex < dt.Rows.Count; rowIndex++)
                {
                    DataRow r = dt.Rows[rowIndex];
                    r["Name"] = r["Last Name"] + ", " + r["First Name"];
                    r["InsertedBy"] = user;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
    }
}