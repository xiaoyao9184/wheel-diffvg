#!/bin/bash

export DIFFVG_CUDA=1
export CUDA_HOME=/usr/local/cuda
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

pip wheel . --wheel-dir dist --no-deps

chmod -R a+rwX dist/
