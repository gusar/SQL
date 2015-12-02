create or replace TRIGGER PAYMENT_VALIDATION 
BEFORE UPDATE ON MEMBERS
FOR EACH ROW
BEGIN
  IF :NEW.FEESPAID < :OLD.FEESPAID THEN
    RAISE_APPLICATION_ERROR (-20110, 'A fee payment can not be a negative number.');
  END IF;
END;



create or replace TRIGGER MEMBER_AUDIT 
BEFORE INSERT ON MEMBERS
FOR EACH ROW
BEGIN
  INSERT INTO MEMBER_LOGTABLE VALUES(
    'obstacle table', :NEW.memberid, :NEW.mname, :NEW.mtype, TO_CHAR(user), 'INS', sysdate);
END;




CREATE TABLE MEMBER_LOGTABLE (
  tableName VARCHAR(20),
  mId VARCHAR2(4),
  mName VARCHAR(4),
  mType VARCHAR(10),
  userlogin varchar(255),
  auditor char(3) CHECK (auditor IN ('INS','UPD','DEL')),
  sys_date DATE
)
