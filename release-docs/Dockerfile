FROM openttd/base:linux-debian-stretch-amd64

# Compiler used in this Docker
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    \
    clang \
    doxygen \
    gawk \
    && rm -rf /var/lib/apt/lists/*

COPY files/run.sh /usr/bin/

WORKDIR /workdir/source

ENTRYPOINT ["run.sh"]
CMD ["dev"]
