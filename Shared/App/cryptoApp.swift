import SwiftUI

@main
struct cryptoApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppView()
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
