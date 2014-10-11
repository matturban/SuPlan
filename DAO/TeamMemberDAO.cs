using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace SuPlan
{
    public class TeamMemberDAO : BaseDAO
    {
        public DataTable GetTeamMembers(
            bool? updated,
            int tmid,
            int teamid,
            int metroid,
            int locationid,
            string shorttitle,
            DateTime? jobentrydate,
            DateTime? lastjddate,
            int jdratingid,
            int riskid,
            int nextjobid,
            int teaminterestid, 
            int timeframeid,
            string relocate,
            string destinationplan
            )
        {
            DataTable dt = new DataTable();
            SqlParameter[] parameters = 
            {
            new SqlParameter("Updated",updated),
            new SqlParameter("TMID",tmid),
            new SqlParameter("TeamID",teamid),
            new SqlParameter("MetroID",metroid),
            new SqlParameter("LocationID",locationid),
            new SqlParameter("ShortTitle",shorttitle),
            new SqlParameter("JobEntryDate",jobentrydate),
            new SqlParameter("LastJDDate",lastjddate),
            new SqlParameter("JDRatingID",jdratingid),
            new SqlParameter("RiskID",riskid),
            new SqlParameter("NextJobID",nextjobid),
            new SqlParameter("TeamInterestID",teaminterestid),
            new SqlParameter("TimeFrameID",timeframeid),
            new SqlParameter("Relocate",relocate),
            new SqlParameter("DestinationPlan",destinationplan)
            };

            dt = ReturnDataTable("GetTeamMembers", parameters);
            return dt;
        }

        public DataTable GetTeamMemberByTMID(int tmid)
        {
            DataTable dt = new DataTable();
            SqlParameter[] parameters = 
            {
            new SqlParameter("TMID",tmid),
            };

            dt = ReturnDataTable("GetTeamMemberByTMID", parameters);
            return dt;
        }

        public DataTable GetBackFillByTMID(int tmid)
        {
            DataTable dt = new DataTable();
            SqlParameter[] parameters = 
            {
            new SqlParameter("TMID",tmid),
            };

            dt = ReturnDataTable("GetBackFillByTMID", parameters);
            return dt;
        }

        public void UpdateTeamMembers(int id,
            DateTime? jobentrydate,
            int educationlevelid,
            DateTime? lastjd,
            int lastjdratingid,
            int riskid,
            int nextjobid,
            int teaminterestid,
            int nextjobtimeframeid,
            DataTable dtRelocate,
            string destinationplan,
            int backfillid,
            bool updated,
            string username)
        {


            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id),
                new SqlParameter("JobEntryDate",jobentrydate),
                new SqlParameter("EducationLevelID",educationlevelid),
                new SqlParameter("LastJD",lastjd),
                new SqlParameter("LastJDRatingID",lastjdratingid),
                new SqlParameter("RiskID",riskid),
                new SqlParameter("NextJobID",nextjobid),
                new SqlParameter("TeamInterestID",teaminterestid),
                new SqlParameter("NextJobTimeFrameID",nextjobtimeframeid),
                new SqlParameter("Relocate", dtRelocate),
                new SqlParameter("DestinationPlan",destinationplan),
                new SqlParameter("BackFillID", backfillid),
                new SqlParameter("Updated", updated),
                new SqlParameter("UserName", username)
            };

            RunNonQuery("UpdateTeamMembers", parameters);

        }

        public void InsertBackFill(int tmid, int backfillid)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("TMID",tmid),
                new SqlParameter("BackFillID",backfillid),
            };

            RunNonQuery("InsertBackFill", parameters);
        }

        public void DeleteBackFill(int id)
        {
            SqlParameter[] parameters =
            {
                new SqlParameter("ID",id)
            };

            RunNonQuery("DeleteBackFill", parameters);
        }

        public DataTable GetMetros()
        {
            DataTable dt = new DataTable();

            dt = ReturnDataTable("GetMetros", null);
            return dt;
        }

        public DataTable GetLocations()
        {
            DataTable dt = new DataTable();

            dt = ReturnDataTable("GetLocations", null);
            return dt;
        }

        public DataTable GetJobTitles()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetJobTitles", null);
            DataRow dr = dt.NewRow();
            dr["TitleID"] = -1;
            dr["Title"] = "";
            dt.Rows.InsertAt(dr, 0);
            return dt;
        }

        public DataTable GetShortTitles()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetShortTitles", null);
            DataRow dr = dt.NewRow();
            dr["ShortTitle"] = "";
            dt.Rows.InsertAt(dr, 0);
            return dt;
        }

        public DataTable GetNextJobTitles()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetNextJobTitles", null);
            DataRow dr = dt.NewRow();
            dr["NextJobID"] = -1;
            dr["ShortTitle"] = "";
            dt.Rows.InsertAt(dr, 0);
            return dt;
        }

        public DataTable GetTeams()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetTeams", null);
            DataRow dr = dt.NewRow();
            dr["TeamID"] = -1;
            dr["Name"] = "";
            dt.Rows.InsertAt(dr, 0);
            return dt;
        }

        public DataTable GetJDRatings()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetJDRatings", null);
            DataRow dr = dt.NewRow();
            dr["RatingID"] = -1;
            dr["Rating"] = "";
            dt.Rows.InsertAt(dr, 0);
            return dt;
        }

        public DataTable GetRisks()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetRisks", null);
            DataRow dr = dt.NewRow();
            dr["RiskID"] = -1;
            dr["Risk"] = "";
            dt.Rows.InsertAt(dr, 0);
            return dt;
        }

        public DataTable GetTeamMemberIDs()
        {
            DataTable dt = new DataTable();

            dt = ReturnDataTable("GetTeamMemberIDs", null);
            return dt;
        }


        public DataTable GetTeamMemberNames()
        {
            DataTable dt = new DataTable();

            dt = ReturnDataTable("GetTeamMemberNames", null);
            return dt;
        }

        public DataTable GetTimeFrames()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetTimeFrames", null);
            DataRow dr = dt.NewRow();
            dr["TimeFrameID"] = -1;
            dr["TimeFrame"] = "";
            dt.Rows.InsertAt(dr, 0);
            return dt;
        }

        public DataTable GetEducationLevels()
        {
            DataTable dt = new DataTable();
            dt = ReturnDataTable("GetEducationLevels", null);
            DataRow dr = dt.NewRow();
            dr["LevelID"] = -1;
            dr["Level"] = "";
            dt.Rows.InsertAt(dr, 0);
            return dt;
        }

        //public DataTable GetTeamMembersExport(bool? updated,
        //    int tmid,
        //    int teamid,
        //    int metroid,
        //    int locationid,
        //    int jobtitleid,
        //    DateTime? jobentrydate,
        //    DateTime? lastjddate,
        //    int jdratingid,
        //    int riskid,
        //    int nextjobid,
        //    int teaminterestid,
        //    int timeframeid,
        //    string relocate,
        //    string destinationplan
        //    )
        //{
        //    DataTable dt = new DataTable();
        //    SqlParameter[] parameters = 
        //    {
        //    new SqlParameter("Updated",updated),
        //    new SqlParameter("TMID",tmid),
        //    new SqlParameter("TeamID",teamid),
        //    new SqlParameter("MetroID",metroid),
        //    new SqlParameter("LocationID",locationid),
        //    new SqlParameter("JobTitleID",jobtitleid),
        //    new SqlParameter("JobEntryDate",jobentrydate),
        //    new SqlParameter("LastJDDate",lastjddate),
        //    new SqlParameter("JDRatingID",jdratingid),
        //    new SqlParameter("RiskID",riskid),
        //    new SqlParameter("NextJobID",nextjobid),
        //    new SqlParameter("TeamInterestID",teaminterestid),
        //    new SqlParameter("TimeFrameID",timeframeid),
        //    new SqlParameter("Relocate",relocate),
        //    new SqlParameter("DestinationPlan",destinationplan)
        //    };

        //    dt = ReturnDataTable("GetTeamMembersExport", parameters);
        //    return dt;
        //}
    }
}