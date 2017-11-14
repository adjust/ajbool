
-- adds parallel suport
DO $$
DECLARE version_num integer;
BEGIN
	SELECT current_setting('server_version_num') INTO STRICT version_num;
	IF version_num > 90600 THEN
		EXECUTE $E$ ALTER FUNCTION ajbool_in(cstring) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION ajbool_out(ajbool) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION ajbool_recv(internal) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION ajbool_send(ajbool) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION ajbool_to_bool(ajbool) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION bool_to_ajbool(bool) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION ajbool_eq(ajbool, ajbool) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION ajbool_ne(ajbool, ajbool) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION ajbool_lt(ajbool, ajbool) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION ajbool_le(ajbool, ajbool) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION ajbool_gt(ajbool, ajbool) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION ajbool_ge(ajbool, ajbool) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION ajbool_cmp(ajbool, ajbool) PARALLEL SAFE $E$;
		EXECUTE $E$ ALTER FUNCTION hash_ajbool(ajbool) PARALLEL SAFE $E$;
	END IF;
END;
$$;
