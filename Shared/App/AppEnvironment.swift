import ComposableArchitecture
import Foundation

struct Apis {
    let binance: URL
    
    static let live = Apis(
        binance: URL(string: "https://api.binance.com")!
    )
    
    static let mock = Apis(
        binance: URL(string: "https://api.binance.com")!
    )
}

struct AppEnvironment {
    let apis: Apis
    let mainQueue: AnySchedulerOf<DispatchQueue>
    let userDefaults: UserDefaults
    
    static let live = AppEnvironment(
        apis: .live,
        mainQueue: .main,
        userDefaults: .standard
    )
    static let mock = AppEnvironment(
        apis: .mock,
        mainQueue: .main,
        userDefaults: UserDefaults(suiteName: "Mock User Defaults")!
    )
}
