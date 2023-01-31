CREATE OR REPLACE PROCEDURE wedagrowstobq.create_customer()
BEGIN
  DECLARE day INT64;
  SET day = (SELECT EXTRACT(DAYOFWEEK from CURRENT_DATE));
  if day = 1 or day = 7 THEN
    SELECT 'Weekend';
  ELSE
    SELECT 'Weekday';
  END IF;
END

-------------

CALL wedagrowstobq.create_customer();