-- Function: dpl.createdailychildtables(character varying, character varying, date, date)

-- DROP FUNCTION dpl.createdailychildtables(character varying, character varying, date, date);

CREATE OR REPLACE FUNCTION dpl.createdailychildtables(
    tableschema character varying,
    tablename character varying,
    fromdate date,
    todate date)
  RETURNS void AS
$BODY$
declare dayslot text:= '';
BEGIN

FOR dayslot in (select dpl.getdayslots(fromdate, todate)) LOOP
EXECUTE dpl.createtable(tableschema,tablename,dayslot,true);
EXECUTE dpl.createpartitionrules(tableschema, tablename,'dayslot', dayslot);
END LOOP;

END;

 $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION dpl.createdailychildtables(character varying, character varying, date, date)
  OWNER TO postgres;
