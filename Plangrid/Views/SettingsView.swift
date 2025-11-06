//
//  SettingsView.swift
//  Plangrid
//
//  Created by Evan Plant on 04/11/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedAccentIndex") private var selectedAccentIndex = 5 // blue
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
    @AppStorage("eventsPerColumn") private var eventsPerColumn = 5
    
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
                
                Stepper(value: $eventsPerColumn, in: 1...15) {
                    Label("Events per column: \(eventsPerColumn)", systemImage: "ellipsis.calendar")
                }
            }
            
            Section {
                ForEach(1...gridColumns, id: \.self) { i in
                    ColumnTitleRowView(
                        num: "\(i)",
                        placeholder: colLabelPlaceholder(for: i),
                        variable: colLabelVar(for: i)
                    )
                }
            } header: {
                Text("Column titles")
            }
        }
    }
    
    // ew ew even more bad code
    private func colLabelVar(for index: Int) -> Binding<String> {
        switch index {
        case 1: return $column1Label
        case 2: return $column2Label
        case 3: return $column3Label
        case 4: return $column4Label
        case 5: return $column5Label
        case 6: return $column6Label
        case 7: return $column7Label
        default: return $column1Label
        }
    }
    private func colLabelPlaceholder(for index: Int) -> String {
        switch index {
        case 1: return "Mon"
        case 2: return "Tue"
        case 3: return "Wed"
        case 4: return "Thu"
        case 5: return "Fri"
        case 6: return "Sat"
        case 7: return "Sun"
        default: return ""
        }
    }
}

#Preview {
    SettingsView()
}
