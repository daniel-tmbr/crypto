import SwiftUI

public enum Screen: String {
    case home
    case account
    case market
    case settings
}

struct AppView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    #endif
    
    @AppStorage("app.screen")
    private var screen: Screen = .home
    
    var body: some View {
        #if os(iOS)
        switch horizontalSizeClass {
        case .compact: AppTabNavigation(screen: $screen)
        default: AppSidebarNavigation(screen: $screen)
        }
        #else
        AppSidebarNavigation(screen: $screen)
        #endif
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
