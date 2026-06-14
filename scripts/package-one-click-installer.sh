#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist"
VERSION="${1:-1.12.1-zh.4}"
APP_ZIP="${2:-$DIST_DIR/Xingyizhu-Container-1.12.1-zh.4-macos-arm64.zip}"
APP_NAME="星奕筑容器.app"
WORK_DIR="$DIST_DIR/one-click-work"
INSTALLER_DIR="$WORK_DIR/星奕筑容器一键安装"
OUT_ZIP="$DIST_DIR/Xingyizhu-Container-OneClick-Installer-$VERSION-macos-arm64.zip"

if [[ ! -f "$APP_ZIP" ]]; then
  echo "未找到 App 压缩包: $APP_ZIP" >&2
  exit 1
fi

rm -rf "$WORK_DIR" "$OUT_ZIP"
mkdir -p "$INSTALLER_DIR"

echo "解压 App..."
ditto -x -k "$APP_ZIP" "$INSTALLER_DIR"

if [[ ! -d "$INSTALLER_DIR/$APP_NAME" ]]; then
  echo "压缩包中未找到 $APP_NAME" >&2
  find "$INSTALLER_DIR" -maxdepth 2 -type d -name '*.app' -print >&2
  exit 1
fi

echo "复制一键安装脚本..."
cp "$ROOT_DIR/scripts/one-click-install.command" "$INSTALLER_DIR/双击一键安装星奕筑容器.command"
chmod +x "$INSTALLER_DIR/双击一键安装星奕筑容器.command"

cat > "$INSTALLER_DIR/安装说明.txt" <<'EOF'
星奕筑容器一键安装包

使用方法：
1. 双击“双击一键安装星奕筑容器.command”。
2. 如果 macOS 提示阻止打开，请右键点击该文件，选择“打开”。
3. 按窗口提示输入电脑密码。

安装器会自动完成：
- 安装 Homebrew（如果电脑没有）。
- 通过 Homebrew 安装 Apple container。
- 启动 Apple container 系统服务。
- 把“星奕筑容器.app”安装到 /Applications。
- 打开“星奕筑容器”中文图形界面。

说明：
- 本安装包包含“星奕筑容器.app”中文图形界面。
- Apple container 由安装器从官方 Homebrew 软件源安装，不在本压缩包内直接分发。
- 本包不包含 Docker Desktop。
EOF

echo "创建一键安装 ZIP..."
(
  cd "$WORK_DIR"
  ditto -c -k --sequesterRsrc --keepParent "星奕筑容器一键安装" "$OUT_ZIP"
)

echo "输出文件:"
ls -lh "$OUT_ZIP"
shasum -a 256 "$OUT_ZIP"
