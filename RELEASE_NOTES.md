# v1.12.1-zh.4 发布说明

这是基于 Orchard `v1.12.1` 的星奕筑容器版本。

## 包含内容

- 新增一键安装包 `Xingyizhu-Container-OneClick-Installer-1.12.1-zh.4-macos-arm64.zip`。
- 一键安装包包含 `星奕筑容器.app` 中文 UI 和 `双击一键安装星奕筑容器.command`。
- 安装脚本会自动安装 Homebrew（如缺失）、安装 Apple `container`、启动服务、安装 UI 到 `/Applications` 并打开应用。
- 简体中文本地化资源。
- App 名称改为“星奕筑容器”。
- App 图标替换为星奕筑标识。
- 中文侧边栏标题。
- 镜像、挂载等详情页常见英文标签改为中文。
- 中文 README、安装脚本、第三方许可证说明和非商业用途声明。
- GitHub Release 附件提供本地构建的 `星奕筑容器.app` zip。

## 已验证

- Release 构建通过。
- 本机临时签名校验通过。
- `/Applications/星奕筑容器.app` 可启动。
- 图形界面主窗口可打开，侧边栏、搜索、镜像详情页显示中文。
- Apple `container` 服务状态为 `running`。
- `alpine:latest` 前台容器启动测试通过。
- 短时后台容器创建、列表显示、停止和删除测试通过。
- 一键安装包可解压，安装脚本语法检查通过。
- 一键安装脚本本机实装路径测试通过，可安装 UI、启动服务并打开应用。

## 说明

- 一键安装包会自动安装 Apple `container`，但不直接把 Apple `container` 二进制文件放进本仓库。
- Apple `container` 由 Homebrew 从官方软件源安装。
- 不包含 Docker Desktop。
- 不包含 Apple Developer ID 签名或 notarization。

## 推荐安装

下载 Release 附件中的 `Xingyizhu-Container-OneClick-Installer-1.12.1-zh.4-macos-arm64.zip`，解压后双击 `双击一键安装星奕筑容器.command`。

如果 macOS 阻止打开，这是因为当前包是本机临时签名、未做 Apple notarization。可以在“系统设置 > 隐私与安全性”里允许打开，或自行从源码构建。

## 校验

```text
5278d0cdae1b8b78fae02831fd09f2495ebd44ceffeaa12ca630c17a66a463f8  Xingyizhu-Container-OneClick-Installer-1.12.1-zh.4-macos-arm64.zip
1756c4ac480ac45f70b8e1892a25cb90adaa928233d5823d0aca97b3b781b596  Xingyizhu-Container-1.12.1-zh.4-macos-arm64.zip
```
