//
//  CaloriTrackerApp.swift
//  CaloriTracker
//
//  Created by Chon Hin Chou on 8/6/24.
//

import SwiftUI

@main
struct CaloriTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
