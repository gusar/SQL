create or replace PROCEDURE INSERT_MEMBER (
MEMBER_NAME IN MEMBERS.MNAME%TYPE,
MEMBER_ADDR IN MEMBERS.MADDRESS%TYPE,
MEMBER_TYPE IN MEMBERS.MTYPE%TYPE,
MEMBER_TEL IN TELEPHONE.PHONENUMBER%TYPE) 
AS 
  MEMBER_ID MEMBERS.MEMBERID%TYPE;
  EXTRA_FEES MEMBERS.FEESPAID%TYPE;
  FEES_DUE MEMBERS.FEESDUE%TYPE;
  DUPLICATE_MEMBER EXCEPTION;
BEGIN
  IF NOT MEMBER_EXISTS(MEMBER_NAME, MEMBER_TEL) THEN
    IF MEMBER_TYPE LIKE 'Swimming' THEN
      FEES_DUE := 150;
    ELSIF MEMBER_TYPE LIKE 'Full' THEN
      FEES_DUE := 250;
    END IF;
    dbms_output.put_line('Registation Fee: ' || FEES_DUE);
    
    INSERT INTO MEMBERS(MEMBERID, MNAME, MADDRESS, MTYPE, FEESPAID, FEESDUE)
      VALUES(MEMBER_ID_SEQ.NEXTVAL, MEMBER_NAME, MEMBER_ADDR, MEMBER_TYPE, 0, FEES_DUE);
    
    SELECT MEMBERID INTO MEMBER_ID FROM MEMBERS WHERE MNAME LIKE MEMBER_NAME;
    INSERT INTO TELEPHONE VALUES(MEMBER_ID, MEMBER_TEL);
    COMMIT;
  ELSE
    RAISE DUPLICATE_MEMBER;
  END IF;
  EXCEPTION
  WHEN DUPLICATE_MEMBER THEN
    RAISE_APPLICATION_ERROR(-20101,'Name: ' || MEMBER_NAME || ', Tel: ' || MEMBER_TEL || ' already exists!');
    ROLLBACK;
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20999,'Constraint violated');
    ROLLBACK;
END;



create or replace PROCEDURE PROCESS_PAYMENT (
MEMBER_ID MEMBERS.MEMBERID%TYPE,
MEMBER_PAYMENT MEMBERS.FEESPAID%TYPE,
MEMBER_FEES MEMBERS.FEESDUE%TYPE)
AS
FEES_DUE MEMBERS.FEESDUE%TYPE;
BEGIN
  FEES_DUE := MEMBER_FEES - MEMBER_PAYMENT;
  UPDATE MEMBERS SET FEESDUE = FEES_DUE, FEESPAID = MEMBER_PAYMENT WHERE MEMBERID = MEMBER_ID;
  dbms_output.put_line('Updated fees due: ' || FEES_DUE);
  commit;
END PROCESS_PAYMENT;
