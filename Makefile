# Should be absolute paths
# - TMP
# - DESTDIR

default: help

PLUGINS=$(shell find plugins -type f -printf '%f\n')

.PHONY: help default $(PLUGINS)

help:
	@echo "Usage:"
	@echo "NODE_VER=x.y.z DESTDIR=path TMP=path $(MAKE) node"

$(PLUGINS):
	$(MAKE) -f ./plugins/$@ install
