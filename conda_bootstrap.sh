#! /bin/bash
set -e

export PATH="$HOME/.conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

if [ ! -d "$HOME/.conda" ]; then
    wget -q https://repo.continuum.io/miniconda/Miniconda3-4.4.10-Linux-x86_64.sh -O "$HOME/miniconda.sh" && \
    echo "bec6203dbb2f53011e974e9bf4d46e93 *$HOME/miniconda.sh" | md5sum -c - && \
    bash "$HOME/miniconda.sh" -f -b -p "$HOME/.conda" && \
    rm -rf "$HOME/miniconda.sh" || \
    (rm -rf "$HOME/.conda" "$HOME/miniconda.sh"; exit 1)
fi

exec $@
