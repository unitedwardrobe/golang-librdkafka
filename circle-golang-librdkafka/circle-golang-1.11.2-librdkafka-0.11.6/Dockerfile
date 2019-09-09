FROM circleci/golang:1.11.2

ARG LIBRDKAFKA_VERSION=0.11.6

RUN cd /tmp

RUN wget -O "librdkafka.tar.gz" "https://github.com/edenhill/librdkafka/archive/v${LIBRDKAFKA_VERSION}.tar.gz"

RUN mkdir -p librdkafka

RUN tar \
  --extract \
  --file "librdkafka.tar.gz" \
  --directory "librdkafka" \
  --strip-components 1

RUN cd "librdkafka" && \
  ./configure --prefix=/usr && \
  make && \
  sudo make install

ENV CGO_ENABLED=1 \
  GOOS=linux \
  GOARCH=amd64