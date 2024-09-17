SUBDIRS := $(wildcard */)
SUBDIRSCLEAN=$(addsuffix .clean,$(SUBDIRS))
SUBDIRSHTML=$(addsuffix .html,$(SUBDIRS))
SUBDIRSSINGLEHTML=$(addsuffix .singlehtml,$(SUBDIRS))

PYTHON := python3
ROOT := $(shell pwd)
VENV := $(ROOT)/.venv
PIP := $(VENV)/bin/pip
SPHINXBUILD := $(VENV)/bin/sphinx-build
IS_CERTIFIED ?= 0

.DEFAULT: all

.PHONY: all bootstrap clean distclean pdf html $(SUBDIRS) $(SUBDIRSCLEAN)

all: pdf html

pdf: $(SUBDIRS)

html: $(SUBDIRSHTML)

singlehtml: $(SUBDIRSSINGLEHTML)

bootstrap:
	$(PYTHON) -m venv .venv
	$(PIP) install -r requirements.txt

clean: $(SUBDIRSCLEAN)

distclean: clean
	- rm -r $(VENV)

$(SUBDIRSCLEAN):
	- SPHINXBUILD=$(SPHINXBUILD) $(MAKE) -C $(basename $@) clean

$(SUBDIRS):
	IS_CERTIFIED=$(IS_CERTIFIED) SPHINXBUILD=$(SPHINXBUILD) $(MAKE) -C $@ latexpdf

$(SUBDIRSHTML):
	IS_CERTIFIED=$(IS_CERTIFIED) SPHINXBUILD=$(SPHINXBUILD) $(MAKE) -C $(basename $@) html

$(SUBDIRSSINGLEHTML):
	IS_CERTIFIED=$(IS_CERTIFIED) SPHINXBUILD=$(SPHINXBUILD) $(MAKE) -C $(basename $@) singlehtml

