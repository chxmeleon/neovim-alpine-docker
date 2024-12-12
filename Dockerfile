# Use Ubuntu as base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install essential dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    build-essential \
    software-properties-common \
    python3-pip \
    python3-venv \
    nodejs \
    npm \
    ripgrep \
    fd-find \
    # Neovim dependencies
    && add-apt-repository ppa:neovim-ppa/stable \
    && apt-get update \
    && apt-get install -y neovim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create development user
RUN useradd -m -s /bin/bash devuser
USER devuser
WORKDIR /home/devuser

# Set up Neovim configuration directory
RUN mkdir -p /home/devuser/.config/nvim

# Install Lazy.nvim
RUN git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
    --depth 1 /home/devuser/.local/share/nvim/lazy/lazy.nvim
