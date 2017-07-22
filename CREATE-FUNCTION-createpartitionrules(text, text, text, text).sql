-- Function: dpl.createpartitionrules(text, text, text, text)

-- DROP FUNCTION dpl.createpartitionrules(text, text, text, text);

CREATE OR REPLACE FUNCTION dpl.createpartitionrules(
    _tableschema text,
    _tablename text,
    _partitioncolumn text,
    _timeslot text)
  RETURNS void AS
$BODY$

DECLARE

_templaterule text := 'CREATE OR REPLACE RULE %%tablename_timeslot%%_rule AS ON INSERT TO %%tableschema%%.%%tablename%% WHERE %%condition%% DO INSTEAD INSERT INTO %%tableschema%%.%%tablename_timeslot%% VALUES (NEW.*);';
_sqlrule text := '';

BEGIN

--RAISE NOTICE  '%: Creating rules for %.%' , CLOCK_TIMESTAMP(), _tableschema, _tablename;

   
	_sqlrule := _templaterule;
	_sqlrule := REPLACE (_sqlrule,'%%tableschema%%',_tableschema);
	_sqlrule := REPLACE (_sqlrule,'%%tablename%%',_tablename);
	_sqlrule := REPLACE (_sqlrule,'%%tablename_timeslot%%',format('%s_%s', _tablename, _timeslot));
	_sqlrule := REPLACE (_sqlrule,'%%condition%%',format('%s = %s',_partitioncolumn,_timeslot));
	--RAISE NOTICE  '%' , _sqlrule;
	EXECUTE _sqlrule;

END;

 $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION dpl.createpartitionrules(text, text, text, text)
  OWNER TO postgres;
