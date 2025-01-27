ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

ENV UBUNTU_VERSION=${UBUNTU_VERSION}
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_BREAK_SYSTEM_PACKAGES=1

RUN set -eux; \
	apt-get update -y; \
	apt-get upgrade -y; \
	apt-get install -y   \
		abigail-tools \
		afl++ \
		autoconf \
		automake \
		bash \
		binutils \
		binutils-common \
		build-essential \
		bzip2 \
		ccache \
		clang \
		cmake \
		curl \
		dpkg-dev \
		file \
		flex \
		gawk \
		gcc \
		g++ \
		gdb \
		git \
		gnutls-bin \
		gnupg \
		gzip \
		jq \
		lsof \
		libtool \
		make \
		nano \
		ncurses-bin \
		ninja-build \
		python3-dev \
		python3-pip \
		python3-numpy \
		python3-setuptools \
		python3-venv \
		readline-common \
		subversion \
		perl \
		tar \
		tzdata \
		texinfo \
		unzip \
		wget \
		xz-utils \
		zip \
	; \
	apt-get clean -y; \
	apt-get autoremove -y; \
	apt-get autopurge -y; \
	rm -rf /var/lib/apt/lists/*

# Install Conan
RUN set -eux; \
	python3 -m pip install --no-cache-dir --upgrade conan; \
	conan remote update conancenter --url https://center2.conan.io;

ENV APP_HOME=/app \
	APP_USER_NAME=cpp-docker-runner \
	APP_USER_ID=1001

RUN set -eux; \
	useradd \
		--home-dir ${APP_HOME} \
		--uid ${APP_USER_ID} \
		--create-home \
		--user-group \
		${APP_USER_NAME} \
	;

USER ${APP_USER_ID}

WORKDIR ${APP_HOME}
