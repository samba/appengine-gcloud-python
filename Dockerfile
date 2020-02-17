FROM python:3.8-slim as main 

ARG GCLOUD_SDK_VERSION
ENV GCLOUD_SDK_VERSION=${GCLOUD_SDK_VERSION:-280.0.0}
ENV PATH /opt/google-cloud-sdk/bin:/usr/local/bin:$PATH

COPY scripts/*.sh /opt/
COPY requirements.txt /opt/
COPY packages.txt /opt/
RUN ln -s /opt/env_secure.sh /usr/local/bin/ && chmod +x /opt/env_secure.sh

# Dependencies for Google AppEngine Python
RUN bash /opt/setup_debian.sh /opt/packages.txt

# Install Google Cloud SDK
RUN bash /opt/setup_appengine.sh /opt/google-cloud-sdk


