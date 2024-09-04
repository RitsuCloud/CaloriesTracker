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
    @EnvironmentObject var vm: DataController
    
    @State private var showAlert = false
//    @State var totalCalories = Int64(0)
//    @State var totalProtein = Int64(0)
//    @State var totalFat = Int64(0)
//    @State var totalCarbs = Int64(0)
    
    @State private var showAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.savedEntity) { fd in
                    Section {
                        Text(fd.name ?? "Unknow")
                        Text("Calories: \(fd.cal)")
                        Text("Carb: \(fd.carb)" )
                        Text("Fat: \(fd.fat)")
                        Text("Protein: \(fd.protein)")
                    }
                }
            }
            .navigationTitle("Todays Macro Count")
        }
        VStack {
            VStack{
                Section{
                    Text("Calories: \(vm.totalCalories) Carb: \(vm.totalCarbs)g")
                    Text("Fat: \(vm.totalFat)g Protein: \(vm.totalProtein)g")
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
    func resetMacro() {
//        totalCalories = Int64(0)
//        totalProtein = Int64(0)
//        totalFat = Int64(0)
//        totalCarbs = Int64(0)
//        
//        ForEach(vm.savedEntity) { fd in
//            //vm.context.delete(fd)
//        }
//        vm.saveData()
    }
}

#Preview {
    HomeView()
}
