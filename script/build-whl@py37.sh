#!/bin/bash

conda install -y cmake==3.22.1

export DIFFVG_CUDA=1
export CUDA_HOME=/usr/local/cuda
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

pip install scipy==1.7.3

python setup.py install
python setup.py bdist_wheel

chmod -R a+rwX dist/
