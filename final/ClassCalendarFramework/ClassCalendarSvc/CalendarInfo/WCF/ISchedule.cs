using System.ServiceModel;

namespace noble.coder.pweatherby.ClassCalendarSvc.CalendarInfo.WCF
{
    [ServiceContract]
    public interface ISchedule
    {
        [OperationContract]
        void DoWork();
    }
}
