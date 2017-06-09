FROM golang:1.8.3-alpine

RUN apk add --no-cache --virtual .fetch-deps ca-certificates openssl tar

RUN mkdir -p /root/librdkafka
WORKDIR /root/librdkafka

RUN wget -O "librdkafka.tar.gz" "https://github.com/edenhill/librdkafka/archive/v0.9.5.tar.gz"
RUN mkdir -p librdkafka-$VERSION

RUN tar \
  --extract \
  --file "librdkafka.tar.gz" \
  --directory "librdkafka-$VERSION" \
  --strip-components 1

RUN apk add --no-cache --virtual .build-deps \
  bash \
  g++ \
  openssl-dev \
  make \
  musl-dev \
  zlib-dev \
  python

RUN cd "librdkafka-$VERSION" && \
  ./configure --prefix=/usr && \
  make -j "$(getconf _NPROCESSORS_ONLN)" && \
  make install

RUN runDeps="$( \
  scanelf --needed --nobanner --recursive /usr/local \
    | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
    | sort -u \
    | xargs -r apk info --installed \
    | sort -u \
  )" && \
apk add --no-cache --virtual .librdkafka-rundeps \
  $runDeps

RUN cd / && \
  apk del .fetch-deps .build-deps && \
  rm -rf /root/librdkafka
