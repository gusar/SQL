DROP TABLE Activity CASCADE CONSTRAINTS PURGE;
DROP TABLE ActivityMember CASCADE CONSTRAINTS PURGE;
DROP TABLE HallRoster CASCADE CONSTRAINTS PURGE;
DROP TABLE Grade CASCADE CONSTRAINTS PURGE;
DROP TABLE GradeMember CASCADE CONSTRAINTS PURGE;
DROP TABLE PoolRoster CASCADE CONSTRAINTS PURGE;
DROP TABLE Trainer CASCADE CONSTRAINTS PURGE;
DROP TABLE Telephone CASCADE CONSTRAINTS PURGE;
DROP TABLE Members CASCADE CONSTRAINTS PURGE;
DROP TABLE Equipment CASCADE CONSTRAINTS PURGE;
DROP TABLE GymBooking CASCADE CONSTRAINTS PURGE;
DROP TABLE PoolBooking CASCADE CONSTRAINTS PURGE;
DROP SEQUENCE member_id_seq;
DROP SEQUENCE trainer_id_seq;
DROP SEQUENCE equipment_id_seq;
DROP SEQUENCE prsession_id_seq;
DROP SEQUENCE hrsession_id_seq;

CREATE TABLE Members (
	memberId             NUMBER(5) NOT NULL ,
	mName                VARCHAR2(60) NOT NULL ,
	mAddress             VARCHAR2(100) NOT NULL ,
	mType                VARCHAR2(10) NOT NULL ,
	feesPaid             NUMBER(8,2) NULL ,
	feesDue              NUMBER(8,2) NULL ,
CONSTRAINT member_type_values CHECK (mType IN ('Full', 'Swimming')),
CONSTRAINT member_primary_key PRIMARY KEY (memberId)
);
CREATE SEQUENCE member_id_seq START WITH 1;

INSERT INTO Members (memberId, mName, mAddress, mType, feesPaid, feesDue) 
    VALUES (member_id_seq.nextval, 'John Spencer', 'Ballymun Road', 'Full', 0, 0);
INSERT INTO Members (memberId, mName, mAddress, mType, feesPaid, feesDue) 
   VALUES (member_id_seq.nextval, 'Marx Thompson', 'Santry Avenue', 'Swimming', 200,300);
INSERT INTO Members (memberId, mName, mAddress, mType, feesPaid, feesDue) 
    VALUES (member_id_seq.nextval, 'Anne Brittain ', 'Temple Bar', 'Swimming', 150, 50);
INSERT INTO Members (memberId, mName, mAddress, mType, feesPaid, feesDue) 
    VALUES (member_id_seq.nextval, 'Richard Good', 'Waterford Road', 'Full', 0, 0);
INSERT INTO Members (memberId, mName, mAddress, mType, feesPaid, feesDue) 
    VALUES (member_id_seq.nextval, 'Frank Doyle', 'Kevin Street', 'Full', 100, 100);



CREATE TABLE Telephone (
	memberId             NUMBER(5) NOT NULL ,
	phoneNumber          VARCHAR2(11) NULL ,
CONSTRAINT  telepone_primary_key PRIMARY KEY (memberId),
CONSTRAINT fk_mebmer_telephone FOREIGN KEY (memberId) REFERENCES Members (memberId)
);

INSERT INTO Telephone VALUES (1, '+0848444484');
INSERT INTO Telephone VALUES (2, '+0879032193');
INSERT INTO Telephone VALUES (3, '+5419283092');
INSERT INTO Telephone VALUES (4, '48572039471');
INSERT INTO Telephone VALUES (5, '93058342350');


CREATE TABLE Trainer (
	trainerId            NUMBER(5) NOT NULL ,
	trainerName          VARCHAR2(60) NOT NULL ,
	trainerDayOff1       NUMBER(1) NULL ,
	trainerDayOff2        NUMBER(1) NULL ,
CONSTRAINT trainer_primary_key PRIMARY KEY (trainerId)
);
CREATE SEQUENCE trainer_id_seq START WITH 1;

INSERT INTO Trainer VALUES (trainer_id_seq.nextval, 'Carlos Jose', 3, 7);
INSERT INTO Trainer VALUES (trainer_id_seq.nextval, 'Juan Pablo', 4, 5);
INSERT INTO Trainer VALUES (trainer_id_seq.nextval, 'Ciaran Allen', 6, 7);
INSERT INTO Trainer VALUES (trainer_id_seq.nextval, 'Josh Barret', 1, 3);
INSERT INTO Trainer VALUES (trainer_id_seq.nextval, 'Paola Caffrey', 2, 3);


