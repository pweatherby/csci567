create or replace package VALET_OFFICE is

  -- Author  : PWEATHERBY
  -- Created : 5/7/2013 3:02:13 PM
  -- Purpose : Admin Section
  
  PROCEDURE UpdateApp(APP_NAME  in varchar2,
                      VALET_APP in varchar2);
  
  PROCEDURE UpdateAppDeviceKey(VALET_APP in varchar2,
                               PORTAL    in varchar2,
                               DEVICE    in varchar2,
                               KEY       in varchar2);


end VALET_OFFICE;
/
create or replace package body VALET_OFFICE is

  PROCEDURE UpdateApp(APP_NAME  in varchar2,
                      VALET_APP in varchar2) IS
   v_APP varchar2(36 CHAR) := VALET_APP;
   v_NME varchar2(100 CHAR) := APP_NAME;
  BEGIN
    UPDATE VALET_APP v
       SET v.APP_NAME = v_NME
     WHERE v.valet_app_id = v_APP;
    MERGE INTO VALET_APP v
          USING DUAL
          ON (v.APP_NAME = v_APP)
    WHEN MATCHED THEN
         UPDATE SET v.valet_app_id = v_APP
    WHEN NOT MATCHED THEN
         INSERT (v.valet_app_id, v.app_name)
         VALUES (v_APP, v_NME);
          
  END UpdateApp;
    

  PROCEDURE UpdateAppDeviceKey(VALET_APP in varchar2,
                               PORTAL    in varchar2,
                               DEVICE    in varchar2,
                               KEY       in varchar2) IS
   v_APP varchar2(36 CHAR) := VALET_APP;
   v_USR varchar2(30 CHAR) := PORTAL;
   v_DVC varchar2(37 CHAR) := DEVICE;
   v_KEY varchar2(36 CHAR) := KEY;
  BEGIN
    MERGE INTO VALET_APP_DEVICE d
          USING DUAL
          ON (d.VALET_APP_ID = v_APP AND
              d.PORTALID     = v_USR AND
              d.DEVICE_UID   = v_DVC)
    WHEN MATCHED THEN
         UPDATE SET d.valet_key = v_KEY,
                d.Created_Dt = CURRENT_TIMESTAMP(6),
                d.last_access_dt = CURRENT_TIMESTAMP(6),
                d.usage = 0
    WHEN NOT MATCHED THEN
         INSERT (d.valet_app_id, d.device_uid, d.portalid, d.valet_key, d.key_status,         d.created_dt,     d.last_access_dt, d.usage)
         VALUES (         v_APP,        v_DVC,      v_USR,       v_KEY,          'A', CURRENT_TIMESTAMP(6), CURRENT_TIMESTAMP(6), 0);
  END UpdateAppDeviceKey;


end VALET_OFFICE;
/
