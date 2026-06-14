# 贡献指南

欢迎提交中文翻译、文档、脚本和兼容性改进。

## 提交前检查

```bash
xcodebuild \
  -project Orchard.xcodeproj \
  -scheme Orchard \
  -configuration Release \
  -destination 'platform=macOS' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## 翻译约定

- 保持中文简洁，优先使用大陆简体中文常见术语。
- `container` 作为命令名时保留英文。
- DNS、CPU、URL、IP 等技术缩写保留英文。
- 菜单和按钮尽量使用短词，避免界面挤压。

## Pull Request

- 说明改动范围。
- 如果修改界面文案，请附上截图。
- 不要提交构建产物、`.app`、`.dmg`、`.zip` 或个人 Xcode 配置。
