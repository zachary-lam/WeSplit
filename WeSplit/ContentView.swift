//
//  ContentView.swift
//  WeSplit
//
//  Created by Zachary Lâm on 2026-01-03.
//

import SwiftUI

struct ContentView: View {
    let localCurrency: String = Locale.current.currency?.identifier ?? "USD"
    
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    @FocusState private var amountIsFocused: Bool
    @State private var showAlert: Bool = false
    
    let tipPercentages: Array<Int> = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount: Double = Double(numberOfPeople + 2) // convert to double
        let tipSelection: Double = Double(tipPercentage) // convert to double
        
        let tipValue: Double = checkAmount / 100 * tipSelection
        let grandTotal: Double = checkAmount + tipValue
        let amountPerPerson: Double = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let amount: Double
        
        if checkAmount == 0.0 {
            amount = checkAmount
            
            return amount
        } else {
            return checkAmount + Double(tipPercentage)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                AngularGradient(colors: [
                    Color(red: 0.1, green: 0.1, blue: 0.12),
                    Color(red: 0.2, green: 0.15, blue: 0.26)],
                                center: .center, angle: .degrees(45.0))
                .ignoresSafeArea()
                
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format: .currency(code: localCurrency))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    .listRowBackground(Rectangle().fill(.thinMaterial)) // use Rectangle to conform to View and fill with colour
                    
                    Section("Tip %") {
                        Picker("Tip %", selection: $tipPercentage) {
                            ForEach(0..<101) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    .listRowBackground(Rectangle().fill(.thinMaterial))
                    
                    Section("Total amount") {
                        Text(totalAmount, format: .currency(code: localCurrency))
                    }
                    .listRowBackground(Rectangle().fill(.thinMaterial))
                    
                    Section("Amount per person") {
                        Text(totalPerPerson, format: .currency(code: localCurrency))
                    }
                    .listRowBackground(Rectangle().fill(.thinMaterial))
                    
                    Button("Confirm payment") {
                        showAlert = true
                    }
                    .alert("Thank you", isPresented: $showAlert) {
                        Button("Confirm", role: .confirm) {}
                        Button("Cancel", role: .cancel) {}
                    } message: {
                        Text(totalPerPerson, format: .currency(code: localCurrency))
                    }
                    .listRowBackground(Rectangle().fill(.thinMaterial))

                }
                .navigationTitle("WeSplit")
                .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    ContentView()
}
