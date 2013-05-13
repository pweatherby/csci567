using System;
using System.Text;
using System.Web;

namespace noble.coder.pweatherby.ClassCalendarSvc.CalendarInfo.JSON
{
    /// <summary>
    /// Summary description for SESSIONS_REQUEST
    /// </summary>
    public class SESSIONS_REQUEST : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (!CalendarInfoAuth.isRequestAuthorized(context))
            {
                return;
            }

            String requestedTerm = context.Request["term"];
            if (String.IsNullOrWhiteSpace(requestedTerm) || !System.Text.RegularExpressions.Regex.IsMatch(requestedTerm, "[0-9]{4}"))
            {
                context.Response.Clear();
                context.Response.StatusCode = 400;// Bad Request
                context.Response.Write("Invalid term format.");
                return;
            }


            PS_SCHEDULE_WS.ClassSchedSessionGroupResult result = new PS_SCHEDULE_WS.ClassSchedSessionGroupResult();
            Exception error = new Exception();
            if (PeopleSoftDataManager.TryGetSessionGroups(requestedTerm, out result, out error) && result != null)
            {
                StringBuilder JSON = new StringBuilder();
                JSON.Append("[");
                for (int i = 0; i < result.SessionGroupResultCount; i++)
                {
                    PS_SCHEDULE_WS.ClassSchedSessionGroup SessGrp = result.ClassSchedSessionGroups[i];
                    if (i > 0)
                    {
                        JSON.Append(",");
                    }
                    JSON.Append("{\"INSTITUTION\": \"" + HttpUtility.HtmlAttributeEncode(result.INSTITUTION) + "\" ");
                    JSON.Append(", \"TERM\": \"" + HttpUtility.HtmlAttributeEncode(result.TERM) + "\" ");
                    JSON.Append(", \"SESSION_GROUP\": \"" + SessGrp.SESSION_GROUP + "\" ");
                    JSON.Append(", \"GROUP_ABBREV\": \"" + HttpUtility.HtmlAttributeEncode(SessGrp.GROUP_ABBREV) + "\" ");
                    JSON.Append(", \"GROUP_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(SessGrp.GROUP_LDESC) + "\" ");
                    JSON.Append(", \"DISPLAY_SEQ\": \"" + SessGrp.DISPLAY_SEQ + "\" ");
                    /* Commented out cause we dont use Sessions in the other stuff
                    JSON.AppendLine(", \"SESSIONS\": [");
                    if (SessGrp.ClassSchedSessions.Count() > 0)
                    {
                        foreach(PS_SCHEDULE_WS.ClassSchedSession Sess in SessGrp.ClassSchedSessions)
                        {
                            JSON.AppendLine("{ \"SESSION_CODE\": \"" + Sess.SESSION_CODE + "\" ");
                            JSON.AppendLine(", \"SESSION_SDESC\": \"" + Sess.SESSION_SDESC + "\" ");
                            JSON.AppendLine(", \"SESSION_LDESC\": \"" + Sess.SESSION_LDESC + "\" }");
                        }
                    }
                    
                    JSON.AppendLine(" \"] ");
                    */
                    JSON.AppendLine("}");
                }
                JSON.AppendLine("]");
                context.Response.ContentType = "application/json";
                context.Response.Write(JSON.ToString());
            }
            else
            {
#if DEBUG
                context.Response.ContentType = "text/plain";
                context.Response.Write(error.ToString());
#endif
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}