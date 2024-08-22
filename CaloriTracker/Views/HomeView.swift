//
//  HomeView.swift
//  CaloriTracker
//
//  Created by Chon Hin Chou on 8/7/24.
//
import CoreData
import SwiftUI
import UIKit

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var showAlert = false
    @State var totalCalories = Int64(0)
    @State var totalProtein = Int64(0)
    @State var totalFat = Int64(0)
    @State var totalCarbs = Int64(0)
    
    /* sortDescriptors is empty so no sorting, fetch the data into var
       named foods with type Food */
    @FetchRequest(sortDescriptors: []) var foods: FetchedResults<Food>
    
    @State private var showAddScreen = false
    
    var body: some View {
        NavigationView {
            List(foods) { fd in
                Section {
                    Text(fd.name ?? "Unknow")
                    Text("Calories: \(fd.cal)")
                    Text("Carb: \(fd.carb)" )
                    Text("Fat: \(fd.fat)")
                    Text("Protein: \(fd.protein)")
                }
            }
            .navigationTitle("Todays Macro Count")
        }
        VStack {
            VStack{
                Section{
                    Text("Calories: \(totalCalories) Carb: \(totalCarbs)g")
                    Text("Fat: \(totalFat)g Protein: \(totalProtein)g")
                }
                .font(.title2)
            }
            .padding()
            HStack {
                
                  Button(role: .destructive) {
                        showAlert = true
                  } label: {
                        Text("Clear")
                            .foregroundColor(.red)
                            .font(.title2)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 2)  // Border color and width
                            )

                    }
                    .padding(.trailing, 15)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Confirm Delete"),
                            message: Text("Are you sure you want to delete all items? This action cannot be undone."),
                                   primaryButton: .destructive(Text("Delete")) {
                                       // Perform the delete action
                                       resetMacro()
                                   },
                            secondaryButton: .cancel()
                        )
                    }
                
                Button{
                    sumFoodAttributes()
                } label: {
                    Text("Calculate")
                }
                .font(.title2)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 2)  // Border color and width
                )
                .padding(.trailing, 10)
                
                Button{
                    showAddScreen.toggle()
                } label: {
                    Text("Add")
                }
                .font(.title2)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 2)  // Border color and width
                )
                .sheet(isPresented: $showAddScreen) {
                    AddFoodView()
                }
            }
        }
    }
    func sumFoodAttributes() {
        totalCalories = Int64(0)
        totalProtein = Int64(0)
        totalFat = Int64(0)
        totalCarbs = Int64(0)
        // Loop through each Food entity and sum up the attributes
        for food in foods {
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
    func resetMacro() {
        let persistenceController = DataController.shared
        let context = persistenceController.context
        
        totalCalories = Int64(0)
        totalProtein = Int64(0)
        totalFat = Int64(0)
        totalCarbs = Int64(0)
        
        for food in foods{
            context.delete(food)
        }
        
        do{
            try context.save()
        } catch {
            print("Failed to delete entities")
        }
    }
}

#Preview {
    HomeView()
}
