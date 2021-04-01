import Foundation
import Rest

extension SecureStringStore {
    public static let binanceApiKey = SecureStringStore(identifier: .binance, key: .apiKey)
    public static let binanceApiSecret = SecureStringStore(identifier: .binance, key: .apiSecret)
}

extension SecureStringIdentifier {
    static let binance = SecureStringIdentifier("Binance")
}
