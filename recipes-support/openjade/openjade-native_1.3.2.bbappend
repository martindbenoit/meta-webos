# Copyright (c) 2013 LG Electronics, Inc.

PR_append = "webos1"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://Makefile.prog.in.patch \
"
