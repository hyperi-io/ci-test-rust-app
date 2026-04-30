# Project:   ci-test-rust-app
# File:      Dockerfile
# Purpose:   Runtime container image — consumes pre-built binary from
#            hyperi-ci's Build stage (dist/) instead of compiling
#            from source. Mirrors dfe-loader's pattern.
# License:   FSL-1.1-ALv2
# Copyright: (c) 2026 HYPERI PTY LIMITED
#
# Build context: hyperi-ci's Container job runs after Build and uses
# actions/download-artifact to populate dist/ with cross-compiled
# binaries named:
#
#   dist/ci-test-rust-app-linux-amd64
#   dist/ci-test-rust-app-linux-arm64
#
# buildx multi-arch sets TARGETARCH per platform run; we COPY the
# matching binary in. No Rust toolchain needed in the image.

FROM ubuntu:24.04

# Runtime shared libraries for dynamically-linked dependencies.
# librdkafka1 (runtime SO) for the rdkafka crate; libssl3 + zlib1g
# for openssl-sys + miniz_oxide. Confluent's Debian repo carries
# more recent librdkafka than Ubuntu's archive.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ca-certificates curl gnupg \
    && curl -fsSL https://packages.confluent.io/clients/deb/archive.key \
       | gpg --dearmor -o /usr/share/keyrings/confluent-clients.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/confluent-clients.gpg] \
            https://packages.confluent.io/clients/deb noble main" \
       > /etc/apt/sources.list.d/confluent-clients.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       librdkafka1 libssl3 zlib1g \
    && rm -rf /var/lib/apt/lists/*

# buildx exposes TARGETARCH (amd64 | arm64) per platform run. Pick the
# pre-built cross-compiled binary that matches.
ARG TARGETARCH
COPY dist/ci-test-rust-app-linux-${TARGETARCH} /usr/local/bin/ci-test-rust-app
RUN chmod +x /usr/local/bin/ci-test-rust-app

# Ubuntu 24.04 ships with a default `ubuntu` user at uid 1000 — remove
# before adding our nonroot appuser.
RUN userdel -r ubuntu 2>/dev/null || true \
    && useradd --create-home --uid 10001 appuser

USER appuser

HEALTHCHECK --interval=30s --timeout=3s --start-period=2s --retries=2 \
    CMD ci-test-rust-app || exit 1

ENTRYPOINT ["ci-test-rust-app"]
