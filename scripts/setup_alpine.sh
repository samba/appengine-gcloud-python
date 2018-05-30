#!/bin/sh

set -euf -o pipefail

DEV_PACKAGES="libffi-dev libjpeg-turbo-dev libressl-dev python2-dev musl-dev zlib-dev"
BUILD_PACKAGES="gcc"


apk --no-cache add ${DEV_PACKAGES} ${BUILD_PACKAGES}  python2 py2-pip zlib make wget
pip install -q Pillow

apk del -r ${DEV_PACKAGES} ${BUILD_PACKAGES} 

