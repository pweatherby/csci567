create or replace package SHOP_CART is

  -- Author  : PWEATHERBY
  -- Created : 5/13/2013 10:07:33 AM
  -- Purpose : to provide a dummy shop cart since PS isn't avail in time
  
  TYPE t_CartItem_rec IS RECORD (
    EMPLID VARCHAR2(13),
    TERM VARCHAR2(4),
    SESSION_GROUP number(10),
    COURSE_ID VARCHAR2(6),
    COURSE_OFFER_NBR number(10),
    CLASS_SECTION varchar2(3),
    REGISTRATION_NBR varchar2(5)
   );
  TYPE t_CartItem_cursor is REF CURSOR RETURN t_CartItem_rec;

  PROCEDURE GetCart(EMPLID in varchar2,
                 io_cursor in out t_CartItem_cursor);
  
  PROCEDURE AddItem(EMPLID in varchar2,
                    TERM   in varchar2,
                    SESGRP in number,
                    CRSID  in varchar2,
                    CRSOFR in number,
                    SECT   in varchar2,
                    REGNBR in varchar2);
                    
  PROCEDURE RemoveItem(EMPLID in varchar2,
                       TERM   in varchar2,
                       SESGRP in number,
                       CRSID  in varchar2,
                       CRSOFR in number,
                       SECT   in varchar2,
                       REGNBR in varchar2);
  
end SHOP_CART;
/
create or replace package body SHOP_CART is

  PROCEDURE GetCart(EMPLID in varchar2,
                 io_cursor in out t_CartItem_cursor) IS
   v_EMP varchar2(13) := EMPLID;
   v_cursor t_CartItem_cursor;
  BEGIN
    OPEN v_cursor FOR
    SELECT i.emplid,
           i.term,
           i.session_group,
           i.course_id,
           i.course_offer_nbr,
           i.class_section,
           i.registration_nbr
      FROM SHOP_CART_ITEMS i
     WHERE i.emplid = v_EMP;
     io_cursor := v_cursor;
  END GetCart;
  
  PROCEDURE AddItem(EMPLID in varchar2,
                    TERM   in varchar2,
                    SESGRP in number,
                    CRSID  in varchar2,
                    CRSOFR in number,
                    SECT   in varchar2,
                    REGNBR in varchar2) IS
   v_EMP varchar2(13) := EMPLID;
   v_TRM varchar2(4) := TERM;
   v_GRP number(10) := SESGRP;
   v_CRS varchar2(6) := CRSID;
   v_OFR number(10) := CRSOFR;
   v_SCT varchar2(3) := SECT;
   v_REG varchar2(5) := REGNBR;
  BEGIN
    MERGE INTO SHOP_CART_ITEMS c
          USING DUAL
          ON (c.EMPLID = v_EMP AND
              c.TERM = v_TRM AND
              c.SESSION_GROUP = v_GRP AND
              c.COURSE_ID = v_CRS AND
              c.COURSE_OFFER_NBR = v_OFR AND
              c.CLASS_SECTION = v_SCT)
     WHEN MATCHED THEN
          UPDATE SET c.REGISTRATION_NBR = v_REG
     WHEN NOT MATCHED THEN
          INSERT (c.EMPLID, c.term, c.session_group, c.course_id, c.course_offer_nbr, c.class_section, c.registration_nbr)
          VALUES (v_EMP, v_TRM, v_GRP, v_CRS, v_OFR, v_SCT, v_REG);

  END AddItem;
  
  
  PROCEDURE RemoveItem(EMPLID in varchar2,
                       TERM   in varchar2,
                       SESGRP in number,
                       CRSID  in varchar2,
                       CRSOFR in number,
                       SECT   in varchar2,
                       REGNBR in varchar2) IS
   v_EMP varchar2(13) := EMPLID;
   v_TRM varchar2(4) := TERM;
   v_GRP number(10) := SESGRP;
   v_CRS varchar2(6) := CRSID;
   v_OFR number(10) := CRSOFR;
   v_SCT varchar2(3) := SECT;
   v_REG varchar2(5) := REGNBR;
  BEGIN
    DELETE
      FROM SHOP_CART_ITEMS c
     WHERE c.EMPLID = v_EMP AND
           c.TERM = v_TRM AND
           c.SESSION_GROUP = v_GRP AND
           c.COURSE_ID = v_CRS AND
           c.COURSE_OFFER_NBR = v_OFR AND
           c.CLASS_SECTION = v_SCT AND
           c.REGISTRATION_NBR = v_REG;
  END RemoveItem;
  
end SHOP_CART;
/
