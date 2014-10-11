using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace SuPlan.DAO
{
    public class LocationDAO : BaseDAO
    {
        //http://www.codeproject.com/Articles/14799/Populating-a-TreeView-Control-from-the-Database

        public List<Metro> GetRelocations(int tmid)
        {
            List<Metro> metroList = new List<Metro>();
            int i = -1;

            SqlParameter[] parameters = 
            {
            new SqlParameter("TMID",tmid)
            };

            //SqlDataReader reader = OpenReader("GetRelocations", parameters, null);
            DataTable dt = ReturnDataTable("GetRelocations", parameters);

            foreach (DataRow row in dt.Rows)
            {
                Metro metro = new Metro();
                metro.MetroID = Convert.ToInt32(row["MetroID"]);
                metro.MetroName = row["MetroName"] as String;

                if (!DoesMetroIDAlreadyExists(metro.MetroID, metroList))
                {
                    metroList.Add(metro);
                    i++;

                    metroList[i].LocationList.Add(new Location
                                                        (
                                                        Convert.ToInt32(row["LocationID"])
                                                        , row["LocationName"] as String
                                                        , Convert.ToBoolean(row["LocationChecked"])
                                                        )
                                                  );
                }
                else
                {
                    metroList[i].LocationList.Add(new Location
                                                        (Convert.ToInt32(row["LocationID"])
                                                        , row["LocationName"] as String
                                                        , Convert.ToBoolean(row["LocationChecked"])
                                                        )
                                                  );
                }
            }

            return metroList;
        }
        
        //http://www.codeproject.com/Articles/14799/Populating-a-TreeView-Control-from-the-Database

        //public List<Metro> GetMetros(int tmid)
        //{
        //    List<Metro> metroList = new List<Metro>();
        //    int i = -1;
      
        //    SqlParameter[] parameters = 
        //    {
        //    new SqlParameter("TMID",tmid)
        //    };

        //    SqlDataReader reader = OpenReader("GetRelocations", parameters, null);

        //    while (reader.Read())
        //    {
        //        Metro metro = new Metro();
        //        metro.MetroID = Convert.ToInt32(reader["MetroID"]);
        //        metro.MetroName = reader["MetroName"] as String;

        //        if (!DoesMetroIDAlreadyExists(metro.MetroID, metroList))
        //        {
        //            metroList.Add(metro);
        //            i++;

        //            metroList[i].LocationList.Add(new Location
        //                                                (
        //                                                Convert.ToInt32(reader["LocationID"])
        //                                                , reader["LocationName"] as String
        //                                                , Convert.ToBoolean(reader["LocationChecked"])
        //                                                )
        //                                          );
        //        }
        //        else
        //        {
        //            metroList[i].LocationList.Add(new Location
        //                                                (Convert.ToInt32(reader["LocationID"])
        //                                                , reader["LocationName"] as String
        //                                                , Convert.ToBoolean(reader["LocationChecked"])
        //                                                )
        //                                          );
        //        }
        //    }

        //    return metroList;
        //}

        // Helper method 
        private bool DoesMetroIDAlreadyExists(int metroID, List<Metro> metroIDList)
        {
            bool result = false;

            foreach (Metro metro in metroIDList)
            {
                if (metro.MetroID == metroID)
                {
                    result = true;
                    break;
                }
            }

            return result;
        }
    }


}