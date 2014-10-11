<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SuPlan.Default" EnableEventValidation="false" %>

<!DOCTYPE html />

<%@ Register Assembly="AjaxControlToolkit" TagPrefix="asp" Namespace="AjaxControlToolkit" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Succession Planning</title>
    <link rel="stylesheet" type="text/css" href="css/default.css" />
    <%--<script src="js/jquery-1.10.1.js" type="text/javascript"></script>--%>
    <script language="javascript" type="text/javascript">
        function pageLoad() {
            var mpe = $find("mpeTM");
            mpe.add_shown(onShown);
        }

        function onShown() {
            var background = $find("mpeTM")._backgroundElement;
            background.onclick = function () { $find("mpeTM").hide(); }
        }

        function OnTreeClick(evt) {
            var src = window.event != window.undefined ? window.event.srcElement : evt.target;
            var isChkBoxClick = (src.tagName.toLowerCase() == "input" && src.type == "checkbox");
            if (isChkBoxClick) {
                var parentTable = GetParentByTagName("table", src);
                var nxtSibling = parentTable.nextSibling;
                if (nxtSibling && nxtSibling.nodeType == 1)//check if nxt sibling is not null & is an element node
                {
                    if (nxtSibling.tagName.toLowerCase() == "div") //if node has children
                    {
                        //check or uncheck children at all levels
                        CheckUncheckChildren(parentTable.nextSibling, src.checked);
                    }
                }
                //check or uncheck parents at all levels
                CheckUncheckParents(src, src.checked);
            }
        }

        function CheckUncheckChildren(childContainer, check) {
            var childChkBoxes = childContainer.getElementsByTagName("input");
            var childChkBoxCount = childChkBoxes.length;
            for (var i = 0; i < childChkBoxCount; i++) {
                childChkBoxes[i].checked = check;
            }
        }

        function CheckUncheckParents(srcChild, check) {
            var parentDiv = GetParentByTagName("div", srcChild);
            var parentNodeTable = parentDiv.previousSibling;

            if (parentNodeTable) {
                var checkUncheckSwitch;

                if (check) //checkbox checked
                {
                    var isAllSiblingsChecked = AreAllSiblingsChecked(srcChild);
                    if (isAllSiblingsChecked)
                        checkUncheckSwitch = true;
                    else
                        return; //do not need to check parent if any(one or more) child not checked
                }
                else //checkbox unchecked
                {
                    checkUncheckSwitch = false;
                }

                var inpElemsInParentTable = parentNodeTable.getElementsByTagName("input");
                if (inpElemsInParentTable.length > 0) {
                    var parentNodeChkBox = inpElemsInParentTable[0];
                    parentNodeChkBox.checked = checkUncheckSwitch;
                    //do the same recursively
                    CheckUncheckParents(parentNodeChkBox, checkUncheckSwitch);
                }
            }
        }

        function AreAllSiblingsChecked(chkBox) {
            var parentDiv = GetParentByTagName("div", chkBox);
            var childCount = parentDiv.childNodes.length;
            for (var i = 0; i < childCount; i++) {
                if (parentDiv.childNodes[i].nodeType == 1) //check if the child node is an element node
                {
                    if (parentDiv.childNodes[i].tagName.toLowerCase() == "table") {
                        var prevChkBox = parentDiv.childNodes[i].getElementsByTagName("input")[0];
                        //if any of sibling nodes are not checked, return false
                        if (!prevChkBox.checked) {
                            return false;
                        }
                    }
                }
            }
            return true;
        }

        //utility function to get the container of an element by tagname
        function GetParentByTagName(parentTagName, childElementObj) {
            var parent = childElementObj.parentNode;
            while (parent.tagName.toLowerCase() != parentTagName.toLowerCase()) {
                parent = parent.parentNode;
            }
            return parent;
        }

    </script>
</head>

