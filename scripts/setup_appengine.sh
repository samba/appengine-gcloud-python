#!/bin/sh

# NB this script expects the following environment variables to be defined (via Dockerfile)
# - GCLOUD_SDK_VERSION

CLOUD_SDK=${1:-/opt/google-cloud-sdk}
CLOUD_SDK_BIN=${CLOUD_SDK}/bin
GCLOUD_SDK_URL=https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz

# Download and extract the gcloud SDK
cd $(dirname ${CLOUD_SDK})  # NB the tarball extracts to ./google-cloud-sdk
wget -q -O - ${GCLOUD_SDK_URL} | tar -zxf - 

# NOTE: these settings are designed to facilitate *user* activity in the container.
CLOUDSDK_CORE_DISABLE_PROMPTS=1 ${CLOUD_SDK}/install.sh \
    --usage-reporting=false \
    --path-update=true \
    --command-completion true

# A handy shortcut for selectively enabling them :)
gcloud_components () {
  # echo bq
  # echo kubectl
  # echo gsutil
  # echo docker-credential-gcr
  echo app-engine-python
  # echo cloud-datastore-emulator
}


# Install the desired components 
echo Y | ${CLOUD_SDK_BIN}/gcloud components install $(gcloud_components) 


rm -rf /opt/google-cloud-sdk/.install/.backup
