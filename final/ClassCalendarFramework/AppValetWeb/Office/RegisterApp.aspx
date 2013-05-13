<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterApp.aspx.cs" Inherits="noble.coder.pweatherby.AppValetWeb.Office.RegisterApp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="AppNameTextbox" runat="server" Text="Class Calendar Mobile App- IOS" />
            <asp:Button ID="RegisterButton" runat="server" Text="Register!" 
                onclick="RegisterButton_Click" />
        </div>
    </form>
</body>
</html>
