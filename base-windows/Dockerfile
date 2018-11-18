ARG DISTRO=debian
ARG DISTRO_TAG=stretch-slim
FROM ${DISTRO}:${DISTRO_TAG}
#This arg is placed after the from to avoid it being resetted
ARG TARGET_ARCHITECTURE

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
    ca-certificates \
    git \
    gnupg2 \
    make \
    software-properties-common \
    tar \
    wget \
    build-essential            \
    mingw-w64 && \
    rm -rf /var/lib/apt/lists/*


WORKDIR /workdir

#Compiling zlib
RUN wget http://zlib.net/zlib-1.2.11.tar.gz -O- | tar xfz - && \
    cd zlib* && \
    CC=${TARGET_ARCHITECTURE}-w64-mingw32-gcc prefix=/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32 ./configure --static && \
    make install && \
    cd .. && rm -r zlib*

#Compiling libpng
RUN wget https://sourceforge.net/projects/libpng/files/libpng16/1.6.35/libpng-1.6.35.tar.gz -O- | tar xfz - && \
    cd l*png* && \
    ./configure \
    --host=${TARGET_ARCHITECTURE}-w64-mingw32 \
    --prefix=/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32 \
    CPPFLAGS="-I/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/include" \
    LDFLAGS="-L/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib" && \
    make install && \
    cd .. && rm -r l*png*

#Compiling liblzo
RUN wget http://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz -O- | tar xfz - && \
    cd lzo* && \
    ./configure \
    --host=${TARGET_ARCHITECTURE}-w64-mingw32 \
    --prefix=/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32 \
    --enable-static \
    CPPFLAGS="-I/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/include" \
    LDFLAGS="-L/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib" && \
    make install && \
    cd .. && rm -r lzo*

#Compiling libfreetype
RUN wget http://downloads.sourceforge.net/project/freetype/freetype2/2.9/freetype-2.9.tar.gz -O- | tar xfz - && \
    cd freetype* && \
    ./configure \
    --host=${TARGET_ARCHITECTURE}-w64-mingw32 \
    --prefix=/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32 \
    --enable-static \
    CPPFLAGS="-I/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/include" \
    LDFLAGS="-L/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib" \
    PKG_CONFIG_LIBDIR=/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib/pkgconfig && \
    make install && \
    cd .. && rm -r freetype*

#Compiling libxz
RUN wget http://tukaani.org/xz/xz-5.2.4.tar.gz -O- | tar xfz - && \
    cd xz* && \
    ./configure \
    --host=${TARGET_ARCHITECTURE}-w64-mingw32 \
    --prefix=/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32 \
    --enable-static --disable-threads \
    CPPFLAGS="-I/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/include" \
    LDFLAGS="-L/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib" && \
    make install && \
    cd .. && rm -r xz*

#Compiling ICU natively (not using the cross-compiler)
RUN wget http://download.icu-project.org/files/icu4c/57.1/icu4c-57_1-src.tgz -O- | tar xfz - && \
    mkdir icu/build && \
    cd icu/build && \
    ../source/runConfigureICU Linux/gcc && \
    make -j`nproc` && \
    cd .. && \
                    \
#Cross-compiling ICU
    mkdir build-cross && \
    cd build-cross && \
    env CPPFLAGS="-I/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/include" \
        LDFLAGS="-L/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib" \
        PKG_CONFIG_LIBDIR=/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib/pkgconfig \
    ../source/runConfigureICU MinGW \
    --host=${TARGET_ARCHITECTURE}-w64-mingw32 \
    --prefix=/usr/local/${TARGET_ARCHITECTURE}-w64-mingw32 \
    --enable-static --disable-shared --disable-strict \
    --with-cross-build=`pwd`/../build && \
    make install -j`nproc` && \
    cd ../.. && rm -r icu
    

#Fox up some files so OpenTTD picks up the right files
#See https://wiki.openttd.org/Cross-compiling_for_Windows#OpenTTD_with_ICU_57_and_earlier
RUN mv /usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib/libsicudt.a /usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib/libsicudt.a.old && \
    ln -s sicudt.a /usr/local/${TARGET_ARCHITECTURE}-w64-mingw32/lib/libsicudt.a
