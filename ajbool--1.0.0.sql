-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION ajbool" to load this file. \quit
--source file sql/ajbool.sql
CREATE FUNCTION ajbool_in(cstring)
RETURNS ajbool
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION ajbool_out(ajbool)
RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION ajbool_recv(internal)
RETURNS ajbool
LANGUAGE internal IMMUTABLE AS 'charrecv' PARALLEL SAFE;


CREATE FUNCTION ajbool_send(ajbool)
RETURNS bytea
LANGUAGE internal IMMUTABLE AS 'charsend' PARALLEL SAFE;

CREATE TYPE ajbool (
    INPUT          = ajbool_in,
    OUTPUT         = ajbool_out,
    RECEIVE        = ajbool_recv,
    SEND           = ajbool_send,
    INTERNALLENGTH = 1,
ALIGNMENT      = char,
    STORAGE        = plain,
    CATEGORY       = 'B',
    PASSEDBYVALUE
);
COMMENT ON TYPE ajbool IS 'boolean type with explict NULL';

CREATE FUNCTION ajbool_to_bool(ajbool) RETURNS bool AS
'MODULE_PATHNAME'
LANGUAGE c IMMUTABLE STRICT PARALLEL SAFE;

CREATE CAST (ajbool AS bool)
WITH FUNCTION ajbool_to_bool(ajbool) AS IMPLICIT;

CREATE FUNCTION bool_to_ajbool(bool) RETURNS ajbool
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

CREATE CAST (bool as ajbool) WITH FUNCTION bool_to_ajbool(bool) AS ASSIGNMENT;

CREATE FUNCTION ajbool_eq(ajbool, ajbool)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'chareq' PARALLEL SAFE;

CREATE FUNCTION ajbool_ne(ajbool, ajbool)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charne' PARALLEL SAFE;

CREATE FUNCTION ajbool_lt(ajbool, ajbool)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charlt' PARALLEL SAFE;

CREATE FUNCTION ajbool_le(ajbool, ajbool)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charle' PARALLEL SAFE;

CREATE FUNCTION ajbool_gt(ajbool, ajbool)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'chargt' PARALLEL SAFE;

CREATE FUNCTION ajbool_ge(ajbool, ajbool)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charge' PARALLEL SAFE;

CREATE FUNCTION ajbool_cmp(ajbool, ajbool)
RETURNS integer LANGUAGE internal IMMUTABLE AS 'btcharcmp' PARALLEL SAFE;

CREATE FUNCTION hash_ajbool(ajbool)
RETURNS integer LANGUAGE internal IMMUTABLE AS 'hashchar' PARALLEL SAFE;

CREATE OPERATOR = (
    LEFTARG = ajbool,
    RIGHTARG = ajbool,
    PROCEDURE = ajbool_eq,
    COMMUTATOR = '=',
    NEGATOR = '<>',
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);
COMMENT ON OPERATOR =(ajbool, ajbool) IS 'equals?';

CREATE OPERATOR <> (
    LEFTARG = ajbool,
    RIGHTARG = ajbool,
    PROCEDURE = ajbool_ne,
    COMMUTATOR = '<>',
    NEGATOR = '=',
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);
COMMENT ON OPERATOR <>(ajbool, ajbool) IS 'not equals?';

CREATE OPERATOR < (
    LEFTARG = ajbool,
    RIGHTARG = ajbool,
    PROCEDURE = ajbool_lt,
    COMMUTATOR = > ,
    NEGATOR = >= ,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);
COMMENT ON OPERATOR <(ajbool, ajbool) IS 'less-than';

CREATE OPERATOR <= (
    LEFTARG = ajbool,
    RIGHTARG = ajbool,
    PROCEDURE = ajbool_le,
    COMMUTATOR = >= ,
    NEGATOR = > ,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);
COMMENT ON OPERATOR <=(ajbool, ajbool) IS 'less-than-or-equal';

CREATE OPERATOR > (
    LEFTARG = ajbool,
    RIGHTARG = ajbool,
    PROCEDURE = ajbool_gt,
    COMMUTATOR = < ,
    NEGATOR = <= ,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);
COMMENT ON OPERATOR >(ajbool, ajbool) IS 'greater-than';

CREATE OPERATOR >= (
    LEFTARG = ajbool,
    RIGHTARG = ajbool,
    PROCEDURE = ajbool_ge,
    COMMUTATOR = <= ,
    NEGATOR = < ,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);
COMMENT ON OPERATOR >=(ajbool, ajbool) IS 'greater-than-or-equal';

CREATE OPERATOR CLASS btree_ajbool_ops
DEFAULT FOR TYPE ajbool USING btree
AS
        OPERATOR        1       <  ,
        OPERATOR        2       <= ,
        OPERATOR        3       =  ,
        OPERATOR        4       >= ,
        OPERATOR        5       >  ,
        FUNCTION        1       ajbool_cmp(ajbool, ajbool);

CREATE OPERATOR CLASS hash_ajbool_ops
    DEFAULT FOR TYPE ajbool USING hash AS
        OPERATOR        1       = ,
        FUNCTION        1       hash_ajbool(ajbool);
 
