using System;
using System.Data;
using edu.csu.chico.enr.DataAbstractionLayer;

namespace noble.coder.pweatherby.AppValet
{
    public class ValetStand
    {
        public static AppUserName GetUserName(String DeviceID, String ValetKey)
        {
            using (DataWorker dw = DataWorkerFactory.CreateDataWorker("RDSDB"))
            {
                IDataParameter[] args = new IDataParameter[]{
                    dw.NewParameter("DEVICE", DeviceID),
                    dw.NewParameter("KEY", ValetKey)
                };
                DataTable dt = dw.ExecuteDataTable("PWEATHERBY.VALET_STAND.GetUserName", CommandType.StoredProcedure, ref args);
                if (dt.Rows.Count > 0)
                {
                    AppUserName stats = new AppUserName();
                    stats.FirstName = Convert.ToString(dt.Rows[0]["FIRST_NAME"]);
                    stats.LastName = Convert.ToString(dt.Rows[0]["LAST_NAME"]);
                    return stats;
                }
            }
            return null;
        }

        public static String GetUserID(String DeviceID, String ValetKey)
        {
            using (DataWorker dw = DataWorkerFactory.CreateDataWorker("RDSDB"))
            {
                IDataParameter[] args = new IDataParameter[]{
                    dw.NewParameter("DEVICE", DeviceID),
                    dw.NewParameter("KEY", ValetKey)
                };
                DataTable dt = dw.ExecuteDataTable("PWEATHERBY.VALET_STAND.GetUserID", CommandType.StoredProcedure, ref args);
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToString(dt.Rows[0]["EMPLID"]);
                }
            }
            return String.Empty;
        }


        public static ValetKeyStatus GetKeyStatus(String DeviceID, String ValetKey)
        {
            using (DataWorker dw = DataWorkerFactory.CreateDataWorker("RDSDB"))
            {
                IDataParameter[] args = new IDataParameter[]{
                    dw.NewParameter("DEVICE", DeviceID),
                    dw.NewParameter("KEY", ValetKey)
                };
                DataTable dt = dw.ExecuteDataTable("PWEATHERBY.VALET_STAND.GetKeyStatus", CommandType.StoredProcedure, ref args);
                if (dt.Rows.Count > 0)
                {
                    String dbStat = Convert.ToString(dt.Rows[0]["KEY_STATUS"]);
                    return dbStat.ToValetKeyStatus();
                }
            }
            return ValetKeyStatus.Unknown;
        }
    }
}