using System;
using System.Text;
using System.Web;

namespace noble.coder.pweatherby.ClassCalendarSvc.CalendarInfo.JSON
{
    /// <summary>
    /// Summary description for NUMBERS_REQUEST
    /// </summary>
    public class NUMBERS_REQUEST : IHttpHandler
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

            String requestedSessionGroup = context.Request["session_group"];
            Decimal reqSessGrpDec = 0;
            if (String.IsNullOrWhiteSpace(requestedSessionGroup) ||
               !System.Text.RegularExpressions.Regex.IsMatch(requestedSessionGroup, "[0-9]{1,10}") ||
               !Decimal.TryParse(requestedSessionGroup, out reqSessGrpDec))
            {
                context.Response.Clear();
                context.Response.StatusCode = 400;// Bad Request
                context.Response.Write("Invalid Session Group format.");
                return;
            }

            String requestedSubject = context.Request["subject"];
            if (String.IsNullOrWhiteSpace(requestedSubject) || !System.Text.RegularExpressions.Regex.IsMatch(requestedSubject, "[A-Z]{4}"))
            {
                context.Response.Clear();
                context.Response.StatusCode = 400;// Bad Request
                context.Response.Write("Invalid Subject format.");
                return;
            }


            PS_SCHEDULE_WS.ClassSchedClassNumberResult result = new PS_SCHEDULE_WS.ClassSchedClassNumberResult();
            Exception error = new Exception();
            if (PeopleSoftDataManager.TryGetNumbers(requestedTerm, reqSessGrpDec, requestedSubject, out result, out error) && result != null)
            {
                StringBuilder JSON = new StringBuilder();
                JSON.Append("[");
                for (int i = 0; i < result.NumberResultCount; i++)
                {
                    PS_SCHEDULE_WS.ClassSchedClassNumber numb = result.ClassSchedClassNumbers[i];
                    if (i > 0)
                    {
                        JSON.Append(",");
                    }
                    JSON.Append("{\"INSTITUTION\": \"" + HttpUtility.HtmlAttributeEncode(result.INSTITUTION) + "\" ");
                    JSON.Append(", \"TERM\": \"" + HttpUtility.HtmlAttributeEncode(result.TERM) + "\" ");
                    JSON.Append(", \"SESSION_GROUP\": \"" + result.SESSION_GROUP + "\" ");
                    JSON.Append(", \"SUBJECT_CODE\": \"" + HttpUtility.HtmlAttributeEncode(result.SUBJECT) + "\" ");
                    JSON.Append(", \"CLASS_NUMBER\": \"" + HttpUtility.HtmlAttributeEncode(numb.CLASS_NBR) + "\" ");
                    JSON.Append(", \"COURSE_ID\": \"" + HttpUtility.HtmlAttributeEncode(numb.COURSE_ID) + "\" ");
                    JSON.Append(", \"COURSE_OFFER_NBR\": \"" + numb.COURSE_OFFER_NBR + "\" ");
                    JSON.Append(", \"COURSE_TITLE_SDESC\": \"" + HttpUtility.HtmlAttributeEncode(numb.COURSE_TITLE_SDESC) + "\" ");
                    JSON.Append(", \"COURSE_TITLE_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(numb.COURSE_TITLE_LDESC) + "\" ");
                    JSON.Append(", \"UNITS_MIN\": \"" + numb.UNITS_MINIMUM + "\" ");
                    JSON.Append(", \"UNITS_MAX\": \"" + numb.UNITS_MAXIMUM + "\" ");
                    JSON.Append(", \"COURSE_DESCRIPTION\": \"" + HttpUtility.HtmlAttributeEncode(numb.ClassSchedCourseDescriptions.COURSE_DESCRIPTION) + "\" ");
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