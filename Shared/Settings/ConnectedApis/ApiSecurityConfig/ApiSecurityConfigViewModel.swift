import Combine
import CryptoKit
import Foundation
import SwiftUI

final class ApiSecurityConfigViewModel {
    private let config: ApiSecurityConfig
    
    var name: String { config.name }
    let apiKey: ConsumerKey
    let secretKey: ConsumerKey
    
    init(config: ApiSecurityConfig) {
        self.config = config
        apiKey = ConsumerKey(store: config.apiKey)
        secretKey = ConsumerKey(store: config.secretKey)
    }
}
