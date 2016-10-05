#==============================================================================#
# CIMPLE MAKEFILE
#==============================================================================#

#==============================================================================#
# Compiler
#==============================================================================#
CC=gcc
CFLAGS=-Wall -Wextra -O2
#CFILES=$(shell ls *.c)
PROGS=$(CFILES:%.c=%)

#==============================================================================#
# Directories
#==============================================================================#
PREFIX=./
SRCDIR=$(PREFIX)src
BINDIR=$(PREFIX)bin
MUTEXDIR=$(SRCDIR)/mutex

#==============================================================================#
# Dependencies
#==============================================================================#
LIBS=-pthread
MUTEX_DEPS=$(LIBS)

#==============================================================================#
# Commands
#==============================================================================#
MKDIR=@mkdir -pv
CLEAN=@rm -frv

#==============================================================================#
# Targets
#==============================================================================#
.PHONY: all createdir clean

all: createdir hello

createdir:
	@echo "[Make]> Creating directories."
	$(MKDIR) $(BINDIR)

hello:
	@echo "[Make]> Compiling hello."
	$(CC) $(CFLAGS) -o $(BINDIR)/$@ $(SRCDIR)/$@.c

$(MUTEXDIR)/%: %.c
	@echo "[Make]> Compiling mutex."
	$(CC) $(CFLAGS) $(MUTEX_DEPS) -o $(BINDIR)/% $^

#mutex:
#	@echo "[Make]> Compiling mutex."
#	echo $(patsubst $(MUTEXDIR)/%.c,$(BINDIR)/%.o,./src/mutex/hello.c)
#	for source in $(shell find $(MUTEXDIR) -name '*.c') ; do \
#		$(CC) $(CFLAGS) $(MUTEX_DEPS) $$source -o $$(patsubst $(MUTEXDIR)/%.c,$(BINDIR)/%.o,$$(source)) ; \
#	done

clean:
	@echo "[Make]> Cleaning binaries."
	$(CLEAN) $(BINDIR)/*
