#!/bin/bash
# args:  <debian_packages.txt>  <python_requirements.txt>


set -euf -o pipefail
set -x


fail () {
    echo "$2" >&2
    exit $1
}

test -f "${1}" || fail 2 "A package list is required." 


# NB: some packages install man pages
mkdir -p /usr/share/man/man1

apt-get update
apt-get install -y $(cat "${1}")
apt-get clean


# Upgrade pip first.
pip install --upgrade pip

# Python dependencies
pip install -r ${2} 


apt-get autoremove
apt-get clean autoclean
