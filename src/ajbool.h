#ifndef AJBOOL_H
#define AJBOOL_H
#include "fmgr.h"

typedef int8 ajbool;
#define DatumGetAjBool(X) ((ajbool) GET_1_BYTE(X))
#define AjBoolGetDatum(X) ((Datum) SET_1_BYTE(X))

#define PG_GETARG_AJBOOL(n)    DatumGetAjBool(PG_GETARG_DATUM(n))
#define PG_RETURN_AJBOOL(x)    return AjBoolGetDatum(x)

Datum ajbool_to_bool(PG_FUNCTION_ARGS);
Datum bool_to_ajbool(PG_FUNCTION_ARGS);
Datum ajbool_in(PG_FUNCTION_ARGS);
Datum ajbool_out(PG_FUNCTION_ARGS);

#endif   /* AJBOOL_H */