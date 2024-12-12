# Use Alpine as the base image
FROM alpine:latest

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

