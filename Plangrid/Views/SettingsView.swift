//
//  SettingsView.swift
//  Plangrid
//
//  Created by Evan Plant on 04/11/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedAccentIndex") private var selectedAccentIndex = 5
    let accentColours = [
        Color.red.gradient, Color.orange.gradient,
        Color.yellow.gradient, Color.green.gradient,
        Color.mint.gradient, Color.blue.gradient,
        Color.purple.gradient, Color.brown.gradient,
        Color.white.gradient, Color.black.gradient
    ]
    let accentColourNames = [
        "Red", "Orange",
        "Yellow", "Green",
        "Mint", "Blue",
        "Purple", "Brown",
        "White", "Black"
    ]
    
    @AppStorage("gridColumns") private var gridColumns = 5
    
    // ew ew ew bad code ew
    // i know theres a better way somewhere somehow but i cant be
    // bothered finding it and learning it when i have like 3 days left
    @AppStorage("column1Label") private var column1Label = "Mon"
    @AppStorage("column2Label") private var column2Label = "Tue"
    @AppStorage("column3Label") private var column3Label = "Wed"
    @AppStorage("column4Label") private var column4Label = "Thu"
    @AppStorage("column5Label") private var column5Label = "Fri"
    @AppStorage("column6Label") private var column6Label = "Sat"
    @AppStorage("column7Label") private var column7Label = "Sun"
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $selectedAccentIndex) {
                    ForEach(accentColours.indices, id: \.self) { index in
                        Text(accentColourNames[index])
                    }
                } label: {
                    Label("Accent colour", systemImage: "paintpalette")
                }
            }
            
            Section {
                Stepper(value: $gridColumns, in: 1...7) {
                    Label("Days in grid: \(gridColumns)", systemImage: "calendar")
                }
            }
            
            Section {
                
            } header: {
                Text("Column titles")
            }
        }
    }
}

#Preview {
    SettingsView()
}
