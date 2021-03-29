import SwiftUI

struct AppSidebarNavigation: View {

    @Binding
    private var screen: Screen?
    
    init(screen: Binding<Screen>) {
        self._screen = Binding(screen)
    }
    
    private var sidebar: some View {
        List(selection: $screen) {
            NavigationLink(
                destination: HomeView(),
                tag: Screen.home,
                selection: $screen
            ) {
                Label(L10n.Navigation.home.localizedKey, systemImage: "house")
                    .accessibilityLabel(L10n.Navigation.home.localizedKey)
            }
            .tag(Screen.home)
            
            NavigationLink(
                destination: AccountView(),
                tag: Screen.account,
                selection: $screen
            ) {
                Label(L10n.Navigation.account.localizedKey, systemImage: "person.crop.circle")
                    .accessibilityLabel(L10n.Navigation.account.localizedKey)
            }
            .tag(Screen.account)

            NavigationLink(
                destination: CoinsView(),
                tag: Screen.coins,
                selection: $screen
            ) {
                Label(L10n.Navigation.coins.localizedKey, systemImage: "bitcoinsign.circle")
                    .accessibilityLabel(L10n.Navigation.coins.localizedKey)
            }
            .tag(Screen.coins)
            
            NavigationLink(
                destination: SettingsView(),
                tag: Screen.settings,
                selection: $screen
            ) {
                Label(L10n.Navigation.settings.localizedKey, systemImage: "gearshape")
                    .accessibilityLabel(L10n.Navigation.settings.localizedKey)
            }
            .tag(Screen.settings)

        }
        .listStyle(SidebarListStyle())
    }
    
    var body: some View {
        NavigationView {
            sidebar
            EmptyView()
            EmptyView()
        }
    }
}

struct AppSidebarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSidebarNavigation(screen: .constant(Screen.home))
    }
}
