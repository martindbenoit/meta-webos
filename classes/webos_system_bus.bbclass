# Copyright (c) 2012-2013 LG Electronics, Inc.
#
# webos_system_bus

# This class is to be inherited by the recipe for every component that offers
# Luna System Bus services.
#
# Variables that control this bbclass's behavior:
#
# WEBOS_SYSTEM_BUS_FILES_LOCATION
#   - The location of the system bus files to be installed. Defaults to
#     ${S}/service. Set to "" to skip.
#
# WEBOS_SYSTEM_BUS_SKIP_DO_TASKS
#   - If "1", all do_*() tasks or additions to them defined in this bbclass are
#     skipped.
#

RDEPENDS_${PN} += "luna-service2"

webos_system_bus_install_files () {
    local _LS_PRV_DIR="${D}$1"    # destination directory for private hub files
    local _LS_PUB_DIR="${D}$2"    # destination directory for public hub files
    local _LS_PRV_FILE="$3"       # match string for private hub files
    local _LS_PUB_FILE="$4"       # match string for public hub files
    local _LS_TREE="$5"           # tree under which to search for the files
    local i

    install -d $_LS_PRV_DIR
    install -d $_LS_PUB_DIR

    _LS_PUB=`find $_LS_TREE -name "$_LS_PUB_FILE"`
    _LS_PRV=`find $_LS_TREE -name "$_LS_PRV_FILE"`

    for i in $_LS_PUB; do
        _LS_PUB_DEST=`basename $i .pub`
        bbnote "PUBLIC: $_LS_PUB_DIR/$_LS_PUB_DEST"
        install -v -m 0644 $i $_LS_PUB_DIR/$_LS_PUB_DEST
    done

    for i in $_LS_PRV; do
        _LS_PRV_DEST=`basename $i .prv`
        bbnote "PRIVATE: $_LS_PRV_DIR/$_LS_PRV_DEST"
        install -v -m 0644 $i $_LS_PRV_DIR/$_LS_PRV_DEST
    done
}

# - Can't assume our current directory is still ${S}
# - Default to the pre Open webOS location (because it's intended everything in
#   Open webOS is not require installation by the recipe).
WEBOS_SYSTEM_BUS_FILES_LOCATION ?= "${S}/service"

do_install_append () {
    # Only want WEBOS_SYSTEM_BUS_SKIP_DO_TASKS to be expanded by bitbake => single quotes
    if [ '${WEBOS_SYSTEM_BUS_SKIP_DO_TASKS}' != 1 ]; then
        local tree=${WEBOS_SYSTEM_BUS_FILES_LOCATION}

        if [ -n "$tree" ]; then
            webos_system_bus_install_files ${webos_sysbus_prvservicesdir} ${webos_sysbus_pubservicesdir} "*.service.prv" "*.service.pub" "$tree"
            webos_system_bus_install_files ${webos_sysbus_prvrolesdir}    ${webos_sysbus_pubrolesdir}    "*.json.prv"    "*.json.pub"    "$tree"

            # If the files don't have .prv/.pub suffixes, then the same file is meant to be used for both (and there's no suffix to be removed)
            webos_system_bus_install_files ${webos_sysbus_prvservicesdir} ${webos_sysbus_pubservicesdir} "*.service"     "*.service"     "$tree"
            webos_system_bus_install_files ${webos_sysbus_prvrolesdir}    ${webos_sysbus_pubrolesdir}    "*.json"        "*.json"        "$tree"
        fi
    fi
}

FILES_${PN} += "${webos_sysbus_prvservicesdir} ${webos_sysbus_pubservicesdir}"
FILES_${PN} += "${webos_sysbus_prvrolesdir}    ${webos_sysbus_pubrolesdir}"