CREATE TABLE Grade (
	gradeNumber          NUMBER(1) NOT NULL ,
    gradeDesc            VARCHAR(60) NULL,
CONSTRAINT gradenumber_values CHECK (gradeNumber IN (1, 2, 3, 4)),
CONSTRAINT grade_primary_key PRIMARY KEY (gradeNumber)
);

INSERT INTO Grade values (1, '');
INSERT INTO Grade values (2, '');
INSERT INTO Grade values (3, '');
INSERT INTO Grade values (4, '');


CREATE TABLE GradeMember (
  gradeNumber          NUMBER(1) NOT NULL ,
	memberId             NUMBER(5) NULL ,
	gradeStartDate       DATE NOT NULL ,
CONSTRAINT fk_grademember_grade FOREIGN KEY (gradeNumber) REFERENCES Grade (gradeNumber),
CONSTRAINT fk_grademember_members FOREIGN KEY (memberId) REFERENCES Members (memberId)
);

INSERT INTO GradeMember values (1, 1, '13-OCT-15');
INSERT INTO GradeMember values (1, 2, '27-OCT-15');
INSERT INTO GradeMember values (2, 4, '07-FEB-14');
INSERT INTO GradeMember values (3, 5, '20-OCT-13');
INSERT INTO GradeMember values (3, 3, '27-AUG-15');


CREATE TABLE PoolRoster (
  prSessionId          NUMBER(5) NOT NULL ,
	gradeNumber          NUMBER(1) NULL ,
	prType               VARCHAR2(10) NOT NULL ,
  prDate               DATE NOT NULL ,
	prStartTime          DATE NOT NULL ,
	prEndTime            DATE NOT NULL ,
	trainerId            NUMBER(5) NULL ,
    CONSTRAINT pr_type_values CHECK (prType IN ('Public', 'Private')),
    CONSTRAINT poolroster_primary_key PRIMARY KEY (prSessionId),
    CONSTRAINT fk_poolroster_grade FOREIGN KEY (gradeNumber) REFERENCES Grade (gradeNumber),
    CONSTRAINT fk_poolroster_trainer FOREIGN KEY (trainerId) REFERENCES Trainer (trainerId)
);
CREATE SEQUENCE prsession_id_seq START WITH 1;

INSERT INTO PoolRoster (prSessionId, gradeNumber, prType, prDate, prStartTime, prEndTime, trainerId) 
  values (prsession_id_seq.nextval, 1, 'Private', TO_DATE('15-11-15','DD-MM-YY'), TO_DATE('10:00','HH24:MI'), TO_DATE('12:00','HH24:MI'), 1 );
INSERT INTO PoolRoster (prSessionId, prType, prStartTime, prDate, prEndTime) 
  values (prsession_id_seq.nextval, 'Public', TO_DATE('15-11-15','DD-MM-YY'), TO_DATE('13:00','HH24:MI'), TO_DATE('15:00','HH24:MI'));
INSERT INTO PoolRoster (prSessionId, gradeNumber, prType, prDate, prStartTime, prEndTime, trainerId) 
  values (prsession_id_seq.nextval, 4, 'Private', TO_DATE('15-11-15','DD-MM-YY'), TO_DATE('15:00','HH24:MI'), TO_DATE('17:00','HH24:MI'), 3 );
INSERT INTO PoolRoster (prSessionId, prType, prStartTime, prDate, prEndTime) 
  values (prsession_id_seq.nextval, 'Public', TO_DATE('16-11-15','DD-MM-YY'), TO_DATE('10:00','HH24:MI'), TO_DATE('12:00','HH24:MI'));
INSERT INTO PoolRoster (prSessionId, gradeNumber, prType, prDate, prStartTime, prEndTime, trainerId) 
  values (prsession_id_seq.nextval, 2, 'Private', TO_DATE('16-11-15','DD-MM-YY'), TO_DATE('13:00','HH24:MI'), TO_DATE('15:00','HH24:MI'), 4 );


CREATE TABLE Activity (
	activityName         VARCHAR2(40) NOT NULL ,
    maxMembers           NUMBER(2) NOT NULL,
	activityDesc         VARCHAR2(60) NULL ,
CONSTRAINT hallroster_activity_values CHECK (activityName IN ('Football', 'Basketball', 'Yoga', 'Taekwondo')),
CONSTRAINT activity_primary_key PRIMARY KEY (activityName)
);

INSERT INTO Activity VALUES ('Basketball' , 20, '');
INSERT INTO Activity VALUES ('Taekwondo' , 20, '');
INSERT INTO Activity VALUES ('Football' , 20, '');
INSERT INTO Activity VALUES ('Yoga' , 20, '');


