using System;
using System.Web;

namespace noble.coder.pweatherby.ClassCalendarSvc.CalendarInfo.JSON
{
    public class CalendarInfoAuth
    {
        public static bool isRequestAuthorized(HttpContext context)
        {
            bool isLocal = false;
#if DEBUG
            isLocal = context.Request.IsLocal;
#endif
            if (!isLocal && !context.Request.IsSecureConnection)
            {// if not over https (but allow if localhost); dont even acknowledge them
                context.Response.Clear();
                context.Response.Close();
                return false;
            }
            return true; // To turn off auth; uncomment.

            String AuthRequest = context.Request.Headers["Authorization"];
            if (String.IsNullOrWhiteSpace(AuthRequest))
            {  // If no Auth provided, Respond with 'Unauthorized, btw; i (the server) like basic auth'
                context.Response.Clear();
                context.Response.StatusCode = 401;
                context.Response.AddHeader("WWW-Authenticate", "Basic realm=\"CHICOCLASSCALENDAR\"");
                context.Response.Write(String.Empty);
                return false;
            }
            if (!AuthRequest.StartsWith("Basic ", StringComparison.InvariantCultureIgnoreCase))
            {  // If improper Auth method provided, Respond with 'Unauthorized, btw; i (the server) like basic auth'
                context.Response.Clear();
                context.Response.StatusCode = 401;
                context.Response.AddHeader("WWW-Authenticate", "Basic realm=\"CHICOCLASSCALENDAR\"");
                context.Response.Write(String.Empty);
                return false;
            }
            String base64Auth = AuthRequest.Substring(6);// 6 := ("Basic ").Length+1

            String decodedAuth = System.Text.Encoding.UTF8.GetString(Convert.FromBase64String(base64Auth));

            Int32 index = decodedAuth.IndexOf(":");
            if (index <= 0 || index >= decodedAuth.Length)
            {  // if improper format; just deny request
                context.Response.Clear();
                context.Response.StatusCode = 401;// Unauthorized; Try to enter a different auth
                context.Response.AddHeader("WWW-Authenticate", "Basic realm=\"CHICOCLASSCALENDAR\"");
                context.Response.Write(String.Empty);
                return false;
            }
            String _usr = decodedAuth.Substring(0, index);
            String _pwd = decodedAuth.Substring(index + 1);
            ValetStand.ValetKeyStatus stats = ValetStand.ValetKeyStatus.Unknown;
            using (ValetStand.AttendantClient Attendant = new ValetStand.AttendantClient())
            {
                stats = Attendant.GetKeyStatus(_usr, _pwd);
            }

            if (stats != ValetStand.ValetKeyStatus.Active)
            {// Invalid credentials
                context.Response.Clear();
                context.Response.StatusCode = 401;// Unauthorized; Try a different auth
                context.Response.AddHeader("WWW-Authenticate", "Basic realm=\"CHICOCLASSCALENDAR\"");
                context.Response.Write(String.Empty);
                return false;
            }
            return true;
        }
    }
}