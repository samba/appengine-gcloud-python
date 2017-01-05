#!/bin/sh

CLOUD_SDK=${1:-/opt/google-cloud-sdk}
CLOUD_SDK_BIN=${CLOUD_SDK}/bin

# NOTE: these settings are designed to facilitate *user* activity in the container.
CLOUDSDK_CORE_DISABLE_PROMPTS=1 ${CLOUD_SDK}/install.sh \
    --usage-reporting=false \
    --path-update=true \
    --command-completion true

# Common components for application development
echo Y | ${CLOUD_SDK_BIN}/gcloud components install \
    app-engine-python \
    cloud-datastore-emulator \
    gsutil \
    bq \
    kubectl \
    docker-credential-gcr
