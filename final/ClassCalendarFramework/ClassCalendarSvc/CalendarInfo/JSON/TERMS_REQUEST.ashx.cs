using System;
using System.Text;
using System.Web;

namespace noble.coder.pweatherby.ClassCalendarSvc.CalendarInfo.JSON
{
    /// <summary>
    /// Summary description for TERMS_REQUEST
    /// </summary>
    public class TERMS_REQUEST : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (!CalendarInfoAuth.isRequestAuthorized(context))
            {
                return;
            }


            PS_SCHEDULE_WS.ClassSchedTermResult result = new PS_SCHEDULE_WS.ClassSchedTermResult();
            Exception error = new Exception();
            if (PeopleSoftDataManager.TryGetTerms(out result, out error) && result != null)
            {
                StringBuilder JSON = new StringBuilder();
                JSON.Append("[");
                for (int i = 0; i < result.ClassSchedTerms.Length; i++)
                {
                    PS_SCHEDULE_WS.ClassSchedTerm term = result.ClassSchedTerms[i];
                    if (i > 0)
                    {
                        JSON.Append(",");
                    }
                    JSON.Append("{ \"TERM\": \"" + HttpUtility.HtmlAttributeEncode(term.TERM) + "\" ");
                    JSON.Append(", \"TERM_SDESC\": \"" + HttpUtility.HtmlAttributeEncode(term.TERM_SDESC) + "\" ");
                    JSON.AppendLine(", \"TERM_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(term.TERM_LDESC) + "\" }");
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