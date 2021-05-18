import ComposableArchitecture
import Foundation

public enum ScreenAction: Equatable {
    case load
    case change(Screen)
}

public enum Screen: String, Equatable {
    case home
    case account
    case coins
    case settings
}

extension Reducer
where State == Screen,
      Action == ScreenAction,
      Environment == ScreenEnvironment {
    static let live = Reducer { state, action, env in
        switch action {
        case .load:
            return env.read()
        case .change(let screen):
            state = screen
            return env.save(screen)
        }
    }
}

struct ScreenEnvironment {
    var read: () -> Effect<ScreenAction, Never>
    var save: (Screen) -> Effect<ScreenAction, Never>
}

extension AppEnvironment {
    var screen: ScreenEnvironment {
        let key = "screen"
        return ScreenEnvironment(
            read: userDefaults.read(for: key, path: /ScreenAction.change, default: .home),
            save: userDefaults.save(for: key)
        )
    }
}
