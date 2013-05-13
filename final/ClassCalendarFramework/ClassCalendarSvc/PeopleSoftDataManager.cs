using System;

using wsseUserTokenBehavior;

namespace noble.coder.pweatherby.ClassCalendarSvc
{
    public class PeopleSoftDataManager
    {
        public static Boolean TryGetTerms(out PS_SCHEDULE_WS.ClassSchedTermResult result, out Exception error)
        {
            error = null;
            result = null;
            try
            {
                String _usr = System.Configuration.ConfigurationManager.AppSettings["WS_USR"];
                String _pwd = System.Configuration.ConfigurationManager.AppSettings[_usr];
                using (PS_SCHEDULE_WS.CHI_SR_CLASS_SCHED_PortTypeClient client = new PS_SCHEDULE_WS.CHI_SR_CLASS_SCHED_PortTypeClient())
                {
                    client.Endpoint.Behaviors.Add(new InspectorBehavior(new ClientInspector(new SecurityHeader(_usr, _pwd))));
                    client.Open();
                    PS_SCHEDULE_WS.TERMS_REQUEST request = new PS_SCHEDULE_WS.TERMS_REQUEST();
                    PS_SCHEDULE_WS.ClassSchedTermResults results = client.CHI_SR_CLASS_SCHED_TERMS(request);
                    if (results != null)
                    {
                        result = results.ClassSchedTermResult;
                        return true;
                    }
                }
            }
            catch(Exception e)
            {
                error = e;
            }
            return false;
        }

        public static Boolean TryGetSessionGroups(String TermCode, out PS_SCHEDULE_WS.ClassSchedSessionGroupResult result, out Exception error)
        {
            error = null;
            result = null;
            try
            {
                String _usr = System.Configuration.ConfigurationManager.AppSettings["WS_USR"];
                String _pwd = System.Configuration.ConfigurationManager.AppSettings[_usr];
                using (PS_SCHEDULE_WS.CHI_SR_CLASS_SCHED_PortTypeClient client = new PS_SCHEDULE_WS.CHI_SR_CLASS_SCHED_PortTypeClient())
                {
                    client.Endpoint.Behaviors.Add(new InspectorBehavior(new ClientInspector(new SecurityHeader(_usr, _pwd))));
                    client.Open();
                    PS_SCHEDULE_WS.SESSIONGROUPS_REQUEST request = new PS_SCHEDULE_WS.SESSIONGROUPS_REQUEST();
                    request.INSTITUTION = "CHICO";
                    request.TERM = TermCode;
                    PS_SCHEDULE_WS.ClassSchedSessionGroupResults results = client.CHI_SR_CLASS_SCHED_SESSIONS(request);
                    if (results != null)
                    {
                        result = results.ClassSchedSessionGroupResult;
                        return true;
                    }
                }
            }
            catch (Exception e)
            {
                error = e;
            }
            return false;
        }

        public static Boolean TryGetSubjects(String TermCode, Decimal SessGrpCode, out PS_SCHEDULE_WS.ClassSchedSubjResult result, out Exception error)
        {
            error = null;
            result = null;
            try
            {
                String _usr = System.Configuration.ConfigurationManager.AppSettings["WS_USR"];
                String _pwd = System.Configuration.ConfigurationManager.AppSettings[_usr];
                using (PS_SCHEDULE_WS.CHI_SR_CLASS_SCHED_PortTypeClient client = new PS_SCHEDULE_WS.CHI_SR_CLASS_SCHED_PortTypeClient())
                {
                    client.Endpoint.Behaviors.Add(new InspectorBehavior(new ClientInspector(new SecurityHeader(_usr, _pwd))));
                    client.Open();
                    PS_SCHEDULE_WS.SUBJECTS_REQUEST request = new PS_SCHEDULE_WS.SUBJECTS_REQUEST();
                    request.INSTITUTION = "CHICO";
                    request.TERM = TermCode;
                    request.SESSION_GROUP = SessGrpCode;
                    PS_SCHEDULE_WS.ClassSchedSubjResults results = client.CHI_SR_CLASS_SCHED_SUBJECTS(request);
                    if (results != null)
                    {
                        result = results.ClassSchedSubjResult;
                        return true;
                    }
                }
            }
            catch (Exception e)
            {
                error = e;
            }
            return false;
        }

        public static Boolean TryGetNumbers(String TermCode, Decimal SessGrpCode, String SubjectCode, out PS_SCHEDULE_WS.ClassSchedClassNumberResult result, out Exception error)
        {
            error = null;
            result = null;
            try
            {
                String _usr = System.Configuration.ConfigurationManager.AppSettings["WS_USR"];
                String _pwd = System.Configuration.ConfigurationManager.AppSettings[_usr];
                using (PS_SCHEDULE_WS.CHI_SR_CLASS_SCHED_PortTypeClient client = new PS_SCHEDULE_WS.CHI_SR_CLASS_SCHED_PortTypeClient())
                {
                    client.Endpoint.Behaviors.Add(new InspectorBehavior(new ClientInspector(new SecurityHeader(_usr, _pwd))));
                    client.Open();
                    PS_SCHEDULE_WS.NUMBERS_REQUEST request = new PS_SCHEDULE_WS.NUMBERS_REQUEST();
                    request.INSTITUTION = "CHICO";
                    request.TERM = TermCode;
                    request.SESSION_GROUP = SessGrpCode;
                    request.SUBJECT = SubjectCode;
                    PS_SCHEDULE_WS.ClassSchedClassNumberResults results = client.CHI_SR_CLASS_SCHED_NUMBERS(request);
                    if (results != null)
                    {
                        result = results.ClassSchedClassNumberResult;
                        return true;
                    }
                }
            }
            catch (Exception e)
            {
                error = e;
            }
            return false;
        }

        public static Boolean TryGetSections(String TermCode, Decimal SessGrpCode, String CourseID, Decimal CourseOfferNumber, out PS_SCHEDULE_WS.ClassSchedClassSectionResult result, out Exception error)
        {
            error = null;
            result = null;
            try
            {
                String _usr = System.Configuration.ConfigurationManager.AppSettings["WS_USR"];
                String _pwd = System.Configuration.ConfigurationManager.AppSettings[_usr];
                using (PS_SCHEDULE_WS.CHI_SR_CLASS_SCHED_PortTypeClient client = new PS_SCHEDULE_WS.CHI_SR_CLASS_SCHED_PortTypeClient())
                {
                    client.Endpoint.Behaviors.Add(new InspectorBehavior(new ClientInspector(new SecurityHeader(_usr, _pwd))));
                    client.Open();
                    PS_SCHEDULE_WS.SECTIONS_REQUEST request = new PS_SCHEDULE_WS.SECTIONS_REQUEST();
                    request.INSTITUTION = "CHICO";
                    request.TERM = TermCode;
                    request.SESSION_GROUP = SessGrpCode;
                    request.COURSE_ID = CourseID;
                    request.COURSE_OFFER_NBR = CourseOfferNumber;
                    PS_SCHEDULE_WS.ClassSchedClassSectionResults results = client.CHI_SR_CLASS_SCHED_SECTIONS(request);
                    if (results != null)
                    {
                        result = results.ClassSchedClassSectionResult;
                        return true;
                    }
                }
            }
            catch (Exception e)
            {
                error = e;
            }
            return false;
        }
    }
}