<body>
    <asp:HyperLink ID="lnkAdmin" runat="server" NavigateUrl="~/Admin/Admin.aspx">Admin</asp:HyperLink>
    <asp:HyperLink ID="lnkUpload" runat="server" NavigateUrl="~/Upload.aspx">Upload</asp:HyperLink>
    <div id="loginDetails">
        <asp:Label ID="lblLogin" runat="server"/>
        <asp:LinkButton ID="btnLogout" runat="server"
            OnClick="btnLogout_Click"
            CssClass="Buttons" 
            Text="log out"/>
    </div>
    <form id="form1" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" ScriptMode="Release"></asp:ToolkitScriptManager>

    <asp:ObjectDataSource ID="dsMetros" runat="server" SelectMethod="GetMetros" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsLocations" runat="server" SelectMethod="GetLocations" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsTeams" runat="server" SelectMethod="GetTeams" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsJobTitles" runat="server" SelectMethod="GetJobTitles" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsShortTitles" runat="server" SelectMethod="GetShortTitles" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsNextJobTitles" runat="server" SelectMethod="GetNextJobTitles" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsEducationLevels" runat="server" SelectMethod="GetEducationLevels" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsJDRatings" runat="server" SelectMethod="GetJDRatings" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsRisks" runat="server" SelectMethod="GetRisks" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsTeamMemberIDs" runat="server" SelectMethod="GetTeamMemberIDs" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsTeamMemberNames" runat="server" SelectMethod="GetTeamMemberNames" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsTimeFrames" runat="server" SelectMethod="GetTimeFrames" TypeName="SuPlan.TeamMemberDAO"></asp:ObjectDataSource>

<div id="title">
<h1>Succession Planning</h1>
</div>

<%--<asp:Button ID="btnExportExcel" runat="server" 
Text="export" 
OnClick="btnExportExcel_Click"
CssClass="Buttons"/>--%>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
    <ContentTemplate>
    <asp:Button ID="btnFilter" runat="server" onclick="btnFilter_Click" Text="filter" CssClass="Buttons"/>
    <asp:Button ID="btnClear" runat="server" onclick="btnClear_Click" Text="clear" CssClass="Buttons" /></br>
    <asp:GridView 
        ID="gvTeamMembers" 
        runat="server" 
        Font-Size="10px"
        AutoGenerateColumns="False"
        DataKeyNames="TMID"
        OnRowEditing="EditRow"
        OnRowUpdating="UpdateRow"
        OnRowCancelingEdit="CancelEditRow"
        OnRowDataBound="RowDataBound"
        ShowHeaderWhenEmpty="True"
        EmptyDataText="No records found."
        UseAccessibleHeader="True"
        GridLines="None"
        OnSelectedIndexChanged="popTM"
        AutoGenerateEditButton="True"
    >
    <RowStyle BackColor="#efefef" />
    <AlternatingRowStyle BackColor="White" />
    <EditRowStyle BackColor="DarkOrange" Font-Size="10px" HorizontalAlign="Left" 
        VerticalAlign="Top" />  
        <Columns>

          
        <%-- TMID ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:BoundField DataField="TMID" ReadOnly="true" Visible="false"/>

        <%-- Updated ------------------------------------------------------------------------------------------------------------------------------------%>

             <asp:TemplateField HeaderText="Updated" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>!
                    <asp:CheckBox ID="cUpdated"  runat="server"
                        Enabled="true"
                        ToolTip="Check to see TMs with updates - unchecked shows all TMs."
                    />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server"
                        Enabled="false"
                        Checked='<%#Eval("Updated") %>' 
                    />
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">!:</span>
                    <asp:CheckBox ID="cEditUpdated" runat="server"
                        Enabled="true"
                        Checked='<%#Eval("Updated") %>'
                    />
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- TMName ------------------------------------------------------------------------------------------------------------------------------------%>

             <asp:TemplateField HeaderText="TMName" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>
