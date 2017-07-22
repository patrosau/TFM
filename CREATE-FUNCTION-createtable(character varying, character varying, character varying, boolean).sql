-- Function: dpl.createtable(character varying, character varying, character varying, boolean)

-- DROP FUNCTION dpl.createtable(character varying, character varying, character varying, boolean);

CREATE OR REPLACE FUNCTION dpl.createtable(
    tableschema character varying,
    tablename character varying,
    timeslot character varying,
    index_geom boolean)
  RETURNS void AS
$BODY$
DECLARE
table_temp text := '
CREATE TABLE %%tableschema%%.%%tablename%%_%%timeslot%% (CHECK (%%condition%%)) INHERITS (%%tableschema%%.%%tablename%%);

CREATE INDEX idx_%%tablename%%_%%timeslot%%_%%timecolumn%% on %%tableschema%%.%%tablename%%_%%timeslot%% (%%timecolumn%%);
';
indexgeom_temp text := '
CREATE INDEX idx_%%tablename%%_%%timeslot%%_geom ON %%tableschema%%.%%tablename%%_%%timeslot%% USING gist(geom);
CLUSTER idx_%%tablename%%_%%timeslot%%_geom ON %%tableschema%%.%%tablename%%_%%timeslot%%;';
cluster_temp text := '
CLUSTER idx_%%tablename%%_%%timeslot%%_%%timecolumn%% on %%tableschema%%.%%tablename%%_%%timeslot%%;';
sql_exec text := '';
timecolumn varchar(128);
 BEGIN
RAISE NOTICE  '%: Begin CREATE %.%_%' , CLOCK_TIMESTAMP(), $1,$2,$3;
 
IF char_length($3)= 10 THEN
	timecolumn = 'hourslot';
ELSIF char_length($3) = 12 THEN
	timecolumn = 'timeslot';
ELSE
	timecolumn = 'dayslot';
END IF;

  IF index_geom
	THEN
	sql_exec := table_temp || indexgeom_temp;
	ELSE
	sql_exec := table_temp || cluster_temp;
 END IF;

 sql_exec := REPLACE (sql_exec,'%%tableschema%%',tableschema);
 sql_exec := REPLACE (sql_exec,'%%tablename%%',tablename);
 sql_exec := REPLACE (sql_exec,'%%timeslot%%',timeslot);
 sql_exec := REPLACE (sql_exec,'%%timecolumn%%',timecolumn);
 sql_exec := REPLACE (sql_exec,'%%condition%%',format('%s = %s',timecolumn,timeslot));

 EXECUTE sql_exec;

 --END;
 --END IF;
RAISE NOTICE  '%: End CREATE %.%_%' , CLOCK_TIMESTAMP(), $1,$2,$3;
 END;

 $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION dpl.createtable(character varying, character varying, character varying, boolean)
  OWNER TO postgres;
