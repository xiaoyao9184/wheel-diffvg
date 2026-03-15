#!/bin/bash

conda install -y cmake==3.22.1

export DIFFVG_CUDA=1
export CUDA_HOME=/usr/local/cuda
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export CC=$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-cc
export CXX=$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-c++


export LD_LIBRARY_PATH=/opt/conda/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=/opt/conda/lib:$LIBRARY_PATH
export LDFLAGS="-Wl,-rpath,/opt/conda/lib"
export CC=/opt/conda/bin/x86_64-conda-linux-gnu-gcc
export CXX=/opt/conda/bin/x86_64-conda-linux-gnu-g++

if [[ -f /opt/conda/lib/libstdc++.so.6 ]]; then
    echo "==== conda libstdc++ (GLIBCXX) versions ===="
    strings /opt/conda/lib/libstdc++.so.6 2>/dev/null | grep GLIBCXX | sort -V || true

    STDCPP_VER=$(conda list libstdcxx-ng 2>/dev/null | awk '/libstdcxx-ng/{print $2; exit}' | cut -d. -f1,2)
    if [[ -n "$STDCPP_VER" ]]; then
        echo "==== install gcc_linux-64=$STDCPP_VER gxx_linux-64=$STDCPP_VER ===="
        conda install -y "gcc_linux-64=$STDCPP_VER" "gxx_linux-64=$STDCPP_VER"
    fi
fi

if [[ ! -f /opt/conda/bin/x86_64-conda-linux-gnu-gcc || ! -f /opt/conda/bin/x86_64-conda-linux-gnu-g++ ]]; then
    echo "==== install gcc_linux-64 and gxx_linux-64 ===="
    conda install -y gcc_linux-64 gxx_linux-64
fi

echo "==== conda libstdc++ (GLIBCXX) versions ===="
strings /opt/conda/lib/libstdc++.so.6 2>/dev/null | grep GLIBCXX | sort -V || true


echo "==== build wheel ===="
python setup.py install
python setup.py bdist_wheel


echo "==== unzip wheels ===="
mkdir tmp
cd tmp
apt update
apt install -y unzip
unzip ../dist/*.whl

echo "==== linked libstdc++ ===="
ldd diffvg.so | grep stdc++

echo "==== required GLIBCXX ===="
strings diffvg.so | grep GLIBCXX | sort -V
cd ..
rm -rf tmp

chmod -R a+rwX dist/
