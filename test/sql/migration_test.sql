BEGIN;
DROP EXTENSION ajbool;
CREATE EXTENSION ajbool VERSION '0.0.1';
ALTER EXTENSION ajbool UPDATE TO '0.0.2';
ALTER EXTENSION ajbool UPDATE TO '0.0.1';
SELECT e.extname, e.extversion FROM pg_catalog.pg_extension e WHERE e.extname = 'ajbool' ORDER BY 1;
ROLLBACK;

BEGIN;
DROP EXTENSION ajbool;
CREATE EXTENSION ajbool VERSION '0.0.2';
ALTER EXTENSION ajbool UPDATE TO '0.0.1';
ALTER EXTENSION ajbool UPDATE TO '0.0.2';
SELECT e.extname, e.extversion FROM pg_catalog.pg_extension e WHERE e.extname = 'ajbool' ORDER BY 1;
ROLLBACK;