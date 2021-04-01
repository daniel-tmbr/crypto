import Foundation
import Rest

enum SecurityType {
    case none       // NONE Endpoint can be accessed freely.
    case trade      // TRADE Endpoint requires sending a valid API-Key and signature.
    case margin     // MARGIN Endpoint requires sending a valid API-Key and signature.
    case userData   // USER_DATA Endpoint requires sending a valid API-Key and signature.
    case userStream // USER_STREAM Endpoint requires sending a valid API-Key.
    case marketData // MARKET_DATA Endpoint requires sending a valid API-Key.
}
