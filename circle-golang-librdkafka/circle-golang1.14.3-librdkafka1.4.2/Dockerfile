FROM circleci/golang:1.14.3

ARG LIBRDKAFKA_VERSION=1.4.2

RUN sudo apt-get update
RUN sudo apt-get install python3-pip gettext-base
RUN sudo pip3 install --no-cache-dir 'awscli>=1.15.50'
RUN go get -u github.com/rubenv/sql-migrate/...

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