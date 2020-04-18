#!/bin/bash

export RED='\n\033[0;31m'
export GREEN='\n\033[0;32m'
export NC='\033[0m'

function installTpl() {
  TPL_VERSION="v0.4.6"
  TPL_URL="https://github.com/schneidexe/tpl/releases/download/$TPL_VERSION/tpl-linux-amd64"
  curl -fsSLo /usr/local/bin/tpl $TPL_URL &&
  chmod +x /usr/local/bin/tpl &&
  tpl -v
}

function parseTplTemplates() {
  find "$1" -type f -name "*.tpl" | while read file; do
    echo "Parsing template ${file%.tpl}"
    tpl -t "${file}" > "${file%.tpl}" && rm "${file}"
  done
}

function prefixOutput() {
    local prefix="$1"
    shift
    "$@" > >(sed "s/^/$prefix: /") 2> >(sed "s/^/$prefix (err): /" >&2)
}
