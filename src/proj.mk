# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := proj
$(PKG)_WEBSITE  := https://trac.osgeo.org/proj/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.1.1
$(PKG)_CHECKSUM := 82f1345e5fa530c407cb1fc0752e83f8d08d2b98772941bbdc7820241f7fada2
$(PKG)_SUBDIR   := proj-$($(PKG)_VERSION)
$(PKG)_FILE     := proj-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://download.osgeo.org/proj/$($(PKG)_FILE)
$(PKG)_DEPS     := cc sqlite

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://proj.org/download.html' | \
    $(SED) -n 's,.*proj-\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --with-mutex
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef

