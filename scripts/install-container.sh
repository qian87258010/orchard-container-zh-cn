#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "未找到 Homebrew，请先安装 Homebrew: https://brew.sh/"
  exit 1
fi

if [[ "$(uname -m)" != "arm64" ]]; then
  echo "Apple container 主要面向 Apple Silicon Mac。当前架构: $(uname -m)"
  exit 1
fi

echo "安装或更新 Apple container..."
brew install container || brew upgrade container

echo "启动 container 系统服务..."
container system start || true

echo "当前状态:"
container system status

echo "完成。可以运行下面命令测试:"
echo "container run --rm docker.io/library/alpine:latest uname -a"
