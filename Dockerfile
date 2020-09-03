FROM php:7.1.30-fpm-buster

ENV GRPC_VERSION="1.31.0"
ENV PROTOBUF_VERSION="3.13.0"

RUN apt-get update && apt-get install -y \
  curl \
  git \
  libtool \
  autotools-dev \
  automake \
  zlib1g-dev \
  --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pecl install grpc-${GRPC_VERSION} protobuf-${PROTOBUF_VERSION}

WORKDIR /grpc/bin

WORKDIR /tmp
RUN git clone -b v${GRPC_VERSION} https://github.com/grpc/grpc && \
    cd /tmp/grpc && \
    git submodule update --init && \
    cd /tmp/grpc && \
    make grpc_php_plugin && \
    cp /tmp/grpc/bins/opt/grpc_php_plugin /grpc/bin && \
    cp /tmp/grpc/bins/opt/protobuf/protoc /grpc/bin && \
    rm -rf /tmp/grpc

WORKDIR /workspace

# add binaries to PATH
ENV PATH /grpc/bin:${PATH}
