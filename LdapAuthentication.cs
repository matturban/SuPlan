//http://msdn.microsoft.com/en-us/library/ms180890%28v=vs.80%29.aspx

using System;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.DirectoryServices;

namespace SuPlan
{
    public class LdapAuthentication
    {
        private string _path;
        private string _filterAttribute;

        public LdapAuthentication(string path)
        {
            _path = path;
        }

        public bool IsAuthenticated(string domain, string username, string pwd)
        {
            string domainAndUsername = domain + @"\" + username;
            DirectoryEntry entry = new DirectoryEntry(_path, domainAndUsername, pwd);
            //DirectoryEntry entry = new DirectoryEntry(_path, domainAndUsername, pwd, AuthenticationTypes.SecureSocketsLayer);
            //entry.AuthenticationType = AuthenticationTypes.SecureSocketsLayer;

            try
            {
                //Bind to the native AdsObject to force authentication.
                object obj = entry.NativeObject;

                DirectorySearcher search = new DirectorySearcher(entry);

                search.Filter = "(SAMAccountName=" + username + ")";
                search.PropertiesToLoad.Add("cn");
                SearchResult result = search.FindOne();

                if (null == result)
                {
                    return false;
                }

                //Update the new path to the user in the directory.
                _path = result.Path;
                _filterAttribute = (string)result.Properties["cn"][0];
            }
            catch (Exception ex)
            {
                return false;
            }

            return true;
        }

       //public string[] GetUserRoles()
       // {
       //     List<string> ur = new List<string>();
       //     string[] userRoles;
       //     string userGroup = ConfigurationManager.AppSettings["UserADGroup"].ToLower();
       //     string adminGroup = ConfigurationManager.AppSettings["AdminADGroup"].ToLower();

       //     string groups = getGroups();
       //     string[] g = groups.Split('|');

       //     foreach (string group in g)
       //     {
       //         if (group.ToLower() == userGroup)
       //         {
       //             ur.Add("user");
       //         }
       //         if (group.ToLower() == adminGroup)
       //         {
       //             ur.Add("admin");
       //         }
       //     }
       //    userRoles = ur.ToArray();

       //    return userRoles;
       // }

        public string GetGroups()
        {
            DirectoryEntry searchRoot = new DirectoryEntry(_path);
            DirectorySearcher search = new DirectorySearcher(searchRoot);
            //DirectorySearcher search = new DirectorySearcher(_path);
            search.Filter = "(cn=" + _filterAttribute + ")";
            search.PropertiesToLoad.Add("memberOf");
            //StringBuilder groupNames = new StringBuilder();
            StringBuilder roleNames = new StringBuilder();
            string userGroup = ConfigurationManager.AppSettings["UserADGroup"].ToLower();
            string adminGroup = ConfigurationManager.AppSettings["AdminADGroup"].ToLower();

            try
            {
                SearchResult result = search.FindOne();
                int propertyCount = result.Properties["memberOf"].Count;
                string dn;
                int equalsIndex, commaIndex;

                for (int propertyCounter = 0; propertyCounter < propertyCount; propertyCounter++)
                {
                    dn = (string)result.Properties["memberOf"][propertyCounter];
                    equalsIndex = dn.IndexOf("=", 1);
                    commaIndex = dn.IndexOf(",", 1);
                    if (-1 == equalsIndex)
                    {
                        return null;
                    }
                    //groupNames.Append(dn.Substring((equalsIndex + 1), (commaIndex - equalsIndex) - 1));
                    //groupNames.Append("|");
                    string group = dn.Substring((equalsIndex + 1), (commaIndex - equalsIndex) - 1);
                    if (group.ToLower() == userGroup)
                    {
                        roleNames.Append("user");
                        roleNames.Append("|");
                    }
                    if (group.ToLower() == adminGroup)
                    {
                        roleNames.Append("admin");
                        roleNames.Append("|");
                        Global.IsAdmin = true;
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error obtaining group names. " + ex.Message);
            }
            //return groupNames.ToString();
            return roleNames.ToString();
        }
    }
}