CREATE TABLE ActivityMember (
    activityName         VARCHAR2(40) NOT NULL ,
	memberId             NUMBER(5) NULL , 
CONSTRAINT fk_activitymember_members FOREIGN KEY (memberId) REFERENCES Members (memberId),
CONSTRAINT fk_activitymember_activity FOREIGN KEY (activityName) REFERENCES Activity (activityName)
);

INSERT INTO ActivityMember VALUES ('Taekwondo' , 1);
INSERT INTO ActivityMember VALUES ('Basketball' , 1);
INSERT INTO ActivityMember VALUES ('Taekwondo' , 4);
INSERT INTO ActivityMember VALUES ('Football' , 5);
INSERT INTO ActivityMember VALUES ('Yoga' , 4);


CREATE TABLE Equipment (
	equipmentId          NUMBER(5) NOT NULL ,
	equipmentName        VARCHAR2(40) NOT NULL ,
CONSTRAINT equipment_primary_key PRIMARY KEY (equipmentId)
);
CREATE SEQUENCE equipment_id_seq START WITH 1;

INSERT INTO Equipment values (equipment_id_seq.nextval, 'Multi Adjustable Bench');
INSERT INTO Equipment values (equipment_id_seq.nextval, 'Stepper');
INSERT INTO Equipment values (equipment_id_seq.nextval, 'Leg Press');
INSERT INTO Equipment values (equipment_id_seq.nextval, 'Triceps Extension');
INSERT INTO Equipment values (equipment_id_seq.nextval, 'Pectoral Fly');


CREATE TABLE HallRoster (
    hrSessionId          NUMBER(5) NOT NULL,
	activityName         VARCHAR2(40) NOT NULL ,
    hrDate               DATE NOT NULL ,
	hrStartTime          DATE NOT NULL ,
	hrEndTime            DATE NOT NULL ,
	trainerId            NUMBER(5) NOT NULL ,
    equipmentId          NUMBER(5) NULL ,
CONSTRAINT hallroster_primary_key PRIMARY KEY (hrSessionId),
CONSTRAINT fk_hallroster_equipment FOREIGN KEY (equipmentId) REFERENCES Equipment (equipmentId),
CONSTRAINT fk_hallroster_activity FOREIGN KEY (activityName) REFERENCES Activity (activityName),
CONSTRAINT fk_hallroster_trainer FOREIGN KEY (trainerId) REFERENCES Trainer (trainerId)
);
CREATE SEQUENCE hrsession_id_seq START WITH 1;


INSERT INTO HallRoster 
    VALUES (hrsession_id_seq.nextval, 'Taekwondo', TO_DATE('01-11-15', 'DD-MM-YY'), TO_DATE('12:00', 'HH24:MI'), TO_DATE('13:00', 'HH24:MI'), 1, 2);
INSERT INTO HallRoster 
    VALUES (hrsession_id_seq.nextval, 'Football', TO_DATE('01-11-15', 'DD-MM-YY'), TO_DATE('13:00', 'HH24:MI'), TO_DATE('15:00', 'HH24:MI'), 3, 3);
INSERT INTO HallRoster 
    VALUES (hrsession_id_seq.nextval, 'Yoga', TO_DATE('01-11-15', 'DD-MM-YY'), TO_DATE('16:00', 'HH24:MI'), TO_DATE('18:00', 'HH24:MI'), 5, 1);
INSERT INTO HallRoster 
    VALUES (hrsession_id_seq.nextval, 'Basketball', TO_DATE('02-11-15', 'DD-MM-YY'), TO_DATE('10:00', 'HH24:MI'), TO_DATE('11:00', 'HH24:MI'), 4, 2);
INSERT INTO HallRoster 
    VALUES (hrsession_id_seq.nextval, 'Football', TO_DATE('02-11-15', 'DD-MM-YY'), TO_DATE('11:00', 'HH24:MI'), TO_DATE('15:00', 'HH24:MI'), 2, 5);


CREATE TABLE GymBooking (
	memberId             NUMBER(5) NOT NULL ,
	equipmentId          NUMBER(5) NOT NULL ,
    gbDate               DATE NOT NULL ,
	gbStartTime          DATE NOT NULL ,
	gbEndTime            DATE NOT NULL ,
CONSTRAINT gymbooking_primary_key PRIMARY KEY (memberId,equipmentId),
CONSTRAINT fk_gymbooking_members FOREIGN KEY (memberId) REFERENCES Members (memberId),
CONSTRAINT fk_gymbooking_equipment FOREIGN KEY (equipmentId) REFERENCES Equipment (equipmentId)
);

