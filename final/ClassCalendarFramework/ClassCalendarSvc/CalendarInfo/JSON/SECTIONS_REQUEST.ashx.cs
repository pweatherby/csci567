using System;
using System.Text;
using System.Web;

namespace noble.coder.pweatherby.ClassCalendarSvc.CalendarInfo.JSON
{
    /// <summary>
    /// Summary description for SECTIONS_REQUEST
    /// </summary>
    public class SECTIONS_REQUEST : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            if (!ScheduleInfoAuth.isRequestAuthorized(context))
            {
                return;
            }

            String requestedTerm = context.Request["term"];
            if (String.IsNullOrWhiteSpace(requestedTerm) ||
                !System.Text.RegularExpressions.Regex.IsMatch(requestedTerm, "[0-9]{4}"))
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

            String requestedCrsID = context.Request["course_id"];
            if (String.IsNullOrWhiteSpace(requestedCrsID) ||
                !System.Text.RegularExpressions.Regex.IsMatch(requestedCrsID, "[0-9]{6}"))
            {
                context.Response.Clear();
                context.Response.StatusCode = 400;// Bad Request
                context.Response.Write("Invalid Course ID format.");
                return;
            }

            String requestedCrsOffrNbr = context.Request["course_offer_nbr"];
            Decimal reqCrsOffrDec = 0;
            if (String.IsNullOrWhiteSpace(requestedCrsOffrNbr) ||
                !System.Text.RegularExpressions.Regex.IsMatch(requestedCrsOffrNbr, "[0-9]{1,10}") ||
                !Decimal.TryParse(requestedCrsOffrNbr, out reqCrsOffrDec))
            {
                context.Response.Clear();
                context.Response.StatusCode = 400;// Bad Request
                context.Response.Write("Invalid Course Offer Number format.");
                return;
            }


