FROM rust:1.73.0-alpine3.18 AS build

# Set working directory
WORKDIR /app

# Update package index and install dependencies
RUN apk update
RUN apk add --no-cache build-base musl-dev openssl-dev pkgconf openssl-libs-static nodejs npm screen bash

# Add the wasm target
RUN rustup target add wasm32-unknown-unknown

# Install cargo-leptos
RUN cargo install cargo-leptos

# Build
COPY . .
WORKDIR /app/panel
RUN npm install
RUN npx sass ./style/input.scss ./style/input.css
RUN npx tailwindcss -i ./style/input.css -o ./style/output.css --minify
WORKDIR /app

# Set Rust environment variables
ENV RUST_BACKTRACE=1
ENV RUST_LOG=warn
# ENV RUSTFLAGS="-C target-feature=-crt-static"

RUN cargo leptos build --release

# Runner
FROM alpine:3.18

# Set working directory
WORKDIR /app

COPY --from=build /app/target/release/panel ./panel
COPY --from=build /app/target/site ./site

# Set Rust environment variables
ENV RUST_BACKTRACE=1
ENV RUST_LOG=warn
# ENV RUSTFLAGS="-C target-feature=-crt-static"

# Set Leptos environment variables
ENV LEPTOS_OUTPUT_NAME="panel"
ENV LEPTOS_SITE_ROOT="site"
ENV LEPTOS_SITE_PKG_DIR="pkg"
ENV LEPTOS_SITE_ADDR="0.0.0.0:3000"
ENV LEPTOS_RELOAD_PORT="3001"

EXPOSE 3000

CMD ["./panel"]