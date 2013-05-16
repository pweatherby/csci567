using System;
using System.Web;

namespace noble.coder.pweatherby.ClassCalendarSvc.ShopCart.JSON
{
    /// <summary>
    /// Summary description for RemoveItem
    /// </summary>
    public class RemoveItem : IHttpHandler
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
            Emplid = "003883361";
            if (!String.IsNullOrWhiteSpace(Emplid))
            {
                String requestedTerm = context.Request["term"];
                if (String.IsNullOrWhiteSpace(requestedTerm) || !System.Text.RegularExpressions.Regex.IsMatch(requestedTerm, "[0-9]{4}"))
                {
                    context.Response.Clear();
                    context.Response.StatusCode = 400;// Bad Request
                    context.Response.Write("Invalid term format.");
                    return;
                }

                String requestedSessionGroup = context.Request["session_group"];
                Int32 reqSessGrpInt = 0;
                if (String.IsNullOrWhiteSpace(requestedSessionGroup) ||
                   !System.Text.RegularExpressions.Regex.IsMatch(requestedSessionGroup, "[0-9]{1,10}") ||
                   !Int32.TryParse(requestedSessionGroup, out reqSessGrpInt))
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
                Int32 reqCrsOffrInt = 0;
                if (String.IsNullOrWhiteSpace(requestedCrsOffrNbr) ||
                    !System.Text.RegularExpressions.Regex.IsMatch(requestedCrsOffrNbr, "[0-9]{1,10}") ||
                    !Int32.TryParse(requestedCrsOffrNbr, out reqCrsOffrInt))
                {
                    context.Response.Clear();
                    context.Response.StatusCode = 400;// Bad Request
                    context.Response.Write("Invalid Course Offer Number format.");
                    return;
                }

                String requestedSubject = context.Request["subject"];
                if (String.IsNullOrWhiteSpace(requestedSubject) ||
                    !System.Text.RegularExpressions.Regex.IsMatch(requestedSubject, "[a-zA-Z]{4}"))
                {
                    context.Response.Clear();
                    context.Response.StatusCode = 400;// Bad Request
                    context.Response.Write("Invalid subject format.");
                    return;
                }

                String requestedNumber = context.Request["number"];
                if (String.IsNullOrWhiteSpace(requestedNumber) ||
                    !System.Text.RegularExpressions.Regex.IsMatch(requestedNumber, "[a-zA-Z0-9]{3,8}"))
                {
                    context.Response.Clear();
                    context.Response.StatusCode = 400;// Bad Request
                    context.Response.Write("Invalid class number format.");
                    return;
                }

                String requestedSection = context.Request["section"];
                if (String.IsNullOrWhiteSpace(requestedSection) ||
                    !System.Text.RegularExpressions.Regex.IsMatch(requestedSection, "[0-9]{1,3}"))
                {
                    context.Response.Clear();
                    context.Response.StatusCode = 400;// Bad Request
                    context.Response.Write("Invalid Class Section format.");
                    return;
                }

                String requestedRegNbr = context.Request["reg_nbr"];
                if (String.IsNullOrWhiteSpace(requestedCrsOffrNbr) ||
                    !System.Text.RegularExpressions.Regex.IsMatch(requestedCrsOffrNbr, "[0-9]{1,5}"))
                {
                    context.Response.Clear();
                    context.Response.StatusCode = 400;// Bad Request
                    context.Response.Write("Invalid Class Section format.");
                    return;
                }

                Exception error = new Exception();
                if (ShopCartDataManager.TryRemoveItem(Emplid,
                                                      requestedTerm,
                                                      reqSessGrpInt,
                                                      requestedCrsID,
                                                      reqCrsOffrInt,
                                                      requestedSubject,
                                                      requestedNumber,
                                                      requestedSection,
                                                      requestedRegNbr,
                                                      out error))
                {
                    context.Response.ContentType = "application/json";
                    context.Response.Write("[{\"RESULT\":\"SUCCESS\"}]");
                }
                else
                {
#if DEBUG
                    context.Response.ContentType = "text/plain";
                    context.Response.Write(error.ToString());
#endif
                }
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