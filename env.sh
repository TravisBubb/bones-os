#!/usr/bin/bash

# Sets up the dev environment for the current terminal session
# Execute using `sudo bash env.sh`

export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"
export PATH="$HOME/opt/cross/bin:$PATH"

