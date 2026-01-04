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
                
                Section("Tip %") {
                    Picker("Tip %", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total amount") {
                    Text(totalAmount, format: .currency(code: localCurrency))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: localCurrency))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
