#!/bin/bash

set -euf -o pipefail
set -x


fail () {
    echo "$2" >&2
    exit $1
}

test -f "${1}" || fail 2 "A package list is required." 


apt-get update
apt-get install -y $(cat "${1}")
apt-get clean


# Upgrade pip first.
pip install --upgrade pip

# Python dependencies
pip install -r $(dirname $0)/requirements.txt


apt-get autoremove
apt-get clean autoclean