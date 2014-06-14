# Should be absolute paths
# - TMP
# - DESTDIR

default: help

.PHONY: node help default

ifndef DESTDIR
$(error DESTDIR is not set)
endif
ifndef TMP
$(error TMP is not set)
endif

help:
	# TODO: documentation
	@echo "Usage:"
	@echo "NODE_VER=x.y.z DESTDIR=path TMP=path make node"

node: $(DESTDIR)/usr/bin/node

### Node js

NODEJS=nodejs-$(NODE_VER)

$(TMP)/$(NODEJS)/configure:
	mkdir -p $(TMP)/$(NODEJS)
	curl -L https://github.com/joyent/node/archive/v$(NODE_VER).tar.gz | tar xzv -C $(TMP)/$(NODEJS) --strip-components 1
	touch $@

$(TMP)/$(NODEJS)/config.gypi: $(TMP)/$(NODEJS)/configure
	cd $(@D); PKG_CONFIG_PATH=/usr/lib/pkgconfig/openssl.pc ./configure --prefix=/usr
	touch $@

$(DESTDIR)/usr/bin/node: $(TMP)/$(NODEJS)/config.gypi
	PORTABLE=1 $(MAKE) -j4 -C $(TMP)/$(NODEJS) DESTDIR=$(DESTDIR) install
	touch $@

