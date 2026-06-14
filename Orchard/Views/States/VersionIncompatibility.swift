import SwiftUI

struct VersionIncompatibilityView: View {
    @EnvironmentObject var containerService: ContainerService

    var body: some View {
        VStack(spacing: 30) {
            SwiftUI.Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.orange)

            VStack(spacing: 16) {
                Text("Container 版本不兼容")
                    .font(.title)
                    .fontWeight(.semibold)

                if let installedVersion = containerService.parsedContainerVersion {
                    Text("星奕筑容器需要 Apple Container 版本 \(containerService.parsedContainerVersion ?? "未知")，当前运行版本为 \(installedVersion)。")
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                } else if let rawVersion = containerService.containerVersion {
                    Text("检测到版本：\(rawVersion)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)

                    Text("星奕筑容器需要 Apple Container 版本 \(containerService.parsedContainerVersion ?? "未知")。")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } else {
                    Text("星奕筑容器需要 Apple Container 版本 \(containerService.parsedContainerVersion ?? "未知")。")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Text("请更新 Apple Container 后再继续使用星奕筑容器。")
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }

            HStack(spacing: 16) {
                Button("查看升级说明") {
                    if let url = URL(string: "https://github.com/apple/container?tab=readme-ov-file#install-or-upgrade") {
                        NSWorkspace.shared.open(url)
                    }
                }
                .buttonStyle(.borderedProminent)

                Button("重新检查") {
                    Task { @MainActor in
                        await containerService.checkSystemStatus()
                    }
                }
                .buttonStyle(.bordered)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .task {
            await containerService.checkSystemStatus()
        }
    }
}
