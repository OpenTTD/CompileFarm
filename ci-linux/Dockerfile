ARG DISTRO=debian
ARG DISTRO_TAG=stretch-slim
FROM openttd/base:${DISTRO}-${DISTRO_TAG}

# Extra packages needed for this Docker
ARG EXTRA_PACKAGES
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    \
    ${EXTRA_PACKAGES} \
    && rm -rf /var/lib/apt/lists/*

# Install openttd-opengfx, so we can run regression
RUN apt-get update && apt-get install -y --no-install-recommends \
    openttd-opengfx \
    && rm -rf /var/lib/apt/lists/*

COPY files/run.sh /usr/bin/

WORKDIR /workdir/source

ENTRYPOINT ["run.sh"]
CMD []
