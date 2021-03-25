import SwiftUI
import CoreData

struct ContentView: View {
    public init() {}
    
    var body: some View {
        NavigationView {
            ConnectedApisView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
