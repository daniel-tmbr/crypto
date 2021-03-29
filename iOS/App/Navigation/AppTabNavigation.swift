import SwiftUI

struct AppTabNavigation: View {
    
    @Binding
    private var screen: Screen
    
    init(screen: Binding<Screen>) {
        self._screen = screen
    }

    var body: some View {
        TabView(selection: $screen) {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label(L10n.Navigation.home.localizedKey, systemImage: "house")
                    .accessibilityLabel(L10n.Navigation.home.localizedKey)
            }
            .tag(Screen.home)

            NavigationView {
                AccountView()
            }
            .tabItem {
                Label(L10n.Navigation.account.localizedKey, systemImage: "person.crop.circle")
                    .accessibilityLabel(L10n.Navigation.account.localizedKey)
            }
            .tag(Screen.account)

            NavigationView {
                CoinsView()
            }
            .tabItem {
                Label(L10n.Navigation.coins.localizedKey, systemImage: "bitcoinsign.circle")
                    .accessibilityLabel(L10n.Navigation.coins.localizedKey)
            }
            .tag(Screen.coins)

            NavigationView {
                SettingsView()
            }
            .tabItem {
                Label(L10n.Navigation.settings.localizedKey, systemImage: "gearshape")
                    .accessibilityLabel(L10n.Navigation.settings.localizedKey)
            }
            .tag(Screen.settings)
        }
    }
}

// MARK: - Previews

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation(screen: .constant(Screen.home))
    }
}
