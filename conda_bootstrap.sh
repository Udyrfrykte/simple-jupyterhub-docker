#! /bin/bash
set -x
set -e

export PATH="$HOME/.conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# we finish by uninstalling pip and breaking conda to force using conda envs
if [ ! -d "$HOME/.conda" ]; then
    wget -q https://repo.continuum.io/miniconda/Miniconda3-4.4.10-Linux-x86_64.sh -O "$HOME/miniconda.sh" && \
    echo "bec6203dbb2f53011e974e9bf4d46e93 *$HOME/miniconda.sh" | md5sum -c - && \
    bash "$HOME/miniconda.sh" -f -b -p "$HOME/.conda" && \
    pip install jupyterhub==0.8.1 notebook && \
    conda create --yes -n py3 python=3 ipykernel && \
    conda create --yes -n py2 python=2 ipykernel && \
    source activate py2 && \
    ipython kernel install --prefix="$HOME/.conda" && \
    source deactivate && \
    source activate py3 && \
    ipython kernel install --prefix="$HOME/.conda" && \
    source deactivate && \
    pip uninstall --yes pip && \
    echo 'conda() { echo '"'"'please activate an environment first ("source activate py2" for Python 2 and "source activate py3" for Python 3)'"'"'; }' > "$HOME/.bashrc" && \
    rm -rf "$HOME/miniconda.sh" || \
    (rm -rf "$HOME/.bashrc" "$HOME/.cache" "$HOME/.conda" "$HOME/miniconda.sh"; exit 1)
fi

exec $@
