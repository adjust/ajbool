#include "postgres.h"
#include "ajbool.h"

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(ajbool_to_bool);
PG_FUNCTION_INFO_V1(bool_to_ajbool);
PG_FUNCTION_INFO_V1(ajbool_in);
PG_FUNCTION_INFO_V1(ajbool_out);

/*
 * cast from ajbool to bool
 */
Datum
ajbool_to_bool(PG_FUNCTION_ARGS)
{
    switch(PG_GETARG_AJBOOL(0))
    {
        case 0: PG_RETURN_BOOL(false);
        case 1: PG_RETURN_BOOL(true);
        default: PG_RETURN_NULL();
    }
}

/*
 * cast from bool to ajbool
 * null values are casted to 'u' (-1)
 */
Datum
bool_to_ajbool(PG_FUNCTION_ARGS)
{
    if (PG_ARGISNULL(0))
        PG_RETURN_AJBOOL(-1);

    if (PG_GETARG_BOOL(0) == false)
        PG_RETURN_AJBOOL(0);
    else
        PG_RETURN_AJBOOL(1);
}

Datum
ajbool_in(PG_FUNCTION_ARGS)
{
    char       *ch = PG_GETARG_CSTRING(0);
    switch (ch[0])
    {
        case 't' : PG_RETURN_AJBOOL(1);
        case 'f' : PG_RETURN_AJBOOL(0);
        default  : PG_RETURN_AJBOOL(-1);
    }
}

Datum
ajbool_out(PG_FUNCTION_ARGS)
{
    ajbool      n      = PG_GETARG_AJBOOL(0);
    char       *result = (char *) palloc(2);
    switch (n)
    {
        case 1  :  result[0] = 't'; break;
        case 0  :  result[0] = 'f'; break;
        default :  result[0] = 'u';
    }
    result[1] = '\0';

    PG_RETURN_CSTRING(result);
}
