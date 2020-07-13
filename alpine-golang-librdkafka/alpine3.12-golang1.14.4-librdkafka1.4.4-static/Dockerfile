FROM golang:1.14.4-alpine3.12

ARG LIBRDKAFKA_VERSION=1.4.4

RUN apk update

# Install all dependencies required to build the project as a static binary.
RUN apk add -U \
  bash \
  build-base \
  coreutils \
  cyrus-sasl-dev \
  git \
  libevent \
  libressl2.7-libcrypto \
  libressl2.7-libssl \
  libsasl \
  lz4-dev \
  openssh \
  openssl \
  openssl-dev \
  python3 \
  yajl-dev \
  zlib-dev \
  g++ \
  pkgconfig \
  --repository http://nl.alpinelinux.org/alpine/v3.10/main

# SASL support is disabled for now, due to issues when compiling a static
# binary. See: https://git.io/vAFFm
RUN git clone https://github.com/edenhill/librdkafka.git && \
  cd librdkafka && \
  git checkout v${LIBRDKAFKA_VERSION} && \
  ./configure --disable-sasl && \
  make && \
  make install && \
  rm -rf librdkafka

ENV CGO_ENABLED=1 \
  GOOS=linux \
  GOARCH=amd64