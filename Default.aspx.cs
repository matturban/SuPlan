using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;
using System.IO;
using AjaxControlToolkit;

namespace SuPlan
{
    public partial class Default : System.Web.UI.Page
    {
        protected bool? updated;
        protected int tmid;
        protected int teamid;
        protected int metroid;
        protected int locationid;
        protected string shorttitle;
        protected DateTime? jobentrydate;
        protected DateTime? lastjddate;
        protected int jdratingid;
        protected int riskid;
        protected int nextjobid;
        protected int teaminterestid;
        protected int timeframeid;
        protected string relocate;
        protected string destinationplan;


        protected void Page_Load(object sender, EventArgs e)
        {
            Trace.TraceFinished += new TraceContextEventHandler(this.TraceFinished);

            if (!IsPostBack)
            {
                loadGrid(false);
                Trace.Write("!!!", "Page load (load)");
            }
            else
            {
                Trace.Write("!!!", "Page load (postback)");
            }

            Trace.Write("!!!", "Page load (all times)");

            lblLogin.Text = "logged in as " + Context.User.Identity.Name;

            if (Global.IsAdmin == true)//(Context.User.Identity.Name == "matt.urban" || Context.User.Identity.Name == "sara.woll")
            {
                lnkAdmin.Visible = true;
                lnkUpload.Visible = true;
            }
            else
            {
                lnkAdmin.Visible = false;
                lnkUpload.Visible = false;
            }
        }

        void TraceFinished(object sender, TraceContextEventArgs e)
        {
            foreach (TraceContextRecord traceRecord in e.TraceRecords)
            {
                if (traceRecord.Category == "!!!")
                {
                    Response.Write("<br>" + traceRecord.Message);
                }
            }
        }

