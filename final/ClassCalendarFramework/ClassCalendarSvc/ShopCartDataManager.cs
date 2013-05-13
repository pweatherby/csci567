using System;
using System.Collections.Generic;
using System.Data;
using edu.csu.chico.enr.DataAbstractionLayer;
using noble.coder.pweatherby.ClassCalendarSvc.ShopCart;

namespace noble.coder.pweatherby.ClassCalendarSvc
{
    // This Functionality should eventually migrate into PeopleSoftDataManager,
    // but the PS project wont be approved before presentation...so creating dummy cart in rdsdb
    public class ShopCartDataManager
    {
        internal static Boolean TryGetCart(String Emplid, out List<ShopCartItem> result, out Exception error)
        {
            result = new List<ShopCartItem>();
            error = null;
            try
            {
                using (DataWorker dw = DataWorkerFactory.CreateDataWorker("RDSDB"))
                {
                    IDataParameter[] args = new IDataParameter[]{
                        dw.NewParameter("EMPLID", Emplid)
                    };
                    DataTable dt = dw.ExecuteDataTable("PWEATHERBY.SHOP_CART.GetCart", CommandType.StoredProcedure, ref args);
                    foreach (DataRow dr in dt.Rows)
                    {
                        ShopCartItem item = new ShopCartItem();
                        item.Term = Convert.ToString(dr["TERM"]);
                        item.SessionGroup = Convert.ToString(dr["SESSION_GROUP"]);
                        item.CourseID = Convert.ToString(dr["COURSE_ID"]);
                        item.CourseOfferNbr = Convert.ToString(dr["COURSE_OFFER_NBR"]);
                        item.ClassSection = Convert.ToString(dr["CLASS_SECTION"]);
                        item.RegistrationNbr = Convert.ToString(dr["REGISTRATION_NBR"]);
                        result.Add(item);
                    }
                    return true;
                }
            }
            catch (Exception e)
            {
                error = e;
            }
            return false;
        }

        internal static bool TryAddItem(String Emplid,
                                        String requestedTerm,
                                        Int32 requestedSessionGroup,
                                        String requestedCrsID,
                                        Int32 requestedCrsOffrNbr,
                                        String requestedSection,
                                        String requestedRegNbr,
                                        out Exception error)
        {
            error = null;
            try
            {
                using (DataWorker dw = DataWorkerFactory.CreateDataWorker("RDSDB"))
                {
                    IDataParameter[] args = new IDataParameter[]{
                        dw.NewParameter("EMPLID", Emplid),
                        dw.NewParameter("TERM", requestedTerm),
                        dw.NewParameter("SESGRP", requestedSessionGroup),
                        dw.NewParameter("CRSID", requestedCrsID),
                        dw.NewParameter("CRSOFR", requestedCrsOffrNbr),
                        dw.NewParameter("SECT", requestedSection),
                        dw.NewParameter("REGNBR", requestedRegNbr)
                    };
                    int rowsAffected = dw.ExecuteNonQuery("PWEATHERBY.SHOP_CART.AddItem", CommandType.StoredProcedure, ref args);
                    if (rowsAffected > 0)
                    {
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
        internal static bool TryRemoveItem(String Emplid,
                                           String requestedTerm,
                                           Int32 requestedSessionGroup,
                                           String requestedCrsID,
                                           Int32 requestedCrsOffrNbr,
                                           String requestedSection,
                                           String requestedRegNbr,
                                           out Exception error)
        {
            error = null;
            try
            {
                using (DataWorker dw = DataWorkerFactory.CreateDataWorker("RDSDB"))
                {
                    IDataParameter[] args = new IDataParameter[]{
                        dw.NewParameter("EMPLID", Emplid),
                        dw.NewParameter("TERM", requestedTerm),
                        dw.NewParameter("SESGRP", requestedSessionGroup),
                        dw.NewParameter("CRSID", requestedCrsID),
                        dw.NewParameter("CRSOFR", requestedCrsOffrNbr),
                        dw.NewParameter("SECT", requestedSection),
                        dw.NewParameter("REGNBR", requestedRegNbr)
                    };
                    int rowsAffected = dw.ExecuteNonQuery("PWEATHERBY.SHOP_CART.RemoveItem", CommandType.StoredProcedure, ref args);
                    if (rowsAffected > 0)
                    {
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