#!/usr/bin/env bash
set -euo pipefail

APP_NAME="星奕筑容器"
APP_BUNDLE="${APP_NAME}.app"
APP_ID="container-compose.Orchard"
DEST_APP="/Applications/${APP_BUNDLE}"
MIN_MACOS_MAJOR=15

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUNDLED_APP="${SCRIPT_DIR}/${APP_BUNDLE}"

RED="$(printf '\033[31m')"
GREEN="$(printf '\033[32m')"
YELLOW="$(printf '\033[33m')"
BLUE="$(printf '\033[34m')"
RESET="$(printf '\033[0m')"

log() {
  printf '%s\n' "${BLUE}==>${RESET} $*"
}

ok() {
  printf '%s\n' "${GREEN}完成:${RESET} $*"
}

warn() {
  printf '%s\n' "${YELLOW}提示:${RESET} $*"
}

fail() {
  printf '%s\n' "${RED}错误:${RESET} $*" >&2
  pause
  exit 1
}

pause() {
  if [[ -t 0 && "${XINGYIZHU_SKIP_PAUSE:-0}" != "1" ]]; then
    printf '\n按回车键关闭窗口...'
    read -r _ || true
  fi
}

run() {
  if [[ "${XINGYIZHU_DRY_RUN:-0}" == "1" ]]; then
    printf '+ %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

ensure_supported_machine() {
  if [[ "$(uname -m)" != "arm64" ]]; then
    fail "Apple container 主要支持 Apple Silicon Mac。当前机器架构是 $(uname -m)。"
  fi

  local macos_major
  macos_major="$(sw_vers -productVersion | awk -F. '{print $1}')"
  if [[ "$macos_major" -lt "$MIN_MACOS_MAJOR" ]]; then
    fail "当前 macOS 版本过低。建议使用 macOS 15 或更新版本，并以 Apple container 官方要求为准。"
  fi
}

ensure_bundled_app() {
  if [[ ! -d "$BUNDLED_APP" ]]; then
    fail "没有找到 ${APP_BUNDLE}。请把本脚本和 ${APP_BUNDLE} 放在同一个文件夹后再运行。"
  fi
}

ensure_homebrew() {
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
  else
    warn "没有检测到 Homebrew，将自动安装 Homebrew。安装过程中可能会要求输入电脑密码。"
    run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      fail "Homebrew 安装完成后仍未找到 brew，请重新打开终端后再试。"
    fi
  fi
}

install_container_runtime() {
  log "安装或更新 Apple container..."
  if brew list --formula container >/dev/null 2>&1; then
    run brew upgrade container || true
  else
    run brew install container
  fi

  if ! command -v container >/dev/null 2>&1; then
    fail "Apple container 安装后仍未找到 container 命令。"
  fi

  log "启动 Apple container 系统服务..."
  run container system start || true
  run container system status || true
}

install_app() {
  log "安装 ${APP_NAME} 到 /Applications..."
  osascript -e "tell application \"${APP_NAME}\" to quit" >/dev/null 2>&1 || true
  osascript -e 'tell application "Orchard" to quit' >/dev/null 2>&1 || true

  if [[ -w /Applications ]]; then
    run rm -rf "$DEST_APP"
    run ditto "$BUNDLED_APP" "$DEST_APP"
  else
    warn "需要管理员权限复制到 /Applications。"
    run sudo rm -rf "$DEST_APP"
    run sudo ditto "$BUNDLED_APP" "$DEST_APP"
  fi

  run xattr -dr com.apple.quarantine "$DEST_APP" || true
  defaults write "$APP_ID" AppleLanguages -array zh-Hans en
  defaults write "$APP_ID" AppleLocale zh_CN
}

open_app() {
  log "打开 ${APP_NAME}..."
  run open "$DEST_APP"
}

main() {
  clear || true
  printf '%s\n' "星奕筑容器一键安装器"
  printf '%s\n\n' "会自动安装 Apple container，并安装中文图形界面。"

  ensure_supported_machine
  ensure_bundled_app
  ensure_homebrew
  install_container_runtime
  install_app
  open_app

  ok "已安装 ${APP_NAME}，并已启动 Apple container 服务。"
  pause
}

main "$@"
