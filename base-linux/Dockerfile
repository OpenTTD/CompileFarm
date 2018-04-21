ARG DISTRO=debian
ARG DISTRO_TAG=stretch-slim
FROM ${DISTRO}:${DISTRO_TAG}

ENV DEBIAN_FRONTEND=noninteractive

LABEL \
    maintainer="info@openttd.org" \
    org.label-schema.description="OpenTTD Compile-Farm images" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://www.openttd.org/" \
    org.label-schema.vcs-url="https://github.com/OpenTTD/OpenTTD-CF" \
    org.label-schema.vendor=OpenTTD

# Blocks in this file are created as such that we have as many cache hits as
# possible between different Dockerfiles

# Dependencies needed to compile OpenTTD
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    \
    bzip2 \
    ca-certificates \
    git \
    gnupg2 \
    libc6-dev \
    libfile-fcntllock-perl \
    libfontconfig-dev \
    libicu-dev \
    liblzma-dev \
    liblzo2-dev \
    libsdl1.2-dev \
    libxdg-basedir-dev \
    make \
    mercurial \
    software-properties-common \
    subversion \
    tar \
    wget \
    xz-utils \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Fox up some files so OpenTTD picks up the right files
RUN cd /usr/lib/*-linux-gnu \
    && ln -s libiculx.a libsiculx.a \
    && ln -s libicule.a libsicule.a \
    && ln -s libicuuc.a libsicuuc.a \
    && ln -s libicudata.a libsicudata.a \
    && ln -s libicui18n.a libsicui18n.a \
    && rm liblzo2*.so*