        protected void restoreFilter()
        {
            Trace.Write("!!!", "start restoreFilter");
            ComboBox cboMetro = gvTeamMembers.HeaderRow.FindControl("cboMetro") as ComboBox;
            ComboBox cboLocation = gvTeamMembers.HeaderRow.FindControl("cboLocation") as ComboBox;
            ComboBox cboTeam = gvTeamMembers.HeaderRow.FindControl("cboTeam") as ComboBox;
            //ComboBox cboTeamMemberID = gvTeamMembers.HeaderRow.FindControl("cboTeamMemberID") as ComboBox;
            ComboBox cboTeamMemberName = gvTeamMembers.HeaderRow.FindControl("cboTeamMemberName") as ComboBox;
            ComboBox cboJobTitle = gvTeamMembers.HeaderRow.FindControl("cboJobTitle") as ComboBox;
            //TextBox txtHireDate = gvTeamMembers.HeaderRow.FindControl("txtHireDate") as TextBox;
            TextBox txtJobEntryDate = gvTeamMembers.HeaderRow.FindControl("txtJobEntryDate") as TextBox;
            TextBox txtLastJDDate = gvTeamMembers.HeaderRow.FindControl("txtLastJDDate") as TextBox;
            ComboBox cboJDRatings = gvTeamMembers.HeaderRow.FindControl("cboJDRatings") as ComboBox;
            //ComboBox cboEducationLevel = gvTeamMembers.HeaderRow.FindControl("cboEducationLevel") as ComboBox;
            ComboBox cboRisk = gvTeamMembers.HeaderRow.FindControl("cboRisk") as ComboBox;
            ComboBox cboNextJob = gvTeamMembers.HeaderRow.FindControl("cboNextJob") as ComboBox;
            ComboBox cboTeamInterest = gvTeamMembers.HeaderRow.FindControl("cboteamInterest") as ComboBox;
            ComboBox cboTimeFrame = gvTeamMembers.HeaderRow.FindControl("cboTimeFrame") as ComboBox;
            TextBox txtSearchRelocate = gvTeamMembers.HeaderRow.FindControl("txtSearchRelocate") as TextBox;
            TextBox txtSearchDestinationPlan = gvTeamMembers.HeaderRow.FindControl("txtSearchDestinationPlan") as TextBox;
            CheckBox cUpdated = gvTeamMembers.HeaderRow.FindControl("cUpdated") as CheckBox;

            if (ViewState["metroid"] != null && ViewState["metroid"].ToString() != "0")
            {
                cboMetro.Items.FindByValue(ViewState["metroid"].ToString()).Selected = true;
            }

            if (ViewState["locationid"] != null && ViewState["locationid"].ToString() != "0")
            {
                cboLocation.Items.FindByValue(ViewState["locationid"].ToString()).Selected = true;
            }

            if (ViewState["teamid"] != null && ViewState["teamid"].ToString() != "0")
            {
                cboTeam.Items.FindByValue(ViewState["teamid"].ToString()).Selected = true;
            }

            if (ViewState["tmid"] != null && ViewState["tmid"].ToString() != "0")
            {
                cboTeamMemberName.Items.FindByValue(ViewState["tmid"].ToString()).Selected = true;
            }

            if (ViewState["shorttitle"] != null && ViewState["shorttitle"].ToString() != string.Empty)
            {
                cboJobTitle.Items.FindByValue(ViewState["shorttitle"].ToString()).Selected = true;
            }

            if (ViewState["jobentrydate"] != null && ViewState["jobentrydate"].ToString() != string.Empty)
            {
                txtJobEntryDate.Text = Convert.ToDateTime(ViewState["jobentrydate"]).ToShortDateString();
            }

            if (ViewState["lastjddate"] != null && ViewState["lastjddate"].ToString() != string.Empty)
            {
                txtLastJDDate.Text = Convert.ToDateTime(ViewState["lastjddate"]).ToShortDateString();
            }

            if (ViewState["jdratingid"] != null && ViewState["jdratingid"].ToString() != "0")
            {
                cboJDRatings.Items.FindByValue(ViewState["jdratingid"].ToString()).Selected = true;
            }

            if (ViewState["riskid"] != null && ViewState["riskid"].ToString() != "0")
            {
                cboRisk.Items.FindByValue(ViewState["riskid"].ToString()).Selected = true;
            }

            if (ViewState["nextjobid"] != null && ViewState["nextjobid"].ToString() != "0")
            {
                cboNextJob.Items.FindByValue(ViewState["nextjobid"].ToString()).Selected = true;
            }

            if (ViewState["teaminterestid"] != null && ViewState["teaminterestid"].ToString() != "0")
            {
                cboTeamInterest.Items.FindByValue(ViewState["teaminterestid"].ToString()).Selected = true;
            }

            if (ViewState["timeframeid"] != null && ViewState["timeframeid"].ToString() != "0")
            {
                cboTimeFrame.Items.FindByValue(ViewState["timeframeid"].ToString()).Selected = true;
            }

            if (ViewState["relocate"] != null && ViewState["relocate"].ToString() != string.Empty)
            {
                txtSearchRelocate.Text = relocate;
            }

            if (ViewState["destinationplan"] != null && ViewState["destinationplan"].ToString() != string.Empty)
            {
                txtSearchDestinationPlan.Text = destinationplan;
            }

            if (ViewState["updated"] != null)
            {
                //updated = Convert.ToBoolean(ViewState["updated"]);
                cUpdated.Checked = updated.GetValueOrDefault();
            }
            Trace.Write("!!!", "end restoreFilter");
        }

