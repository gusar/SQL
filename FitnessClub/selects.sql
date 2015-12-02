-- SELECTS

-- Inner Join
-- Select a games hall session by id an show: 
-- the game name, trainer name, equipment used, and date.
SELECT 
  activityName, Trainer.trainerName, Equipment.equipmentName, hrDate
FROM HallRoster INNER JOIN Equipment ON
  Hallroster.equipmentId = Equipment.equipmentId
INNER JOIN Trainer ON
  Hallroster.trainerId = Trainer.trainerId
WHERE 
  Hallroster.hrSessionId = 4;
  

-- Outer join
-- List all members and if they participate in activities, list those activities.
SELECT
  Members.mName, ActivityMember.activityName
FROM Members LEFT OUTER JOIN ActivityMember ON
  Members.memberId = ActivityMember.MemberId;
  


-- Aggregate & sub query
-- Find the member who has the highest outstanding fees,
-- show that member's grade, name, and fees due.
SELECT gradeNumber, Members.mName, Members.feesDue FROM GradeMember
JOIN Members ON GradeMember.memberId = Members.memberId
WHERE Members.memberId IN 
  (SELECT memberId FROM Members WHERE feesDue IN
    (SELECT MAX(feesDue) FROM Members));


-- Union
-- Select all trainers who coached either a game or a pool session on 02-11-15.
SELECT trainerId FROM PoolBooking WHERE PBDATE = TO_DATE('02-11-15', 'DD-MM-YY')
UNION
SELECT trainerId FROM HallRoster WHERE hrDate = TO_DATE('02-11-15', 'DD-MM-YY');



-- Intersect
-- Show IDs of trainers which coach the pool roster sessions.
SELECT trainerId FROM Trainer
INTERSECT
SELECT trainerId FROM PoolRoster;