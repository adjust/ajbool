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