        protected void getFilterRowValues()
        {
            Trace.Write("!!!", "start getFilterRowValues");
            ComboBox cboMetro = gvTeamMembers.HeaderRow.FindControl("cboMetro") as ComboBox;
            ComboBox cboLocation = gvTeamMembers.HeaderRow.FindControl("cboLocation") as ComboBox;
            ComboBox cboTeam = gvTeamMembers.HeaderRow.FindControl("cboTeam") as ComboBox;
            ComboBox cboTeamMemberName = gvTeamMembers.HeaderRow.FindControl("cboTeamMemberName") as ComboBox;
            ComboBox cboJobTitle = gvTeamMembers.HeaderRow.FindControl("cboJobTitle") as ComboBox;
            TextBox txtJobEntryDate = gvTeamMembers.HeaderRow.FindControl("txtJobEntryDate") as TextBox;
            TextBox txtLastJDDate = gvTeamMembers.HeaderRow.FindControl("txtLastJDDate") as TextBox;
            ComboBox cboJDRatings = gvTeamMembers.HeaderRow.FindControl("cboJDRatings") as ComboBox;
            ComboBox cboRisk = gvTeamMembers.HeaderRow.FindControl("cboRisk") as ComboBox;
            ComboBox cboNextJob = gvTeamMembers.HeaderRow.FindControl("cboNextJob") as ComboBox;
            ComboBox cboTeamInterest = gvTeamMembers.HeaderRow.FindControl("cboTeamInterest") as ComboBox;
            ComboBox cboTimeFrame = gvTeamMembers.HeaderRow.FindControl("cboTimeFrame") as ComboBox;
            TextBox txtSearchRelocate = gvTeamMembers.HeaderRow.FindControl("txtSearchRelocate") as TextBox;
            TextBox txtSearchDestinationPlan = gvTeamMembers.HeaderRow.FindControl("txtSearchDestinationPlan") as TextBox;
            CheckBox cUpdated = gvTeamMembers.HeaderRow.FindControl("cUpdated") as CheckBox;

            if (cboMetro.SelectedItem != null)
            {
                metroid = Convert.ToInt32(cboMetro.SelectedValue);
            }

            if (cboLocation.SelectedItem != null)
            {
                locationid = Convert.ToInt32(cboLocation.SelectedValue);
            }

            if (cboTeam.SelectedItem != null)
            {
                teamid = Convert.ToInt32(cboTeam.SelectedValue);
            }

            if (cboTeamMemberName.SelectedItem != null)
            {
                tmid = Convert.ToInt32(cboTeamMemberName.SelectedValue);
            }

            if (cboJobTitle.SelectedItem != null && cboJobTitle.SelectedValue != string.Empty)
            {
                shorttitle = cboJobTitle.SelectedValue.ToString();
            }

            if (cboJDRatings.SelectedItem != null)
            {
                jdratingid = Convert.ToInt32(cboJDRatings.SelectedValue);
            }

            if (txtJobEntryDate.Text != string.Empty)
            {
                jobentrydate = Convert.ToDateTime(txtJobEntryDate.Text);
            }

            if (txtLastJDDate.Text != string.Empty)
            {
                lastjddate = Convert.ToDateTime(txtLastJDDate.Text);
            }

            if (cboRisk.SelectedItem != null)
            {
                riskid = Convert.ToInt32(cboRisk.SelectedValue);
            }

            if (cboNextJob.SelectedItem != null && cboNextJob.SelectedValue != string.Empty)
            {
                nextjobid = Convert.ToInt32(cboNextJob.SelectedValue);
            }

            if (cboTeamInterest.SelectedItem != null)
            {
                teaminterestid = Convert.ToInt32(cboTeamInterest.SelectedValue);
            }

            if (cboTimeFrame.SelectedItem != null)
            {
                timeframeid = Convert.ToInt32(cboTimeFrame.SelectedValue);
            }

            if (txtSearchRelocate.Text != null && txtSearchRelocate.Text != string.Empty)
            {
                relocate = txtSearchRelocate.Text;
            }

            if (txtSearchDestinationPlan.Text != null && txtSearchDestinationPlan.Text != string.Empty)
            {
                destinationplan = txtSearchDestinationPlan.Text;
            }

            updated = cUpdated.Checked;

            ViewState["metroid"] = metroid;
            ViewState["locationid"] = locationid;
            ViewState["teamid"] = teamid;
            ViewState["tmid"] = tmid;
            ViewState["shorttitle"] = shorttitle;
            ViewState["jobentrydate"] = jobentrydate;
            ViewState["lastjddate"] = lastjddate;
            ViewState["jdratingid"] = jdratingid;
            ViewState["riskid"] = riskid;
            ViewState["nextjobid"] = nextjobid;
            ViewState["teaminterestid"] = teaminterestid;
            ViewState["timeframeid"] = timeframeid;
            ViewState["relocate"] = relocate;
            ViewState["destinationplan"] = destinationplan;
            ViewState["updated"] = updated;
            Trace.Write("!!!", "end getFilterRowValues");
        }

