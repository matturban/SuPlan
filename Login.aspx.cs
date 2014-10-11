using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices;
using System.Web.Security;
using System.Configuration;

namespace SuPlan
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtUsername.Focus();
            //chkPersist.Checked = true;
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            string adPath = ConfigurationManager.AppSettings["WFM_AD_SERVER"]; //Path to your LDAP directory server
            string domain = ConfigurationManager.AppSettings["WFM_AD_Domain"];
            LdapAuthentication adAuth = new LdapAuthentication(adPath);

            //            http://msdn.microsoft.com/en-us/library/ms180890%28v=vs.80%29.aspx

            if (true == adAuth.IsAuthenticated(domain, txtUsername.Text, txtPassword.Text))
            {
                string userRoles = adAuth.GetGroups();

                if (userRoles != string.Empty)
                {
                    //Create the ticket, and add the groups.
                    bool isCookiePersistent = true; //chkPersist.Checked;
                    int timeout = Convert.ToInt32(ConfigurationManager.AppSettings["LoginTimeout"]);
                    FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1, txtUsername.Text, DateTime.Now, DateTime.Now.AddMinutes(timeout), isCookiePersistent, userRoles);

                    //Encrypt the ticket.
                    string encryptedTicket = FormsAuthentication.Encrypt(authTicket);

                    //Create a cookie, and then add the encrypted ticket to the cookie as data.
                    HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);

                    if (true == isCookiePersistent)
                        authCookie.Expires = authTicket.Expiration;

                    //Add the cookie to the outgoing cookies collection.
                    Response.Cookies.Add(authCookie);

                    //You can redirect now.
                    //FormsAuthentication.RedirectFromLoginPage(txtUsername.Text, chkPersist.Checked);
                    FormsAuthentication.RedirectFromLoginPage(txtUsername.Text, true);
                }
                else
                {
                    errorLabel.Text = txtUsername.Text + " is not authorized to log in to the Succession Planning Tool";
                }
            }
            else
            {
                errorLabel.Text = "Wrong user name or password.";
            }
        }
    }
}