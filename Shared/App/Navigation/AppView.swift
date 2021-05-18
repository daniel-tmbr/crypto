import ComposableArchitecture
import SwiftUI

struct AppView: View {
    enum Action {
        case launched
    }
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    #endif
    
    private let store: Store<AppState, AppAction>
    @ObservedObject
    private var viewStore: ViewStore<Void, Action>
    
    init(store: Store<AppState, AppAction>) {
        self.store = store
        viewStore = ViewStore(store.scope(
            state: { _ in () },
            action: { _ in .launched }
        ))
        viewStore.send(.launched)
    }
    
    var body: some View {
        #if os(iOS)
        switch horizontalSizeClass {
        case .compact:
            AppTabNavigation(store: store)
        default:
            AppSidebarNavigation(store: store)
        }
        #else
        AppSidebarNavigation(store: store)
        #endif
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: Store(
            initialState: AppState(symbols: .empty),
            reducer: Reducer<AppState, AppAction, AppEnvironment>.app,
            environment: AppEnvironment.mock
        ))
    }
}