        protected void UpdateRow(object sender, GridViewUpdateEventArgs e)
        {
            Trace.Write("!!!", "start UpdateRow"); 
            GridViewRow row = gvTeamMembers.Rows[e.RowIndex] as GridViewRow;
            TextBox txtEditJobEntryDate = row.FindControl("txtEditJobEntryDate") as TextBox;
            ComboBox cboEditEducation = row.FindControl("cboEditEducation") as ComboBox;
            TextBox txtEditLastJD = row.FindControl("txtEditLastJDDate") as TextBox;
            ComboBox cboEditJDRating = row.FindControl("cboEditJDRating") as ComboBox;
            ComboBox cboEditRisk = row.FindControl("cboEditRisk") as ComboBox;
            ComboBox cboEditNextJob = row.FindControl("cboEditNextJob") as ComboBox;
            ComboBox cboEditTeamInterest = row.FindControl("cboEditTeamInterest") as ComboBox;
            ComboBox cboEditTimeFrame = row.FindControl("cboEditTimeFrame") as ComboBox;
            TreeView tvRelocate = row.FindControl("tvMetros") as TreeView;
            TextBox txtEditDestinationPlan = row.FindControl("txtEditDestinationPlan") as TextBox;
            ComboBox cboAddAsBackFillFor = row.FindControl("cboAddAsBackFillFor") as ComboBox;
            CheckBox cEditUpdated = row.FindControl("cEditUpdated") as CheckBox;

            int id = Convert.ToInt32(gvTeamMembers.DataKeys[e.RowIndex].Values[0]);
            DateTime? jobentrydate;
            if (txtEditJobEntryDate != null && txtEditLastJD.Text != string.Empty)
            {
                jobentrydate = Convert.ToDateTime(txtEditJobEntryDate.Text);
            }
            else
            {
                jobentrydate = null;
            }
            
            int educationlevelid = Convert.ToInt32(cboEditEducation.SelectedValue);
            DateTime? lastjd;
            if (txtEditLastJD != null && txtEditLastJD.Text != string.Empty)
            {
                lastjd = Convert.ToDateTime(txtEditLastJD.Text);
            }
            else
            {
                lastjd = null;
            }

            int lastjdratingid = Convert.ToInt32(cboEditJDRating.SelectedValue);
            int riskid = Convert.ToInt32(cboEditRisk.SelectedValue);
            int nextjobid = Convert.ToInt32(cboEditNextJob.SelectedValue);
            int teaminterestid = Convert.ToInt32(cboEditTeamInterest.SelectedValue);
            int timeframe = Convert.ToInt32(cboEditTimeFrame.SelectedValue);

            string destinationplan = txtEditDestinationPlan.Text;

            DataTable dtRelocate = getLocationsFromTreeView(tvRelocate);

            bool updated = cEditUpdated.Checked;

            int backfillforid;
            if (cboAddAsBackFillFor.SelectedValue == "" || cboAddAsBackFillFor.SelectedValue == null)
            {
                backfillforid = 0;
            }
            else
            {
                backfillforid = Convert.ToInt32(cboAddAsBackFillFor.SelectedValue);
            }

            string username = Context.User.Identity.Name;

            TeamMemberDAO d = new TeamMemberDAO();

            d.UpdateTeamMembers(id, jobentrydate, educationlevelid, lastjd, lastjdratingid, riskid, nextjobid, teaminterestid, timeframe, dtRelocate, destinationplan, backfillforid, updated, username);

            gvTeamMembers.EditIndex = -1;
            loadGrid(true);
            Trace.Write("!!!", "end UpdateRow");
        }

        protected void EditRow(object sender, GridViewEditEventArgs e)
        {
            Trace.Write("!!!", "start EditRow");
            gvTeamMembers.EditIndex = e.NewEditIndex;
            loadGrid(true);
            populateTreeViewControl(gvTeamMembers.EditIndex);
            int tmid = Convert.ToInt32(gvTeamMembers.DataKeys[e.NewEditIndex].Values[0]);
            GridView gv = gvTeamMembers.Rows[e.NewEditIndex].FindControl("gvBackFillEdit") as GridView;
            bindBackFillGV(tmid, gv);
            Trace.Write("!!!", "end EditRow");
        }

        protected void CancelEditRow(object sender, GridViewCancelEditEventArgs e)
        {
            gvTeamMembers.EditIndex = -1;
            loadGrid(true);
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            Trace.Write("!!!", "start btnFilter_Click"); 
            //getFilterRowValues();
            loadGrid(true);
            Trace.Write("!!!", "end btnFilter_Click"); 
        }

        protected void getEmptyText(object sender, EventArgs e)
        {
            Trace.Write("!!!", "start getEmptyText"); 
            Label lblEmptyText = (Label)sender;
            if (!IsPostBack)
            {
                lblEmptyText.Text = "Choose filter criteria and click 'filter'.";
            }
            else
            {
                lblEmptyText.Text = "No records found.";
            }
            Trace.Write("!!!", "end EmptyText"); 
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Trace.Write("!!!", "start btnClear_Click"); 
            ViewState.Clear();
            loadGrid(false);
            Trace.Write("!!!", "end btnClear_Click"); 
        }

