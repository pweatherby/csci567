using System;
using System.ServiceModel;
using noble.coder.pweatherby.AppValet;

namespace noble.coder.pweatherby.AppValetWeb.Stand
{
    [ServiceContract]
    public interface IAttendant
    {
        [OperationContract]
        AppUserName GetUserName(String DeviceID, String ValetKey);

        [OperationContract]
        String GetUserID(String DeviceID, String ValetKey);

        [OperationContract]
        ValetKeyStatus GetKeyStatus(String DeviceID, String ValetKey);
    }
}
