//
//  ContentView.swift
//  Include WeConvert
//
//  Created by Bruno Oliveira on 24/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue = 0
    @State private var inputUnit = "ºF"
    @State private var outputValue = 0
    @State private var outputUnit = "ºC"
    
    let unitList = ["Fahrenheit": "ºF", "Celsius": "ºC", "Kelvin": "ºK"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Choose the input Value and Unit"){
                    TextField("Input Value", value: $inputValue, format: .number)
                        .keyboardType(.numberPad)
                        .padding()
                    Picker("Input Unit", selection: $inputUnit){
                        ForEach(unitList.sorted(by: <), id: \.key){ key, value in
                            Text(value)
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section("Choose the Output unit:"){
                    Picker("Output Unit", selection: $outputUnit){
                        ForEach(unitList.sorted(by: <), id: \.key){ key, value in
                            Text(value)
                        }
                    }
                }
            }
            .navigationTitle("Include We Convert")
            
            .padding()
            
            Section("Output convertion"){
                //Text(outputValue, format: .number)
            }
            Spacer()
            
            VStack {
                Button {
                    outputValue = convert()
                } label: {
                    Text("Convert")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.black)
                        .frame(minWidth:200, maxWidth: .infinity, maxHeight: 100)
                }
            }
            
        }
    }

    func convert() -> Int {
    
        switch(inputUnit) {
        case "ºF": 
            if(outputUnit == "ºC") {
                return (inputValue - 32) * 5/9
            } else if (outputUnit == "ºF") {
                return inputValue
            } else {
                return ((inputValue - 32) * 5/9 + Int(273.15))
            }
        case "ºC": return 0
        case "ºK": return 0
        default: return 0
        }
        
    }
    
}

#Preview {
    ContentView()
}
