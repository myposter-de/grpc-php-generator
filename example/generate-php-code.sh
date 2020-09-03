#!/bin/bash

cd /workspace

protoc --proto_path=./protos \
    --php_out=./php-code \
    --grpc_out=./php-code \
    --plugin=protoc-gen-grpc=/grpc/bin/grpc_php_plugin \
    ./protos/helloworld.proto