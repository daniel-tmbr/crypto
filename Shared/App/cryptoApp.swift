import ComposableArchitecture
import SwiftUI

@main
struct cryptoApp: App {    
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppState(symbols: .empty),
                    reducer: Reducer<AppState, AppAction, AppEnvironment>.app,
                    environment: AppEnvironment.live
                )
            )
        }
        .commands {
            SidebarCommands()
        }
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}
