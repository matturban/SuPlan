<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SuPlan.Login" %>
<%@ Import Namespace="SuPlan" %>

<!DOCTYPE html />

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <link href="css/default.css" rel="stylesheet" type="text/css" />
        <title>Log in</title>
    </head>
    <body>
    <form id="Login" method="post" runat="server">
        <div id="loginDiv">
        <h1>Succession Planning</h1>
            <div id="logControls">
                <asp:Label ID="lblUserName" runat="server" >user name:</asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="loginBoxes" style="width:200px;font-family:'Segoe UI',Arial,Helvetica;font-size:10px;" ></asp:TextBox><br/>
                <asp:Label ID="lblPassword" runat="server" >password:</asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="loginBoxes" style="width:200px;font-family:'Segoe UI',Arial,Helvetica;font-size:10px;"></asp:TextBox><br/>
                <asp:Button ID="btnLogin" runat="server" Text="login" OnClick="Login_Click" CssClass="Buttons"></asp:Button><br/>
                <asp:Label ID="errorLabel" runat="server" ForeColor="#ff3300"></asp:Label><br/>
                <%--<asp:CheckBox ID="chkPersist" runat="server" Text="keep me logged in" />--%>
            </div>
        </div>
    </form>
    </body>
</html>