INSERT INTO GymBooking VALUES (1, 1, TO_DATE('05-11-15', 'DD-MM-YY'), TO_DATE('09:00', 'HH24:MI'), TO_DATE('09:15', 'HH24:MI'));
INSERT INTO GymBooking VALUES (3, 2, TO_DATE('05-11-15', 'DD-MM-YY'), TO_DATE('09:00', 'HH24:MI'), TO_DATE('09:15', 'HH24:MI'));
INSERT INTO GymBooking VALUES (4, 5, TO_DATE('06-11-15', 'DD-MM-YY'), TO_DATE('12:00', 'HH24:MI'), TO_DATE('12:15', 'HH24:MI'));
INSERT INTO GymBooking VALUES (2, 3, TO_DATE('08-11-15', 'DD-MM-YY'), TO_DATE('12:15', 'HH24:MI'), TO_DATE('12:30', 'HH24:MI'));
INSERT INTO GymBooking VALUES (1, 5, TO_DATE('11-11-15', 'DD-MM-YY'), TO_DATE('09:30', 'HH24:MI'), TO_DATE('09:45', 'HH24:MI'));


CREATE TABLE PoolBooking (
	memberId             NUMBER(5) NOT NULL ,
    pbDate               DATE NOT NULL ,
	pbStartTime          DATE NOT NULL ,
	pbEndTime            DATE NOT NULL ,
	trainerId            NUMBER(5) NULL ,
CONSTRAINT poolbooking_primary_key PRIMARY KEY (memberId),
CONSTRAINT fk_poolbooking_trainer FOREIGN KEY (trainerId) REFERENCES Trainer (trainerId),
CONSTRAINT fk_poolbooking_members FOREIGN KEY (memberId) REFERENCES Members (memberId)
);


INSERT INTO PoolBooking values (1, TO_DATE('02-11-15', 'DD-MM-YY'), TO_DATE('10:00', 'HH24:MI'), TO_DATE('12:00', 'HH24:MI'), 1);
INSERT INTO PoolBooking values (5, TO_DATE('02-11-15', 'DD-MM-YY'), TO_DATE('11:00', 'HH24:MI'), TO_DATE('13:00', 'HH24:MI'), 5);
INSERT INTO PoolBooking values (2, TO_DATE('03-11-15', 'DD-MM-YY'), TO_DATE('10:00', 'HH24:MI'), TO_DATE('12:00', 'HH24:MI'), 4);
INSERT INTO PoolBooking values (4, TO_DATE('04-11-15', 'DD-MM-YY'), TO_DATE('10:00', 'HH24:MI'), TO_DATE('12:00', 'HH24:MI'), 4);
INSERT INTO PoolBooking VALUES (3, TO_DATE('04-11-15', 'DD-MM-YY'), TO_DATE('13:00', 'HH24:MI'), TO_DATE('15:00', 'HH24:MI'), 2);


--Trainer
GRANT SELECT ON PoolBooking TO pjusti;
GRANT SELECT ON GymBooking TO pjusti;
GRANT SELECT, INSERT, DELETE ON PoolRoster TO pjusti;
GRANT SELECT, INSERT, DELETE ON HallRoster TO pjusti;
GRANT SELECT ON ActivityMember TO pjusti;
GRANT SELECT, UPDATE ON GradeMember TO pjusti;
GRANT SELECT ON Equipment TO pjusti;
GRANT SELECT ON GymBooking TO pjusti;

--Member
GRANT SELECT ON Member TO pgood;
GRANT SELECT, INSERT ON Telephone TO pgood;
GRANT UPDATE ON PhoneNumber TO pgood;
GRANT SELECT PoolRoster TO pgood;
GRANT SELECT HallRoster TO pgood;
GRANT SELECT, INSERT GymBooking TO pgood;
GRANT SELECT, INSERT PoolBooking TO pgood;
GRANT SELECT Activity TO pgood;
GRANT SELECT Trainer TO pgood;

--Secretary
GRANT SELECT, INSERT, DELETE, UPDATE ON Members to alahs;
GRANT SELECT ON PoolRoster TO alahs;
GRANT SELECT ON HallRoster TO alahs;
GRANT SELECT, INSERT, DELETE ON PoolBooking TO alahs;
GRANT SELECT, INSERT, DELETE ON GymBooking TO alahs;
GRANT SELECT ON Grade TO alahs;
GRANT SELECT, INSERT, DELETE ON ActivityMember TO alahs;
GRANT SELECT ON GradeMember TO alahs;
GRANT SELECT, INSERT ON Activity TO alahs;
GRANT SELECT, UPDATE, INSERT, DELETE ON Telephone TO alahs;
GRANT SELECT ON Equipment TO alahs;
GRANT SELECT, UPDATE, INSERT, DELETE ON Trainer TO alahs;