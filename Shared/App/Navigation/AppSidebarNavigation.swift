import ComposableArchitecture
import SwiftUI

struct AppSidebarNavigation: View {
    private let store: Store<AppState, AppAction>
    private let viewStore: ViewStore<Screen, ScreenAction>
    private let selection: Binding<Screen?>
    
    init(store: Store<AppState, AppAction>) {
        let viewStore = ViewStore(store.scope(
            state: { $0.screen },
            action: { .screen($0) }
        ))
        let selection = Binding<Screen?>(
            get: { viewStore.state },
            set: { viewStore.send(.change($0 ?? .home)) }
        )
        self.store = store
        self.viewStore = viewStore
        self.selection = selection
        viewStore.send(.load)
    }
    
    private var sidebar: some View {
        List(selection: selection) {
            NavigationLink(destination: HomeView()) {
                Label(L10n.Navigation.home.localizedKey, systemImage: "house")
                    .accessibilityLabel(L10n.Navigation.home.localizedKey)
            }
            .tag(Screen.home)
            
            NavigationLink(destination: AccountView()) {
                Label(L10n.Navigation.account.localizedKey, systemImage: "person.crop.circle")
                    .accessibilityLabel(L10n.Navigation.account.localizedKey)
            }
            .tag(Screen.account)

            NavigationLink(destination: SymbolsView(
                store: store.scope(
                    state: \.symbols,
                    action: AppAction.symbols
                ))
            ) {
                Label(L10n.Navigation.coins.localizedKey, systemImage: "bitcoinsign.circle")
                    .accessibilityLabel(L10n.Navigation.coins.localizedKey)
            }
            .tag(Screen.coins)
            
            NavigationLink(destination: SettingsView()) {
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
        AppSidebarNavigation(
            store: Store(
                initialState: AppState(),
                reducer: Reducer<AppState, AppAction, AppEnvironment>.app,
                environment: .live
            )
        )
    }
}
