import ComposableArchitecture
import SwiftUI

struct AppTabNavigation: View {
    private let store: Store<AppState, AppAction>
    private let viewStore: ViewStore<Screen, ScreenAction>
    private let selection: Binding<Screen>
    
    init(store: Store<AppState, AppAction>) {
        let viewStore = ViewStore(store.scope(
            state: { $0.screen },
            action: { .screen($0) }
        ))
        let selection = Binding<Screen>(
            get: { viewStore.state },
            set: { viewStore.send(.change($0)) }
        )
        self.store = store
        self.viewStore = viewStore
        self.selection = selection
        viewStore.send(.load)
    }

    var body: some View {
        TabView(selection: selection) {
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
                SymbolsView(
                    store: store.scope(
                        state: \.symbols,
                        action: AppAction.symbols
                    )
                )
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
        AppTabNavigation(
            store: Store(
                initialState: AppState(),
                reducer: Reducer<AppState, AppAction, AppEnvironment>.app,
                environment: .live
            )
        )
    }
}
