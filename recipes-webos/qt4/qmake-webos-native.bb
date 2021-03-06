# Copyright (c) 2012-2013 LG Electronics, Inc.

# This recipe only works for -native => no BBCLASSEXTEND = "native"

inherit native
inherit webos_program

# XXX OE-core requires that we break up the native from the non-native. It would
# be cleaner to split up what's done by the ./configure script invoked in the
# qt4-webos recipe's do_configure() into the portion that builds qmake-palm and
# the portion that then uses it to generate the Makefiles for qt4-webos. But
# it's simpler and less error-prone to leave ./configure as it is and continue
# to build (but not install) a native qmake-palm when building qt4-webos, and
# then to use the do_configure() from the qt4-webos recipe here to make sure we
# build the qmake-palm and the other *-palm utilities for use by other components
# exactly the same way.

require qt4-webos.inc

# Fix-up the settings from qt4-webos to what they should be for qmake-webos
SUMMARY = "Open webOS edition of the qmake makefile configurator from Qt4"
SECTION = "devel/tools"

# We pass configure -glib, so it needs to be present
DEPENDS = "glib-2.0-native"

PR = "${INC_PR}.0"

PALM_BUILD_DIR = "${S}/../qt-build-native-${BUILD_ARCH}"

# remove dependency on MACHINE in native recipe
QT4_MACHINE_CONFIG_ARCH_LITE_QPA = "-qpa"
QT4_MACHINE_CONFIG_FLAGS = "-xplatform qws/linux-qemux86-g++ -no-neon -no-rpath -DPALM_DEVICE -qconfig palm"
# this is wrong but better then depending on MACHINE variable
export WEBOS_CONFIG="webos qemux86"

# Only qmake-palm is compiled during do_configure, so build the rest in
# do_compile().
do_compile() {
    oe_runmake -C ${PALM_BUILD_DIR}/src/tools
}

do_install() {
    # Only install the *-palm utilities
    oe_runmake -C ${PALM_BUILD_DIR} INSTALL_ROOT=${D} install_qmake
    oe_runmake -C ${PALM_BUILD_DIR}/src/tools INSTALL_ROOT=${D} install
}

