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
                Exception error = new Exception();
                if (ShopCartDataManager.TryGetCart(Emplid, out result, out error) && result != null)
                {
                    StringBuilder JSON = new StringBuilder();
                    JSON.AppendLine("[");
                    for (int i = 0; i < result.Count; i++)
                    {
                        ShopCartItem item = result.ElementAt(i);
                        if (i > 0)
                        {
                            JSON.AppendLine(", ");
                        }
                        JSON.Append("{ \"TERM\": \"" + HttpUtility.HtmlAttributeEncode(item.Term) + "\" ");
                        JSON.Append(", \"SESSION_GROUP\": \"" + HttpUtility.HtmlAttributeEncode(item.SessionGroup) + "\" ");
                        JSON.Append(", \"COURSE_ID\": \"" + HttpUtility.HtmlAttributeEncode(item.CourseID) + "\" ");
                        JSON.Append(", \"COURSE_OFFER_NBR\": \"" + HttpUtility.HtmlAttributeEncode(item.CourseOfferNbr) + "\" ");
                        JSON.Append(", \"CLASS_SECTION\": \"" + HttpUtility.HtmlAttributeEncode(item.ClassSection) + "\" ");
                        JSON.AppendLine(", \"REGISTRATION_NBR\": \"" + HttpUtility.HtmlAttributeEncode(item.RegistrationNbr) + "\" }");
                    }
                    JSON.Append("]");
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