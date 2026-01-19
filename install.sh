#!/bin/bash

# Install `brew` (https://brew.sh/)
echo "\n" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install `bat`
brew install bat

# Install `nvim`
brew install neovim

# Install `tmux`
brew install tmux

# Install `hyperfine`
brew install hyperfine

# Copy `.config` to home directory
cp -R .config ~

