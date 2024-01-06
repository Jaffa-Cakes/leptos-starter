#!/bin/bash

# Set Leptos environment variables
export LEPTOS_SITE_ADDR=0.0.0.0:3000
export LEPTOS_RELOAD_PORT=3001

# Set Rust environment variables
export RUST_BACKTRACE=1
export RUST_LOG=info

# Watch for changes in the tailwindcss file
echo "1. Starting CSS watcher..."

echo "Installing..."
cd site # /site
npm install

echo "Starting screen session for SASS..."
screen -d -m bash -c "npx sass ./style/input.scss ./style/input.css -w"
sleep 2

echo "Starting screen session for Tailwind..."
screen -d -m bash -c "npx tailwindcss -i ./style/input.css -o ./style/output.css --watch"
sleep 2

cd .. # /

# Watch for changes in the project
echo "2. Starting Leptos watcher..."
cargo leptos watch