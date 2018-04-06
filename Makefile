DOCKER=$(which docker)

LINUX_DEB_TARGETS =
LINUX_DEB_TARGETS += debian-stretch-amd64 debian-stretch-i386
LINUX_DEB_TARGETS += debian-jessie-amd64 debian-jessie-i386
LINUX_DEB_TARGETS += debian-wheezy-amd64 debian-wheezy-i386
LINUX_DEB_TARGETS += ubuntu-trusty-amd64 ubuntu-trusty-i386
LINUX_DEB_TARGETS += ubuntu-xenial-amd64 ubuntu-xenial-i386
LINUX_DEB_TARGETS += ubuntu-artful-amd64 ubuntu-artful-i386

LINUX_CI_TARGETS=amd64 i386

LINUX_GENERIC_TARGETS=amd64 i386

.PHONY: all
all: linux

.PHONY: prune
prune:
	$(DOCKER) image prune -f

.PHONY: linux
linux: linux-deb linux-ci linux-generic

.PHONY: linux-deb
linux-deb: $(LINUX_DEB_TARGETS:%=linux-deb-%)

.PHONY: linux-ci
linux-ci: $(LINUX_CI_TARGETS:%=linux-ci-%)

.PHONY: linux-generic
linux-generic: $(LINUX_GENERIC_TARGETS:%=linux-generic-%)

.PHONY: $(LINUX_DEB_TARGETS:%=linux-deb-%)
$(LINUX_DEB_TARGETS:%=linux-deb-%):
	cd linux-deb && DOCKER_OPTS="--pull" DOCKER_TAG=$(@:linux-deb-%=%) IMAGE_NAME=openttd/compile-farm:$(@:linux-deb-%=%) hooks/build

.PHONY: $(LINUX_CI_TARGETS:%=linux-ci-%)
$(LINUX_CI_TARGETS:%=linux-ci-%):
	cd linux-ci && DOCKER_OPTS="--pull" DOCKER_TAG=$(@:linux-ci-%=%) IMAGE_NAME=openttd/compile-farm-ci:linux-$(@:linux-ci-%=%) hooks/build

.PHONY: $(LINUX_GENERIC_TARGETS:%=linux-generic-%)
$(LINUX_GENERIC_TARGETS:%=linux-generic-%):
	cd linux-generic && DOCKER_OPTS="--pull" DOCKER_TAG=$(@:linux-generic-%=%) IMAGE_NAME=openttd/compile-farm:linux-generic-$(@:linux-generic-%=%) hooks/build
