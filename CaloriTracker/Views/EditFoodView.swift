//
//  EditFoodView.swift
//  CaloriTracker
//
//  Created by Chon Hin Chou on 9/12/24.
//

import SwiftUI

struct EditFoodView: View {
    @EnvironmentObject var vm: DataController
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String
    @State private var cal: String
    @State private var fat: String
    @State private var carb: String
    @State private var protein: String
    let foodEntry: FoodEntity
    
    init(curFood: FoodEntity) {
        self.foodEntry = curFood
        self.name = curFood.name ?? ""
        self.cal = String(curFood.cal)
        self.fat = String(curFood.fat)
        self.carb = String(curFood.carb)
        self.protein = String(curFood.protein)
    }
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section {
                        TextField("Name of Food with Weight", text: $name)
                        TextField("Amount of Calories: ", text: $cal)
                            .keyboardType(.numberPad)
                        TextField("Amount of Fat: ", text: $fat)
                            .keyboardType(.numberPad)
                        TextField("Amount of Carb: ", text: $carb)
                            .keyboardType(.numberPad)
                        TextField("Amount of Protein: ", text: $protein)
                            .keyboardType(.numberPad)
                    }
                }
            }
            .navigationTitle("Edit Food")
            Spacer()
            Button("Save") {
                vm.editFood(foodEntry: foodEntry, name: name, cal: cal, fat: fat, carb: carb, protein: protein)
                dismiss()
            }
            .font(.title2)
        }
    }
}

//#Preview {
    //EditFoodView()
//}
