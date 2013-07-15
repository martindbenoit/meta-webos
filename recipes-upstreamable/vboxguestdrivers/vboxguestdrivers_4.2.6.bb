# Copyright (c) 2013 LG Electronics, Inc.

require vboxguestdrivers.inc

PR = "${INC_PR}.1"

VBOX_NAME = "VirtualBox-${PV}"

SRC_URI = "http://download.virtualbox.org/virtualbox/${PV}/${VBOX_NAME}.tar.bz2 \
           file://Makefile.utils \
          "
SRC_URI[md5sum] = "d680aeb3b4379b8281527aeb012b2df5"
SRC_URI[sha256sum] = "54526091bc2aa66b88ca878dd9ecc4466f96d607db2f6678a9d673ecf6646ae3"

