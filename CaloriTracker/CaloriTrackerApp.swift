//
//  CaloriTrackerApp.swift
//  CaloriTracker
//
//  Created by Chon Hin Chou on 8/6/24.
//

import SwiftUI

@main
struct CaloriTrackerApp: App {
    @StateObject var vm = DataController()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
