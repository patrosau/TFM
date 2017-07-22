-- Function: dpl.getdayslots(date, date)

-- DROP FUNCTION dpl.getdayslots(date, date);

CREATE OR REPLACE FUNCTION dpl.getdayslots(
    fromdate date,
    todate date)
  RETURNS SETOF text AS
$BODY$select to_char(generate_series (fromDate, toDate, '1 day')::timestamp,'YYYYMMDD') as timeslot$BODY$
  LANGUAGE sql IMMUTABLE
  COST 100
  ROWS 1000;
ALTER FUNCTION dpl.getdayslots(date, date)
  OWNER TO postgres;
