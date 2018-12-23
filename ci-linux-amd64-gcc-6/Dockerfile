FROM openttd/base:linux-debian-stretch-amd64

RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    binutils \
    g++=4:6.* \
    gcc=4:6.* \
    && rm -rf /var/lib/apt/lists/*

# Install openttd-opengfx, so we can easier run the regression tests
RUN apt-get update && apt-get install -y --no-install-recommends \
    openttd-opengfx \
    && rm -rf /var/lib/apt/lists/*

COPY files/run.sh /usr/bin/

WORKDIR /workdir/source

ENTRYPOINT ["run.sh"]
CMD []
