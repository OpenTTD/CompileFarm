ARG DISTRO=debian
ARG DISTRO_TAG=stretch-slim
FROM openttd/base:${DISTRO}-${DISTRO_TAG}

# Compiler used in this Docker
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    \
    binutils \
    g++ \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Dependencies needed to create deb files
RUN apt-get update && apt-get install -y --no-install-recommends \
    debhelper \
    fakeroot \
    && rm -rf /var/lib/apt/lists/*

COPY files/run.sh /usr/bin/

WORKDIR /workdir/source

ENTRYPOINT ["run.sh"]
CMD ["dev"]
