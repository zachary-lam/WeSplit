//
//  ContentView.swift
//  WeSplit
//
//  Created by Zachary Lâm on 2026-01-03.
//

import SwiftUI

struct ContentView: View {
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
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
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
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
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
