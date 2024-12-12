# Use Alpine Linux as base image
FROM alpine:latest AS base

# Install essential build dependencies
RUN apk add --no-cache \
    git \
    curl \
    wget \
    unzip \
    build-base \
    python3 \
    py3-pip \
    nodejs \
    npm \
    neovim \
    ripgrep \
    fd \
    # Additional dependencies for Neovim and development
    lua5.1 \
    cargo \
    cmake \
    make \
    gcc \
    g++ \
    libstdc++ \
    # Language support
    python3-dev

# Create development user
RUN adduser -D devuser
USER devuser
WORKDIR /home/devuser

# Set up Neovim configuration directory
RUN mkdir -p /home/devuser/.config/nvim

# Start Neovim by default
CMD ["nvim"]
