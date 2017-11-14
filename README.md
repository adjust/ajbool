# ajbool

A special boolean type that allows 'unknown' state without beeing NULL.
The intent is to allow a triple boolean value that can be used as PRIMARY key.
Expected intput is 't', 'f', 'u' for true, false and unknown.
Note ajbool can still be set to NULL if needed.

## usage

Typecast

```
SELECT true::ajbool, false::ajbool, NULL::bool::ajbool;
 ajbool | ajbool | ajbool
--------+--------+--------
 t      | f      | u
(1 row)

SELECT 't'::ajbool::bool, 'f'::ajbool::bool, 'u'::ajbool::bool;
 bool | bool | bool
------+------+------
 t    | f    | NULL

```

##Parallelism Support

PostgreSQL 9.6 introduced parallelism safety markings for functions.
The ajbool-00.0.1--0.0.2.sql in the extensions directory makrs these
as safe.  You should run this file after upgrading PostgreSQL.
