# 星奕筑容器

星奕筑容器是基于 Orchard 中文化整理的 macOS 图形界面，并附带 Apple `container` 的安装、启动和使用说明。

它用来管理 Apple `container` 创建的容器、镜像、挂载、网络、DNS、统计信息和系统配置。操作体验更接近 Docker Desktop，但底层使用的是 Apple 官方 `container` 工具。

## 当前内容

- 基于上游 Orchard `v1.12.1` 源码整理。
- App 名称改为“星奕筑容器”。
- App 图标替换为星奕筑标识。
- 增加 `zh-Hans` 简体中文本地化资源。
- 修正侧边栏硬编码英文标题，已显示为“容器 / 镜像 / 挂载 / 网络 / 统计 / 配置”。
- 提供 Apple `container` 安装与启动脚本。
- 提供星奕筑容器本地构建和安装脚本。
- 保留上游 MIT 许可证和 Apple `container` 的 Apache-2.0 许可证说明。

## 系统要求

- Apple Silicon Mac，建议 M 系列芯片。
- macOS 26 Tahoe 或可运行 Apple `container` 的新版 macOS。
- Xcode 26 或更新版本，用于本地构建星奕筑容器。
- Homebrew。

## 快速安装 Release 包

如果你只想使用图形界面，可以在 GitHub Release 下载 `Xingyizhu-Container-1.12.1-zh.3-macos-arm64.zip`。Release 附件只包含星奕筑容器，不包含 Apple `container`，所以仍需先安装 Apple `container`。

先安装并启动 Apple `container`：

```bash
brew install container
container system start
container system status
```

然后解压 Release 附件，把 `星奕筑容器.app` 放入 `/Applications` 并打开。

如果 macOS 阻止打开，这是因为当前包是本机临时签名、未做 Apple notarization。可以在“系统设置 > 隐私与安全性”里允许打开，或自行从源码构建。

## 从源码构建安装

安装 Apple `container`：

```bash
./scripts/install-container.sh
```

构建并安装星奕筑容器：

```bash
./scripts/build-and-install-orchard-zh.sh
```

安装完成后脚本会打开 `/Applications/星奕筑容器.app`。

## 手动命令

安装 Apple `container`：

```bash
brew install container
container system start
container system status
```

测试容器运行：

```bash
container run --rm docker.io/library/alpine:latest uname -a
```

构建星奕筑容器：

```bash
xcodebuild \
  -project Orchard.xcodeproj \
  -scheme Orchard \
  -configuration Release \
  -destination 'platform=macOS' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## 常见操作

- 容器：创建、启动、停止、强制停止、删除。
- 镜像：拉取、删除、搜索 Docker Hub 镜像。
- 挂载：管理容器挂载目录。
- 网络：管理 Apple `container` 网络。
- DNS：管理 DNS 域名相关配置。
- 统计：查看运行中容器的 CPU、内存和网络状态。
- 配置：管理系统、构建器、内核等设置。

## 与 Docker Desktop 的关系

这不是 Docker Desktop，也不包含 Docker Desktop 的商业组件。

Apple `container` 是 Apple 官方命令行容器工具。Orchard 是第三方开源图形界面，用来管理 Apple `container`。本仓库在 Orchard 基础上整理为“星奕筑容器”，并写好中文使用说明。

## 非商业用途说明

本仓库的整理目标是方便中文用户学习、研究和个人非商业使用。请阅读 [NON_COMMERCIAL_NOTICE.md](NON_COMMERCIAL_NOTICE.md)。

重要说明：上游 Orchard 使用 MIT 许可证，Apple `container` 使用 Apache-2.0 许可证。这些上游许可证本身允许商业使用，本仓库不能撤销上游项目已经授予的权利。请在使用、修改、分发时保留原作者署名和许可证文本。

## 上游项目

- Orchard: https://github.com/andrew-waters/orchard
- Apple container: https://github.com/apple/container
- Apple container 文档: https://apple.github.io/container/documentation/

原始 Orchard README 已保留在 [README_UPSTREAM.md](README_UPSTREAM.md)。

## 许可证

- Orchard 源码继承上游 MIT License，见 [LICENSE](LICENSE)。
- Apple `container` 为 Apache-2.0 License，本仓库不分发 Apple `container` 二进制文件。
- 第三方说明见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。
