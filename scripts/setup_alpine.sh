#!/bin/sh

set -euf -o pipefail

DEV_PACKAGES="libffi-dev libjpeg-turbo-dev libressl-dev python2-dev musl-dev zlib-dev"
BUILD_PACKAGES="gcc"

apk --no-cache add ${DEV_PACKAGES} ${BUILD_PACKAGES}  python2 py2-pip zlib make wget libressl

# Python dependencies
pip install -q unittest2 pytest nose flake8 virtualenv
pip install -q Pillow 

# NB: applications of this container must install more Python packages, which can require
# compiled modules, i.e. requiring gcc and friends to be present in the container.
# apk del -r ${DEV_PACKAGES} ${BUILD_PACKAGES} 

