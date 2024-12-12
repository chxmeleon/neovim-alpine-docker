# Use Alpine as the base image
FROM alpine:latest AS base

# Install essential dependencies
RUN apk add --no-cache \
    bash \
    curl \
    wget \
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
    make \
    cmake \
    git \
    ncurses-dev \

RUN git clone https://github.com/neovim/neovim.git

ARG VERSION=master
RUN cd neovim && git checkout ${VERSION} && make CMAKE_BUILD_TYPE=RelWithDebInfo install

# Create development user
RUN adduser -D devuser
USER devuser
WORKDIR /home/devuser

# Set up Neovim configuration directory
RUN mkdir -p /home/devuser/.config/nvim

# Start Neovim by default
CMD ["nvim"]

