#!/bin/bash

PROFILE=${PROFILE:-"generic"}
INCLUDE_DOCKER=${INCLUDE_DOCKER:-"yes"}

# 载入配置
cp .config .config.bak

# 构建
make image PROFILE=$PROFILE \
     PACKAGES="$(cat packages.txt)" \
     FILES=files/
