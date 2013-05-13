<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Authorize.aspx.cs" Inherits="noble.coder.pweatherby.AppValetWeb.Stand.Authorize" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CSU, Chico Authorize Mobile Application</title>
    <style type="text/css">
        form
        {
            margin: auto auto;
            width: 90%;
            min-width: 300px;
            max-width: 400px;
        }
        .section {
            border: 1px solid #9B9B9B;
            padding: 4px;
            background-color: white;
            border-radius: 10px;
            margin-top: 5px;
        }
        .section legend
        {
            background-color: white;
            border-radius: 5px;
            border: 1px solid #9B9B9B;
        }
        .appIcon
        {
            border-radius: 15px;
        }
        
        .padding
        {
            padding: 10px;
        }
        
        .greeting
        {
            display: inline;
            font-size: 1.17em;
            margin: 1em 1em 1em 1em;
            font-weight: bold;
            color: #960000;
        }
        .small
        {
            font-size: .70em;
        }
        .column-left,
        .column-right
        {
            display: inline-block;
            width: 49%;
            text-align: center;
        }
        
        img
        {
            vertical-align: middle;
            margin-right: 20px;
        }
        
        .button
        {
            display: inline-block;
            min-width: 46px;
            text-align: center;
            color: #444;
            font-size: 11px;
            font-weight: bold;
            height: 27px;
            padding: 0 8px;
            line-height: 27px;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
            border-radius: 2px;
            border: 1px solid #dcdcdc;
            background-color: #f5f5f5;
        }
        .button-confirm
        {
            border: 1px solid #075220;
            color: #fff;
            background-color: #1D9E48;
            width: 90px;
            height: 44px;
        }
        
        .button-deny
        {
            border: 1px solid #520907;
            color: #FFF;
            background-color: #9E0601;
            width: 90px;
            height: 44px;
        }
    </style>
</head>
    <body>
        <form id="form1" runat="server" method="post" action="Authorize.aspx"> 
          <asp:Panel ID="ErrorPanel" runat="server">
            <fieldset class="section">
                <legend><asp:Literal ID="ErrorHeading" runat="server" /></legend>
                <div class="padding">
                    The Following Error Occured:<br />
                    <asp:Literal ID="ErrorMessage" runat="server" />
                </div>
            </fieldset>
          </asp:Panel>
          <asp:Panel ID="PermissionPromptPanel" runat="server">
              <fieldset class="section">
                <legend>Mobile App Access</legend>
                <img src="https://www.csuchico.edu/_assets/2.0/images/csuc-signature.jpg" alt="Chico State Web Logo" height="57px" />
                <img src="../_images/calendar_iconx57.jpg" alt="Requesting Mobile Application's Icon" class="appIcon" />
                <hr />
                <span class="greeting">Greetings <asp:Literal ID="UserNameLabel" runat="server" />,</span>
                <asp:LinkButton ID="notYouLink" runat="server" Text="Not You?" onclick="notYouLink_Click" CssClass="small" />
                <hr />
                <div class="padding">
                    <p>The Class Calendar App requests your permission to:</p>
                    <ul>
                        <li>View your name.</li>
                        <li>View your Enrollment Shopping Cart.</li>
                        <li>Modify your Enrollment Shopping Cart.</li>
                    </ul>
                    <hr />
                    <p>It will <strong>NOT</strong> be able to:</p>
                    <ul>
                        <li>Modify your actual Enrollment.</li>
                        <li>See your password.</li>
                        <li>See any Financial Data.</li>
                    </ul>
                    <hr />
                </div>
                <div class="column-left">
                    <asp:Button ID="AcceptButton" runat="server" Text="Allow" 
                        CssClass="button button-confirm" onclick="AcceptButton_Click"  />
                </div>
                <div class="column-left">
                    <asp:Button ID="DenyButton" runat="server" Text="Deny" 
                        CssClass="button button-deny" onclick="DenyButton_Click" />
                </div>
                <br style="clear:both;"/>
                <br />
              </fieldset>
          </asp:Panel>
        </form>
    </body>
</html>
