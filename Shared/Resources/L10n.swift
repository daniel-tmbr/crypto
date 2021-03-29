import SwiftUI

enum L10n {
    enum Apis {
        static let footnote = "apis.footnote"
        static func setup(_ apiName: String) -> LocalizedStringKey {
            "apis.setup.\(apiName)"
        }
        static let subtitle = "apis.subtitle"
        static let title = "apis.title"

    }
    
    enum Binance {
        static let apiKey = "binance.apiKey";
        static let apiSecret = "binance.apiSecret";
        static let helpUrl = "binance.helpUrl";
    }
    
    enum Navigation {
        static let account = "navigation.account"
        static let coins = "navigation.coins"
        static let home = "navigation.home"
        static let settings = "navigation.settings"
    }
    
    enum SecurityKey {
        static let emptyPasteboard = "securitykey.emptypasteboard"
        static func placeholder(_ string: String) -> LocalizedStringKey {
            "securitykey.placeholder.\(string.localized)"
        }
        static func stored(_ string: String) -> LocalizedStringKey {
            "securitykey.stored.\(string.localized)"
        }
    }
    
    enum Settings {
        static let title = "settings.title"
    }
    
    enum Twitter {
        static let accessToken = "twitter.accessToken"
        static let accessTokenSecret = "twitter.accessTokenSecret"
        static let apiKey = "twitter.apiKey"
        static let apiSecret = "twitter.apiSecret"
        static let bearerToken = "twitter.bearerToken"
        static let helpUrl = "twitter.helpUrl"
    }
}

extension String {
    var localizedKey: LocalizedStringKey { LocalizedStringKey(self) }
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
