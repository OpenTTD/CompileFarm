ARG DISTRO=debian
ARG DISTRO_TAG=stretch-slim
FROM openttd/base:${DISTRO}-${DISTRO_TAG}

# Dependencies for some commit checkers
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    && rm -rf /var/lib/apt/lists/*

COPY files/run.sh /usr/bin/
COPY files/is-on-top-of-master.sh /usr/bin/
COPY git-hooks/hooks/* /git-hooks/

WORKDIR /workdir/source

ENTRYPOINT ["run.sh"]
CMD []
