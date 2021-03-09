//
//  cryptoApp.swift
//  Shared
//
//  Created by Daniel Tombor on 09/03/2021.
//

import SwiftUI

@main
struct cryptoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
