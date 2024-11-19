//
//  SwyptoTrackerApp.swift
//  SwyptoTracker
//
//  Created by Sabbir Nasir on 19/11/24.
//

import SwiftUI

@main
struct SwyptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
