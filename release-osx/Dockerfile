ARG DISTRO=osx
ARG DISTRO_TAG=10.13
FROM openttd/base:${DISTRO}-${DISTRO_TAG}

ARG OSX_DEPLOYMENT_TARGET=10.13
ENV MACOSX_DEPLOYMENT_TARGET=${OSX_DEPLOYMENT_TARGET}

# Rememner: only install static libraries, as we never want to link to (possibly incompatible) dylib/tbd
RUN OSXCROSS_MACPORTS_MIRROR="http://packages.macports.org" osxcross-macports --static install \
	freetype \
	icu \
	libpng \
	lzo2 \
	zlib \
	xz

RUN echo ${OSX_DEPLOYMENT_TARGET} > /etc/target-version

COPY files/run.sh /usr/bin/

WORKDIR /workdir/source

ENTRYPOINT ["run.sh"]
CMD []
