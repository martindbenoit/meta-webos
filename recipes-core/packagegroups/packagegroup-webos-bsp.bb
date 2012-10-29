# (c) Copyright 2012  Hewlett-Packard Development Company, L.P. 

DESCRIPTION = "Emulator BSP components for Open webOS"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

PR = "r2"

inherit packagegroup

PACKAGE_ARCH = "${MACHINE_ARCH}"

ALLOW_EMPTY = "1"

RDEPENDS_${PN} = " \
    base-files \
    initscripts \
    udev  \
    update-rc.d  \
    upstart-initscripts \
    netbase \
"
# For backwards compatibility after rename
# I don't think these are needed
RPROVIDES_${PN} = "task-webos-boot"
RREPLACES_${PN} = "task-webos-boot"
RCONFLICTS_${PN} = "task-webos-boot"
