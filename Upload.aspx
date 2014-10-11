<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="SuPlan.Upload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="css/default.css" />
    <title>Upload WorkDay File</title>
</head>
<body>
    <form id="form1" runat="server">

        <div id="uploadControls">
            <asp:FileUpload ID="fuUpload" runat="server" />
            <br/>
            <asp:Button ID="btnUpload" runat="server" Text="Upload"  OnClick="btnUpload_Click" />
        </div>
        <asp:Label ID="lblImportResult" runat="server"></asp:Label>

    </form>
</body>
</html>