<%--                <asp:Button ID="btnFilter" runat="server" onclick="btnFilter_Click" Text="filter" CssClass="Buttons"/>
                <asp:Button ID="btnClear" runat="server" onclick="btnClear_Click" Text="clear" CssClass="Buttons" /></br>--%>
                Team Member Name
                    <ajaxToolkit:ComboBox ID="cboTeamMemberName" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsTeamMemberNames" 
                        DataTextField="Name" 
                        DataValueField="NameID" 
                        MaxLength="0" 
                        style="display: inline;"
                        Width="100"
                        AutoPostBack="false"
                        CssClass="ComboBoxes"
                        ToolTip="Start typing a TM's last name, or click and scroll."
                        >
                    </ajaxToolkit:ComboBox>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:LinkButton runat="server"
                        ID = "lbTMName" 
                        Text= '<%# Eval("TMName")%>'
                        CssClass="Labels"
                        CommandName="Select"
                        AutoPostBack="false"
                    ></asp:LinkButton>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Team Member Name:</span>
                    <asp:Label runat="server"
                        ID = "lbEditTMName" 
                        Text= '<%# Eval("TMName")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>

         <%-- Team ------------------------------------------------------------------------------------------------------------------------------------%>

             <asp:TemplateField HeaderText="Team" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>Team
                    <ajaxToolkit:ComboBox ID="cboTeam" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsTeams" 
                        DataTextField="Name" 
                        DataValueField="TeamID" 
                        MaxLength="0" 
                        style="display: inline;"
                        Width="50"
                        AutoPostBack="false"
                        CssClass="ComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblTeam" 
                        Text= '<%# Eval("Team")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Team:</span>
                    <asp:Label runat="server"
                        ID = "lblEditTeam" 
                        Text= '<%# Eval("Team")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- Metro ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top" HeaderStyle-Height="50">
                <HeaderTemplate>Metro
                    <ajaxToolkit:ComboBox ID="cboMetro" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsMetros" 
                        DataTextField="Name" 
                        DataValueField="MetroID" 
                        MaxLength="0" 
                        style="display: inline;"
                        Width="20"
                        AutoPostBack="false"
                        CssClass="ComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblMetro" 
                        Text= '<%# Eval("Metro")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Metro:</span>
                    <asp:Label runat="server"
                        ID = "lblEditMetro" 
                        Text= '<%# Eval("Metro")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- Location ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderText="Location" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>Location
                    <ajaxToolkit:ComboBox ID="cboLocation" 
                        runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsLocations" 
                        DataTextField="Acronym" 
                        DataValueField="LocationID" 
                        MaxLength="0" 
                        style="display: inline;"
                        Width="25"
                        AutoPostBack="false"
                        CssClass="ComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblLocation" 
                        Text= '<%# Eval("Location")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Location:</span>
                    <asp:Label runat="server"
                        ID = "lblEditLocation" 
                        Text= '<%# Eval("Location")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- Job Title ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderText="JobTitle" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>Job Title
                    <ajaxToolkit:ComboBox ID="cboJobTitle" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsShortTitles" 
                        DataTextField="ShortTitle" 
                        DataValueField="ShortTitle" 
                        MaxLength="0" 
                        style="display: inline;"
                        Width="25"
                        AutoPostBack="false"
                        CssClass="ComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblJobTitle" 
                        Text= '<%# Eval("JobTitle")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Title:</span>
                    <asp:Label runat="server"
                        ID = "lblEditJobTitle" 
                        Text= '<%# Eval("JobTitle")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- Job Entry Date ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderText="JobEntryDate" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>Job Entry
                    <asp:TextBox ID="txtJobEntryDate" runat="server"
                        AutoPostBack="false"
                        Width="55"
                        CssClass="FilterTextBoxes"
                    ></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="calJobEntryDate" runat="server" TargetControlID="txtJobEntryDate"></ajaxToolkit:CalendarExtender>
<%--                    <asp:CompareValidator
                        id="txtJobEntryDateValidator" runat="server" 
                        Type="Date"
                        Operator="DataTypeCheck"
                        ControlToValidate="txtJobEntryDate" 
                        ErrorMessage="Please enter a valid date."
                        CssClass="dateValidator">
                    </asp:CompareValidator>--%>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblJobEntryDate" 
                        Text= '<%# Eval("JobEntryDate","{0:d}")%>'
                        Width="55"
                        CssClass="Labels"
                    ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Job Entry:</span>
                    <asp:TextBox ID="txtEditJobEntryDate" runat="server" 
                        Text='<%# Eval("JobEntryDate","{0:d}")%>'
                        Width="55"
                        CssClass="EditTextBoxes"
                        ></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="calEditJobEntryDate" TargetControlID = "txtEditJobEntryDate" runat="server" ></ajaxToolkit:CalendarExtender>
                    <asp:CompareValidator
                        id="txtEditJobEntryDateValidator" runat="server" 
                        Type="Date"
                        Operator="DataTypeCheck"
                        ControlToValidate="txtEditJobEntryDate" 
                        ErrorMessage="Please enter a valid date."
                        CssClass="dateValidator">
                    </asp:CompareValidator>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- Last JD Date ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderText="LastJD" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>Last JD
                    <asp:TextBox ID="txtLastJDDate" runat="server"
                        AutoPostBack="false"
                        Width="55"
                        CssClass="FilterTextBoxes"
                    ></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="calLastJDDate" runat="server" TargetControlID="txtLastJDDate"></ajaxToolkit:CalendarExtender>
