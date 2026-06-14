# v1.12.1-zh.2 发布说明

这是基于 Orchard `v1.12.1` 的星奕筑容器版本。

## 包含内容

- 简体中文本地化资源。
- App 名称改为“星奕筑容器”。
- App 图标替换为星奕筑标识。
- 中文侧边栏标题。
- 中文 README、安装脚本、第三方许可证说明和非商业用途声明。
- GitHub Release 附件提供本地构建的 `星奕筑容器.app` zip。

## 已验证

- Release 构建通过。
- 本机临时签名校验通过。
- `/Applications/星奕筑容器.app` 可启动。
- Apple `container` 服务状态为 `running`。
- `alpine:latest` 容器启动测试通过。

## 不包含内容

- 不包含 Apple `container` 二进制文件。
- 不包含 Docker Desktop。
- 不包含 Apple Developer ID 签名或 notarization。

## 安装

先安装并启动 Apple `container`：

```bash
brew install container
container system start
```

然后下载 Release 附件中的 `Xingyizhu-Container-1.12.1-zh.2-macos-arm64.zip`，解压后把 `星奕筑容器.app` 放入 `/Applications`。

如果 macOS 阻止打开，这是因为当前包是本机临时签名、未做 Apple notarization。可以在“系统设置 > 隐私与安全性”里允许打开，或自行从源码构建。

## 校验

```text
021f7482e1d6fda6a6f83e542be8aeeefa6f4fe0ab8c80da5e00d6e279d50ba4  Xingyizhu-Container-1.12.1-zh.2-macos-arm64.zip
```
