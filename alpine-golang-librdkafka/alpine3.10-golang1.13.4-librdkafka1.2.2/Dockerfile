FROM golang:1.13.4-alpine3.10

RUN apk add --no-cache openssl ca-certificates pkgconfig g++

ARG LIBRDKAFKA_VERSION=1.2.2

RUN apk --update add --virtual build-dependencies gcc bash python-dev build-base git && \
  git clone https://github.com/edenhill/librdkafka.git && \
  cd librdkafka && \
  git checkout v${LIBRDKAFKA_VERSION} && \
  ./configure && \
  make && \
  make install && \
  apk del build-dependencies && \
  rm -rf librdkafka

ENV CGO_ENABLED=1 \
  GOOS=linux \
  GOARCH=amd64