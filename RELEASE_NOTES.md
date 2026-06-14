# v1.12.1-zh.1 发布说明

这是基于 Orchard `v1.12.1` 的简体中文整理版本。

## 包含内容

- 简体中文本地化资源。
- 中文侧边栏标题。
- 中文 README、安装脚本、第三方许可证说明和非商业用途声明。
- GitHub Release 附件提供本地构建的 `Orchard.app` zip。

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

然后下载 Release 附件中的 `Orchard-zh-Hans-1.12.1-zh.1-macos-arm64.zip`，解压后把 `Orchard.app` 放入 `/Applications`。

如果 macOS 阻止打开，这是因为当前包是本机临时签名、未做 Apple notarization。可以在“系统设置 > 隐私与安全性”里允许打开，或自行从源码构建。

## 校验

```text
SHA256 4655c1cc32ab6606d6af00793c8cb23b3037970984fd366250dcc7942c9c5b0f
```
