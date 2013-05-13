using System;
using System.Data;
using edu.csu.chico.enr.DataAbstractionLayer;

namespace noble.coder.pweatherby.AppValet
{
    public class ValetOffice
    {
        public static void UpdateApp(String AppID, String AppName)
        {
            using (DataWorker dw = DataWorkerFactory.CreateDataWorker("RDSDB"))
            {
                IDataParameter[] args = new IDataParameter[]{
                    dw.NewParameter("APP_NAME", AppName),
                    dw.NewParameter("VALET_APP", AppID)
                };
                dw.ExecuteNonQuery("PWEATHERBY.VALET_OFFICE.UpdateApp", CommandType.StoredProcedure, ref args);
            }
        }

        public static String GenerateNewAppDeviceKey(String AppID, String Portal, String Device)
        {
            String result = Guid.NewGuid().ToString("D");// 36 characters (Hyphenated e.g. 12345678-1234-1234-1234-123456789abc)
            using (DataWorker dw = DataWorkerFactory.CreateDataWorker("RDSDB"))
            {
                IDataParameter[] args = new IDataParameter[]{
                    dw.NewParameter("VALET_APP", AppID),
                    dw.NewParameter("PORTAL", Portal),
                    dw.NewParameter("DEVICE", Device),
                    dw.NewParameter("KEY", result)
                };
                dw.ExecuteNonQuery("PWEATHERBY.VALET_OFFICE.UpdateAppDeviceKey", CommandType.StoredProcedure, ref args);
            }
            return result;
        }
    }
}