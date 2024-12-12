# Use Alpine as the base image
FROM alpine:latest AS base

# Install essential dependencies
RUN apk add --no-cache \
    autoconf \
    automake \
    build-base \
    cmake \
    ninja \
    bash \
    coreutils \
    curl \
    wget \
    unzip \
    python3 \
    py3-pip \
    nodejs \
    npm \
    ripgrep \
    fd \
    fuse \
    libstdc++ \
    gcc \
    g++ \
    git \
    ncurses-dev \
    && git clone --depth 1 https://github.com/neovim/neovim.git /neovim \
    && cd /neovim \
    && make CMAKE_BUILD_TYPE=Release \
    && make install \
    && rm -rf /neovim

# Create development user
RUN adduser -D devuser
USER devuser
WORKDIR /home/devuser

# Set up Neovim configuration directory
RUN mkdir -p /home/devuser/.config/nvim

# Start Neovim by default
CMD ["nvim"]

