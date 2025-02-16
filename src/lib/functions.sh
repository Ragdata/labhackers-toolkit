#!/usr/bin/env bash
####################################################################
# Author:       Ragdata
# Date:         12/02/2025
# License:      MIT License
# Copyright:    Copyright © 2025 Redeyed Technologies
####################################################################
# FUNCTIONS
####################################################################
TERM_ESC=$'\033'
TERM_CSI="${TERM_ESC}["
TERM_OSC="${TERM_ESC}]"
TERM_ST="${TERM_ESC}\\"

term::color::reset()			{ printf -- '%s0m' "$TERM_CSI"; }

term::red()						{ printf -- '%s31m' "$TERM_CSI"; }
term::green()					{ printf -- '%s32m' "$TERM_CSI"; }
term::gold()					{ printf -- '%s33m' "$TERM_CSI"; }
term::blue()					{ printf -- '%s34m' "$TERM_CSI"; }

RED="$(term::red)"
GREEN="$(term::green)"
GOLD="$(term::gold)"
BLUE="$(term::blue)"

RESET="$(term::color::reset)"
_0="$(term::color::reset)"

#-------------------------------------------------------------------
# echoError
#-------------------------------------------------------------------
echoError()
{
    local msg="$1" code="${2:-1}"

    printf -- "${RED}${msg}${_0}"
}

#-------------------------------------------------------------------
# errorExit
#-------------------------------------------------------------------
errorExit()
{
    local msg="ERROR :: " code="${2:-1}"

    [[ -n "${FUNCNAME[1]}" ]] && msg+="${FUNCNAME[1]} - "
    [[ -n "$1" ]] && msg+="$1"

    echoError "$msg"
    exit "$code"
}
#-------------------------------------------------------------------
# file2env
#-------------------------------------------------------------------
file2env()
{
    [[ (($# == 0)) || ! -f "$1" ]] && errorExit "No file passed or file not found"

    while IFS= read -r line
    do
        if [[ -n "$line" && "${line:0:1}" != "#" ]]; then
            key="${line##=*}"
            export "${key?}"
        fi
    done < "$1"
}
