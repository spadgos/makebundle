# Should be absolute paths
# - TMP
# - DESTDIR

default: help

PLUGINS=$(shell find plugins -type f -printf '%f\n')

.PHONY: help default $(PLUGINS)

help:
	@echo "Available plugins"
	@for plugin in $(PLUGINS) ; do \
		echo ; \
		echo $$plugin ; \
		echo '---------------' ; \
		$(MAKE) --no-print-directory -f ./plugins/$$plugin help ; \
	done

$(PLUGINS):
	@$(MAKE) --no-print-directory -f ./plugins/$@ install
