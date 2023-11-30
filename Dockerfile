# docker build -t openmc_wasm .
# docker run -it --entrypoint /bin/bash openmc_wasm

FROM emscripten/emsdk:3.1.49

WORKDIR /app

# Install dependencies
RUN apt-get update -y && \
    apt-get install -y build-essential g++ cmake

RUN embuilder --pic build libpng
RUN git clone --depth 2 --recurse-submodules https://github.com/openmc-dev/openmc.git


RUN wget https://github.com/usnistgov/libhdf5-wasm/releases/download/v0.4.3_3.1.43/HDF5-1.14.2-Emscripten.tar.gz && \
    tar -f HDF5-1.14.2-Emscripten.tar.gz -z -C /emsdk/upstream/emscripten/cache/sysroot -x
ARG HDF5_ROOT=/emsdk/upstream/emscripten/cache/sysroot

WORKDIR /app/openmc

# Create build directory
WORKDIR /app/openmc/build

# Configure the build with emcmake
RUN emcmake cmake \
  -DOPENMC_BUILD_TESTS=OFF \
  -DHDF5_LIBRARIES="$HDF5_ROOT/lib/libhdf5.a;$HDF5_ROOT/lib/libz.a;$HDF5_ROOT/lib/libsz.a" \
  -DHDF5_HL_LIBRARIES="$HDF5_ROOT/lib/libhdf5_hl.a" \
  -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=TRUE \
  -DHDF5_DIR="$HDF5_ROOT/cmake" \
  -DZLIB_LIBRARY="$HDF5_ROOT/lib/libz.a" \
  -DZLIB_INCLUDE_DIR="$HDF5_ROOT/include" \
  -DCMAKE_CXX_STANDARD=14 \
  ..

RUN emmake make -j VERBOSE=1 libopenmc
RUN emcc -sSIDE_MODULE=1 -sWASM_BIGINT \
   lib/libopenmc.a lib/libfmt.a lib/libpugixml.a \
   $HDF5_ROOT/lib/libhdf5.a \
   $HDF5_ROOT/lib/libz.a \
   $HDF5_ROOT/lib/libsz.a \
   $HDF5_ROOT/lib/wasm32-emscripten/pic/libpng.a \
   -o libopenmc.so