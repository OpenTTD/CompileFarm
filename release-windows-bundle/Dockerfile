ARG DISTRO=debian
ARG DISTRO_TAG=stretch-slim
ARG TARGET_ARCHITECTURE
FROM openttd/base:${DISTRO}-${DISTRO_TAG}-windows-cross-${TARGET_ARCHITECTURE}
#Args are resetted after a FROM directive
ARG TARGET_ARCHITECTURE
ENV DEBIAN_FRONTEND=noninteractive


LABEL \
    maintainer="info@openttd.org" \
    org.label-schema.description="OpenTTD Compile-Farm images" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://www.openttd.org/" \
    org.label-schema.vcs-url="https://github.com/OpenTTD/OpenTTD-CF" \
    org.label-schema.vendor=OpenTTD

    
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    \
    zip \
    dos2unix \
    && rm -rf /var/lib/apt/lists/*


COPY files/run.sh /usr/bin/

WORKDIR /workdir/source
#Store the target architecture in an environment variable so that the run.sh script can use it
ENV TARGET_ARCHITECTURE=$TARGET_ARCHITECTURE

ENTRYPOINT ["run.sh"]
CMD ["dev"]
