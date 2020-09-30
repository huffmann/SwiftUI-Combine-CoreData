//
//  StarterApp.swift
//  Starter
//
//  Created by Xumak on 23/09/20.
//

import SwiftUI

@main
struct StarterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CoinsList()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
