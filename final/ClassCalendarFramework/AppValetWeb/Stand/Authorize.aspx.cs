using System;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using noble.coder.pweatherby.AppValet;

namespace noble.coder.pweatherby.AppValetWeb.Stand
{
    public partial class Authorize : System.Web.UI.Page
    {
        private String GetCurUserFromSession()
        {
            if (HttpContext.Current != null)
            {
                if (HttpContext.Current.Session != null)
                {
                    lock (HttpContext.Current.Session.SyncRoot)
                    {
                        return Convert.ToString(HttpContext.Current.Session["CurCASUserName"]);
                    }
                }
            }
            return String.Empty;
        }

        private void SetCurUserIntoSession(String value)
        {
            if (HttpContext.Current != null)
            {
                if (HttpContext.Current.Session != null)
                {
                    lock (HttpContext.Current.Session.SyncRoot)
                    {
                        HttpContext.Current.Session["CurCASUserName"] = value;
                    }
                }
            }
        }

        private String GetAppIDFromSession()
        {
            if (HttpContext.Current != null)
            {
                if (HttpContext.Current.Session != null)
                {
                    lock (HttpContext.Current.Session.SyncRoot)
                    {
                        return Convert.ToString(HttpContext.Current.Session["CurAppID"]);
                    }
                }
            }
            return String.Empty;
        }

        private void SetAppIDIntoSession(String value)
        {
            if (HttpContext.Current != null)
            {
                if (HttpContext.Current.Session != null)
                {
                    lock (HttpContext.Current.Session.SyncRoot)
                    {
                        HttpContext.Current.Session["CurAppID"] = value;
                    }
                }
            }
        }

        private String GetDeviceIDFromSession()
        {
            if (HttpContext.Current != null)
            {
                if (HttpContext.Current.Session != null)
                {
                    lock (HttpContext.Current.Session.SyncRoot)
                    {
                        return Convert.ToString(HttpContext.Current.Session["CurDevice"]);
                    }
                }
            }
            return String.Empty;
        }

        private void SetDeviceIDIntoSession(String value)
        {
            if (HttpContext.Current != null)
            {
                if (HttpContext.Current.Session != null)
                {
                    lock (HttpContext.Current.Session.SyncRoot)
                    {
                        HttpContext.Current.Session["CurDevice"] = value;
                    }
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.ClientTarget = "uplevel";
            bool isLocal = false;
#if DEBUG
            isLocal = Request.IsLocal;
#endif
            if (!isLocal && !Request.IsSecureConnection)
            {// if not over https (but allow if localhost); dont even acknowledge them
                Response.Clear();
                Response.Close();
                return;
            }
            if (!Page.IsPostBack)
            {
                String DeviceIDFromRequest = Request["deviceID"];
                if (!String.IsNullOrWhiteSpace(DeviceIDFromRequest) && Regex.IsMatch(DeviceIDFromRequest, @"[a-f0-9\-]{36,37}", RegexOptions.IgnoreCase))
                {
                    SetDeviceIDIntoSession(DeviceIDFromRequest);
                }
                String DeviceIDFromSession = GetDeviceIDFromSession();
                
                if (String.IsNullOrWhiteSpace(DeviceIDFromSession))
                {//If both empty; show error panel
                    ErrorPanel.Visible = true;
                    ErrorHeading.Text = "Error: No Device ID Found";
                    ErrorMessage.Text = "Could not find a valid deviceID";
                    PermissionPromptPanel.Visible = false;
                    return;
                }

                String AppIDFromRequest = Request["appID"];
                if (!String.IsNullOrWhiteSpace(AppIDFromRequest) && Regex.IsMatch(AppIDFromRequest, @"[a-f0-9\-]{36,37}", RegexOptions.IgnoreCase))
                {
                    SetAppIDIntoSession(AppIDFromRequest);
                }

                String AppIDFromSession = GetAppIDFromSession();

                if (String.IsNullOrWhiteSpace(AppIDFromSession))
                {//If both empty; show error panel
                    ErrorPanel.Visible = true;
                    ErrorHeading.Text = "Error: No App ID Found";
                    ErrorMessage.Text = "Could not find a valid appID";
                    PermissionPromptPanel.Visible = false;
                    return;
                }

                ErrorPanel.Visible = false;
                PermissionPromptPanel.Visible = true;
                LogInThroughCAS();
            }
        }
        private void LogInThroughCAS(bool renew = false)
        {

            String _UserName = GetCurUserFromSession();
            if (String.IsNullOrWhiteSpace(_UserName) || renew)
            {
                _UserName = CAS.Authenticate(this, renew).Trim();

                if (String.IsNullOrWhiteSpace(_UserName))
                {
                    throw new UnauthorizedAccessException("Incorrect Credentials");
                }
                SetCurUserIntoSession(_UserName);
                Response.Redirect(HttpContext.Current.Request.Url.AbsolutePath);
            }
            UserNameLabel.Text = _UserName;
        }

        protected void notYouLink_Click(object sender, EventArgs e)
        {
            this.Session.Clear();
            this.Session.Abandon();
            LogInThroughCAS(true);
        }

        protected void AcceptButton_Click(object sender, EventArgs e)
        {
            String ClassCalendarID = "0a0c2deb-4596-41a7-a0b9-37aa9b45ed11";
            String key = ValetOffice.GenerateNewAppDeviceKey(ClassCalendarID, GetCurUserFromSession(), GetDeviceIDFromSession());
            Response.Clear();
            Response.ContentType = "text/xml";
            Response.Write("<AuthRequestResult accept=\"true\">");
            Response.Write("<ValetKey>" + key + "</ValetKey>");
            Response.Write("</AuthRequestResult>");
            Response.Flush();
            Response.Close();
        }

        protected void DenyButton_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.ContentType = "text/xml";
            Response.Write("<AuthRequestResult accept=\"false\">");
            Response.Write("<ValetKey></ValetKey>");
            Response.Write("</AuthRequestResult>");
            Response.Flush();
            Response.Close();
        }
    }
}