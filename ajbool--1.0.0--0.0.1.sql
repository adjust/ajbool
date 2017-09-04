----functions----
CREATE OR REPLACE FUNCTION ajbool_gt(ajbool, ajbool)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$chargt$function$;
----
CREATE OR REPLACE FUNCTION ajbool_cmp(ajbool, ajbool)
 RETURNS integer
 LANGUAGE internal
 IMMUTABLE
AS $function$btcharcmp$function$;
----
CREATE OR REPLACE FUNCTION ajbool_ge(ajbool, ajbool)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$charge$function$;
----
CREATE OR REPLACE FUNCTION ajbool_le(ajbool, ajbool)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$charle$function$;
----
CREATE OR REPLACE FUNCTION ajbool_lt(ajbool, ajbool)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$charlt$function$;
----
CREATE OR REPLACE FUNCTION ajbool_ne(ajbool, ajbool)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$charne$function$;
----
CREATE OR REPLACE FUNCTION ajbool_eq(ajbool, ajbool)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$chareq$function$;
----
CREATE OR REPLACE FUNCTION bool_to_ajbool(boolean)
 RETURNS ajbool
 LANGUAGE c
 IMMUTABLE
AS '$libdir/ajbool', $function$bool_to_ajbool$function$;
----
CREATE OR REPLACE FUNCTION ajbool_to_bool(ajbool)
 RETURNS boolean
 LANGUAGE c
 IMMUTABLE STRICT
AS '$libdir/ajbool', $function$ajbool_to_bool$function$;
----
CREATE OR REPLACE FUNCTION ajbool_send(ajbool)
 RETURNS bytea
 LANGUAGE internal
 IMMUTABLE
AS $function$charsend$function$;
----
CREATE OR REPLACE FUNCTION ajbool_recv(internal)
 RETURNS ajbool
 LANGUAGE internal
 IMMUTABLE
AS $function$charrecv$function$;
----
CREATE OR REPLACE FUNCTION ajbool_out(ajbool)
 RETURNS cstring
 LANGUAGE c
 IMMUTABLE STRICT
AS '$libdir/ajbool', $function$ajbool_out$function$;
----
CREATE OR REPLACE FUNCTION ajbool_in(cstring)
 RETURNS ajbool
 LANGUAGE c
 IMMUTABLE STRICT
AS '$libdir/ajbool', $function$ajbool_in$function$;
----
CREATE OR REPLACE FUNCTION hash_ajbool(ajbool)
 RETURNS integer
 LANGUAGE internal
 IMMUTABLE
AS $function$hashchar$function$;
