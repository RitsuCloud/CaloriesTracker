//
//  AddFoodView.swift
//  CaloriTracker
//
//  Created by Chon Hin Chou on 8/7/24.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var cal = ""
    @State private var fat = ""
    @State private var carb = ""
    @State private var protein = ""
    @State private var showAlert = false
    @State private var alertMsg = ""
    
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
                let foodEntry = Food(context: moc)
                foodEntry.name = name
                if let cal16 = Int64(cal) {
                    foodEntry.cal = cal16
                } else {
                    alertMsg += "Missing input for Calories! \n"
                    showAlert = true
                }
                if let fat16 = Int64(fat) {
                    foodEntry.fat = fat16
                } else {
                    alertMsg += "Missing input for Fat! \n"
                    showAlert = true
                }
                if let carb16 = Int64(carb) {
                    foodEntry.carb = carb16
                } else {
                    alertMsg += "Missing input for Carb! \n"
                    showAlert = true
                }
                if let protein16 = Int64(protein) {
                    foodEntry.protein = protein16
                } else {
                    alertMsg += "Missing input for Protein! \n"
                    showAlert = true
                }
                if !showAlert {
                    try? moc.save()
                    dismiss()
                }
            }
            .font(.title2)
            .alert("Error", isPresented: $showAlert) {
                Button("Ok", role: .cancel) {
                    alertMsg = ""
                }
            } message: {
                Text(alertMsg)
            }
        }
    }
}

#Preview {
    AddFoodView()
}