            PS_SCHEDULE_WS.ClassSchedClassSectionResult result = new PS_SCHEDULE_WS.ClassSchedClassSectionResult();
            Exception error = new Exception();
            if (PeopleSoftDataManager.TryGetSections(requestedTerm, reqSessGrpDec, requestedCrsID, reqCrsOffrDec, out result, out error) && result != null)
            {
                StringBuilder JSON = new StringBuilder();
                JSON.Append("[");
                for (int i = 0; i < result.SectionsResultCount; i++)
                {
                    PS_SCHEDULE_WS.ClassSchedClassSection sect = result.ClassSchedClassSections[i];
                    if (i > 0)
                    {
                        JSON.Append(",");
                    }
                    JSON.Append("{\"INSTITUTION\": \"" + HttpUtility.HtmlAttributeEncode(result.INSTITUTION) + "\" ");
                    JSON.Append(", \"TERM\": \"" + HttpUtility.HtmlAttributeEncode(result.TERM) + "\" ");
                    JSON.Append(", \"SESSION_GROUP\": \"" + result.SESSION_GROUP + "\" ");
                    JSON.Append(", \"COURSE_ID\": \"" + HttpUtility.HtmlAttributeEncode(result.COURSE_ID) + "\" ");
                    JSON.Append(", \"COURSE_OFFER_NBR\": \"" + result.COURSE_OFFER_NBR + "\" ");
                    JSON.Append(", \"CLASS_SECTION\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_SECTION) + "\" ");
                    JSON.Append(", \"CLASS_STATUS\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_STATUS) + "\" ");
                    JSON.Append(", \"CLASS_STATUS_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_STATUS_LDESC) + "\" ");
                    JSON.Append(", \"CLASS_TYPE\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_TYPE) + "\" ");
                    JSON.Append(", \"CLASS_TYPE_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_TYPE_LDESC) + "\" ");
                    JSON.Append(", \"ASSOCIATED_CLASS\": \"" + sect.ASSOCIATED_CLASS + "\" ");
                    JSON.Append(", \"REGISTRATION_NBR\": \"" + sect.REGISTRATION_NBR + "\" ");
                    JSON.Append(", \"CLASS_COMPONENT\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_COMPONENT) + "\" ");
                    JSON.Append(", \"CLASS_COMPONENT_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_COMPONENT_LDESC) + "\" ");
                    JSON.Append(", \"ENRL_STATUS\": \"" + HttpUtility.HtmlAttributeEncode(sect.ENRL_STATUS) + "\" ");
                    JSON.Append(", \"ENRL_STATUS_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(sect.ENRL_STATUS_LDESC) + "\" ");
                    JSON.Append(", \"ENRL_TOTAL\": \"" + sect.ENRL_TOTAL + "\" ");
                    JSON.Append(", \"ENRL_CAPACITY\": \"" + sect.ENRL_CAPACITY + "\" ");
                    JSON.Append(", \"AUTO_ENRL_WAITLIST\": \"" + HttpUtility.HtmlAttributeEncode(sect.AUTO_ENRL_WAITLIST) + "\" ");
                    JSON.Append(", \"WAITLIST_DAEMON\": \"" + HttpUtility.HtmlAttributeEncode(sect.WAITLIST_DAEMON) + "\" ");
                    JSON.Append(", \"WAITLIST_TOTAL\": \"" + sect.WAITLIST_TOTAL + "\" ");
                    JSON.Append(", \"WAITLIST_CAPACTIY\": \"" + sect.WAITLIST_CAPACITY + "\" ");
                    JSON.AppendLine(", \"MEETING_PATTERNS\": [");
                    int curPat = 0;
                    foreach (PS_SCHEDULE_WS.ClassSchedMeetingPattern pat in sect.ClassSchedMeetingPatterns)
                    {
                        if (curPat > 0)
                        {
                            JSON.Append(",");
                        }
                        JSON.Append("{ \"CLASS_MTG_NBR\": \"" + pat.CLASS_MTG_NBR + "\" ");
                        JSON.Append(", \"BUILDING\": \"" + HttpUtility.HtmlAttributeEncode(pat.BUILDING) + "\" ");
                        JSON.Append(", \"ROOM\": \"" + HttpUtility.HtmlAttributeEncode(pat.ROOM) + "\" ");
                        JSON.Append(", \"MEETING_DATE_START\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_DATE_START.ToString("YYYY-MM-dd")) + "\" ");
                        JSON.Append(", \"MEETING_DATE_START_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_DATE_START_LDESC) + "\" ");
                        JSON.Append(", \"MEETING_DATE_END\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_DATE_END.ToString("YYYY-MM-dd")) + "\" ");
                        JSON.Append(", \"MEETING_DATE_END_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_DATE_END_LDESC) + "\" ");
                        JSON.Append(", \"MEETING_TIME_START\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_TIME_START) + "\" ");
                        JSON.Append(", \"MEETING_TIME_END\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_TIME_END) + "\" ");
                        JSON.Append(", \"STND_MTG_PAT\": \"" + HttpUtility.HtmlAttributeEncode(pat.STND_MTG_PAT) + "\" ");
                        JSON.AppendLine(", \"INSTRUCTORS\": [" );
                        int curInst = 0;
                        foreach (PS_SCHEDULE_WS.ClassSchedInstructor inst in pat.ClassSchedInstructors)
                        {
                            if (curInst > 0)
                            {
                                JSON.Append(",");
                            }
                            JSON.Append("{ \"INSTR_ASSIGN_SEQ\": \"" + inst.INSTR_ASSIGN_SEQ + "\" ");
                            JSON.Append(", \"NAME_DISPLAY\": \"" + HttpUtility.HtmlAttributeEncode(inst.NAME_DISPLAY) + "\" ");
                            JSON.Append(", \"LAST_NAME\": \"" + HttpUtility.HtmlAttributeEncode(inst.LAST_NAME) + "\" ");
                            JSON.Append(", \"FIRST_NAME\": \"" + HttpUtility.HtmlAttributeEncode(inst.FIRST_NAME) + "\" ");
                            JSON.AppendLine("}");
                            curInst++;
                        }//finish all instructors in this pattern
                        JSON.AppendLine("] }");
                        curPat++;
                    }// finish all Meeting Patterns
                    JSON.Append(", \"CLASS_ATTRIBUTES\": [");
                    int curAttr = 0;
                    foreach (PS_SCHEDULE_WS.ClassSchedClassAttribute attr in sect.ClassSchedClassAttributes)
                    {
                        if (curAttr > 0)
                        {
                            JSON.Append(",");
                        }
                        JSON.Append("{ \"COURSE_ATTR\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR) + "\" ");
                        JSON.Append(", \"COURSE_ATTR_SDESC\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR_SDESC)+ "\" ");
                        JSON.Append(", \"COURSE_ATTR_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR_LDESC) + "\" ");
                        JSON.Append(", \"COURSE_ATTR_VALUE\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR_VALUE) + "\" ");
                        JSON.Append(", \"COURSE_ATTR_VALUE_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR_VALUE_LDESC) + "\" ");
                        JSON.Append(", \"COURSE_ATTR_VALUE_FDESC\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR_VALUE_FDESC) + "\" ");
                        JSON.AppendLine("}");
                        curAttr++;
                    }
                    JSON.AppendLine("]");

                    JSON.Append(", \"CLASS_NOTES\": [");
                    int curNote = 0;
                    foreach (PS_SCHEDULE_WS.ClassSchedClassNote nte in sect.ClassSchedClassNotes)
                    {
                        if (curNote > 0)
                        {
                            JSON.Append(",");
                        }
                        JSON.Append("{ \"CLASS_NOTE_SEQ\": \"" + nte.CLASS_NOTES_SEQ + "\" ");
                        JSON.Append(", \"COURSE_NOTE\": \"" + HttpUtility.HtmlAttributeEncode(nte.CLASS_NOTE) + "\" ");
                        JSON.AppendLine("}");
                        curNote++;
                    }
                    JSON.AppendLine("]");

                    JSON.Append(", \"CLASS_TEXTBOOKS\": [");
                    int curTxtBk = 0;
                    foreach (PS_SCHEDULE_WS.ClassScheduleClassTextbook txtbk in sect.ClassSchedClassTextbooks)
                    {
                        if (curTxtBk > 0)
                        {
                            JSON.Append(",");
                        }
                        JSON.Append("{ \"TEXTBOOK_SEQ\": \"" + txtbk.SSR_CRSEMAT_SEQ + "\" ");
                        JSON.Append(", \"TEXTBOOK_TYPE\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_CRSEMAT_TYPE) + "\" ");
                        JSON.Append(", \"TEXTBOOK_STATUS\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_STATUS) + "\" ");
                        JSON.Append(", \"TEXTBOOK_ISBN\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_ISBN) + "\" ");  
                        JSON.Append(", \"TEXTBOOK_TITLE\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_TITLE) + "\" ");                        
                        JSON.Append(", \"TEXTBOOK_AUTHOR\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_AUTHOR) + "\" ");
                        JSON.Append(", \"TEXTBOOK_EDITION\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_EDITION) + "\" ");
                        JSON.Append(", \"TEXTBOOK_PUBYEAR\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_PUBYEAR) + "\" ");
                        JSON.Append(", \"TEXTBOOK_PUBLISH\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_PUBLISH) + "\" ");
                        JSON.Append(", \"TEXTBOOK_PRICE\": \"" + txtbk.SSR_TXBDTL_PRICE + "\" ");
                        JSON.Append(", \"TEXTBOOK_CURRENCY\": \"" + txtbk.CURRENCY_CD + "\" ");
                        JSON.Append(", \"TEXTBOOK_NOTES\": \"" + txtbk.SSR_TXBDTL_NOTES + "\" ");
                        JSON.AppendLine("}");
                        curTxtBk++;
                    }
                    JSON.AppendLine("]");

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
