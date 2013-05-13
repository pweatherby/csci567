using System;
using System.IO;
using System.Net;
using System.Web.UI;

namespace noble.coder.pweatherby.AppValetWeb
{
    /// <summary>
    /// CAS (Central Authentication Server) is used solely to securely identify a user 
    /// across multiple applications.
    /// </summary>
    /// <example>
    /// using edu.csu.chico.enr.Authentication;
    /// private void Page_Load(object sender, System.EventArgs e)
    /// {			
    ///    String username = CAS.Authenticate( this ) ;
    /// }
    /// </example>
    public class CAS
    {
        private static string Server_Url
        {
            get
            {
                string CAS_SERVER_URL = System.Configuration.ConfigurationManager.AppSettings["CAS_SERVER_URL"];
                if (String.IsNullOrWhiteSpace(CAS_SERVER_URL))
                {
                    throw new ApplicationException("Application Setting {CAS_SERVER_URL} is not set");
                }
                return CAS_SERVER_URL;
            }
        }

        private static string Server_Login_Page
        {
            get
            {
                string CAS_LOGIN_PAGE = System.Configuration.ConfigurationManager.AppSettings["CAS_LOGIN_PAGE"];
                if (String.IsNullOrWhiteSpace(CAS_LOGIN_PAGE))
                {
                    throw new ApplicationException("Application Setting {CAS_LOGIN_PAGE} is not set");
                }
                return (Server_Url + CAS_LOGIN_PAGE);
            }
        }

        private static string Server_Validate_Page
        {
            get
            {
                return Server_Url + "validate";
            }
        }

        private static string Server_Logout_Page
        {
            get
            {
                return Server_Url + "logout";
            }
        }
        /// <summary>
        /// Make sure the web.config file Has the following:
        ///    &#lt;appSettings&#gt;
        ///         &#lt;add key="CAS_SERVER_URL" value="https://cas.csuchico.edu/cas" /&#gt;
        ///         &#lt;add key="CAS_LOGIN_PAGE" value="/login" /&#gt;
        ///    &#lt;/appSettings&#gt;
        /// </summary>
        /// <param name="page">Typically the Login Page for the app</param>
        /// <param name="username">The logged-in User (if any)</param>
        /// <returns>Weather a User is already Authenticated or Not</returns>
        public static bool isAuthenticated(Page page, out String username)
        {

            username = String.Empty;
            
            // verify ticket
            if (page.Request == null || page.Session == null)
            {
                throw new ApplicationException("Page Request or Session is null when Attempting to Validate CAS Ticket");
            }
            if (page.Request.QueryString["ticket"] != null)
            {
                String validateUrlBuilt = String.Empty;
                try
                {
                    String ticket = (page.Request.QueryString["ticket"]).Split(',')[0];
                    validateUrlBuilt = Server_Validate_Page + "?ticket=" + ticket + "&service=" + System.Web.HttpUtility.UrlEncode(page.Request.Url.AbsoluteUri.Split(new string[] { "&ticket=", "?ticket=" }, StringSplitOptions.None)[0]);
                    StreamReader reader = new StreamReader(new WebClient().OpenRead(validateUrlBuilt));
                    String cur_line = reader.ReadLine();
                    if (cur_line != null && cur_line.Trim().ToLower() != "no")
                    // returned username if verified, nothing if not
                    {
                        username = reader.ReadLine().Trim();
                        if (!String.IsNullOrEmpty(username))
                        {
                            return true;
                        }

                    }
                }
                catch
                {
                }
            }
            return false;
        }

        /// <summary>
        /// Make sure the web.config file Has the following:
        ///    &#lt;appSettings&#gt;
        ///         &#lt;add key="CAS_SERVER_URL" value="https://cas.csuchico.edu/cas" /&#gt;
        ///         &#lt;add key="CAS_LOGIN_PAGE" value="/login" /&#gt;
        ///    &#lt;/appSettings&#gt;
        /// </summary>
        /// <param name="page">Typically the Login Page for the app</param>
        /// <returns>The logged-in User (if any)</returns>
        public static String Authenticate(Page page, bool renew)
        {
            if (page == null)
            {
                throw new ArgumentNullException("Page Cannot be Null");
            }
            String checkUser = String.Empty;
            if(renew || !isAuthenticated(page, out checkUser))
            {
                // ticket was invalid, or didn't exist, so request ticket
                string builtLoginPage = Server_Login_Page + "?service=" + System.Web.HttpUtility.UrlEncode(page.Request.Url.AbsoluteUri) + ( renew ? "&renew=true" : String.Empty);
                page.Response.Redirect(builtLoginPage, true);
                return String.Empty;
            }
            else
            {
                return checkUser;
            }

        }

        public static void Logout_Async()
        {

            using (WebClient wc = new WebClient())
            { wc.OpenReadAsync(new Uri(Server_Logout_Page)); }
            System.Web.Security.FormsAuthentication.SignOut();
        }

        public static string Logout()
        {
            System.Web.Security.FormsAuthentication.SignOut();
            using (WebClient wc = new WebClient())
            { return wc.DownloadString(new Uri(Server_Logout_Page)); }
            
        }
    }
}