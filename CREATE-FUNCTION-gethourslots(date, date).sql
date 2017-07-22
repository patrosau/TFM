-- Function: dpl.gethourslots(date, date)

-- DROP FUNCTION dpl.gethourslots(date, date);

CREATE OR REPLACE FUNCTION dpl.gethourslots(
    fromdate date,
    todate date)
  RETURNS SETOF text AS
$BODY$select to_char(generate_series (fromDate, toDate + interval '23 hours', '1 hour')::timestamp,'YYYYMMDDHH24') as timeslot$BODY$
  LANGUAGE sql IMMUTABLE
  COST 100
  ROWS 1000;
ALTER FUNCTION dpl.gethourslots(date, date)
  OWNER TO postgres;
