ARG DISTRO=debian
ARG DISTRO_TAG=stretch-slim
FROM openttd/base:${DISTRO}-${DISTRO_TAG}

RUN cd / && git clone https://github.com/tpoechtrager/osxcross
RUN cd /osxcross && git clone https://github.com/tpoechtrager/apple-libtapi.git
RUN cd /osxcross && git clone https://github.com/tpoechtrager/cctools-port.git

RUN wget -q -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && add-apt-repository 'deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch-6.0 main' \
    && apt-get update \
	&& apt-get install -y --no-install-recommends \
	    cmake \
	    clang-6.0 \
	    patch \
	    libssl-dev \
	    libxml2-dev \
	    llvm-6.0-dev \
	    zip \
	&& update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 100 \
	&& update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 100 \
	&& update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-6.0 100 \
	&& rm -rf /var/lib/apt/lists/*

ARG OSX_SDK_URL
ARG OSX_SDK_VERSIION=10.13
RUN cd /osxcross/tarballs \
	&& wget -q ${OSX_SDK_URL}/MacOSX${OSX_SDK_VERSIION}.sdk.tar.xz

# As we run as root, make sure we don't keep the user in the tar (default tar behaviour for superuser)
RUN sed -i 's/tarflags="xf"/tarflags="-x --no-same-owner -f"/' /osxcross/tools/tools.sh
# Insert support for 10.12 and 10.13
RUN sed -i 's/10.11\*) TARGET=darwin15; X86_64H_SUPPORTED=1; ;;/10.11*) TARGET=darwin15; X86_64H_SUPPORTED=1; ;;\n10.12*) TARGET=darwin16; X86_64H_SUPPORTED=1; ;;\n10.13*) TARGET=darwin17; X86_64H_SUPPORTED=1; ;;/' /osxcross/build.sh
RUN sed -i 's/10.12\* ) OSXVERSION="darwin_16" ;;/10.12* ) OSXVERSION="darwin_16" ;;\n10.13* ) OSXVERSION="darwin_17" ;;/' /osxcross/tools/osxcross-macports
# Stop just before tests; we know they fail. We fix that after the build step
RUN sed -i 's/unset MACOSX_DEPLOYMENT_TARGET/unset MACOSX_DEPLOYMENT_TARGET\nexit 0/' /osxcross/build.sh

# Install most of the cross compiler
RUN cd /osxcross && \
    OSX_VERSION_MIN=10.9 SDK_VERSION=${OSX_SDK_VERSIION} UNATTENDED=1 ./build.sh

# Install libtapi support
RUN cd /osxcross/apple-libtapi && \
    INSTALLPREFIX=/osxcross/target ./build.sh && \
    ./install.sh
# Install latest cctools
RUN cd /osxcross/cctools-port/cctools &&  \
    ./configure --prefix=/osxcross/target --target=x86_64-apple-darwin17 --with-libtapi=/osxcross/target && \
    make && \
    make install
# Install compiler-rt
RUN cd /osxcross && ./build_compiler_rt.sh

# compiler-rt tells this at the end, but you have to do it manually
RUN mkdir -p /usr/lib/llvm-6.0/bin/../lib/clang/6.0.1/include && \
    mkdir -p /usr/lib/llvm-6.0/bin/../lib/clang/6.0.1/lib/darwin && \
    cp -rv /osxcross/build/compiler-rt/include/sanitizer /usr/lib/llvm-6.0/bin/../lib/clang/6.0.1/include && \
    cp -v /osxcross/build/compiler-rt/build/lib/darwin/*.a /usr/lib/llvm-6.0/bin/../lib/clang/6.0.1/lib/darwin && \
    cp -v /osxcross/build/compiler-rt/build/lib/darwin/*.dylib /usr/lib/llvm-6.0/bin/../lib/clang/6.0.1/lib/darwin

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/osxcross/target/bin

RUN ln -s /osxcross/target/SDK/MacOSX${OSX_SDK_VERSIION}.sdk/System /System
RUN echo ${OSX_SDK_VERSIION} > /etc/sdk-version
