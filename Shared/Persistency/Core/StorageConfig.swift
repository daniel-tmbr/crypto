import CoreData
import Foundation

struct StorageConfig {
    struct Description {
        let fileUrl: URL
        let configurationName: String
        let cloudContainerId: String?
    }
    
    let bundle: Bundle
    let name: String
    let `extension`: String
    let descriptions: [Description]
}

extension StorageConfig {
    static let cloud = StorageConfig(
        bundle: Bundle(for: DefaultStorage.self),
        name: "crypto_v1",
        extension: "momd",
        descriptions: [.cloud]
    )
    
    static let memory = StorageConfig(
        bundle: Bundle(for: DefaultStorage.self),
        name: "crypto_v1",
        extension: "momd",
        descriptions: [.memory]
    )
}

extension StorageConfig.Description {
    static let cloud = StorageConfig.Description(
        fileUrl: URL(fileURLWithPath: "files/cloud.sqlite"),
        configurationName: "Cloud",
        cloudContainerId: "iCloud.me.tmbr.lyb.debug"
    )
    
    static let memory = StorageConfig.Description(
        fileUrl: URL(fileURLWithPath: "/dev/null"),
        configurationName: "Default",
        cloudContainerId: nil
    )
}

private class DefaultStorage {}
