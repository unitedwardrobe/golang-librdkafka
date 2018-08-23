FROM golang:alpine

RUN apk add --no-cache --virtual .fetch-deps ca-certificates tar

RUN apk add --no-cache openssl pkgconfig g++

RUN mkdir -p /root/librdkafka
WORKDIR /root/librdkafka

RUN wget -O "librdkafka.tar.gz" "https://github.com/edenhill/librdkafka/archive/v0.11.4.tar.gz"

RUN mkdir -p librdkafka

RUN tar \
  --extract \
  --file "librdkafka.tar.gz" \
  --directory "librdkafka" \
  --strip-components 1

RUN apk add --no-cache --virtual .build-deps \
  bash \
  openssl-dev \
  make \
  musl-dev \
  zlib-dev \
  python

RUN cd "librdkafka" && \
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

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