<%--                    <asp:CompareValidator
                        id="txtLastJDDateValidator" runat="server" 
                        Type="Date"
                        Operator="DataTypeCheck"
                        ControlToValidate="txtLastJDDate" 
                        ErrorMessage="Please enter a valid date."
                        CssClass="dateValidator">
                    </asp:CompareValidator>--%>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblLastJDDate" 
                        Text= '<%# Eval("LastJD","{0:d}")%>'
                        Width="55"
                        CssClass="Labels"
                    ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Last JD:</span>
                    <asp:TextBox ID="txtEditLastJDDate" runat="server" 
                        Text='<%# Eval("LastJD","{0:d}")%>'
                        Width="55"
                        CssClass="EditTextBoxes"
                    ></asp:TextBox>
                    <ajaxToolkit:CalendarExtender ID="calEditLastJDDate" TargetControlID = "txtEditLastJDDate" runat="server"></ajaxToolkit:CalendarExtender>
                    <asp:CompareValidator
                        id="txtEditLastJDDateeValidator" runat="server" 
                        Type="Date"
                        Operator="DataTypeCheck"
                        ControlToValidate="txtEditLastJDDate" 
                        ErrorMessage="Please enter a valid date."
                        CssClass="dateValidator">
                    </asp:CompareValidator>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- JD Rating ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>JD Rating
                    <ajaxToolkit:ComboBox ID="cboJDRatings" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsJDRatings" 
                        DataTextField="RatingValue" 
                        DataValueField="RatingID" 
                        MaxLength="0" 
                        style="display: inline;"
                        Width="30"
                        AutoPostBack="false"
                        CssClass="ComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblJDRatingValue" 
                        Text= '<%# Eval("JDRatingValue")%>'
                        CssClass="Labels"
                    ></asp:Label>
                    <asp:Label runat="server"
                        ID = "lblJDRating" 
                        Text= '<%# Eval("JDRating")%>'
                        CssClass="Labels"
                        Visible="false"
                    ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Rating:</span>
                    <ajaxtoolkit:ComboBox ID="cboEditJDRating" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsJDRatings" 
                        DataTextField="RatingValue" 
                        DataValueField="RatingID" 
                        SelectedValue='<%#Bind("RatingID") %>' 
                        MaxLength="0" 
                        style="display: inline;"  
                        Width="30"
                        CssClass="EditComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- Next Job ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderText="NextJob" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>Next Job
                    <ajaxToolkit:ComboBox ID="cboNextJob" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsNextJobTitles" 
                        DataTextField="ShortTitle" 
                        DataValueField="NextJobID"
                        MaxLength="0" 
                        style="display: inline;"
                        Width="25"
                        AutoPostBack="false"
                        CssClass="ComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblNextJob" 
                        Text= '<%# Eval("NextJob")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Next Job:</span>
                    <ajaxtoolkit:ComboBox ID="cboEditNextJob" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsNextJobTitles" 
                        DataTextField="ShortTitle" 
                        DataValueField="NextJobID" 
                        SelectedValue='<%#Bind("NextJobID") %>'
                        MaxLength="0" 
                        style="display: inline;"
                        Width="25"
                        CssClass="EditComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- Team Interest ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderText="TeamInterest" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>Team Interest
                    <ajaxToolkit:ComboBox ID="cboTeamInterest" runat="server" 
                        AutoCompleteMode="SuggestAppend"
                        DataSourceID="dsTeams" 
                        DataTextField="Name" 
                        DataValueField="TeamID" 
                        MaxLength="0" 
                        style="display: inline;"
                        Width="65"
                        AutoPostBack="false"
                        CssClass="ComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblTeamInterest" 
                        Text= '<%# Eval("TeamInterest")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Team Interest:</span>
                    <ajaxtoolkit:ComboBox ID="cboEditTeamInterest" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsTeams" 
                        DataTextField="Name" 
                        DataValueField="TeamID" 
                        SelectedValue='<%#Bind("TeamInterestID") %>'
                        MaxLength="0" style="display: inline;"
                        Width="65"
                        CssClass="EditComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- TimeFrame ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderStyle-HorizontalAlign="Left"  HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>Time Frame
                    <ajaxToolkit:ComboBox ID="cboTimeFrame" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsTimeFrames" 
                        DataTextField="TimeFrame" 
                        DataValueField="TimeFrameID" 
                        MaxLength="0" 
                        style="display: inline;"
                        Width="50"
                        AutoPostBack="false"
                        CssClass="ComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblTimeFrame" 
                        Text= '<%# Eval("TimeFrame")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Time Frame:</span>
                    <ajaxtoolkit:ComboBox ID="cboEditTimeFrame" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsTimeFrames" 
                        DataTextField="TimeFrame" 
                        DataValueField="TimeFrameID" 
                        SelectedValue='<%#Bind("TimeFrameID") %>'
                        MaxLength="0" style="display: inline;"
                        Width="50"
                        CssClass="EditComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- Education ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderText="Education" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>
