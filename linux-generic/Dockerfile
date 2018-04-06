ARG DISTRO=debian
ARG BASE_IMAGE=stretch
FROM ${DISTRO}:${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && \
	apt-get install -y --no-install-recommends \
	\
	build-essential \
	git \
	libfile-fcntllock-perl \
	libfontconfig-dev \
	libicu-dev \
	liblzma-dev \
	liblzo2-dev \
	libsdl1.2-dev \
	libxdg-basedir-dev \
	mercurial \
	patch \
	subversion \
	zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN cd /usr/lib/*-linux-gnu \
	&& ln -s libiculx.a libsiculx.a \
	&& ln -s libicule.a libsicule.a \
	&& ln -s libicuuc.a libsicuuc.a \
	&& ln -s libicudata.a libsicudata.a \
	&& ln -s libicui18n.a libsicui18n.a \
	&& rm liblzo2*.so*

LABEL \
	maintainer info@openttd.org \
	org.label-schema.description="OpenTTD Compile-Farm image to produce tarballs" \
	org.label-schema.schema-version="1.0" \
	org.label-schema.url="https://www.openttd.org/" \
	org.label-schema.vcs-url="https://github.com/OpenTTD/OpenTTD-CF" \
	org.label-schema.vendor=OpenTTD

COPY run.sh /usr/bin/

WORKDIR /workdir/source

ENTRYPOINT ["run.sh"]
CMD ["dev"]
