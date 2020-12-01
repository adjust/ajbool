#http://blog.pgxn.org/post/4783001135/extension-makefiles pg makefiles
EXTENSION = ajbool
EXTVERSION = $(shell grep default_version $(EXTENSION).control | \
               sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")
PG_CONFIG ?= pg_config
DATA = $(wildcard *--*.sql)
PGXS := $(shell $(PG_CONFIG) --pgxs)
MODULE_big = ajbool
OBJS = $(patsubst %.c,%.o,$(wildcard src/*.c))
TESTS        = $(wildcard test/sql/*.sql)
REGRESS      = $(patsubst test/sql/%.sql,%,$(TESTS))
REGRESS_OPTS = --inputdir=test --load-extension=ajbool
PG_CPPFLAGS  = --std=c99 -Wall -Wextra -Wno-unused-parameter

include $(PGXS)

ifeq ($(shell test $(VERSION_NUM) -lt 90600; echo $$?),0)
REGRESS := $(filter-out parallel_test, $(REGRESS))
endif

all: $(EXTENSION)--$(EXTVERSION).sql

$(EXTENSION)--$(EXTVERSION).sql: sql/$(EXTENSION).sql sql/parallel.sql
	@printf -- "-- complain if script is sourced in psql, rather than via CREATE EXTENSION\n" > $@
	@printf -- "\\\echo Use \"CREATE EXTENSION ${EXTENSION}\" to load this file. \quit\n\n" >> $@
	@cat $^ >> $@
