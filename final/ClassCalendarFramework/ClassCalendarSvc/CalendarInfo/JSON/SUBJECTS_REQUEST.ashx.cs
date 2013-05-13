using System;
using System.Text;
using System.Web;

namespace noble.coder.pweatherby.ClassCalendarSvc.CalendarInfo.JSON
{
    /// <summary>
    /// Summary description for SUBJECTS_REQUEST
    /// </summary>
    public class SUBJECTS_REQUEST : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (!ScheduleInfoAuth.isRequestAuthorized(context))
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
            


            PS_SCHEDULE_WS.ClassSchedSubjResult result = new PS_SCHEDULE_WS.ClassSchedSubjResult();
            Exception error = new Exception();
            if (PeopleSoftDataManager.TryGetSubjects(requestedTerm,  reqSessGrpDec, out result, out error) && result != null)
            {
                StringBuilder JSON = new StringBuilder();
                JSON.Append("[");
                for (int i = 0; i < result.SubjectResultCount; i++)
                {
                    PS_SCHEDULE_WS.ClassSchedSubject subj = result.ClassSchedSubjects[i];
                    if (i > 0)
                    {
                        JSON.Append(",");
                    }
                    JSON.Append("{\"INSTITUTION\": \"" + HttpUtility.HtmlAttributeEncode(result.INSTITUTION) + "\" ");
                    JSON.Append(", \"TERM\": \"" + HttpUtility.HtmlAttributeEncode(result.TERM) + "\" ");
                    JSON.Append(", \"SESSION_GROUP\": \"" + result.SESSION_GROUP + "\" ");
                    JSON.Append(", \"SUBJECT_CODE\": \"" + HttpUtility.HtmlAttributeEncode(subj.SUBJECT) + "\" ");
                    JSON.Append(", \"SUBJECT_SDESC\": \"" + HttpUtility.HtmlAttributeEncode(subj.SUBJECT_SDESC) + "\" ");
                    JSON.Append(", \"SUBJECT_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(subj.SUBJECT_LDESC) + "\" ");
                    JSON.Append(", \"SUBJECT_FDESC\": \"" + HttpUtility.HtmlAttributeEncode(subj.SUBJECT_FDESC) + "\" ");
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