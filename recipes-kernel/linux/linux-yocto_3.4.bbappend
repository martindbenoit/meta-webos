# Copyright (c) 2013 LG Electronics, Inc.

PR_append = "webos3"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_qemux86 = " file://my_gfx.cfg \
                           file://sound.cfg \
                           file://enable_uinput.cfg \
                         "

# replace meta/cfg/kernel-cache/cfg/sound.cfg with new sound.cfg 
do_patch_append_qemux86() {
    cp -v -f ${S}/../sound.cfg ${S}/meta/cfg/kernel-cache/cfg/sound.cfg
}

