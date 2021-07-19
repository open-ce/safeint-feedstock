#!/bin/bash
# *****************************************************************
# (C) Copyright IBM Corp. 2021. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# *****************************************************************

set -ex

ARCH=`uname -p`

if [ $ARCH == "ppc64le" ]; then
    ARCH_PREFIX="powerpc64le-conda_cos7"
elif [ $ARCH == "x86_64" ]; then
    ARCH_PREFIX="x86_64-conda_cos6"
fi

export CMAKE_ARGS="-DCMAKE_AR=$BUILD_PREFIX/bin/${ARCH_PREFIX}-linux-gnu-ar -DCMAKE_CXX_COMPILER_AR=$BUILD_PREFIX/bin/${ARCH_PREFIX}-linux-gnu-gcc-ar -DCMAKE_C_COMPILER_AR=$BUILD_PREFIX/bin/${ARCH_PREFIX}-linux-gnu-gcc-ar -DCMAKE_RANLIB=$BUILD_PREFIX/bin/${ARCH_PREFIX}-linux-gnu-ranlib -DCMAKE_CXX_COMPILER_RANLIB=$BUILD_PREFIX/bin/${ARCH_PREFIX}-linux-gnu-gcc-ranlib -DCMAKE_C_COMPILER_RANLIB=$BUILD_PREFIX/bin/${ARCH_PREFIX}-linux-gnu-gcc-ranlib -DCMAKE_LINKER=$BUILD_PREFIX/bin/${ARCH_PREFIX}-linux-gnu-ld -DCMAKE_STRIP=$BUILD_PREFIX/bin/${ARCH_PREFIX}-linux-gnu-strip -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY -DCMAKE_FIND_ROOT_PATH=$PREFIX;$BUILD_PREFIX/${ARCH_PREFIX}-linux-gnu/sysroot -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_INSTALL_LIBDIR=lib"

mkdir -p build
pushd build
cmake ${CMAKE_ARGS} -GNinja ..
ninja install
popd
