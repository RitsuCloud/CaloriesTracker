//
//  CaloriTrackerApp.swift
//  CaloriTracker
//
//  Created by Chon Hin Chou on 8/6/24.
//

import SwiftUI

@main
struct CaloriTrackerApp: App {
    let persistenceController = DataController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.context)
            //AddFoodView()
        }
    }
}
