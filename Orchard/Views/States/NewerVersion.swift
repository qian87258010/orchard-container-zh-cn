import SwiftUI

struct NewerVersionView: View {
    @EnvironmentObject var containerService: ContainerService

    var body: some View {
        VStack(spacing: 30) {
            SwiftUI.Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.orange)

            VStack(spacing: 16) {
                Text("Container 版本暂未支持")
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

                Text("请检查是否有可用的星奕筑容器更新。")
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }

            HStack(spacing: 16) {
                Button("检查星奕筑容器最新版本") {
                    if let url = URL(string: "https://github.com/qian87258010/orchard-container-zh-cn/releases") {
                        NSWorkspace.shared.open(url)
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("仍然继续") {
                    Task { @MainActor in
                        await containerService.checkSystemStatusIgnoreVersion()
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