<%--    xx            Education
                    <ajaxToolkit:ComboBox ID="cboEducationLevel" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsEducationLevels" 
                        DataTextField="Level" 
                        DataValueField="LevelID" 
                        MaxLength="0" 
                        style="display: inline;"
                        Width="75"
                        AutoPostBack="false"
                        CssClass="ComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>--%>
                </HeaderTemplate>
                <ItemTemplate>
<%--                    <asp:Label runat="server"
                        ID = "lblEducation" 
                        Text= '<%# Eval("Education")%>'
                    ></asp:Label>--%>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Education:</span>
                    <ajaxtoolkit:ComboBox ID="cboEditEducation" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsEducationLevels" 
                        DataTextField="Level" 
                        DataValueField="LevelID" 
                        MaxLength="0" 
                        style="display: inline;"
                        SelectedValue='<%#Bind("LevelID") %>'
                        Width="75"
                        CssClass="EditComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- add as Back Fill for ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top"> 
                <HeaderTemplate></HeaderTemplate>
                <ItemTemplate></ItemTemplate>
                <EditItemTemplate>
                <span style="font-weight:bold">add as a back fill for:</span>
                    <ajaxToolkit:ComboBox ID="cboAddAsBackFillFor" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsTeamMemberNames" 
                        DataTextField="Name" 
                        DataValueField="NameID" 
                        MaxLength="0" 
                        style="display: inline;"
                        Width="105"
                        CssClass="EditComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- TMIDB  ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top" Visible="false"> 
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblTMIDB" 
                        Text= '<%# Eval("TMIDB")%>'
                    ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

        <%-- Relocate ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderText="Relocate" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>Relocate
                    <asp:TextBox ID="txtSearchRelocate" runat="server"
                        AutoPostBack="false"
                        Width="200"
                        CssClass="FilterTextBoxes"
                        ToolTip="Enter the location acronyms to filter for TMs willing to relocate there. Use a comma between multiple locations."
                        >
                    </asp:TextBox>
                </HeaderTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Relocate:</span>
                    <asp:TreeView ID="tvMetros" runat="server"
                        onclick="OnTreeClick(event)"
                        AfterClientCheck="CheckChildNodes();" 
                        PopulateNodesFromClient="true">
                    <NodeStyle CssClass="treeNode" />
                    </asp:TreeView>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblRelocate" 
                        Text= '<%# Eval("Relocate")%>'
                        CssClass="Labels"
                        Width="200"
                    ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

        <%-- Risk ------------------------------------------------------------------------------------------------------------------------------------%>

           <asp:TemplateField HeaderText="Risk" HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>Risk
                    <ajaxToolkit:ComboBox ID="cboRisk" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsRisks" 
                        DataTextField="Risk" 
                        DataValueField="RiskID" 
                        MaxLength="0" 
                        style="display: inline;"
                        Width="65"
                        AutoPostBack="false"
                        CssClass="ComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblRisk" 
                        Text= '<%# Eval("Risk")%>'
                        CssClass="Labels"
                    ></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Risk:</span>
                    <ajaxtoolkit:ComboBox ID="cboEditRisk" runat="server" 
                        AutoCompleteMode="SuggestAppend" 
                        DataSourceID="dsRisks" 
                        DataTextField="Risk" 
                        DataValueField="RiskID" 
                        SelectedValue='<%#Bind("RiskID") %>'
                        MaxLength="0" style="display: inline;"
                        Width="65"
                        CssClass="EditComboBoxes"
                        >
                    </ajaxToolkit:ComboBox>
                </EditItemTemplate>
            </asp:TemplateField>

        <%-- Destination Plan ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top">
                <HeaderTemplate>Destination Plan
                    <asp:TextBox ID="txtSearchDestinationPlan" runat="server"
                        AutoPostBack="false"
                        Width="150"
                        CssClass="FilterTextBoxes"
                        ToolTip="Enter any bit of text you want to search for in this field."
                        >
                    </asp:TextBox>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblDestinationPlan" 
                        Text= '<%# Eval("DestinationPlan")%>'
                        Width="150"
                        CssClass="Labels"
                    ></asp:Label>
                </ItemTemplate>
            <EditItemTemplate>
                <span style="font-weight:bold">Destination Plan:</span>
                <asp:TextBox ID="txtEditDestinationPlan" 
                runat="server" 
                Text='<%# Eval("DestinationPlan") %>'
                Width="150"
                CssClass="EditTextBoxes"
                />
            </EditItemTemplate>
            </asp:TemplateField>

        <%-- Back Fill ------------------------------------------------------------------------------------------------------------------------------------%>

            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderStyle-VerticalAlign="Top" HeaderStyle-Width="100px">
            <HeaderTemplate>Back Fill</HeaderTemplate>
                <ItemTemplate>
                <asp:GridView ID="gvBackFillList" runat="server"
                    Font-Size="9px"
                    AutoGenerateColumns="False"
                    DataKeyNames="BF_TMID"
                    GridLines="None"
                    OnRowCommand="popBackFill"
                    >
                    <Columns>
                        <asp:BoundField DataField="BF_TMID" ReadOnly="true" Visible="false"/>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblBF_TimeFrame"
                                    Text= '<%# Eval("TimeFrame")%>'
                                    style="font-weight:bold;text-align:right"
                                    width="75"
                                ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton runat="server"
                                    ID = "lblBF_TMName"
                                    Text= '<%# Eval("TMName")%>'
                                    style="text-align:left"
                                    width="100"
                                    CommandName="popBackFill"
                                    CommandArgument='<%# Eval("BF_TMID")%>'
                                ></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                </ItemTemplate>
                <EditItemTemplate>
                    <span style="font-weight:bold">Back Fill:</span>
                    <asp:GridView ID="gvBackFillEdit" runat="server"
                        Font-Size="9px"
                        AutoGenerateColumns="False"
                        DataKeyNames="TMID"
                        GridLines="None"
                        ShowFooter="True" 
                        OnRowCommand="addDeleteBackFill"
                        EmptyDataText="No records found."
                        >
                        <Columns>
                            <asp:BoundField DataField="ID" ReadOnly="true" Visible="false"/>
                            <asp:BoundField DataField="TMID" ReadOnly="true" Visible="false"/>
                            <asp:BoundField DataField="BF_TMID" ReadOnly="true" Visible="false"/>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label runat="server"
                                        ID = "lblBF_TimeFrame"
                                        Text= '<%# Eval("TimeFrame")%>'
                                        style="font-weight:bold;text-align:right"
                                        width="75"
                                    ></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label runat="server"
                                        ID = "lblBF_TMName"
                                        Text= '<%# Eval("TMName")%>'
                                        style="text-align:left"
                                        width="150"
                                    ></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <ajaxToolkit:ComboBox ID="cboAddBackFill" runat="server" 
                                        AutoCompleteMode="SuggestAppend" 
                                        DataSourceID="dsTeamMemberNames" 
                                        DataTextField="Name" 
                                        DataValueField="NameID" 
                                        MaxLength="0" 
                                        style="display: inline;"
                                        Width="100"
                                        CssClass="EditComboBoxes"
                                        >
                                    </ajaxToolkit:ComboBox>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnDelete" runat="server" 
                                    Text="delete" 
                                    ForeColor="Red" 
                                    CommandName="deleteBackFill"
                                    CommandArgument='<%# Eval("ID") %>'
                                    CssClass="Buttons" />
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Button ID="btnAddBackFill" 
                                        runat="server" 
                                        Text="add" 
                                        CommandName="addBackFill"
                                        CssClass="Buttons"
                                        />
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                    <EmptyDataTemplate>
                    <table style="border-collapse: collapse;" cellspacing="0">
                    <tr>
                        <td>
                        <ajaxToolkit:ComboBox ID="cboAddFirstBackFill" runat="server" 
                            AutoCompleteMode="SuggestAppend" 
                            DataSourceID="dsTeamMemberNames" 
                            DataTextField="Name" 
                            DataValueField="NameID" 
                            MaxLength="0" 
                            style="display: inline;"
                            Width="100"
                            CssClass="RogueComboBox"
                            >
                        </ajaxToolkit:ComboBox>
                        </td>
                        <td>
                        <asp:Button ID="btnAddBackFill" 
                            runat="server" 
                            Text="add" 
                            CommandName="addBackFill"
                            CssClass="Buttons"
                            />
                        </td>
                    </tr>
                    </table>
                    </EmptyDataTemplate>
                    </asp:GridView>
               </EditItemTemplate>
            </asp:TemplateField>

        <%-- hidden data fields ------------------------------------------------------------------------------------------------------------------------------------%>
            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblTeamMemberID" 
                        Text= '<%# Eval("TeamMemberID")%>'
                    ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblHireDate" 
                        Text= '<%# Eval("HireDate","{0:d}")%>'
                    ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblEducation" 
                        Text= '<%# Eval("Education")%>'
                    ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblUpdates" 
                        Text= '<%# Eval("ImportChecks")%>'
                    ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label runat="server"
                        ID = "lblTimeFrameLong" 
                        Text= '<%# Eval("TimeFrameLong")%>'
                    ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

        <%-- end hidden data fields ------------------------------------------------------------------------------------------------------------------------------------%>

        </Columns>

    <EmptyDataTemplate>
		<asp:Label ID="lblEmptySearch" runat="server"
            OnLoad="getEmptyText"
        ></asp:Label>
	</EmptyDataTemplate>

    </asp:GridView>
    
    </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="gvTeamMembers" EventName="SelectedIndexChanged"/>
    </Triggers>
    <ContentTemplate>
    <asp:LinkButton Text="" ID = "lnkTM" runat="server" />
    <ajaxtoolkit:ModalPopupExtender ID="mpeTM" 
        runat="server" 
        PopupControlID="pnlPopTM" 
        TargetControlID="lnkTM"
        CancelControlID="btnCloseTM"
        BackgroundCssClass="modalBackground">
    </ajaxtoolkit:ModalPopupExtender>
    <asp:Panel ID="pnlPopTM" runat="server" CssClass="modalPopup" Style="display: none">
        <div class="header">
        Details
        </div>
        <div class="body">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class = "tdFieldName"><b>TM ID: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popTMID" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>TM Name: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popTMName" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Team: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popTeam" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Metro: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popMetro" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Location: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popLocation" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Title: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popTitle" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Hire Date: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popHire" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Job Entry Date: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popEntry" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Last JD Date: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popLastJD" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Last JD Rating: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popJDRating" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Next Job: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popNextJob" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Team Interest: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popTeamInterest" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Time Frame: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popTimeFrame" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Education: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popEducation" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Relocate: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popRelocate" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Risk: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popRisk" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Destination Plan: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popDestination" runat="server" /></td>
                </tr>
                <tr>
                    <td class = "tdFieldName"><b>Updates: </b></td>
                    <td class = "tdFieldValue"><asp:Label ID="popUpdates" runat="server" /></td>
                </tr>
            </table>
        </div>
        <div class="footer" align="right">
            <asp:Button ID="btnCloseTM" runat="server" Text="Close" CssClass="button" />
        </div>
    </asp:Panel>
    </ContentTemplate>
    </asp:UpdatePanel>
    </form>

</body>
</html>
