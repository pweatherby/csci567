using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace noble.coder.pweatherby.ClassCalendarSvc.ShopCart.JSON
{
    /// <summary>
    /// Summary description for ViewCart
    /// </summary>
    public class ViewCart : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            String _usr = String.Empty;
            String _pwd = String.Empty;
            if (!ShopCartInfoAuth.isRequestAuthorized(context, out _usr, out _pwd))
            {
                return;
            }
            String Emplid = String.Empty;
            if (!String.IsNullOrWhiteSpace(_usr) && !String.IsNullOrWhiteSpace(_pwd))
            {
                using (ValetStand.AttendantClient attendant = new ValetStand.AttendantClient())
                {
                    Emplid = attendant.GetUserID(_usr, _pwd);
                }
            }
            if (!String.IsNullOrWhiteSpace(Emplid))
            {
                List<ShopCartItem> result = new List<ShopCartItem>();
                Dictionary<String, String> termJSON = new Dictionary<String, String>();
                Dictionary<String, String> sessionJSON = new Dictionary<String, String>();
                Dictionary<String, PS_SCHEDULE_WS.ClassSchedSessionGroupResult> sessionResults = new Dictionary<String, PS_SCHEDULE_WS.ClassSchedSessionGroupResult>();
                Dictionary<String, String> subjectJSON = new Dictionary<String, String>();
                Dictionary<String, PS_SCHEDULE_WS.ClassSchedSubjResult> subjectResults = new Dictionary<String, PS_SCHEDULE_WS.ClassSchedSubjResult>();
                Dictionary<String, String> numbersJSON = new Dictionary<String, String>();
                Dictionary<String, PS_SCHEDULE_WS.ClassSchedClassNumberResult> numberResults = new Dictionary<String, PS_SCHEDULE_WS.ClassSchedClassNumberResult>();
                Dictionary<String, String> sectionJSON = new Dictionary<String, String>();
                Dictionary<String, PS_SCHEDULE_WS.ClassSchedClassSectionResult> sectionResults = new Dictionary<String, PS_SCHEDULE_WS.ClassSchedClassSectionResult>();

                Exception error = new Exception();
                if (ShopCartDataManager.TryGetCart(Emplid, out result, out error) && result != null)
                {
                    PS_SCHEDULE_WS.ClassSchedTermResult theTerms = new PS_SCHEDULE_WS.ClassSchedTermResult();
                    if (!PeopleSoftDataManager.TryGetTerms(out theTerms, out error))
                    {
                        theTerms = new PS_SCHEDULE_WS.ClassSchedTermResult();
                    }
                    StringBuilder JSON = new StringBuilder();
                    JSON.AppendLine("[");
                    for (int k = 0; k < result.Count; k++)
                    {
                        ShopCartItem item = result.ElementAt(k);
                        if (k > 0)
                        {
                            JSON.AppendLine(", ");
                        }

                        JSON.Append("{ \"TERM\": [");
                        if (termJSON.ContainsKey(item.Term))
                        {
                            JSON.Append(termJSON[item.Term]);
                        }
                        else
                        {
                            StringBuilder t = new StringBuilder();
                            int j = 0;
                            for (int i = 0; i < theTerms.ClassSchedTerms.Length; i++)
                            {
                                PS_SCHEDULE_WS.ClassSchedTerm term = theTerms.ClassSchedTerms[i];
                                if (term.TERM.Equals(item.Term, StringComparison.InvariantCultureIgnoreCase))
                                {
                                    if (j > 0)
                                    {
                                        t.Append(",");
                                    }
                                    t.Append("{ \"TERM\": \"" + HttpUtility.HtmlAttributeEncode(term.TERM) + "\" ");
                                    t.Append(", \"TERM_SDESC\": \"" + HttpUtility.HtmlAttributeEncode(term.TERM_SDESC) + "\" ");
                                    t.AppendLine(", \"TERM_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(term.TERM_LDESC) + "\" }");
                                    j++;
                                }
                            }
                            String temp = t.ToString();
                            termJSON.Add(item.Term, temp);
                            JSON.Append(temp);
                        }
                        JSON.AppendLine("]");

                        JSON.Append(", \"SESSION_GROUP\": [");
                        if (sessionJSON.ContainsKey(item.Term + item.SessionGroup))
                        {
                            JSON.Append(sessionJSON[item.Term + item.SessionGroup]);
                        }
                        else
                        {
                            PS_SCHEDULE_WS.ClassSchedSessionGroupResult theSessions = new PS_SCHEDULE_WS.ClassSchedSessionGroupResult();
                            if (sessionResults.ContainsKey(item.Term))
                            {
                                theSessions = sessionResults[item.Term];
                            }
                            else
                            {
                                if (!PeopleSoftDataManager.TryGetSessionGroups(item.Term, out theSessions, out error))
                                {
                                    theSessions = new PS_SCHEDULE_WS.ClassSchedSessionGroupResult();
                                }
                                sessionResults.Add(item.Term, theSessions);
                            }
                            StringBuilder t = new StringBuilder();
                            int j = 0;
                            for (int i = 0; i < theSessions.ClassSchedSessionGroups.Length; i++)
                            {
                                PS_SCHEDULE_WS.ClassSchedSessionGroup SessGrp = theSessions.ClassSchedSessionGroups[i];
                                if (SessGrp.SESSION_GROUP.ToString() == item.SessionGroup)
                                {
                                    if (j > 0)
                                    {
                                        t.Append(",");
                                    }
                                    t.Append("{\"INSTITUTION\": \"" + HttpUtility.HtmlAttributeEncode(theSessions.INSTITUTION) + "\" ");
                                    t.Append(", \"TERM\": \"" + HttpUtility.HtmlAttributeEncode(theSessions.TERM) + "\" ");
                                    t.Append(", \"SESSION_GROUP\": \"" + SessGrp.SESSION_GROUP + "\" ");
                                    t.Append(", \"GROUP_ABBREV\": \"" + HttpUtility.HtmlAttributeEncode(SessGrp.GROUP_ABBREV) + "\" ");
                                    t.Append(", \"GROUP_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(SessGrp.GROUP_LDESC) + "\" ");
                                    t.Append(", \"DISPLAY_SEQ\": \"" + SessGrp.DISPLAY_SEQ + "\" ");
                                    t.AppendLine("}");
                                    j++;
                                }
                            }
                            String temp = t.ToString();
                            sessionJSON.Add(item.Term + item.SessionGroup, temp);
                            JSON.Append(temp);
                        }
                        JSON.AppendLine("]");
                        JSON.Append(", \"SUBJECT\": [");
                        if (subjectJSON.ContainsKey(item.Term + item.SessionGroup + item.Subject))
                        {
                            JSON.Append(subjectJSON[item.Term + item.SessionGroup + item.Subject]);
                        }
                        else
                        {
                            PS_SCHEDULE_WS.ClassSchedSubjResult theSubjects = new PS_SCHEDULE_WS.ClassSchedSubjResult();
                            if (subjectResults.ContainsKey(item.Term + item.SessionGroup))
                            {
                                theSubjects = subjectResults[item.Term + item.SessionGroup];
                            }
                            else
                            {
                                if (!PeopleSoftDataManager.TryGetSubjects(item.Term, Decimal.Parse(item.SessionGroup), out theSubjects, out error))
                                {
                                    theSubjects = new PS_SCHEDULE_WS.ClassSchedSubjResult();
                                }
                                subjectResults.Add(item.Term + item.SessionGroup, theSubjects);
                            }
                            StringBuilder t = new StringBuilder();
                            int j = 0;
                            for (int i = 0; i < theSubjects.ClassSchedSubjects.Length; i++)
                            {
                                PS_SCHEDULE_WS.ClassSchedSubject subj = theSubjects.ClassSchedSubjects[i];
                                if (subj.SUBJECT.Equals(item.Subject, StringComparison.InvariantCultureIgnoreCase))
                                {
                                    if (j > 0)
                                    {
                                        t.Append(",");
                                    }
                                    t.Append("{\"INSTITUTION\": \"" + HttpUtility.HtmlAttributeEncode(theSubjects.INSTITUTION) + "\" ");
                                    t.Append(", \"TERM\": \"" + HttpUtility.HtmlAttributeEncode(theSubjects.TERM) + "\" ");
                                    t.Append(", \"SESSION_GROUP\": \"" + theSubjects.SESSION_GROUP + "\" ");
                                    t.Append(", \"SUBJECT_CODE\": \"" + HttpUtility.HtmlAttributeEncode(subj.SUBJECT) + "\" ");
                                    t.Append(", \"SUBJECT_SDESC\": \"" + HttpUtility.HtmlAttributeEncode(subj.SUBJECT_SDESC) + "\" ");
                                    t.Append(", \"SUBJECT_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(subj.SUBJECT_LDESC) + "\" ");
                                    t.Append(", \"SUBJECT_FDESC\": \"" + HttpUtility.HtmlAttributeEncode(subj.SUBJECT_FDESC) + "\" ");
                                    t.AppendLine("}");
                                    j++;
                                }
                            }
                            String temp = t.ToString();
                            subjectJSON.Add(item.Term + item.SessionGroup + item.Subject, temp);
                            JSON.Append(temp);
                        }
                        JSON.AppendLine("]");
                        JSON.Append(", \"NUMBER\": [ ");
                        if (numbersJSON.ContainsKey(item.Term + item.SessionGroup + item.Subject + item.ClassNumber))
                        {
                            JSON.Append(numbersJSON[item.Term + item.SessionGroup + item.Subject + item.ClassNumber]);
                        }
                        else
                        {
                            PS_SCHEDULE_WS.ClassSchedClassNumberResult theNumbers = new PS_SCHEDULE_WS.ClassSchedClassNumberResult();
                            if (subjectResults.ContainsKey(item.Term + item.SessionGroup + item.Subject))
                            {
                                theNumbers = numberResults[item.Term + item.SessionGroup + item.Subject];
                            }
                            else
                            {
                                if (!PeopleSoftDataManager.TryGetNumbers(item.Term, Decimal.Parse(item.SessionGroup), item.Subject, out theNumbers, out error))
                                {
                                    theNumbers = new PS_SCHEDULE_WS.ClassSchedClassNumberResult();
                                }
                                numberResults.Add(item.Term + item.SessionGroup + item.Subject, theNumbers);
                            }
                            StringBuilder t = new StringBuilder();
                            int j = 0;
                            for (int i = 0; i < theNumbers.ClassSchedClassNumbers.Length; i++)
                            {
                                PS_SCHEDULE_WS.ClassSchedClassNumber numb = theNumbers.ClassSchedClassNumbers[i];
                                if (numb.CLASS_NBR.Equals(item.ClassNumber, StringComparison.InvariantCultureIgnoreCase))
                                {
                                    if (j > 0)
                                    {
                                        t.Append(",");
                                    }
                                    t.Append("{\"INSTITUTION\": \"" + HttpUtility.HtmlAttributeEncode(theNumbers.INSTITUTION) + "\" ");
                                    t.Append(", \"TERM\": \"" + HttpUtility.HtmlAttributeEncode(theNumbers.TERM) + "\" ");
                                    t.Append(", \"SESSION_GROUP\": \"" + theNumbers.SESSION_GROUP + "\" ");
                                    t.Append(", \"SUBJECT_CODE\": \"" + HttpUtility.HtmlAttributeEncode(theNumbers.SUBJECT) + "\" ");
                                    t.Append(", \"CLASS_NUMBER\": \"" + HttpUtility.HtmlAttributeEncode(numb.CLASS_NBR) + "\" ");
                                    t.Append(", \"COURSE_ID\": \"" + HttpUtility.HtmlAttributeEncode(numb.COURSE_ID) + "\" ");
                                    t.Append(", \"COURSE_OFFER_NBR\": \"" + numb.COURSE_OFFER_NBR + "\" ");
                                    t.Append(", \"COURSE_TITLE_SDESC\": \"" + HttpUtility.HtmlAttributeEncode(numb.COURSE_TITLE_SDESC) + "\" ");
                                    t.Append(", \"COURSE_TITLE_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(numb.COURSE_TITLE_LDESC) + "\" ");
                                    t.Append(", \"UNITS_MIN\": \"" + numb.UNITS_MINIMUM + "\" ");
                                    t.Append(", \"UNITS_MAX\": \"" + numb.UNITS_MAXIMUM + "\" ");
                                    t.Append(", \"COURSE_DESCRIPTION\": \"" + HttpUtility.HtmlAttributeEncode(numb.ClassSchedCourseDescriptions.COURSE_DESCRIPTION) + "\" ");
                                    t.AppendLine("}");
                                    j++;
                                }
                            }
                            String temp = t.ToString();
                            numbersJSON.Add(item.Term + item.SessionGroup + item.Subject + item.ClassNumber, temp);
                            JSON.Append(temp);
                        }
                        JSON.AppendLine("]");
                        JSON.Append(", \"CLASS_SECTION\": [ ");
                        if (sectionJSON.ContainsKey(item.Term + item.SessionGroup + item.CourseID + item.CourseOfferNbr + item.ClassSection))
                        {
                            JSON.Append(sectionJSON[item.Term + item.SessionGroup + item.CourseID + item.CourseOfferNbr + item.ClassSection]);
                        }
                        else
                        {
                            PS_SCHEDULE_WS.ClassSchedClassSectionResult theSections = new PS_SCHEDULE_WS.ClassSchedClassSectionResult();
                            if (subjectResults.ContainsKey(item.Term + item.SessionGroup + item.CourseID + item.CourseOfferNbr))
                            {
                                theSections = sectionResults[item.Term + item.SessionGroup + item.CourseID + item.CourseOfferNbr];
                            }
                            else
                            {
                                if (!PeopleSoftDataManager.TryGetSections(item.Term, Decimal.Parse(item.SessionGroup), item.CourseID, Decimal.Parse(item.CourseOfferNbr), out theSections, out error))
                                {
                                    theSections = new PS_SCHEDULE_WS.ClassSchedClassSectionResult();
                                }
                                sectionResults.Add(item.Term + item.SessionGroup + item.CourseID + item.CourseOfferNbr, theSections);
                            }
                            StringBuilder t = new StringBuilder();
                            int j = 0;
                            for (int i = 0; i < theSections.ClassSchedClassSections.Length; i++)
                            {
                                PS_SCHEDULE_WS.ClassSchedClassSection sect = theSections.ClassSchedClassSections[i];
                                if (sect.CLASS_SECTION.Equals(item.ClassSection, StringComparison.InvariantCultureIgnoreCase))
                                {
                                    if (j > 0)
                                    {
                                        t.Append(",");
                                    }
                                    t.Append("{\"INSTITUTION\": \"" + HttpUtility.HtmlAttributeEncode(theSections.INSTITUTION) + "\" ");
                                    t.Append(", \"TERM\": \"" + HttpUtility.HtmlAttributeEncode(theSections.TERM) + "\" ");
                                    t.Append(", \"SESSION_GROUP\": \"" + theSections.SESSION_GROUP + "\" ");
                                    t.Append(", \"COURSE_ID\": \"" + HttpUtility.HtmlAttributeEncode(theSections.COURSE_ID) + "\" ");
                                    t.Append(", \"COURSE_OFFER_NBR\": \"" + theSections.COURSE_OFFER_NBR + "\" ");
                                    t.Append(", \"CLASS_SECTION\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_SECTION) + "\" ");
                                    t.Append(", \"CLASS_STATUS\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_STATUS) + "\" ");
                                    t.Append(", \"CLASS_STATUS_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_STATUS_LDESC) + "\" ");
                                    t.Append(", \"CLASS_TYPE\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_TYPE) + "\" ");
                                    t.Append(", \"CLASS_TYPE_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_TYPE_LDESC) + "\" ");
                                    t.Append(", \"ASSOCIATED_CLASS\": \"" + sect.ASSOCIATED_CLASS + "\" ");
                                    t.Append(", \"REGISTRATION_NBR\": \"" + sect.REGISTRATION_NBR + "\" ");
                                    t.Append(", \"CLASS_COMPONENT\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_COMPONENT) + "\" ");
                                    t.Append(", \"CLASS_COMPONENT_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(sect.CLASS_COMPONENT_LDESC) + "\" ");
                                    t.Append(", \"ENRL_STATUS\": \"" + HttpUtility.HtmlAttributeEncode(sect.ENRL_STATUS) + "\" ");
                                    t.Append(", \"ENRL_STATUS_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(sect.ENRL_STATUS_LDESC) + "\" ");
                                    t.Append(", \"ENRL_TOTAL\": \"" + sect.ENRL_TOTAL + "\" ");
                                    t.Append(", \"ENRL_CAPACITY\": \"" + sect.ENRL_CAPACITY + "\" ");
                                    t.Append(", \"AUTO_ENRL_WAITLIST\": \"" + HttpUtility.HtmlAttributeEncode(sect.AUTO_ENRL_WAITLIST) + "\" ");
                                    t.Append(", \"WAITLIST_DAEMON\": \"" + HttpUtility.HtmlAttributeEncode(sect.WAITLIST_DAEMON) + "\" ");
                                    t.Append(", \"WAITLIST_TOTAL\": \"" + sect.WAITLIST_TOTAL + "\" ");
                                    t.Append(", \"WAITLIST_CAPACTIY\": \"" + sect.WAITLIST_CAPACITY + "\" ");
                                    t.AppendLine(", \"MEETING_PATTERNS\": [");
                                    int curPat = 0;
                                    foreach (PS_SCHEDULE_WS.ClassSchedMeetingPattern pat in sect.ClassSchedMeetingPatterns)
                                    {
                                        if (curPat > 0)
                                        {
                                            t.Append(",");
                                        }
                                        t.Append("{ \"CLASS_MTG_NBR\": \"" + pat.CLASS_MTG_NBR + "\" ");
                                        t.Append(", \"BUILDING\": \"" + HttpUtility.HtmlAttributeEncode(pat.BUILDING) + "\" ");
                                        t.Append(", \"ROOM\": \"" + HttpUtility.HtmlAttributeEncode(pat.ROOM) + "\" ");
                                        t.Append(", \"MEETING_DATE_START\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_DATE_START.ToString("yyyy-MM-dd")) + "\" ");
                                        t.Append(", \"MEETING_DATE_START_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_DATE_START_LDESC) + "\" ");
                                        t.Append(", \"MEETING_DATE_END\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_DATE_END.ToString("yyyy-MM-dd")) + "\" ");
                                        t.Append(", \"MEETING_DATE_END_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_DATE_END_LDESC) + "\" ");
                                        t.Append(", \"MEETING_TIME_START\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_TIME_START) + "\" ");
                                        t.Append(", \"MEETING_TIME_END\": \"" + HttpUtility.HtmlAttributeEncode(pat.MEETING_TIME_END) + "\" ");
                                        t.Append(", \"STND_MTG_PAT\": \"" + HttpUtility.HtmlAttributeEncode(pat.STND_MTG_PAT) + "\" ");
                                        t.AppendLine(", \"INSTRUCTORS\": [");
                                        int curInst = 0;
                                        foreach (PS_SCHEDULE_WS.ClassSchedInstructor inst in pat.ClassSchedInstructors)
                                        {
                                            if (curInst > 0)
                                            {
                                                t.Append(",");
                                            }
                                            t.Append("{ \"INSTR_ASSIGN_SEQ\": \"" + inst.INSTR_ASSIGN_SEQ + "\" ");
                                            t.Append(", \"NAME_DISPLAY\": \"" + HttpUtility.HtmlAttributeEncode(inst.NAME_DISPLAY) + "\" ");
                                            t.Append(", \"LAST_NAME\": \"" + HttpUtility.HtmlAttributeEncode(inst.LAST_NAME) + "\" ");
                                            t.Append(", \"FIRST_NAME\": \"" + HttpUtility.HtmlAttributeEncode(inst.FIRST_NAME) + "\" ");
                                            t.AppendLine("}");
                                            curInst++;
                                        }//finish all instructors in this pattern
                                        t.AppendLine("] }");
                                        curPat++;
                                    }// finish all Meeting Patterns
                                    t.AppendLine("]");
                                    t.Append(", \"CLASS_ATTRIBUTES\": [");
                                    int curAttr = 0;
                                    foreach (PS_SCHEDULE_WS.ClassSchedClassAttribute attr in sect.ClassSchedClassAttributes)
                                    {
                                        if (curAttr > 0)
                                        {
                                            t.Append(",");
                                        }
                                        t.Append("{ \"COURSE_ATTR\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR) + "\" ");
                                        t.Append(", \"COURSE_ATTR_SDESC\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR_SDESC) + "\" ");
                                        t.Append(", \"COURSE_ATTR_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR_LDESC) + "\" ");
                                        t.Append(", \"COURSE_ATTR_VALUE\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR_VALUE) + "\" ");
                                        t.Append(", \"COURSE_ATTR_VALUE_LDESC\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR_VALUE_LDESC) + "\" ");
                                        t.Append(", \"COURSE_ATTR_VALUE_FDESC\": \"" + HttpUtility.HtmlAttributeEncode(attr.COURSE_ATTR_VALUE_FDESC) + "\" ");
                                        t.AppendLine("}");
                                        curAttr++;
                                    }
                                    t.AppendLine("]");

                                    t.Append(", \"CLASS_NOTES\": [");
                                    int curNote = 0;
                                    foreach (PS_SCHEDULE_WS.ClassSchedClassNote nte in sect.ClassSchedClassNotes)
                                    {
                                        if (curNote > 0)
                                        {
                                            t.Append(",");
                                        }
                                        t.Append("{ \"CLASS_NOTE_SEQ\": \"" + nte.CLASS_NOTES_SEQ + "\" ");
                                        t.Append(", \"COURSE_NOTE\": \"" + HttpUtility.HtmlAttributeEncode(nte.CLASS_NOTE) + "\" ");
                                        t.AppendLine("}");
                                        curNote++;
                                    }
                                    t.AppendLine("]");

                                    t.Append(", \"CLASS_TEXTBOOKS\": [");
                                    int curTxtBk = 0;
                                    foreach (PS_SCHEDULE_WS.ClassScheduleClassTextbook txtbk in sect.ClassSchedClassTextbooks)
                                    {
                                        if (curTxtBk > 0)
                                        {
                                            JSON.Append(",");
                                        }
                                        t.Append("{ \"TEXTBOOK_SEQ\": \"" + txtbk.SSR_CRSEMAT_SEQ + "\" ");
                                        t.Append(", \"TEXTBOOK_TYPE\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_CRSEMAT_TYPE) + "\" ");
                                        t.Append(", \"TEXTBOOK_STATUS\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_STATUS) + "\" ");
                                        t.Append(", \"TEXTBOOK_ISBN\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_ISBN) + "\" ");
                                        t.Append(", \"TEXTBOOK_TITLE\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_TITLE) + "\" ");
                                        t.Append(", \"TEXTBOOK_AUTHOR\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_AUTHOR) + "\" ");
                                        t.Append(", \"TEXTBOOK_EDITION\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_EDITION) + "\" ");
                                        t.Append(", \"TEXTBOOK_PUBYEAR\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_PUBYEAR) + "\" ");
                                        t.Append(", \"TEXTBOOK_PUBLISH\": \"" + HttpUtility.HtmlAttributeEncode(txtbk.SSR_TXBDTL_PUBLISH) + "\" ");
                                        t.Append(", \"TEXTBOOK_PRICE\": \"" + txtbk.SSR_TXBDTL_PRICE + "\" ");
                                        t.Append(", \"TEXTBOOK_CURRENCY\": \"" + txtbk.CURRENCY_CD + "\" ");
                                        t.Append(", \"TEXTBOOK_NOTES\": \"" + txtbk.SSR_TXBDTL_NOTES + "\" ");
                                        t.AppendLine("}");
                                        curTxtBk++;
                                    }
                                    t.AppendLine("]");

                                    t.AppendLine("}");
                                    j++;
                                }
                            }
                            String temp = t.ToString();
                            sectionJSON.Add(item.Term + item.SessionGroup + item.CourseID + item.CourseOfferNbr + item.ClassSection, temp);
                            JSON.Append(temp);
                        }
                        JSON.AppendLine("]");//end class section
                        JSON.AppendLine("}");//end cart item
                    }
                    JSON.Append("]");// end shopping cart
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
            else
            {
                context.Response.ContentType = "text/plain";
                context.Response.Write("[]");
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