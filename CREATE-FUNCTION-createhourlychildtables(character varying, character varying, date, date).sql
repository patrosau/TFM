-- Function: dpl.createhourlychildtables(character varying, character varying, date, date)

-- DROP FUNCTION dpl.createhourlychildtables(character varying, character varying, date, date);

CREATE OR REPLACE FUNCTION dpl.createhourlychildtables(
    tableschema character varying,
    tablename character varying,
    fromdate date,
    todate date)
  RETURNS void AS
$BODY$
declare hourslot text:= '';
BEGIN

FOR hourslot in (select dpl.gethourslots(fromdate, todate)) LOOP
EXECUTE dpl.createtable(tableschema,tablename,hourslot,true);
EXECUTE dpl.createpartitionrules(tableschema, tablename,'hourslot', hourslot);
END LOOP;

END;

 $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION dpl.createhourlychildtables(character varying, character varying, date, date)
  OWNER TO postgres;
