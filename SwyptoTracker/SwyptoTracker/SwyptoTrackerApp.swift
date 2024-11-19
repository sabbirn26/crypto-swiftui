//
//  SwyptoTrackerApp.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 19/11/24.
//

import SwiftUI

@main
struct SwyptoTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
