create or replace package VALET_STAND is

  -- Author  : PWEATHERBY
  -- Created : 5/7/2013 2:16:38 PM
  -- Purpose : to provide users a way to grant apps limited access to thier accounts
  
  TYPE t_UserName_rec IS RECORD (
    FIRST_NAME VARCHAR2(30),
    LAST_NAME VARCHAR2(30)
   );
  TYPE t_UserName_cursor is REF CURSOR RETURN t_UserName_rec;

  PROCEDURE GetUserName(DEVICE in varchar2,
                        KEY    in varchar2,
                     io_cursor in out t_UserName_cursor);


  TYPE t_UserID_rec IS RECORD (
    EMPLID VARCHAR2(13)
   );
  TYPE t_UserID_cursor is REF CURSOR RETURN t_UserID_rec;

  PROCEDURE GetUserID(DEVICE in varchar2,
                      KEY    in varchar2,
                   io_cursor in out t_UserID_cursor);

  TYPE t_KeyStat_rec IS RECORD (
    STATUS CHAR(1)
   );
  TYPE t_KeyStat_cursor is REF CURSOR RETURN t_KeyStat_rec;
                   
  PROCEDURE GetKeyStatus(DEVICE in varchar2,
                         KEY    in varchar2,
                      io_cursor in out t_KeyStat_cursor);
end VALET_STAND;
/
create or replace package body VALET_STAND is

  PROCEDURE GetUserName(DEVICE in varchar2,
                        KEY    in varchar2,
                     io_cursor in out t_UserName_cursor) IS
   v_DVC varchar2(37 CHAR) := DEVICE;
   v_KEY varchar2(36 CHAR) := KEY;
   v_cursor t_UserName_cursor;
  BEGIN
    OPEN v_CURSOR FOR
    SELECT p.first_name_primary,
           p.last_name_primary
      FROM VALET_APP_DEVICE d
      JOIN CSUC.PORTALID_XWALK W
        ON (d.portalid = w.emplid)
      JOIN RDSPRD.CC_PERSONAL_DATA_DTL p
        ON (w.emplid = p.emplid)
     WHERE d.device_uid = v_DVC
       AND d.valet_key = v_KEY
       AND d.key_status = 'A';
    io_cursor := v_cursor;
    UPDATE VALET_APP_DEVICE
       SET LAST_ACCESS_DT = CURRENT_TIMESTAMP(6),
           USAGE = USAGE + 1
     WHERE DEVICE_UID = v_DVC
       AND VALET_KEY = v_KEY;
  END GetUserName;


  PROCEDURE GetUserID(DEVICE in varchar2,
                      KEY    in varchar2,
                   io_cursor in out t_UserID_cursor) IS
   v_DVC varchar2(37 CHAR) := DEVICE;
   v_KEY varchar2(36 CHAR) := KEY;
   v_cursor t_UserID_cursor;
  BEGIN
    OPEN v_CURSOR FOR
    SELECT w.emplid
      FROM VALET_APP_DEVICE d
      JOIN CSUC.PORTALID_XWALK W
        ON (d.portalid = w.user_id)
     WHERE d.device_uid = v_DVC
       AND d.valet_key = v_KEY
       AND d.key_status = 'A';
    io_cursor := v_cursor;
    UPDATE VALET_APP_DEVICE
       SET LAST_ACCESS_DT = CURRENT_TIMESTAMP(6),
           USAGE = USAGE + 1
     WHERE DEVICE_UID = v_DVC
       AND VALET_KEY = v_KEY;
  END GetUserID;
  
  
  PROCEDURE GetKeyStatus(DEVICE in varchar2,
                         KEY    in varchar2,
                      io_cursor in out t_KeyStat_cursor) IS
   v_DVC varchar2(37 CHAR) := DEVICE;
   v_KEY varchar2(36 CHAR) := KEY;
   v_cursor t_KeyStat_cursor;
  BEGIN
    OPEN v_CURSOR FOR
    SELECT d.key_status
      FROM VALET_APP_DEVICE d
     WHERE d.device_uid = v_DVC
       AND d.valet_key = v_KEY;
    io_cursor := v_cursor;
    UPDATE VALET_APP_DEVICE
       SET LAST_ACCESS_DT = CURRENT_TIMESTAMP(6),
           USAGE = USAGE + 1
     WHERE DEVICE_UID = v_DVC
       AND VALET_KEY = v_KEY;
  END GetKeyStatus;

end VALET_STAND;
/
