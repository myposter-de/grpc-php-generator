#!/bin/bash

docker run --rm -v $(pwd)/example:/workspace myposter/grpc-php-generator:latest /workspace/generate-php-code.sh