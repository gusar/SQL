create or replace FUNCTION MEMBER_ACTIVITIES (
MEMBER_ID IN MEMBERS.MEMBERID%TYPE,
FOOTBALL IN VARCHAR2,
BASKETBALL IN VARCHAR2,
YOGA IN VARCHAR2,
TAEKWONDO IN VARCHAR2)
RETURN NUMBER
AS
 fees MEMBERS.FEESDUE%TYPE := 0;
 oldfees MEMBERS.FEESDUE%TYPE;
BEGIN  
  IF FOOTBALL = 'y' THEN
    fees := fees + 50.00;
    INSERT INTO ACTIVITYMEMBER VALUES('Football', MEMBER_ID);
    dbms_output.put_line('footbal');
  END IF;
  IF BASKETBALL = 'y' THEN
    fees := fees + 70.00;
    INSERT INTO ACTIVITYMEMBER VALUES('Basketball', MEMBER_ID);
    dbms_output.put_line('basketball');
  END IF;
  IF YOGA = 'y' THEN
    fees := fees + 40.00;
    INSERT INTO ACTIVITYMEMBER VALUES('Yoga', MEMBER_ID);
    dbms_output.put_line('yoga');
  END IF;
  IF TAEKWONDO = 'y' THEN
    fees := fees + 60.00;
    INSERT INTO ACTIVITYMEMBER VALUES('Taekwondo', MEMBER_ID);
    dbms_output.put_line('taekwondo');
  END IF;
  SELECT FEESDUE INTO oldfees FROM MEMBERS WHERE MEMBERID = MEMBER_ID;
  dbms_output.put_line('Old fees: ' || oldfees);
  fees := fees + oldfees;
  UPDATE MEMBERS SET FEESDUE = fees WHERE MEMBERID = MEMBER_ID;
  commit;
  RETURN fees;
  EXCEPTION 
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20999,'Constraint violated');
    ROLLBACK;
    RETURN NULL;
END MEMBER_ACTIVITIES;



create or replace FUNCTION IS_FULLMEMBER (
MEMBER_ID MEMBERS.MEMBERID%TYPE)
RETURN BOOLEAN AS 
MEMBER_TYPE MEMBERS.MTYPE%TYPE;
BEGIN
  SELECT MTYPE INTO MEMBER_TYPE FROM MEMBERS WHERE MEMBERID = MEMBER_ID;
  dbms_output.put_line('CHECK 1');
  IF MEMBER_TYPE LIKE 'Full' THEN
    dbms_output.put_line('CHECK 2');
    RETURN TRUE;
  END IF;
  EXCEPTION
  WHEN no_data_found THEN
    RETURN FALSE;
END IS_FULLMEMBER;



create or replace FUNCTION GET_MEMBER_ID (
MEMBER_NAME IN MEMBERS.MNAME%TYPE,
MEMBER_ADDR IN MEMBERS.MADDRESS%TYPE)
RETURN NUMBER AS 
MEMBER_ID MEMBERS.MEMBERID%TYPE;
BEGIN
  SELECT MEMBERID INTO MEMBER_ID FROM MEMBERS 
    WHERE MNAME LIKE MEMBER_NAME AND MADDRESS LIKE MEMBER_ADDR;
  RETURN MEMBER_ID;
  EXCEPTION
  WHEN no_data_found THEN
    RETURN NULL;
END GET_MEMBER_ID;



create or replace FUNCTION MEMBER_EXISTS(
MEMBER_NAME MEMBERS.MNAME%TYPE,
MEMBER_TEL TELEPHONE.PHONENUMBER%TYPE)
RETURN BOOLEAN AS
TEMP_NAME MEMBERS.MNAME%TYPE;
BEGIN
  SELECT MEMBERS.MNAME INTO TEMP_NAME
  FROM MEMBERS JOIN TELEPHONE ON MEMBERS.MEMBERID = TELEPHONE.MEMBERID
  WHERE MEMBERS.MNAME LIKE MEMBER_NAME AND TELEPHONE.PHONENUMBER LIKE MEMBER_TEL;
  RETURN TRUE;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RETURN FALSE;
END MEMBER_EXISTS;
