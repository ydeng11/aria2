# Multi-stage Dockerfile for aria2 (Linux, suitable for Synology).
# Builds from local source (apply PR #1869 patch before building).
# Usage:
#   docker build -t YOUR_DOCKERHUB_USER/aria2:ex-invalid-range-fix .
#   docker push YOUR_DOCKERHUB_USER/aria2:ex-invalid-range-fix

# -----------------------------------------------------------------------------
# Stage 1: build aria2 from local source
# -----------------------------------------------------------------------------
FROM debian:bookworm AS builder

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    autoconf \
    automake \
    autotools-dev \
    autopoint \
    libtool \
    pkg-config \
    make \
    g++ \
    libssl-dev \
    libc-ares-dev \
    zlib1g-dev \
    libsqlite3-dev \
    libssh2-1-dev \
    libcppunit-dev \
    libxml2-dev \
    libgnutls28-dev \
    nettle-dev \
    libgmp-dev

WORKDIR /build

# Copy local repo (with PR #1869 patch applied)
COPY . .

RUN autoreconf -i && \
    ./configure \
        --without-appletls \
        --without-wintls \
        --with-gnutls \
        --without-openssl \
        --prefix=/usr/local && \
    make -j"$(nproc)" && \
    make install

# -----------------------------------------------------------------------------
# Stage 2: minimal runtime image
# -----------------------------------------------------------------------------
FROM debian:bookworm-slim

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libc-ares2 \
    zlib1g \
    libsqlite3-0 \
    libssh2-1 \
    libxml2 \
    libgnutls30 \
    libnettle8 \
    libgmp10 \
    libhogweed6 \
    libp11-kit0 \
    libidn2-0 \
    libunistring2 \
    libtasn1-6 \
    libffi8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin/aria2c /usr/local/bin/aria2c

# Optional: copy man page if you want `man aria2c`
# COPY --from=builder /usr/local/share/man/man1/aria2c.1* /usr/local/share/man/man1/ 2>/dev/null || true

ENTRYPOINT ["/usr/local/bin/aria2c"]
CMD ["--help"]
