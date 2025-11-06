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
        }
    }
}

#Preview {
    SettingsView()
}
