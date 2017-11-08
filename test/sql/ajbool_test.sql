BEGIN;
\pset null 'NULL'
SELECT true::ajbool, false::ajbool, NULL::bool::ajbool;
SELECT 't'::ajbool::bool, 'f'::ajbool::bool, 'u'::ajbool::bool;
CREATE TABLE test (i int, state ajbool);
INSERT INTO test
SELECT i, (CASE i%3 WHEN 0 THEN true WHEN 1 THEN false ELSE NULL END)::bool
FROM generate_series(1,10) i;
SELECT COUNT(1) FROM test where state;
SELECT COUNT(1) FROM test where not state;
ROLLBACK;