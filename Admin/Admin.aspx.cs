using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;

namespace SuPlan
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Global.IsAdmin)
            {
                upLocations.Visible = false;
                upMetros.Visible = false;
                upJobTitles.Visible = false;
                upNextJobTitles.Visible = false;
                upTeams.Visible = false;
                upImportChecks.Visible = false;
            }

            if (!IsPostBack)
            {
                loadLocations();
                loadMetros();
                loadTeams();
                loadJobTitles();
                loadNextJobTitles();
                loadImportChecks();
            }

            lblLogin.Text = "logged in as " + Context.User.Identity.Name;
        }

        protected void EditLocationsRow(object sender, GridViewEditEventArgs e)
        {
            gvLocations.EditIndex = e.NewEditIndex;
            loadLocations();
            //int id = Convert.ToInt32(gvLocations.DataKeys[e.NewEditIndex].Values[0]);
        }

        protected void CancelEditLocationsRow(object sender, GridViewCancelEditEventArgs e)
        {
            gvLocations.EditIndex = -1;
            loadLocations();
        }

        protected void UpdateLocationsRow(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvLocations.Rows[e.RowIndex] as GridViewRow;
            TextBox txtLocationsAcronym = row.FindControl("txtLocationsAcronym") as TextBox;
            TextBox txtLocationsBusinessUnit = row.FindControl("txtLocationsBusinessUnit") as TextBox;
            ComboBox cboLocationsMetro = row.FindControl("cboLocationsMetro") as ComboBox;

            int id = Convert.ToInt32(gvLocations.DataKeys[e.RowIndex].Values[0]);
            string acronym = txtLocationsAcronym.Text;
            string businessunit = txtLocationsBusinessUnit.Text;
            int metroid = Convert.ToInt32(cboLocationsMetro.SelectedValue);

            AdminDAO ad = new AdminDAO();

            ad.UpdateLocations(id, acronym, businessunit, metroid);

            gvLocations.EditIndex = -1;

            loadLocations();
        }

        protected void AddLocationsRow(object sender, EventArgs e)
        {
            TextBox txtNewLocationsAcronym = gvLocations.HeaderRow.FindControl("txtNewLocationsAcronym") as TextBox;
            TextBox txtNewLocationsBusinessUnit = gvLocations.HeaderRow.FindControl("txtNewLocationsBusinessUnit") as TextBox;
            ComboBox cboNewLocationsMetro = gvLocations.HeaderRow.FindControl("cboNewLocationsMetro") as ComboBox;

            string acronym = txtNewLocationsAcronym.Text;
            string businessunit = txtNewLocationsBusinessUnit.Text;
            int metroid = Convert.ToInt32(cboNewLocationsMetro.SelectedValue);

            AdminDAO ad = new AdminDAO();

            ad.InsertLocations(acronym, businessunit, metroid);
            loadLocations();
        }

        protected void DeleteLocationsRow(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = gvLocations.Rows[e.RowIndex] as GridViewRow;
            int id = Convert.ToInt32(gvLocations.DataKeys[e.RowIndex].Values[0]);

            AdminDAO ad = new AdminDAO();

            ad.DeleteLocations(id);
            loadLocations();
        }

        protected void loadLocations()
        {
            AdminDAO ad = new AdminDAO();

            gvLocations.DataSource = ad.GetLocations();
            gvLocations.DataBind();
        }

        protected void EditMetrosRow(object sender, GridViewEditEventArgs e)
        {
            gvMetros.EditIndex = e.NewEditIndex;
            loadMetros();
            int id = Convert.ToInt32(gvMetros.DataKeys[e.NewEditIndex].Values[0]);
        }

        protected void CancelEditMetrosRow(object sender, GridViewCancelEditEventArgs e)
        {
            gvMetros.EditIndex = -1;
            loadMetros();
        }

        protected void UpdateMetrosRow(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvMetros.Rows[e.RowIndex] as GridViewRow;
            TextBox txtMetrosName = row.FindControl("txtMetrosName") as TextBox;

            int id = Convert.ToInt32(gvMetros.DataKeys[e.RowIndex].Values[0]);
            string name = txtMetrosName.Text;

            AdminDAO ad = new AdminDAO();

            ad.UpdateMetros(id, name);

            gvMetros.EditIndex = -1;

            loadMetros();
        }

        protected void AddMetrosRow(object sender, EventArgs e)
        {
            TextBox txtNewMetrosName = gvMetros.HeaderRow.FindControl("txtNewMetrosName") as TextBox;

            string name = txtNewMetrosName.Text;

            AdminDAO ad = new AdminDAO();

            ad.InsertMetros(name);

            loadMetros();
        }

        protected void DeleteMetrosRow(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = gvMetros.Rows[e.RowIndex] as GridViewRow;
            int id = Convert.ToInt32(gvMetros.DataKeys[e.RowIndex].Values[0]);

            AdminDAO ad = new AdminDAO();

            ad.DeleteMetros(id);

            loadMetros();
        }

        protected void loadMetros()
        {
            AdminDAO ad = new AdminDAO();

            gvMetros.DataSource = ad.GetMetros();
            gvMetros.DataBind();
        }

        protected void EditTeamsRow(object sender, GridViewEditEventArgs e)
        {
            gvTeams.EditIndex = e.NewEditIndex;
            loadTeams();
            int id = Convert.ToInt32(gvTeams.DataKeys[e.NewEditIndex].Values[0]);
        }

        protected void CancelEditTeamsRow(object sender, GridViewCancelEditEventArgs e)
        {
            gvTeams.EditIndex = -1;
            loadTeams();
        }

        protected void UpdateTeamsRow(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvTeams.Rows[e.RowIndex] as GridViewRow;
            TextBox txtTeamsName = row.FindControl("txtTeamsName") as TextBox;
            TextBox txtTeamsTeamCode = row.FindControl("txtTeamsTeamCode") as TextBox;

            int id = Convert.ToInt32(gvTeams.DataKeys[e.RowIndex].Values[0]);
            string name = txtTeamsName.Text;
            string teamcode = txtTeamsTeamCode.Text;

            AdminDAO ad = new AdminDAO();

            ad.UpdateTeams(id, name, teamcode);

            gvTeams.EditIndex = -1;

            loadTeams();
        }

        protected void AddTeamsRow(object sender, EventArgs e)
        {
            TextBox txtNewTeamsName = gvTeams.HeaderRow.FindControl("txtTeamsName") as TextBox;
            TextBox txtNewTeamsTeamCode = gvTeams.HeaderRow.FindControl("txtTeamsTeamCode") as TextBox;

            string name = txtNewTeamsName.Text;
            string teamcode = txtNewTeamsTeamCode.Text;

            AdminDAO ad = new AdminDAO();

            ad.InsertTeams(name, teamcode);

            loadTeams();
        }

        protected void DeleteTeamsRow(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = gvTeams.Rows[e.RowIndex] as GridViewRow;
            int id = Convert.ToInt32(gvTeams.DataKeys[e.RowIndex].Values[0]);

            AdminDAO ad = new AdminDAO();

            ad.DeleteTeams(id);

            loadTeams();
        }

        protected void loadTeams()
        {
            AdminDAO ad = new AdminDAO();

            gvTeams.DataSource = ad.GetTeams();

            gvTeams.DataBind();
        }

        protected void EditJobTitlesRow(object sender, GridViewEditEventArgs e)
        {
            gvJobTitles.EditIndex = e.NewEditIndex;
            loadJobTitles();
            int id = Convert.ToInt32(gvJobTitles.DataKeys[e.NewEditIndex].Values[0]);
        }

        protected void CancelEditJobTitlesRow(object sender, GridViewCancelEditEventArgs e)
        {
            gvJobTitles.EditIndex = -1;
            loadJobTitles();
        }

        protected void UpdateJobTitlesRow(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvJobTitles.Rows[e.RowIndex] as GridViewRow;
            TextBox txtJobTitlesTitle = row.FindControl("txtJobTitlesTitle") as TextBox;
            TextBox txtJobTitlesJobCode = row.FindControl("txtJobTitlesJobCode") as TextBox;
            TextBox txtJobTitlesJobFamily = row.FindControl("txtJobTitlesJobFamily") as TextBox;
            TextBox txtJobTitlesCategory = row.FindControl("txtJobTitlesCategory") as TextBox;
            TextBox txtJobTitlesShortTitle = row.FindControl("txtJobTitlesShortTitle") as TextBox;
            CheckBox chkEditJobTitlesInclude = row.FindControl("chkEditJobTitlesInclude") as CheckBox;

            int id = Convert.ToInt32(gvJobTitles.DataKeys[e.RowIndex].Values[0]);
            string title = txtJobTitlesTitle.Text;
            string jobcode = txtJobTitlesJobCode.Text;
            string jobfamily = txtJobTitlesJobFamily.Text;
            string category = txtJobTitlesCategory.Text;
            string shorttitle = txtJobTitlesShortTitle.Text;
            bool include = chkEditJobTitlesInclude.Checked;

            AdminDAO ad = new AdminDAO();

            ad.UpdateJobTitles(id, title, jobcode, jobfamily, category, shorttitle, include);

            gvJobTitles.EditIndex = -1;

            loadJobTitles();
        }

        protected void AddJobTitlesRow(object sender, EventArgs e)
        {
            TextBox txtNewJobTitlesTitle = gvJobTitles.HeaderRow.FindControl("txtNewJobTitlesTitle") as TextBox;
            TextBox txtNewJobTitlesJobCode = gvJobTitles.HeaderRow.FindControl("txtNewJobTitlesJobCode") as TextBox;
            TextBox txtNewJobTitlesJobFamily = gvJobTitles.HeaderRow.FindControl("txtNewJobTitlesJobFamily") as TextBox;
            TextBox txtNewJobTitlesCategory = gvJobTitles.HeaderRow.FindControl("txtNewJobTitlesCategory") as TextBox;
            TextBox txtNewJobTitlesShortTitle = gvJobTitles.HeaderRow.FindControl("txtNewJobTitlesShortTitle") as TextBox;
            CheckBox chkNewJobTitlesInclude = gvJobTitles.HeaderRow.FindControl("chkNewJobTitlesInclude") as CheckBox;

            string title = txtNewJobTitlesTitle.Text;
            string jobcode = txtNewJobTitlesJobCode.Text;
            string jobfamily = txtNewJobTitlesJobFamily.Text;
            string category = txtNewJobTitlesCategory.Text;
            string shorttitle = txtNewJobTitlesShortTitle.Text;
            bool include = chkNewJobTitlesInclude.Checked;

            AdminDAO ad = new AdminDAO();

            ad.InsertJobTitles(title, jobcode, jobfamily, category, shorttitle, include);

            loadJobTitles();
        }

        protected void DeleteJobTitlesRow(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = gvJobTitles.Rows[e.RowIndex] as GridViewRow;
            int id = Convert.ToInt32(gvJobTitles.DataKeys[e.RowIndex].Values[0]);

            AdminDAO ad = new AdminDAO();

            ad.DeleteJobTitles(id);

            loadJobTitles();
        }

        protected void loadJobTitles()
        {
            AdminDAO ad = new AdminDAO();

            gvJobTitles.DataSource = ad.GetJobTitles();
            gvJobTitles.DataBind();
        }

        protected void EditNextJobTitlesRow(object sender, GridViewEditEventArgs e)
        {
            gvNextJobTitles.EditIndex = e.NewEditIndex;
            loadNextJobTitles();
            int id = Convert.ToInt32(gvNextJobTitles.DataKeys[e.NewEditIndex].Values[0]);
        }

        protected void CancelEditNextJobTitlesRow(object sender, GridViewCancelEditEventArgs e)
        {
            gvNextJobTitles.EditIndex = -1;
            loadNextJobTitles();
        }

        protected void UpdateNextJobTitlesRow(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvNextJobTitles.Rows[e.RowIndex] as GridViewRow;
            TextBox txtNextJobTitlesShortTitle = row.FindControl("txtNextJobTitlesShortTitle") as TextBox;

            int id = Convert.ToInt32(gvNextJobTitles.DataKeys[e.RowIndex].Values[0]);
            string shorttitle = txtNextJobTitlesShortTitle.Text;

            AdminDAO ad = new AdminDAO();

            ad.UpdateNextJobTitles(id, shorttitle);

            gvNextJobTitles.EditIndex = -1;

            loadNextJobTitles();
        }

        protected void AddNextJobTitlesRow(object sender, EventArgs e)
        {
            TextBox txtNewNextJobTitlesShortTitle = gvNextJobTitles.HeaderRow.FindControl("txtNewNextJobTitlesShortTitle") as TextBox;

            string shorttitle = txtNewNextJobTitlesShortTitle.Text;

            AdminDAO ad = new AdminDAO();

            ad.InsertNextJobTitles(shorttitle);

            loadNextJobTitles();
        }

        protected void DeleteNextJobTitlesRow(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = gvNextJobTitles.Rows[e.RowIndex] as GridViewRow;
            int id = Convert.ToInt32(gvNextJobTitles.DataKeys[e.RowIndex].Values[0]);

            AdminDAO ad = new AdminDAO();

            ad.DeleteNextJobTitles(id);

            loadNextJobTitles();
        }

        protected void loadNextJobTitles()
        {
            AdminDAO ad = new AdminDAO();

            gvNextJobTitles.DataSource = ad.GetNextJobTitles();
            gvNextJobTitles.DataBind();
        }


        protected void EditImportChecksRow(object sender, GridViewEditEventArgs e)
        {
            gvImportChecks.EditIndex = e.NewEditIndex;
            loadImportChecks();
            int id = Convert.ToInt32(gvImportChecks.DataKeys[e.NewEditIndex].Values[0]);
        }

        protected void CancelEditImportChecksRow(object sender, GridViewCancelEditEventArgs e)
        {
            gvImportChecks.EditIndex = -1;
            loadImportChecks();
        }

        protected void UpdateImportChecksRow(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvImportChecks.Rows[e.RowIndex] as GridViewRow;
            TextBox txtImportChecksCheckDescription = row.FindControl("txtImportChecksCheckDescription") as TextBox;
            TextBox txtImportChecksCheckSQL = row.FindControl("txtImportChecksCheckSQL") as TextBox;

            int id = Convert.ToInt32(gvImportChecks.DataKeys[e.RowIndex].Values[0]);
            string checkdescription = txtImportChecksCheckDescription.Text;
            string checksql = txtImportChecksCheckSQL.Text;

            AdminDAO ad = new AdminDAO();

            ad.UpdateImportChecks(id, checkdescription, checksql);

            gvImportChecks.EditIndex = -1;

            loadImportChecks();
        }

        protected void AddImportChecksRow(object sender, EventArgs e)
        {
            TextBox txtNewImportChecksCheckDescription = gvImportChecks.HeaderRow.FindControl("txtNewImportChecksCheckDescription") as TextBox;
            TextBox txtNewImportChecksCheckSQL = gvImportChecks.HeaderRow.FindControl("txtNewImportChecksCheckSQL") as TextBox;

            string checkdescription = txtNewImportChecksCheckDescription.Text;
            string checksql = txtNewImportChecksCheckSQL.Text;

            AdminDAO ad = new AdminDAO();

            ad.InsertImportChecks(checkdescription, checksql);

            loadImportChecks();
        }

        protected void DeleteImportChecksRow(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = gvImportChecks.Rows[e.RowIndex] as GridViewRow;
            int id = Convert.ToInt32(gvImportChecks.DataKeys[e.RowIndex].Values[0]);

            AdminDAO ad = new AdminDAO();

            ad.DeleteImportChecks(id);

            loadImportChecks();
        }

        protected void loadImportChecks()
        {
            AdminDAO ad = new AdminDAO();

            gvImportChecks.DataSource = ad.GetImportChecks();
            gvImportChecks.DataBind();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            FormsAuthentication.RedirectToLoginPage();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
               server control at run time. */
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    e.Row.Attributes["ondblclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvLocations, "Edit$" + e.Row.RowIndex);
            //    e.Row.Attributes["style"] = "cursor:pointer";
            //}
        }
    }
}