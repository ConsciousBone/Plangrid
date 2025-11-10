//
//  GridCellDetailView.swift
//  Plangrid
//
//  Created by Evan Plant on 08/11/2025.
//

import SwiftUI

struct GridCellDetailView: View {
    @FocusState var isInputActive: Bool
    
    @Bindable var cell: GridCell
    
    let cellIcons = [
        "document", "clipboard", "book",
        "clock", "soccerball", "rugbyball",
        "tennisball", "flag", "bell",
        "exclamationmark", "car", "bus",
        "bicycle", "house", "building",
        "pencil", "calendar", "graduationcap",
        "music.note", "mic", "paintpalette",
        "gamecontroller", "laptopcomputer", "theatermasks",
        "camera", "film", "leaf",
        "heart", "stethoscope", "fork.knife",
        "bag", "cart", "gift",
        "airplane", "globe", "map"
    ]
    let cellIconNames = [
        "Document", "Clipboard", "Book",
        "Clock", "Football", "Rugby ball",
        "Tennis ball", "Flag", "Bell",
        "Exclamation mark", "Car", "Bus",
        "Bicycle", "House", "Building",
        "Pencil", "Calendar", "Graduation cap",
        "Music note", "Microphone", "Paint palette",
        "Game controller", "Laptop", "Theatre masks",
        "Camera", "Film", "Leaf",
        "Heart", "Stethoscope", "Cutlery",
        "Bag", "Shopping cart", "Gift",
        "Airplane", "Globe", "Map"
    ]
    
    let accentColours = [
        Color.red.gradient, Color.orange.gradient,
        Color.yellow.gradient, Color.green.gradient,
        Color.mint.gradient, Color.blue.gradient,
        Color.purple.gradient, Color.brown.gradient,
        Color.white.gradient, Color.black.gradient,
        Color.gray.gradient
    ]
    let baseAccentColours = [
        Color.red, Color.orange,
        Color.yellow, Color.green,
        Color.mint, Color.blue,
        Color.purple, Color.brown,
        Color.white, Color.black,
        Color.gray
    ]
    let accentColourNames = [
        "Red", "Orange",
        "Yellow", "Green",
        "Mint", "Blue",
        "Purple", "Brown",
        "White", "Black",
        "Grey"
    ]
    
    @State private var showingResetDialog = false
    
    var body: some View {
        Form {
            Section {
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(accentColours[cell.colourIndex])
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .overlay {
                            Image(systemName: "\(cellIcons[cell.iconIndex])")
                                .resizable()
                                .foregroundStyle(baseAccentColours[cell.colourIndex].adaptedTextColor())
                                .scaledToFit()
                                .padding(15)
                        }
                        .padding(5)
                    VStack(alignment: .leading) {
                        Text(cell.name)
                        Text(cell.notes)
                            .foregroundStyle(.secondary)
                        Text("Position (\(cell.row),\(cell.column))")
                            .foregroundStyle(.secondary)
                            .font(.footnote)
                    }
                }
            }
            
            Section {
                TextField("No name", text: $cell.name)
                    .focused($isInputActive)
            } header: {
                Text("Cell name")
            }
            
            Section {
                TextEditor(text: $cell.notes)
                    .focused($isInputActive)
                    .padding(3)
            } header: {
                Text("Cell notes")
            }
            
            Section {
                Picker(selection: $cell.colourIndex) {
                    ForEach(accentColours.indices, id: \.self) { index in
                        Text(accentColourNames[index])
                    }
                } label: {
                    Label("Cell colour", systemImage: "paintpalette")
                }
                
                Picker(selection: $cell.iconIndex) {
                    ForEach(cellIcons.indices, id: \.self) { index in
                        Text(cellIconNames[index])
                    }
                } label: {
                    Label("Cell icon", systemImage: "star")
                }
            }
            
            Section {
                Button {
                    showingResetDialog.toggle()
                } label: {
                    Label("Reset all", systemImage: "arrow.trianglehead.counterclockwise")
                }
                .confirmationDialog(
                    "Reset all cell settings?",
                    isPresented: $showingResetDialog
                ){
                    Button("Reset", role: .destructive) {
                        cell.name = "No name"
                        cell.notes = "No notes"
                        cell.colourIndex = 5
                        cell.iconIndex = 0
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("This will reset this cell to its default settings.")
                }
            }
        }
        .navigationTitle(cell.name)
        .navigationBarTitleDisplayMode(.inline)
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
