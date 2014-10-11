using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace SuPlan
{
    public class AdminDAO : BaseDAO
    {
        public DataTable GetLocations()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetLocationsForEdit",null);
            return dt;
        }

        public void UpdateLocations(int id, string acronym, string businessunit, int metroid)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
                new SqlParameter("Acronym",acronym),
                new SqlParameter("BusinessUnit", businessunit),
                new SqlParameter("MetroID", metroid)
            };
            RunNonQuery("UpdateLocations", parameters);
        }

        public void InsertLocations(string acronym, string businessunit, int metroid)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("Acronym",acronym),
                new SqlParameter("BusinessUnit", businessunit),
                new SqlParameter("MetroID", metroid)
            };

            RunNonQuery("InsertLocations", parameters);
        }

        public void DeleteLocations(int id)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
            };

            RunNonQuery("DeleteLocations", parameters);
        }

        public DataTable GetMetros()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetMetros", null);
            return dt;
        }

        public DataTable GetMetrosForEdit()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetMetros", null);
            DataRow dr = dt.NewRow();
            dr["MetroID"] = -1;
            dr["Name"] = "";
            dt.Rows.InsertAt(dr, 0);
            return dt;
        }

        public void UpdateMetros(int id, string name)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
                new SqlParameter("Name",name)
            };

            RunNonQuery("UpdateMetros", parameters);
        }

        public void InsertMetros(string name)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("Name",name)
            };

            RunNonQuery("InsertMetros", parameters);
        }

        public void DeleteMetros(int id)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
            };

            RunNonQuery("DeleteMetros", parameters);
        }

        public DataTable GetTeams()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetTeams", null);
            return dt;
        }

        public void UpdateTeams(int id, string name, string teamcode)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
                new SqlParameter("Name",name),
                new SqlParameter("TeamCode",teamcode)
            };
            RunNonQuery("UpdateTeams", parameters);
        }

        public void InsertTeams(string name, string teamcode)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("Name",name),
                new SqlParameter("TeamCode",teamcode)
            };

            RunNonQuery("InsertTeams", parameters);
        }

        public void DeleteTeams(int id)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
            };

            RunNonQuery("DeleteTeams", parameters);
        }

        public DataTable GetJobTitles()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetJobTitlesForEdit", null);
            return dt;
        }

        public void UpdateJobTitles(int id, string title, string jobcode, string jobfamily, string category, string shorttitle, bool include)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
                new SqlParameter("Title",title),
                new SqlParameter("JobCode",jobcode),
                new SqlParameter("JobFamily",jobfamily),
                new SqlParameter("Category",category),
                new SqlParameter("ShortTitle",shorttitle),
                new SqlParameter("Include",include)
            };
            RunNonQuery("UpdateJobTitles", parameters);
        }

        public void InsertJobTitles(string title, string jobcode, string jobfamily, string category, string shorttitle, bool include)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("Title",title),
                new SqlParameter("JobCode",jobcode),
                new SqlParameter("JobFamily",jobfamily),
                new SqlParameter("Category",category),
                new SqlParameter("ShortTitle",shorttitle),
                new SqlParameter("Include",include)
            };

            RunNonQuery("InsertJobTitles", parameters);
        }

        public void DeleteJobTitles(int id)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
            };

            RunNonQuery("DeleteJobTitles", parameters);
        }

        public DataTable GetNextJobTitles()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetNextJobTitles", null);
            return dt;
        }

        public void UpdateNextJobTitles(int id, string shorttitle)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
                new SqlParameter("ShortTitle",shorttitle)
            };
            RunNonQuery("UpdateNextJobTitles", parameters);
        }

        public void InsertNextJobTitles(string shorttitle)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ShortTitle",shorttitle)
            };

            RunNonQuery("InsertNextJobTitles", parameters);
        }

        public void DeleteNextJobTitles(int id)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
            };

            RunNonQuery("DeleteNextJobTitles", parameters);
        }

        public DataTable GetImportChecks()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetImportChecks", null);
            return dt;
        }

        public void UpdateImportChecks(int id, string checkdescription, string checksql)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
                new SqlParameter("CheckDescription",checkdescription),
                new SqlParameter("CheckSQL",checksql)
            };
            RunNonQuery("UpdateImportChecks", parameters);
        }

        public void InsertImportChecks(string checkdescription, string checksql)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("CheckDescription",checkdescription),
                new SqlParameter("CheckSQL",checksql)
            };

            RunNonQuery("InsertImportChecks", parameters);
        }

        public void DeleteImportChecks(int id)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
            };

            RunNonQuery("DeleteImportChecks", parameters);
        }
    }
}