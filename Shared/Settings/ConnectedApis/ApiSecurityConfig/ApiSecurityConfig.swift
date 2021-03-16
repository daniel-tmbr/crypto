import CryptoKit
import Foundation
import Rest

struct ApiSecurityConfig {
    let name: String
    let apiKey: ConsumerKeyStore
    let secretKey: ConsumerKeyStore
}

extension ApiSecurityConfig {
    static let binance: ApiSecurityConfig = {
        let store = SecKeyStore()
        let name = "Binance"
        return ApiSecurityConfig(
            name: name,
            apiKey: StringSecKeyStore(store: store, identifier: name, type: .apiKey),
            secretKey: StringSecKeyStore(store: store, identifier: name, type: .secretKey)
        )
    }()
    
    static let twitter: ApiSecurityConfig = {
        let store = SecKeyStore()
        let name = "Twitter"
        return ApiSecurityConfig(
            name: name,
            apiKey: StringSecKeyStore(store: store, identifier: name, type: .apiKey),
            secretKey: StringSecKeyStore(store: store, identifier: name, type: .secretKey)
        )
    }()
}
