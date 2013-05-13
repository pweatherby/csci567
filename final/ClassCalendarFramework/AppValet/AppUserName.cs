using System;
using System.Runtime.Serialization;

namespace noble.coder.pweatherby.AppValet
{
    [DataContract]
    public class AppUserName
    {
        public String FirstName = String.Empty;
        public String LastName = String.Empty;
    }
}