//
//  DataController.swift
//  CaloriTracker
//
//  Created by Chon Hin Chou on 8/7/24.
//

import Foundation
import CoreData

/* Protocal provided by SwiftUI framework, enables the creation of objects
   that can be observed for changes. If object conforms to ObservableObject
   it will automatically update UI when properties is changed
   Doc: https://developer.apple.com/documentation/combine/observableobject
 */
struct DataController{
    static let shared = DataController()
    
    // load the data from CaloriTracker
    let persistentContainer: NSPersistentContainer
    
    let context: NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CaloriTracker")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Failed To Load: \(error.localizedDescription)")
            }
        }
        context = persistentContainer.viewContext
    }
}
