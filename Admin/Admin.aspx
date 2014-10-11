<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="SuPlan.Admin" EnableEventValidation="false" ValidateRequest="false"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="AjaxControlToolkit" TagPrefix="asp" Namespace="AjaxControlToolkit" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Succession Planning Admin</title>
    <link rel="stylesheet" type="text/css" href="~/css/default.css" />
</head>
<body>
    <asp:HyperLink ID="lnkDefault" runat="server" NavigateUrl="~/Default.aspx">Team Member Grid</asp:HyperLink>
    <div id="loginDetails">
        <asp:Label ID="lblLogin" runat="server"/>
        <asp:LinkButton ID="btnLogout" runat="server"
            OnClick="btnLogout_Click"
            CssClass="Buttons" 
            Text="log out"/>
    </div>
    <form id="form1" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" ScriptMode="Debug"></asp:ToolkitScriptManager>
        <div>
            <div id="adminTitle">
            <h1>Succession Planning Admin</h1>
            </div>
        </div>

        <asp:ObjectDataSource ID="dsMetros" runat="server" SelectMethod="GetMetros" TypeName="SuPlan.AdminDAO"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="dsMetrosForEdit" runat="server" SelectMethod="GetMetrosForEdit" TypeName="SuPlan.AdminDAO"></asp:ObjectDataSource>

        <%--Locations--%>
        <asp:UpdatePanel ID="upLocations" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
                <asp:Panel ID="headerLocations" runat="server" CssClass="headerPanels">
                    <asp:Label ID="lblLocations" runat="server"></asp:Label>
                </asp:Panel>
                <asp:Panel ID="pLocations" runat="server">
                    <asp:GridView 
                    ID="gvLocations" 
                    runat="server" 
                    Font-Size="10px"
                    AutoGenerateColumns="False"
                    DataKeyNames="ID"
                    OnRowEditing="EditLocationsRow"
                    OnRowUpdating="UpdateLocationsRow"
                    OnRowDeleting="DeleteLocationsRow"
                    OnRowCancelingEdit="CancelEditLocationsRow"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="No records found."
                    UseAccessibleHeader="True"
                    OnRowDataBound="OnRowDataBound"
                    GridLines="None"                  
                >
                <RowStyle BackColor="#efefef" />
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="DarkOrange" Font-Size="10px" HorizontalAlign="Left" 
                VerticalAlign="Top" />  
                    <Columns>
                        <%--edit button---------------------------------------------------------------%>
                        <asp:CommandField ShowEditButton="true" />

                        <%--id--%>
                        <asp:BoundField DataField="ID" ReadOnly="true" Visible="false"/>

                        <%--acronym-----------------------------------------------------------------%>
                         <asp:TemplateField HeaderText="Acronym" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Acronym
                                <asp:TextBox ID="txtNewLocationsAcronym" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblLocationsAcronym" 
                                    Text= '<%# Eval("Acronym")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtLocationsAcronym" 
                                    Text= '<%# Eval("Acronym")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--businessunit---------------------------------------------------------------%>
                         <asp:TemplateField HeaderText="BusinessUnit" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Business Unit
                                <asp:TextBox ID="txtNewLocationsBusinessUnit" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblLocationsBusinessUnit" 
                                    Text= '<%# Eval("BusinessUnit")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtLocationsBusinessUnit" 
                                    Text= '<%# Eval("BusinessUnit")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--metro---------------------------------------------------------------%>
                        <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Metro
                                <ajaxToolkit:ComboBox ID="cboNewLocationsMetro" runat="server" 
                                    AutoCompleteMode="SuggestAppend" 
                                    DataSourceID="dsMetrosForEdit" 
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
                                    ID = "lblLocationsMetro" 
                                    Text= '<%# Eval("Metro")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <ajaxToolkit:ComboBox ID="cboLocationsMetro" runat="server" 
                                    AutoCompleteMode="SuggestAppend" 
                                    DataSourceID="dsMetrosForEdit" 
                                    DataTextField="Name" 
                                    DataValueField="MetroID" 
                                    MaxLength="0" 
                                    style="display: inline;"
                                    Width="20"
                                    AutoPostBack="false"
                                    CssClass="ComboBoxes"
                                    SelectedValue='<%#Bind("MetroID") %>'
                                    >
                                </ajaxToolkit:ComboBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--add button---------------------------------------------------------------%>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:LinkButton ID="btnAddLocationsRow" 
                                    runat="server" 
                                    Text="add" 
                                    onclick="AddLocationsRow" 
                                    BorderStyle="None" 
                                />
                                </HeaderTemplate>
                            <ItemTemplate></ItemTemplate>
                        </asp:TemplateField>

                        <%--delete button---------------------------------------------------------------%>
                        <asp:CommandField ShowDeleteButton="true" />
                    </Columns>
                </asp:GridView>
                </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="cpeLocations" runat="Server"
                TargetControlID="pLocations"
                CollapsedSize="0"
                Collapsed="True"
                TextLabelID="lblLocations" 
                CollapsedText="locations (click to open)" 
                ExpandedText="locations (click to close)"
                ExpandControlID="headerLocations"
                CollapseControlID="headerLocations"
                AutoCollapse="False"
                AutoExpand="False"
                ScrollContents="False"
                ExpandDirection="Vertical" />
            </ContentTemplate>
        </asp:UpdatePanel>

       <%--Metros--%>
        <asp:UpdatePanel ID="upMetros" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
                <asp:Panel ID="headerMetros" runat="server" CssClass="headerPanels">
                    <asp:Label ID="lblMetros" runat="server"></asp:Label>
                </asp:Panel>
                <asp:Panel ID="pMetros" runat="server">
                    <asp:GridView 
                        ID="gvMetros" 
                        runat="server" 
                        Font-Size="10px"
                        AutoGenerateColumns="False"
                        DataKeyNames="MetroID"
                        OnRowEditing="EditMetrosRow"
                        OnRowUpdating="UpdateMetrosRow"
                        OnRowDeleting="DeleteMetrosRow"
                        OnRowCancelingEdit="CancelEditMetrosRow"
                        ShowHeaderWhenEmpty="True"
                        EmptyDataText="No records found."
                        UseAccessibleHeader="True"
                        OnRowDataBound="OnRowDataBound"
                        GridLines="None"
                        >
                    <RowStyle BackColor="#efefef" />
                    <AlternatingRowStyle BackColor="White" />
                    <EditRowStyle BackColor="DarkOrange" Font-Size="10px" HorizontalAlign="Left" 
                         VerticalAlign="Top" />  
                    <Columns>
                        <%--id--%>
                        <asp:BoundField DataField="MetroID" ReadOnly="true" Visible="false"/>

                        <%--edit button---------------------------------------------------------------%>
                        <asp:CommandField ShowEditButton="true" />

                        <%--Name-----------------------------------------------------------------%>
                         <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Metro Name
                                <asp:TextBox ID="txtNewMetrosName" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblMetrosName" 
                                    Text= '<%# Eval("Name")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtMetrosName" 
                                    Text= '<%# Eval("Name")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--add button---------------------------------------------------------------%>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:LinkButton ID="btnAddMetrosRow" 
                                    runat="server" 
                                    Text="add" 
                                    onclick="AddMetrosRow" 
                                    BorderStyle="None" 
                                />
                            </HeaderTemplate>
                            <ItemTemplate></ItemTemplate>
                         </asp:TemplateField>

                        <%--delete button---------------------------------------------------------------%>
                        <asp:CommandField ShowDeleteButton="true" />
                    </Columns>
                </asp:GridView>
                </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="cpeMetros" runat="Server"
                TargetControlID="pMetros"
                CollapsedSize="0"
                Collapsed="True"
                TextLabelID="lblMetros" 
                CollapsedText="metros (click to open)" 
                ExpandedText="metros (click to close)"
                ExpandControlID="headerMetros"
                CollapseControlID="headerMetros"
                AutoCollapse="False"
                AutoExpand="False"
                ScrollContents="False" 
                ExpandDirection="Vertical" />
            </ContentTemplate>
        </asp:UpdatePanel>


        <%--Teams--%>
       <asp:UpdatePanel ID="upTeams" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
                <asp:Panel ID="headerTeams" runat="server" CssClass="headerPanels">
                    <asp:Label ID="lblTeams" runat="server"></asp:Label>
                </asp:Panel>
                <asp:Panel ID="pTeams" runat="server">
                    <asp:GridView 
                        ID="gvTeams" 
                        runat="server" 
                        Font-Size="10px"
                        AutoGenerateColumns="False"
                        DataKeyNames="TeamID"
                        OnRowEditing="EditTeamsRow"
                        OnRowUpdating="UpdateTeamsRow"
                        OnRowDeleting="DeleteTeamsRow"
                        OnRowCancelingEdit="CancelEditTeamsRow"
                        ShowHeaderWhenEmpty="True"
                        EmptyDataText="No records found."
                        UseAccessibleHeader="True"
                        OnRowDataBound="OnRowDataBound"
                        GridLines="None"
                    >
                <RowStyle BackColor="#efefef" />
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="DarkOrange" Font-Size="10px" HorizontalAlign="Left" 
                VerticalAlign="Top" />  
                    <Columns>
                        <%--id--%>
                        <asp:BoundField DataField="TeamID" ReadOnly="true" Visible="false"/>

                        <%--edit button---------------------------------------------------------------%>
                        <asp:CommandField ShowEditButton="true" />

                        <%--Name-----------------------------------------------------------------%>
                         <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Team Name
                                <asp:TextBox ID="txtNewTeamsName" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblTeamsName" 
                                    Text= '<%# Eval("Name")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtTeamsName" 
                                    Text= '<%# Eval("Name")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--TeamCode---------------------------------------------------------------%>
                         <asp:TemplateField HeaderText="Team Code" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Team Code
                                <asp:TextBox ID="txtNewTeamsTeamCode" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblTeamsTeamCode" 
                                    Text= '<%# Eval("TeamCode")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtTeamsTeamCode" 
                                    Text= '<%# Eval("TeamCode")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--add button---------------------------------------------------------------%>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:LinkButton ID="btnAddTeamsRow" 
                                    runat="server" 
                                    Text="add" 
                                    onclick="AddTeamsRow" 
                                    BorderStyle="None" 
                                />
                                </HeaderTemplate>
                            <ItemTemplate></ItemTemplate>
                        </asp:TemplateField>

                        <%--delete button---------------------------------------------------------------%>
                        <asp:CommandField ShowDeleteButton="true" />
                    </Columns>
                </asp:GridView>
                </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="cpeTeams" runat="Server"
                TargetControlID="pTeams"
                CollapsedSize="0"
                Collapsed="True"
                TextLabelID="lblTeams" 
                CollapsedText="teams (click to open)" 
                ExpandedText="teams (click to close)"
                ExpandControlID="headerTeams"
                CollapseControlID="headerTeams"
                AutoCollapse="False"
                AutoExpand="False"
                ScrollContents="False"
                ExpandDirection="Vertical" />
            </ContentTemplate>
        </asp:UpdatePanel>


        <%--JobTitles--%>
        <asp:UpdatePanel ID="upJobTitles" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
                <asp:Panel ID="headerJobTitles" runat="server" CssClass="headerPanels">
                    <asp:Label ID="lblJobTitles" runat="server"></asp:Label>
                </asp:Panel>
                <asp:Panel ID="pJobTitles" runat="server">
                    <asp:GridView 
                    ID="gvJobTitles" 
                    runat="server" 
                    Font-Size="10px"
                    AutoGenerateColumns="False"
                    DataKeyNames="ID"
                    OnRowEditing="EditJobTitlesRow"
                    OnRowUpdating="UpdateJobTitlesRow"
                    OnRowDeleting="DeleteJobTitlesRow"
                    OnRowCancelingEdit="CancelEditJobTitlesRow"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="No records found."
                    UseAccessibleHeader="True"
                    OnRowDataBound="OnRowDataBound"
                    GridLines="None"
                >
                <RowStyle BackColor="#efefef" />
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="DarkOrange" Font-Size="10px" HorizontalAlign="Left" 
                VerticalAlign="Top" />  
                    <Columns>
                        <%--id--%>
                        <asp:BoundField DataField="ID" ReadOnly="true" Visible="false"/>

                        <%--edit button---------------------------------------------------------------%>
                        <asp:CommandField ShowEditButton="true" />

                        <%--Title-----------------------------------------------------------------%>
                         <asp:TemplateField HeaderText="Title" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Title
                                <asp:TextBox ID="txtNewJobTitlesTitle" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblJobTitlesTitle" 
                                    Text= '<%# Eval("Title")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtJobTitlesTitle" 
                                    Text= '<%# Eval("Title")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--JobCode---------------------------------------------------------------%>
                         <asp:TemplateField HeaderText="JobCode" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Job Code
                                <asp:TextBox ID="txtNewJobTitlesJobCode" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblJobTitlesJobCode" 
                                    Text= '<%# Eval("JobCode")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtJobTitlesJobCode" 
                                    Text= '<%# Eval("JobCode")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--JobFamily---------------------------------------------------------------%>
                         <asp:TemplateField HeaderText="JobFamily" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Job Family
                                <asp:TextBox ID="txtNewJobTitlesJobFamily" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblJobTitlesJobFamily" 
                                    Text= '<%# Eval("JobFamily")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtJobTitlesJobFamily" 
                                    Text= '<%# Eval("JobFamily")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--Category---------------------------------------------------------------%>
                        <asp:TemplateField HeaderText="Category" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Category
                                <asp:TextBox ID="txtNewJobTitlesCategory" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblJobTitlesCategory" 
                                    Text= '<%# Eval("Category")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtJobTitlesCategory" 
                                    Text= '<%# Eval("Category")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--ShortTitle---------------------------------------------------------------%>
                        <asp:TemplateField HeaderText="ShortTitle" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Short Title
                                <asp:TextBox ID="txtNewJobTitlesShortTitle" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblJobTitlesShortTitle" 
                                    Text= '<%# Eval("ShortTitle")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtJobTitlesShortTitle" 
                                    Text= '<%# Eval("ShortTitle")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--Include---------------------------------------------------------------%>
                        <asp:TemplateField HeaderText="Include" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Include
                                <asp:CheckBox ID="chkNewJobTitlesInclude" runat="server"></asp:CheckBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox runat="server"
                                    ID = "chkJobTitlesInclude" 
                                    Checked= '<%# Eval("Include")%>'
                                    Enabled="false"
                                ></asp:CheckBox>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox runat="server"
                                    ID = "chkEditJobTitlesInclude" 
                                    Checked= '<%# Eval("Include")%>'
                                    Enabled="true"
                                ></asp:CheckBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--add button---------------------------------------------------------------%>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:LinkButton ID="btnAddJobTitlesRow" 
                                    runat="server" 
                                    Text="add" 
                                    onclick="AddJobTitlesRow" 
                                    BorderStyle="None" 
                                />
                                </HeaderTemplate>
                            <ItemTemplate></ItemTemplate>
                        </asp:TemplateField>

                        <%--delete button---------------------------------------------------------------%>
                        <asp:CommandField ShowDeleteButton="true" />
                    </Columns>
                </asp:GridView>
                </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="cpeJobTitles" runat="Server"
                TargetControlID="pJobTitles"
                CollapsedSize="0"
                Collapsed="True"
                TextLabelID="lblJobTitles"
                CollapsedText="job titles (click to open)" 
                ExpandedText="job titles (click to close)"
                ExpandControlID="headerJobTitles"
                CollapseControlID="headerJobTitles"
                AutoCollapse="False"
                AutoExpand="False"
                ScrollContents="False"
                ExpandDirection="Vertical" />
            </ContentTemplate>
        </asp:UpdatePanel>

        <%--NextJobTitles--%>
        <asp:UpdatePanel ID="upNextJobTitles" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
                <asp:Panel ID="headerNextJobTitles" runat="server" CssClass="headerPanels">
                    <asp:Label ID="lblNextJobTitles" runat="server"></asp:Label>
                </asp:Panel>
                <asp:Panel ID="pNextJobTitles" runat="server">
                    <asp:GridView 
                    ID="gvNextJobTitles" 
                    runat="server" 
                    Font-Size="10px"
                    AutoGenerateColumns="False"
                    DataKeyNames="NextJobID"
                    OnRowEditing="EditNextJobTitlesRow"
                    OnRowUpdating="UpdateNextJobTitlesRow"
                    OnRowDeleting="DeleteNextJobTitlesRow"
                    OnRowCancelingEdit="CancelEditNextJobTitlesRow"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="No records found."
                    UseAccessibleHeader="True"
                    OnRowDataBound="OnRowDataBound"
                    GridLines="None"
                >
                <RowStyle BackColor="#efefef" />
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="DarkOrange" Font-Size="10px" HorizontalAlign="Left" 
                VerticalAlign="Top" />  
                    <Columns>
                        <%--id--%>
                        <asp:BoundField DataField="ID" ReadOnly="true" Visible="false"/>

                        <%--edit button---------------------------------------------------------------%>
                        <asp:CommandField ShowEditButton="true" />

                        <%--Title-----------------------------------------------------------------%>
                         <asp:TemplateField HeaderText="Title" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Title
                                <asp:TextBox ID="txtNewNextJobTitlesShortTitle" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblNextJobTitlesShortTitle" 
                                    Text= '<%# Eval("ShortTitle")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtNextJobTitlesShortTitle" 
                                    Text= '<%# Eval("ShortTitle")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>


                        <%--add button---------------------------------------------------------------%>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:LinkButton ID="btnAddNextJobTitlesRow" 
                                    runat="server" 
                                    Text="add" 
                                    onclick="AddNextJobTitlesRow" 
                                    BorderStyle="None" 
                                />
                                </HeaderTemplate>
                            <ItemTemplate></ItemTemplate>
                        </asp:TemplateField>

                        <%--delete button---------------------------------------------------------------%>
                        <asp:CommandField ShowDeleteButton="true" />
                    </Columns>
                </asp:GridView>
                </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="cpeNextJobTitles" runat="Server"
                TargetControlID="pNextJobTitles"
                CollapsedSize="0"
                Collapsed="True"
                TextLabelID="lblNextJobTitles"
                CollapsedText="next job titles (click to open)" 
                ExpandedText="next job titles (click to close)"
                ExpandControlID="headerNextJobTitles"
                CollapseControlID="headerNextJobTitles"
                AutoCollapse="False"
                AutoExpand="False"
                ScrollContents="False"
                ExpandDirection="Vertical" />
            </ContentTemplate>
        </asp:UpdatePanel>

        <%--ImportChecks--%>
       <asp:UpdatePanel ID="upImportChecks" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
                <asp:Panel ID="headerImportChecks" runat="server" CssClass="headerPanels">
                    <asp:Label ID="lblImportChecks" runat="server"></asp:Label>
                </asp:Panel>
                <asp:Panel ID="pImportChecks" runat="server">
                    <asp:GridView 
                    ID="gvImportChecks" 
                    runat="server" 
                    Font-Size="10px"
                    AutoGenerateColumns="False"
                    DataKeyNames="ID"
                    OnRowEditing="EditImportChecksRow"
                    OnRowUpdating="UpdateImportChecksRow"
                    OnRowDeleting="DeleteImportChecksRow"
                    OnRowCancelingEdit="CancelEditImportChecksRow"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="No records found."
                    UseAccessibleHeader="True"
                    OnRowDataBound="OnRowDataBound"
                    GridLines="None"
                >
                <RowStyle BackColor="#efefef" />
                <AlternatingRowStyle BackColor="White" />
                <EditRowStyle BackColor="DarkOrange" Font-Size="10px" HorizontalAlign="Left" 
                VerticalAlign="Top" />  
                    <Columns>
                        <%--id--%>
                        <asp:BoundField DataField="ID" ReadOnly="true" Visible="false"/>

                        <%--edit button---------------------------------------------------------------%>
                        <asp:CommandField ShowEditButton="true" />

                        <%--CheckDescription-----------------------------------------------------------------%>
                         <asp:TemplateField HeaderText="CheckDescription" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Check Description
                                <asp:TextBox ID="txtNewImportChecksCheckDescription" runat="server"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblImportChecksCheckDescription" 
                                    Text= '<%# Eval("CheckDescription")%>'
                                    CssClass="Labels"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtImportChecksCheckDescription" 
                                    Text= '<%# Eval("CheckDescription")%>'
                                    CssClass="Labels"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--CheckSQL---------------------------------------------------------------%>
                         <asp:TemplateField HeaderText="CheckSQL" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Top">
                            <HeaderTemplate>Check SQL
                                <asp:TextBox ID="txtNewImportChecksCheckSQL" runat="server" Width="1000"></asp:TextBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label runat="server"
                                    ID = "lblImportChecksCheckSQL" 
                                    Text= '<%# Eval("CheckSQL")%>'
                                    CssClass="Labels"
                                    Width="1000"
                                ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server"
                                    ID = "txtImportChecksCheckSQL" 
                                    Text= '<%# Eval("CheckSQL")%>'
                                    CssClass="Labels"
                                    Width="1000"
                                ></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <%--add button---------------------------------------------------------------%>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:LinkButton ID="btnAddImportChecksRow" 
                                    runat="server" 
                                    Text="add" 
                                    onclick="AddImportChecksRow" 
                                    BorderStyle="None" 
                                />
                                </HeaderTemplate>
                            <ItemTemplate></ItemTemplate>
                        </asp:TemplateField>

                        <%--delete button---------------------------------------------------------------%>
                        <asp:CommandField ShowDeleteButton="true" />
                    </Columns>
                </asp:GridView>
                </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="cpeImportChecks" runat="Server"
                TargetControlID="pImportChecks"
                CollapsedSize="0"
                Collapsed="True"
                TextLabelID="lblImportChecks"
                CollapsedText="import checks (click to open)" 
                ExpandedText="import checks (click to close)" 
                ExpandControlID="headerImportChecks"
                CollapseControlID="headerImportChecks"
                AutoCollapse="False"
                AutoExpand="False"
                ScrollContents="False"
                ExpandDirection="Vertical" />
            </ContentTemplate>
        </asp:UpdatePanel>
 

    </form>
</body>
</html>
