#!/bin/bash

conda install -y cmake==3.22.1

conda install -y -c conda-forge libxcrypt==4.4.36
# fix `crypt.h: No such file or directory` see https://github.com/stanford-futuredata/ColBERT/issues/309
export CPATH=/opt/conda/include/


export DIFFVG_CUDA=1
export CUDA_HOME=/usr/local/cuda
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH


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
    GCC=$(find /opt/conda/pkgs -path "*/gcc_impl_linux-64*/bin/x86_64-conda-linux-gnu-gcc" | head -n1)
    GXX=$(find /opt/conda/pkgs -path "*/gxx_impl_linux-64*/bin/x86_64-conda-linux-gnu-g++" | head -n1)

    echo "==== using conda pkgs gcc_linux-64 and gxx_linux-64 ===="
    echo "GCC=$GCC"
    echo "GXX=$GXX"
    export CC=$GCC
    export CXX=$GXX
fi

echo "==== conda libstdc++ (GLIBCXX) versions ===="
strings /opt/conda/lib/libstdc++.so.6 2>/dev/null | grep GLIBCXX | sort -V || true

echo "==== /opt/conda/lib/libstdc++.so.6 target ===="
ls -la /opt/conda/lib/libstdc++.so.6 2>/dev/null && readlink -f /opt/conda/lib/libstdc++.so.6 2>/dev/null || true
echo "==== CC CXX version ===="
$CC --version 2>/dev/null | head -1 || true
$CXX --version 2>/dev/null | head -1 || true


echo "==== system libstdc++.so.6 (path + target + GLIBCXX) ===="
for f in /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib64/libstdc++.so.6; do
    if [[ -e "$f" ]]; then ls -la "$f" 2>/dev/null; readlink -f "$f" 2>/dev/null; strings "$f" 2>/dev/null | grep GLIBCXX | sort -V; break; fi
done
echo "==== system gcc g++ version ===="
gcc --version 2>/dev/null | head -1 || true
g++ --version 2>/dev/null | head -1 || true

echo "==== install scipy ===="
pip install scipy==1.7.3

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
