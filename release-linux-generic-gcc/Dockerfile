ARG ARCH=amd64
FROM openttd/base:linux-debian-stretch-${ARCH}

ARG ARCH

# Compiler used in this Docker
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    \
    binutils \
    g++ \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY files/run.sh /usr/bin/

ENV ARCH=${ARCH}

WORKDIR /workdir/source

ENTRYPOINT ["run.sh"]
CMD ["dev"]
