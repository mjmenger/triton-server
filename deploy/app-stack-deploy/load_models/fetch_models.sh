#!/bin/bash
# Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#  * Neither the name of NVIDIA CORPORATION nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
# OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

set -ex

echo "LOAD_INCEPTION_GRAPHDEF: $LOAD_INCEPTION_GRAPHDEF"
echo "LOAD_DENSENET_ONNX: $LOAD_DENSENET_ONNX"

cd /models

if [ "$LOAD_INCEPTION_GRAPHDEF" -eq 1 ]
then
     
     echo "Loading TensorFlow inception"
     mkdir -p model_repository/inception_graphdef/1
     wget -O /tmp/inception_v3_2016_08_28_frozen.pb.tar.gz \
          https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz
     (cd /tmp && tar xzf inception_v3_2016_08_28_frozen.pb.tar.gz)
     mv /tmp/inception_v3_2016_08_28_frozen.pb model_repository/inception_graphdef/1/model.graphdef
     wget -O model_repository/inception_graphdef/config.pbtxt \
          https://raw.githubusercontent.com/triton-inference-server/server/main/docs/examples/model_repository/inception_graphdef/config.pbtxt
     wget -O model_repository/inception_graphdef/inception_labels.txt \
          https://raw.githubusercontent.com/triton-inference-server/server/main/docs/examples/model_repository/inception_graphdef/inception_labels.txt
fi

if [ "$LOAD_DENSENET_ONNX" -eq 1 ]
then
     echo "Loading ONNX densenet"
     mkdir -p model_repository/densenet_onnx/1
     wget -O model_repository/densenet_onnx/1/model.onnx \
          https://contentmamluswest001.blob.core.windows.net/content/14b2744cf8d6418c87ffddc3f3127242/9502630827244d60a1214f250e3bbca7/08aed7327d694b8dbaee2c97b8d0fcba/densenet121-1.2.onnx
     wget -O model_repository/densenet_onnx/config.pbtxt \
          https://raw.githubusercontent.com/triton-inference-server/server/main/docs/examples/model_repository/densenet_onnx/config.pbtxt
     wget -O model_repository/densenet_onnx/densenet_labels.txt \
          https://raw.githubusercontent.com/triton-inference-server/server/main/docs/examples/model_repository/densenet_onnx/densenet_labels.txt
fi