        protected void loadGrid(bool filter)
        {
            Trace.Write("!!!", "start loadGrid");

            if (filter)
            {
                getFilterRowValues();
            }

            TeamMemberDAO tm = new TeamMemberDAO();

            gvTeamMembers.DataSource = tm.GetTeamMembers(updated,
                                                            tmid,
                                                            teamid,
                                                            metroid,
                                                            locationid,
                                                            shorttitle,
                                                            jobentrydate,
                                                            lastjddate,
                                                            jdratingid,
                                                            riskid,
                                                            nextjobid,
                                                            teaminterestid,
                                                            timeframeid,
                                                            relocate,
                                                            destinationplan);
            gvTeamMembers.DataBind();
            restoreFilter();
            Trace.Write("!!!", "end loadGrid"); 
        }

        private void populateTreeViewControl(int rowindex)
        {
            Trace.Write("!!!", "start populateTreeViewControl"); 
            GridViewRow row = gvTeamMembers.Rows[rowindex] as GridViewRow;
            int tmid = Convert.ToInt32(gvTeamMembers.DataKeys[rowindex].Values[0]);

            bool has = row.HasControls();
            int many = row.Controls.Count;

            TreeNode parentNode = null;
            TreeView tvMetros = row.FindControl("tvMetros") as TreeView;
            
            Metro metro = new Metro();
            List<Metro> metroList = new List<Metro>();
            metroList = metro.GetMetros(tmid);

            foreach (Metro m in metroList)
            {
                parentNode = new TreeNode(m.MetroName, m.MetroID.ToString());
                bool checkParent = false;

                foreach (Location location in m.LocationList)
                {
                    TreeNode childNode = new TreeNode(location.LocationName, location.LocationID.ToString());
                    childNode.Checked = location.LocationChecked;
                    
                    parentNode.ChildNodes.Add(childNode);

                    if (childNode.Checked == true)
                    {
                        checkParent = true;
                    }
                }
                parentNode.Checked = checkParent;
                parentNode.Collapse();
                // Show all checkboxes 
                tvMetros.ShowCheckBoxes = TreeNodeTypes.All;
                tvMetros.Nodes.Add(parentNode);
                Trace.Write("!!!", "end populateTreeViewControl"); 
            }
        }

        private DataTable getLocationsFromTreeView(TreeView tv)
        {
            Trace.Write("!!!", "start getLocationsFromTreeView"); 
            DataTable dt = new DataTable();
            dt.Columns.Add("ID",typeof(int));
            dt.Columns.Add("LocationID",typeof(int));

            foreach (TreeNode node in tv.Nodes)
            {
                // get the child nodes 
                TreeNodeCollection childNodes = node.ChildNodes;

                // iterate through the child nodes 
                int i = 1; 
                foreach (TreeNode childNode in childNodes)
                {  
                    if (childNode.Checked)
                    {      
                        DataRow dr = dt.NewRow();
                        dr["ID"] = i;
                        dr["LocationID"] = childNode.Value;
                        dt.Rows.Add(dr);
                        i = i + 1;
                    }
                }
            }
            Trace.Write("!!!", "end getLocationsFromTreeView"); 
            return dt;
        }

