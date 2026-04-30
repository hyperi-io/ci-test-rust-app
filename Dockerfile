# Project:   ci-test-rust-app
# File:      Dockerfile
# Purpose:   Container image for ci-test-rust-app (multi-arch, librdkafka)
# License:   FSL-1.1-ALv2
# Copyright: (c) 2026 HYPERI PTY LIMITED

# -- Build stage ---------------------------------------------------------------
FROM rust:1.82-slim AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential cmake pkg-config libssl-dev libcurl4-openssl-dev \
       libsasl2-dev libzstd-dev liblz4-dev libsnappy-dev zlib1g-dev \
       gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
    && rm -rf /var/lib/apt/lists/*

# Add aarch64 cross-compilation target
RUN rustup target add aarch64-unknown-linux-gnu

WORKDIR /build

# Copy cargo config for cross-compilation linker settings
COPY .cargo/ ./.cargo/

# Copy manifests first for layer caching
COPY Cargo.toml Cargo.lock* rust-toolchain.toml ./

# Create dummy src for dependency caching layer
RUN mkdir src && echo 'fn main() { println!("dummy"); }' > src/main.rs \
    && cargo build --release --target x86_64-unknown-linux-gnu 2>/dev/null || true \
    && rm -rf src

# Copy real source
COPY src/ ./src/

# Build for both architectures
ARG TARGETARCH=amd64

RUN if [ "${TARGETARCH}" = "arm64" ]; then \
        export CC_aarch64_unknown_linux_gnu=aarch64-linux-gnu-gcc \
               CXX_aarch64_unknown_linux_gnu=aarch64-linux-gnu-g++ \
               CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc \
               PKG_CONFIG_SYSROOT_DIR=/usr/aarch64-linux-gnu; \
        cargo build --release --target aarch64-unknown-linux-gnu; \
        cp target/aarch64-unknown-linux-gnu/release/ci-test-rust-app /build/ci-test-rust-app; \
    else \
        cargo build --release --target x86_64-unknown-linux-gnu; \
        cp target/x86_64-unknown-linux-gnu/release/ci-test-rust-app /build/ci-test-rust-app; \
    fi

# -- Runtime stage -------------------------------------------------------------
FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl netcat-openbsd \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home --uid 10001 --shell /bin/bash appuser

COPY --from=builder --chown=appuser:appuser /build/ci-test-rust-app /usr/local/bin/ci-test-rust-app

USER appuser

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD ci-test-rust-app || exit 1

CMD ["ci-test-rust-app"]
