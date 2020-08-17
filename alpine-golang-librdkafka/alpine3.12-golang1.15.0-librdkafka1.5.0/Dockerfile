FROM golang:1.15.0-alpine3.12

RUN apk add --no-cache openssl ca-certificates pkgconfig g++

ARG LIBRDKAFKA_VERSION=1.5.0

RUN apk --update add --virtual build-dependencies python3-dev gcc bash build-base git && \
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