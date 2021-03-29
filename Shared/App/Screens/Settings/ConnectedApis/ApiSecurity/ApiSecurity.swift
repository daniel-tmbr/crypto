import Combine
import Foundation
import Rest
import SwiftUI

struct ApiSecurity: Identifiable {
    var id: String { name }
    let name: String
    let keys: [SecurityKey]
    let help: URL
}

extension ApiSecurity {
    static let all: [ApiSecurity] = [.binance, .twitter]
    
    static let binance = ApiSecurity(
        name: "Binance",
        keys: [
            SecurityKey(name: L10n.Binance.apiKey, key: SecureStringStore.binanceApiKey),
            SecurityKey(name: L10n.Binance.apiSecret, key: SecureStringStore.binanceApiKey),
        ],
        help: URL(string: L10n.Binance.helpUrl)!
    )
    
    static let twitter = ApiSecurity(
        name: "Twitter",
        keys: [
            SecurityKey(name: L10n.Twitter.apiKey, key: SecureStringStore.twitterApiKey),
            SecurityKey(name: L10n.Twitter.apiSecret, key: SecureStringStore.twitterApiSectet),
            SecurityKey(name: L10n.Twitter.accessToken, key: SecureStringStore.twitterAccessToken),
            SecurityKey(name: L10n.Twitter.accessTokenSecret, key: SecureStringStore.twitterAccessTokenSecret),
            SecurityKey(name: L10n.Twitter.bearerToken, key: SecureStringStore.twitterBearerToken),
        ],
        help: URL(string: L10n.Twitter.helpUrl)!
    )
}

// TODO: Temporary implementation, needs to be moved to the domain frameworks

extension SecureStringStore {
    static let binanceApiKey = SecureStringStore(identifier: .binance, key: .apiKey)
    static let binanceApiSecret = SecureStringStore(identifier: .binance, key: .apiSecret)
    
    static let twitterApiKey = SecureStringStore(identifier: .twitter, key: .apiKey)
    static let twitterApiSectet = SecureStringStore(identifier: .twitter, key: .apiSecret)
    static let twitterAccessToken = SecureStringStore(identifier: .twitter, key: .accessToken)
    static let twitterAccessTokenSecret = SecureStringStore(identifier: .twitter, key: .accessTokenSecret)
    static let twitterBearerToken = SecureStringStore(identifier: .twitter, key: .bearerToken)
}

extension SecureStringIdentifier {
    static let binance = SecureStringIdentifier("Binance")
    static let twitter = SecureStringIdentifier("Twitter")
}

extension SecureStringKey {
    static let apiKey = SecureStringKey("apiKey")
    static let apiSecret = SecureStringKey("apiSecret")
    static let accessToken = SecureStringKey("accessToken")
    static let accessTokenSecret = SecureStringKey("accessTokenSecret")
    static let bearerToken = SecureStringKey("bearerToken")
}
