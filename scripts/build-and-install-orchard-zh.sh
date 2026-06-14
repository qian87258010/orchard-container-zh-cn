#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DERIVED_DATA="$ROOT_DIR/build/DerivedData"
BUILT_APP="$DERIVED_DATA/Build/Products/Release/星奕筑容器.app"
LEGACY_BUILT_APP="$DERIVED_DATA/Build/Products/Release/Orchard.app"
DEST_APP="/Applications/星奕筑容器.app"

if ! command -v xcodebuild >/dev/null 2>&1; then
  echo "未找到 xcodebuild，请先安装 Xcode。"
  exit 1
fi

echo "构建星奕筑容器..."
xcodebuild \
  -project "$ROOT_DIR/Orchard.xcodeproj" \
  -scheme Orchard \
  -configuration Release \
  -destination 'platform=macOS' \
  -derivedDataPath "$DERIVED_DATA" \
  CODE_SIGNING_ALLOWED=NO \
  build

if [[ ! -d "$BUILT_APP" && -d "$LEGACY_BUILT_APP" ]]; then
  BUILT_APP="$LEGACY_BUILT_APP"
fi

if [[ ! -d "$BUILT_APP" ]]; then
  echo "未找到构建产物: $BUILT_APP"
  exit 1
fi

echo "关闭正在运行的星奕筑容器/Orchard..."
osascript -e 'tell application "星奕筑容器" to quit' >/dev/null 2>&1 || true
osascript -e 'tell application "Orchard" to quit' >/dev/null 2>&1 || true
sleep 1

echo "安装到 $DEST_APP..."
if [[ -w "/Applications" || ! -e "$DEST_APP" ]]; then
  rm -rf "$DEST_APP"
  ditto "$BUILT_APP" "$DEST_APP"
else
  sudo rm -rf "$DEST_APP"
  sudo ditto "$BUILT_APP" "$DEST_APP"
fi

echo "进行本机临时签名..."
codesign --force --deep --sign - "$DEST_APP"

echo "设置中文语言偏好..."
defaults write container-compose.Orchard AppleLanguages -array zh-Hans en
defaults write container-compose.Orchard AppleLocale zh_CN

echo "打开星奕筑容器..."
open "$DEST_APP"

echo "完成。"
