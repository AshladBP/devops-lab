#!/usr/bin/env bash
set -e
name=$(npm pkg get name | tr -d '"')
version=$(npm pkg get version | tr -d '"')

# Build for amd64
docker buildx build \
--platform=linux/amd64 \
--load \
-t "$name:$version-amd64" \
.

# Build for arm64
docker buildx build \
--platform=linux/arm64 \
--load \
-t "$name:$version-arm64" \
.
