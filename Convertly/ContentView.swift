//
//  ContentView.swift
//  Convertly
//
//  Created by Jack Cotton-Brown on 23/11/21.
/* This app has a few functions:
 1. User can input a value (double)
 2. User can select a measurement unit to represent the inputed value.
 3. User can select a unit they want to convert to.
 4. Displays the converted output.

 
 */
import SwiftUI

struct ContentView: View {
    @State private var valueToConvert: Double = 0.0
    @State private var firstUnitSelection: Units = Units.seconds
    @State private var secondUnitSelection: Units = Units.seconds
    @State private var enterUnitsIsFocused: Bool = false

    
    private var calculatedOutput: Double {
        let input = valueToConvert
        var inputInSeconds: Double {
            switch firstUnitSelection {
            case .seconds:
                return input * 1
            case .minutes:
                return input * 60
            case .hours:
                return input * 3600
            case .days:
                return input * 86400
            case .weeks:
                return input * 86400 * 7
            }
        }
        var finalOutput: Double {
            switch secondUnitSelection {
            case .seconds:
                return inputInSeconds / 1
            case .minutes:
                return inputInSeconds / 60
            case .hours:
                return inputInSeconds / 3600
            case .days:
                return inputInSeconds / 86400
            case .weeks:
                return inputInSeconds / 86400 / 7
            }
        }
        return finalOutput
    }
    
    enum Units: String, CaseIterable, Identifiable{
        case seconds
        case minutes
        case hours
        case days
        case weeks
        
        var id: String { self.rawValue }
    }


    var body: some View {
        NavigationView{
            Form{
                //Section to enter a value
                Section{
                    TextField("Enter unit value to convert", value: $valueToConvert, format: .number)
                        
                        .keyboardType(.numberPad)

                } header: {
                    Text("Enter the value to convert")
                }
                
                //Section to select the units that represent the entered value
                Section{
                    Picker("Select your units", selection: $firstUnitSelection){
                        ForEach(Units.allCases, id: \.self){ units in
                            Text(units.rawValue.capitalized)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Select Unit:")
                }
                
                //Section for picking the units to convert into
                Section{
                    Picker("Convert to Unit:", selection: $secondUnitSelection){
                        ForEach(Units.allCases, id: \.self){ units in
                            Text(units.rawValue.capitalized)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Convert to Unit:")
                }
                
                //Display the calculated output
                Section{
                    Text(calculatedOutput.formatted())
                } header: {
                    Text("Converted Value:")
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
