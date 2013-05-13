using System;
using noble.coder.pweatherby.AppValet;

namespace noble.coder.pweatherby.AppValetWeb.Stand
{
    public class Attendant : IAttendant
    {
        public AppUserName GetUserName(String DeviceID, String ValetKey)
        {
            AppUserName result = ValetStand.GetUserName(DeviceID, ValetKey);
            if (result != null)
            {
                return result;
            }
            System.Threading.Thread.Sleep(2500);
            return null;
        }

        public String GetUserID(String DeviceID, String ValetKey)
        {
            String result = ValetStand.GetUserID(DeviceID, ValetKey);
            if (!String.IsNullOrWhiteSpace(result))
            {
                return result;
            }
            System.Threading.Thread.Sleep(2500);
            return String.Empty;
        }


        public ValetKeyStatus GetKeyStatus(String DeviceID, String ValetKey)
        {
            ValetKeyStatus result = ValetStand.GetKeyStatus(DeviceID, ValetKey);
            if (result != ValetKeyStatus.Unknown)
            {
                return result;
            }
            System.Threading.Thread.Sleep(2500);
            return ValetKeyStatus.Unknown;
        }
    }
}
