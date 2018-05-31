#!/bin/sh

set -euf -o pipefail
set -x

DEV_PACKAGES="libffi-dev libjpeg-turbo-dev libressl-dev python2-dev musl-dev zlib-dev"
BUILD_PACKAGES="gcc build-base"
PYTHON_ALPINE="py2-cffi py2-openssl py2-pip python2"

apk --no-cache add ${DEV_PACKAGES} ${BUILD_PACKAGES} ${PYTHON_ALPINE} zlib wget libressl 

# Python dependencies
pip install -q unittest2 pytest nose flake8 virtualenv
pip install -q Pillow
pip install -q 'urllib3[secure]'

# NB: applications of this container must install more Python packages, which can require
# compiled modules, i.e. requiring gcc and friends to be present in the container.
# apk del -r ${DEV_PACKAGES} ${BUILD_PACKAGES} 

