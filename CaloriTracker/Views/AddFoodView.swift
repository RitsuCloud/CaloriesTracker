//
//  AddFoodView.swift
//  CaloriTracker
//
//  Created by Chon Hin Chou on 8/7/24.
//

import SwiftUI

struct AddFoodView: View {
    @EnvironmentObject var vm: DataController
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var cal = ""
    @State private var fat = ""
    @State private var carb = ""
    @State private var protein = ""
    
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
            .navigationTitle("Add Food")
            Spacer()
            Button("Add") {
                vm.addFood(name: name, cal: cal, fat: fat, carb: carb, protein: protein)
                dismiss()
            }
            .font(.title2)
        }
    }
}

#Preview {
    AddFoodView()
}
