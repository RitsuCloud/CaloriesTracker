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
class DataController: ObservableObject{
    
    // load the data from CaloriTracker
    let persistentContainer: NSPersistentContainer
    
    let context: NSManagedObjectContext
    
    @Published var savedEntity: [FoodEntity] = []
    @Published var totalCalories = Int64(0)
    @Published var totalProtein = Int64(0)
    @Published var totalFat = Int64(0)
    @Published var totalCarbs = Int64(0)
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CaloriTracker")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Failed To Load: \(error.localizedDescription)")
            }
        }
        context = persistentContainer.viewContext
        fetchFoods()
    }
    
    func fetchFoods() {
        let request = NSFetchRequest<FoodEntity>(entityName: "FoodEntity")
        
        do{
            savedEntity = try context.fetch(request)
            sumFoodAttributes()
        } catch {
            print("Failed to fetch foods, \(error)")
        }
    }
    
    func addFood(name: String, cal: String, fat: String, carb: String, protein: String) {
        let foodEntry = FoodEntity(context: context)
        foodEntry.name = name
        if let cal16 = Int64(cal) {
            foodEntry.cal = cal16
        }
        if let fat16 = Int64(fat) {
            foodEntry.fat = fat16
        }
        if let carb16 = Int64(carb) {
            foodEntry.carb = carb16
        }
        if let protein16 = Int64(protein) {
            foodEntry.protein = protein16
        }
        saveData()
    }
    
    func sumFoodAttributes() {
        totalCalories = Int64(0)
        totalProtein = Int64(0)
        totalFat = Int64(0)
        totalCarbs = Int64(0)
        // Loop through each Food entity and sum up the attributes
        for food in savedEntity {
            // Ensure safe casting and retrieve the attribute values
            totalCalories += food.cal
            totalProtein += food.protein
            totalFat += food.fat
            totalCarbs += food.carb
        }

        // Print or use the results
        print("Total Calories: \(totalCalories)")
        print("Total Protein: \(totalProtein)g")
        print("Total Fat: \(totalFat)g")
        print("Total Carbs: \(totalCarbs)g")
    }
    
    func editFood(foodEntry: FoodEntity, name: String, cal: String,
                  fat: String, carb: String, protein: String){
        foodEntry.name = name
        if let cal16 = Int64(cal) {
            foodEntry.cal = cal16
        }
        if let fat16 = Int64(fat) {
            foodEntry.fat = fat16
        }
        if let carb16 = Int64(carb) {
            foodEntry.carb = carb16
        }
        if let protein16 = Int64(protein) {
            foodEntry.protein = protein16
        }
        saveData()
    }
    
    func deleteFood(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntity[index]
        context.delete(entity)
        saveData()
    }
    
    func clearAll() {
        for food in savedEntity{
            context.delete(food)
        }
        saveData()
    }
    func saveData() {
        do {
            try context.save()
            fetchFoods()
        } catch {
            print("Failed to save data! \(error)")
        }
    }
}
