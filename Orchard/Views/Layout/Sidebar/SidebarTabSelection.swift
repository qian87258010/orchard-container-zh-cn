import Foundation

enum TabSelection: String, CaseIterable {
    case containers = "containers"
    case images = "images"
    case mounts = "mounts"
    case dns = "dns"
    case networks = "networks"
    case registries = "registries"
    case systemLogs = "systemLogs"
    case stats = "stats"
    case configuration = "configuration"

    var icon: String {
        switch self {
        case .containers:
            return "cube"
        case .images:
            return "cube.transparent"
        case .mounts:
            return "externaldrive"
        case .dns:
            return "network"
        case .networks:
            return "arrow.down.left.arrow.up.right"
        case .registries:
            return "server.rack"
        case .systemLogs:
            return "doc.text.below.ecg"
        case .stats:
            return "water.waves"
        case .configuration:
            return "gearshape"
        }
    }

    var title: String {
        switch self {
        case .containers:
            return "容器"
        case .images:
            return "镜像"
        case .mounts:
            return "挂载"
        case .dns:
            return "DNS"
        case .networks:
            return "网络"
        case .registries:
            return "镜像仓库"
        case .systemLogs:
            return "系统日志"
        case .stats:
            return "统计"
        case .configuration:
            return "配置"
        }
    }
}