        protected void popTM(object sender, EventArgs e)
        {
            Trace.Write("!!!", "start popTM"); 
            //http://www.aspsnippets.com/Articles/Display-GridView-Selected-Row-Details-in-AJAX-ModalPopupExtender-in-ASPNet.aspx
            popTMID.Text = (gvTeamMembers.SelectedRow.FindControl("lblTeamMemberID") as Label).Text;
            popTMName.Text = (gvTeamMembers.SelectedRow.FindControl("lbTMName") as LinkButton).Text;
            popTeam.Text = (gvTeamMembers.SelectedRow.FindControl("lblTeam") as Label).Text;
            popMetro.Text = (gvTeamMembers.SelectedRow.FindControl("lblMetro") as Label).Text;
            popLocation.Text = (gvTeamMembers.SelectedRow.FindControl("lblLocation") as Label).Text;
            popTitle.Text = (gvTeamMembers.SelectedRow.FindControl("lblJobTitle") as Label).Text;
            popHire.Text = (gvTeamMembers.SelectedRow.FindControl("lblHireDate") as Label).Text;
            popEntry.Text = (gvTeamMembers.SelectedRow.FindControl("lblJobEntryDate") as Label).Text;
            popLastJD.Text = (gvTeamMembers.SelectedRow.FindControl("lblLastJDDate") as Label).Text;
            popJDRating.Text = (gvTeamMembers.SelectedRow.FindControl("lblJDRating") as Label).Text + " - " + (gvTeamMembers.SelectedRow.FindControl("lblJDRatingValue") as Label).Text;
            popNextJob.Text = (gvTeamMembers.SelectedRow.FindControl("lblNextJob") as Label).Text;
            popTeamInterest.Text = (gvTeamMembers.SelectedRow.FindControl("lblTeamInterest") as Label).Text;
            popTimeFrame.Text = (gvTeamMembers.SelectedRow.FindControl("lblTimeFrameLong") as Label).Text;
            popEducation.Text = (gvTeamMembers.SelectedRow.FindControl("lblEducation") as Label).Text;
            popRelocate.Text = (gvTeamMembers.SelectedRow.FindControl("lblRelocate") as Label).Text;
            popRisk.Text = (gvTeamMembers.SelectedRow.FindControl("lblRisk") as Label).Text;
            popDestination.Text = (gvTeamMembers.SelectedRow.FindControl("lblDestinationPlan") as Label).Text;
            popUpdates.Text = (gvTeamMembers.SelectedRow.FindControl("lblUpdates") as Label).Text;
            mpeTM.Show();
            Trace.Write("!!!", "end popTM"); 
        }

        protected void popBackFill(object sender, GridViewCommandEventArgs e)
        {
            Trace.Write("!!!", "start popBackFill");
            string cmdName = e.CommandName;
            int tmid;
            if (cmdName == "popBackFill")
            {
                tmid = Convert.ToInt32(e.CommandArgument);

                TeamMemberDAO tm = new TeamMemberDAO();
                DataTable dt = tm.GetTeamMemberByTMID(tmid);

                if (dt.Rows.Count > 0)
                {
                    popTMID.Text = dt.Rows[0]["TeamMemberID"].ToString();
                    popTMName.Text = dt.Rows[0]["TMName"].ToString();
                    popTeam.Text = dt.Rows[0]["Team"].ToString();
                    popMetro.Text = dt.Rows[0]["Metro"].ToString();
                    popLocation.Text = dt.Rows[0]["Location"].ToString();
                    popTitle.Text = dt.Rows[0]["JobTitle"].ToString();
                    if (dt.Rows[0]["HireDate"].ToString() != string.Empty)
                    {
                        popHire.Text = Convert.ToDateTime(dt.Rows[0]["HireDate"]).ToShortDateString();
                    }
                    if (dt.Rows[0]["JobEntryDate"].ToString() != string.Empty)
                    {
                        popEntry.Text = Convert.ToDateTime(dt.Rows[0]["JobEntryDate"]).ToShortDateString();
                    }
                    if (dt.Rows[0]["LastJD"].ToString() != string.Empty)
                    {
                        popLastJD.Text = Convert.ToDateTime(dt.Rows[0]["LastJD"]).ToShortDateString();
                    }
                    popJDRating.Text = dt.Rows[0]["JDRating"].ToString() + " - " + dt.Rows[0]["JDRatingValue"].ToString();
                    popNextJob.Text = dt.Rows[0]["NextJob"].ToString();
                    popTeamInterest.Text = dt.Rows[0]["TeamInterest"].ToString();
                    popTimeFrame.Text = dt.Rows[0]["TimeFrameLong"].ToString();
                    popEducation.Text = dt.Rows[0]["Education"].ToString();
                    popRelocate.Text = dt.Rows[0]["Relocate"].ToString();
                    popRisk.Text = dt.Rows[0]["Risk"].ToString();
                    popDestination.Text = dt.Rows[0]["DestinationPlan"].ToString();
                    popUpdates.Text = dt.Rows[0]["ImportChecks"].ToString();
                    mpeTM.Show();
                }
                else
                {
                    popTMName.Text= "That team member is no longer active in the Succession Planning Tool.";
                    mpeTM.Show();
                }
            }
            Trace.Write("!!!", "end popBackFill");
        }

