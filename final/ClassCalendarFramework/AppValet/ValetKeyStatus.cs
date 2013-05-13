using System.Runtime.Serialization;

namespace noble.coder.pweatherby.AppValet
{
    [DataContract]
    public enum ValetKeyStatus: int
    {
        [EnumMember]
        Unknown = 0,
        [EnumMember]
        Active = 1,
        [EnumMember]
        Inactive = 2,
        [EnumMember]
        Blocked = 4
    }
}