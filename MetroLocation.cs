using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SuPlan
{

    //http://www.codeproject.com/Articles/14799/Populating-a-TreeView-Control-from-the-Database

    public class Location
    {
        private int locationID;
        private string locationName;
        private bool locationChecked;

        public int LocationID
        {
            get { return this.locationID; }
            set { this.locationID = value; }
        }

        public string LocationName
        {
            get { return this.locationName; }
            set { this.locationName = value; }
        }

        public bool LocationChecked
        {
            get { return this.locationChecked; }
            set { this.locationChecked = value; }
        }

        public Location(int locationID, string locationName, bool locationChecked)
        {
            this.locationID = locationID;
            this.locationName = locationName;
            this.locationChecked = locationChecked;
        }

        public Location()
        {
        }

    }

    public class Metro
    {
        private int metroID;
        private string metroName;
        private List<Location> locationList =
                       new List<Location>();

        public int MetroID
        {
            get { return this.metroID; }
            set { this.metroID = value; }
        }

        public string MetroName
        {
            get { return this.metroName; }
            set { this.metroName = value; }
        }

        public List<Location> LocationList
        {
            get { return this.locationList; }
            set { this.locationList = value; }
        }

        public List<Metro> GetMetros(int tmid)
        {
            DAO.LocationDAO l = new DAO.LocationDAO();
            List<Metro> metroList = l.GetRelocations(tmid);
            return metroList;
        }
    }
}