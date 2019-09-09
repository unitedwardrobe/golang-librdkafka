FROM circleci/golang:1.11.10

ARG LIBRDKAFKA_VERSION=1.1.0
ARG EXPAND_ENV_VERSION=0.1.0

RUN sudo apt-get install python3-pip gettext-base
RUN sudo pip3 install --no-cache-dir 'awscli>=1.15.50'
RUN go get -u github.com/rubenv/sql-migrate/...

RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
      gcc \
      g++ \
      build-essential \
      pkg-config \
      liblz4-dev \
      liblz4-1 \
      libzstd1 \
      libssl1.1 \
      libssl-dev && \
    sudo rm -r /var/lib/apt/lists/*

# download libsasl to a temp location and build
# enable/disable features as needed with configure
# RUN cd $(mktemp -d) && \
#   wget -nv -O cyrus-sasl-2.1.27.tar.gz https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz && \
#   tar -xz --strip-components=1 -f cyrus-sasl-2.1.27.tar.gz && \
#   rm -f cyrus-sasl-2.1.27.tar.gz && \
#   ./configure --prefix=/usr --disable-sample --disable-obsolete_cram_attr --disable-obsolete_digest_attr --enable-static --disable-shared \
#   --disable-checkapop --disable-cram --disable-digest --enable-scram --disable-otp --disable-gssapi --with-dblib=none --with-pic && \
#   make && \
#   sudo make install

RUN wget -O "librdkafka.tar.gz" "https://github.com/edenhill/librdkafka/archive/v${LIBRDKAFKA_VERSION}.tar.gz"

RUN mkdir -p librdkafka

RUN tar \
  --extract \
  --file "librdkafka.tar.gz" \
  --directory "librdkafka" \
  --strip-components 1

RUN cd "librdkafka" && \
  ./configure --prefix=/usr --install-deps --disable-sasl && \
  make && \
  sudo make install && \
  cd / rm -r librdkafka

ADD https://github.com/unitedwardrobe/expand-env/releases/download/v${EXPAND_ENV_VERSION}/expand-env-amd64 /usr/local/bin/expand-env

ENV CGO_ENABLED=1 \
  GOOS=linux \
  GOARCH=amd64

