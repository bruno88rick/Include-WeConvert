//
//  ContentView.swift
//  Include WeConvert
//
//  Created by Bruno Oliveira on 24/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingResult = false
    @State private var titleResult = ""
    @State private var isHiddenError = true
    @State private var isHiddenResult = true
    @FocusState private var inputValueisFocused: Bool
    
    @State private var inputValue = 0.0 {
        didSet{
            isHiddenResult = true
        }
    }
    @State private var inputUnit = "Choose"
    @State private var outputValue = 0.0
    @State private var outputUnit = "Choose"

    let unitList = ["Choose","Fahrenheit", "Celsius", "Kelvin"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Choose the input Value and Unit"){
                    TextField("Input Value", value: $inputValue, format: .number)
                        .keyboardType(.numberPad)
                        .padding()
                        .focused($inputValueisFocused)
                    Picker("Input Unit", selection: $inputUnit){
                        ForEach(unitList, id: \.self){
                            Text($0)
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section("Choose the Output unit:"){
                    Picker("Output Unit", selection: $outputUnit){
                        ForEach(unitList, id:\.self){
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle("Include We Convert")
            .toolbar {
                if inputValueisFocused {
                    Button("Done"){
                        inputValueisFocused = false
                        isHiddenResult = true
                        isHiddenError = true
                    }
                }
            }
                     
            Section(){
                Text("Result is: \(titleResult)")
                    .opacity(isHiddenResult ? 0 : 1)
                    .foregroundStyle(.blue)
                    .font(.system(size: 25).bold())
                    .padding()
                
                Text("Error: Chosse an input and output Unit!")
                    .opacity(isHiddenError ? 0 : 1)
                    .foregroundColor(.red)
                    .font(.system(size: 15).bold())
                    .padding()
            }
            Spacer()
            
            VStack {
                Button {
                    if outputUnit == "Choose" || inputUnit == "Choose" {
                        isHiddenError = false
                        isHiddenResult = true
                    } else {
                        let result = convert(inputValue, inputUnit, outputUnit)
                        titleResult = forTrailingZero(toString: result)
                        showingResult = true
                        isHiddenError = true
                        isHiddenResult = false
                    }
                } label: {
                    Text("Convert")
                        .padding()
                        .foregroundStyle(.white)
                        .background(.black)
                        .frame(minWidth:200, maxWidth: .infinity, maxHeight: 100)
                }
                .clipShape(.circle)
                .alert("The Result is: \(titleResult)", isPresented: $showingResult){
                    Button("Ok", role: .cancel){
                        isHiddenError = true
                        isHiddenResult = false
                    }
                }
            }
            VStack{
                HStack{
                    
                }
            }
            
        }
    }

    func convert(_ value: Double, _ input: String, _ output: String) -> Double {
        /*switch(input) {
         case "Fahrenheit":
         switch (output) {
         case "Celsius": return (value - 32) * 5/9
         case "Fahrenheit": return value
         case "kelvin": return ((value - 32) * 5/9 + Int(273.15))
         default: return -1
         }
         case "Celcius":
         switch (output) {
         case "Celsius": return value
         case "Fahrenheit": return value
         case "kelvin": return ((value - 32) * 5/9 + Int(273.15))
         default: return -1
         case "Kelvin":
         return 0
         default:
         return 1
         }*/
        
        if input == "Fahrenheit" && output == "Celsius" {
            return (value - 32) * 5/9
        } else if input == "Fahrenheit" && output == "Kelvin" {
            return ((value - 32) * 5/9 + 273.15)
        } else if input == "Celsius" && output == "Fahrenheit" {
            return value * (9/5) + 32
        } else if input == "Celsius" && output == "Kelvin" {
            return value + 273.15
        } else if input == "Kelvin" && output == "Celsius" {
            return value - 275.15
        } else if input == "Kelvin" && output == "Fahrenheit" {
            return (value - 273.15) * 9/5 + 32
        } else if input == output {
            return value
        } else if output == "Choose" || input == "Choose"{
            isHiddenError = false
            return -1
        } else {
            isHiddenError = false
            return -1
        }
    }
    
    func forTrailingZero(toString value: Double) -> String {
        
        if outputUnit == "Fahrenheit" {
            let temp = String(format: "%g", value)
            return "\(temp) ºF"
        } else if outputUnit == "Celsius" {
            let temp = String(format: "%g", value)
            return "\(temp) ºC"
        } else {
            let temp = String(format: "%g", value)
            return "\(temp) K"
        }
    
    }
    
}

#Preview {
    ContentView()
}
