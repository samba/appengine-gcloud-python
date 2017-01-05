FROM python:2.7
MAINTAINER Sam Briesemeister


ARG GCLOUD_SDK_VERSION
ENV GCLOUD_SDK_VERSION=${GCLOUD_SDK_VERSION:-138.0.0}
ENV GCLOUD_SDK_URL=https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz

# Dependencies for Google AppEngine Python
RUN apt-get -q update && apt-get -q install -y libffi-dev libssl-dev libjpeg62-turbo-dev
RUN pip -q install --upgrade pip
RUN pip -q install Pillow

RUN mkdir -p /opt/scripts
COPY scripts/*.sh /opt/scripts

# Install Google Cloud SDK
RUN mkdir -p /opt && cd /opt &&  wget -q -O - ${GCLOUD_SDK_URL} | tar zxf - \
    && /bin/bash /opt/scripts/setup.sh /opt/google-cloud-sdk

ENV PATH /google-cloud-sdk/bin:$PATH
