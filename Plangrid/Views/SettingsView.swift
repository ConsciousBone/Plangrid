//
//  SettingsView.swift
//  Plangrid
//
//  Created by Evan Plant on 04/11/2025.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    // swiftdatas
    @Environment(\.modelContext) private var modelContext
    @Query private var cells: [GridCell]
    
    // keyboard dismissal
    @FocusState var isInputActive: Bool
    
    // accent colour stuff
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
    
    // grid layout
    @AppStorage("gridColumns") private var gridColumns = 5
    @AppStorage("eventsPerColumn") private var eventsPerColumn = 5
    
    @AppStorage("scheduleIconsPadding") private var scheduleIconsPadding: Double = 18 // min 10 max 25
    
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
    
    // reset confirmationdialog ispresented's
    @State private var showingLayoutResetDialog = false
    @State private var showingColumnTitlesResetDialog = false
    @State private var showingPaddingResetDialog = false
    @State private var showingClearAllCellsDialog = false
    
    var body: some View {
        NavigationStack {
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
                    
                    Stepper(value: $eventsPerColumn, in: 1...10) {
                        Label("Events per column: \(eventsPerColumn)", systemImage: "ellipsis.calendar")
                    }
                    
                    Button {
                        gridColumns = 7
                        eventsPerColumn = 5
                        scheduleIconsPadding = 12
                    } label: {
                        Label("Full week", systemImage: "7.calendar")
                    }
                    
                    Button {
                        gridColumns = 5
                        eventsPerColumn = 5
                        scheduleIconsPadding = 18
                    } label: {
                        Label("Work week", systemImage: "building")
                    }
                    
                    Button {
                        gridColumns = 3
                        eventsPerColumn = 4
                        scheduleIconsPadding = 22
                    } label: {
                        Label("Compact", systemImage: "arrow.down.right.and.arrow.up.left")
                    }
                    
                    Button {
                        showingLayoutResetDialog.toggle()
                    } label: {
                        Label("Reset", systemImage: "arrow.trianglehead.counterclockwise")
                    }
                    .tint(.red)
                    .confirmationDialog(
                        "Reset layout",
                        isPresented: $showingLayoutResetDialog
                    ) {
                        Button("Reset", role: .destructive) {
                            gridColumns = 5
                            eventsPerColumn = 5
                        }
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("This will reset the schedule layout to its default settings. This cannot be undone.")
                    }
                }
                
                Section {
                    ForEach(1...gridColumns, id: \.self) { i in
                        ColumnTitleRowView(
                            num: "\(i)",
                            placeholder: colLabelPlaceholder(for: i),
                            variable: colLabelVar(for: i)
                        )
                        .focused($isInputActive)
                    }
                    
                    Button {
                        showingColumnTitlesResetDialog.toggle()
                    } label: {
                        Label("Reset all", systemImage: "arrow.trianglehead.counterclockwise")
                    }
                    .tint(.red)
                    .confirmationDialog(
                        "Reset column titles",
                        isPresented: $showingColumnTitlesResetDialog
                    ) {
                        Button("Reset", role: .destructive) {
                            column1Label = "Mon"
                            column2Label = "Tue"
                            column3Label = "Wed"
                            column4Label = "Thu"
                            column5Label = "Fri"
                            column6Label = "Sat"
                            column7Label = "Sun"
                        }
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("This will reset the column titles to their default settings. This cannot be undone.")
                    }
                } header: {
                    Text("Column titles")
                }
                
                Section {
                    Slider(
                        value: $scheduleIconsPadding,
                        in: 10...25,
                        step: 1.0,
                        label: {
                            Text("a")
                        }
                    )
                    
                    Button {
                        showingPaddingResetDialog.toggle()
                    } label: {
                        Label("Reset", systemImage: "arrow.trianglehead.counterclockwise")
                    }
                    .tint(.red)
                    .confirmationDialog(
                        "Reset padding",
                        isPresented: $showingPaddingResetDialog
                    ) {
                        Button("Reset", role: .destructive) {
                            scheduleIconsPadding = 18
                        }
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("This will reset the cell icon padding to its default value. This cannot be undone.")
                    }
                } header: {
                    Text("Cell icon padding (\(scheduleIconsPadding.formatted(.number.precision(.fractionLength(0)))))")
                }
                
                Section {
                    Button {
                        showingClearAllCellsDialog.toggle()
                    } label: {
                        Label("Reset all cells", systemImage: "arrow.trianglehead.counterclockwise")
                    }
                    .tint(.red)
                    .confirmationDialog(
                        "Reset all cells",
                        isPresented: $showingClearAllCellsDialog
                    ) {
                        Button("Reset", role: .destructive) { clearAllCells() }
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("This will reset all cells to their default settings. This cannot be undone.")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button {
                        print("dismissing keyboard")
                        isInputActive = false
                    } label: {
                        Label("Dismiss", systemImage: "xmark")
                    }
                }
            }
        }
    }
    
    private func clearAllCells() {
        for cell in cells {
            modelContext.delete(cell)
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