        protected void addDeleteBackFill(object sender, GridViewCommandEventArgs e)
        {
            Trace.Write("!!!", "start addDeleteBackFill");
            //http://forums.asp.net/t/1638799.aspx
            Button btn = (Button)e.CommandSource;
            GridViewRow gvrBF = btn.NamingContainer as GridViewRow;
            GridView gvBF = gvrBF.NamingContainer as GridView;
            GridViewRow gvrTM = gvBF.NamingContainer as GridViewRow;

            int tmid = (int)gvTeamMembers.DataKeys[gvrTM.RowIndex].Values[0];
            
            string cmdName = e.CommandName;

            ComboBox cboAddBackFill;
            if (cmdName == "addBackFill")
            {
                if (gvBF.Rows.Count > 0)
                {
                    cboAddBackFill = gvBF.FooterRow.FindControl("cboAddBackFill") as ComboBox;
                }
                else
                {
                    Control row = gvBF.Controls[0].Controls[0];
                    cboAddBackFill = row.FindControl("cboAddFirstBackFill") as ComboBox;
                }

                int backfillid = Convert.ToInt32(cboAddBackFill.SelectedValue); ;

                TeamMemberDAO tm = new TeamMemberDAO();
                tm.InsertBackFill(tmid, backfillid);
                bindBackFillGV(tmid, gvBF);
            }

            if (cmdName == "deleteBackFill")
            {
                int id;
                id = Convert.ToInt32(e.CommandArgument);
                TeamMemberDAO tm = new TeamMemberDAO();
                tm.DeleteBackFill(id);
                bindBackFillGV(tmid, gvBF);
            }
            Trace.Write("!!!", "end addDeleteBackFill");
        }

        protected void RowDataBound(object sender, GridViewRowEventArgs e)
        {
            Trace.Write("!!!", "start RowDataBound");
            Label lblTMIDB = e.Row.FindControl("lblTMIDB") as Label;

            int tmid;

            if (lblTMIDB != null && lblTMIDB.Text != string.Empty)
            {
                tmid = Convert.ToInt32(lblTMIDB.Text);
                GridView gv = e.Row.FindControl("gvBackFillList") as GridView;
                bindBackFillGV(tmid, gv);
            }

            //if (e.Row.RowType == DataControlRowType.DataRow)
            //{
            //    e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvTeamMembers, "Edit$" + e.Row.RowIndex);
            //    e.Row.Attributes["style"] = "cursor:pointer";
            //}
            Trace.Write("!!!", "end RowDataBound");
        }

        protected void bindBackFillGV(int tmid, GridView gv)
        {
            Trace.Write("!!!", "start bindBackFillGV");
            TeamMemberDAO tm = new TeamMemberDAO();
            DataTable dt = tm.GetBackFillByTMID(tmid);

            if (gv != null)
            {
                gv.DataSource = dt;
                gv.DataBind();
            }
            Trace.Write("!!!", "end bindBackFillGV");
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

        //protected void btnExportExcel_Click(object sender, EventArgs e)
        //{
        //    TeamMemberDAO tm = new TeamMemberDAO();

        //    DataTable dt = tm.GetTeamMembersExport(updated,
        //                                            tmid,
        //                                            teamid,
        //                                            metroid,
        //                                            locationid,
        //                                            shorttitle,
        //                                            jobentrydate,
        //                                            lastjddate,
        //                                            jdratingid,
        //                                            riskid,
        //                                            nextjobid,
        //                                            teaminterestid,
        //                                            timeframeid,
        //                                            relocate,
        //                                            destinationplan);

        //    exportExcel(dt, "SuccessionPlan");

        //    restoreFilter();
        //}

        //protected void exportExcel(DataTable dt, string FileName)
        //{
        //    if (dt.Rows.Count > 0)
        //    {
        //        string filename = FileName + ".xls";
        //        System.IO.StringWriter tw = new System.IO.StringWriter();
        //        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
        //        DataGrid dgGrid = new DataGrid();
        //        dgGrid.DataSource = dt;
        //        dgGrid.DataBind();

        //        //Get the HTML for the control.
        //        dgGrid.RenderControl(hw);
        //        //Write the HTML back to the browser.
        //        Response.ContentType = "application/vnd.ms-excel";
        //        //Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        //        Response.AppendHeader("Content-Disposition",
        //                              "attachment; filename=" + filename + "");
        //        this.EnableViewState = false;
        //        Response.Write(tw.ToString());
        //        Response.End();
        //    }
        //}
    }
}