using System;
using System.Web;

namespace noble.coder.pweatherby.ClassCalendarSvc.ShopCart.JSON
{
    public class ShopCartInfoAuth
    {
        public static bool isRequestAuthorized(HttpContext context, out String _usr, out String _pwd)
        {
            _usr = null;
            _pwd = null;
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

            String paramUsr = context.Request["deviceID"];
            String paramPwd = context.Request["valetKey"];
            if (String.IsNullOrWhiteSpace(paramUsr) || String.IsNullOrWhiteSpace(paramPwd))
            {// Just in case IOS auth isn't working; allow pass on url

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
                _usr = decodedAuth.Substring(0, index);
                _pwd = decodedAuth.Substring(index + 1);
            }
            else
            {
                _usr = paramUsr;
                _pwd = paramPwd;
            }
            ValetStand.ValetKeyStatus stats = ValetStand.ValetKeyStatus.Unknown;
            using (ValetStand.AttendantClient Attendant = new ValetStand.AttendantClient())
            {
                stats = Attendant.GetKeyStatus(_usr, _pwd);
            }

            if (stats != ValetStand.ValetKeyStatus.Active)
            {// Invalid credentials
                _usr = null;
                _pwd = null;
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