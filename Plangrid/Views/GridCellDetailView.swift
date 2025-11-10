//
//  GridCellDetailView.swift
//  Plangrid
//
//  Created by Evan Plant on 08/11/2025.
//

import SwiftUI

struct GridCellDetailView: View {
    @Bindable var cell: GridCell
    
    let cellIcons = [
        "document", "clipboard", "book",
        "clock", "soccerball", "rugbyball",
        "tennisball", "flag", "bell",
        "exclamationmark", "car", "bus",
        "bicycle", "house", "building"
    ]
    let cellIconNames = [
        "Document", "Clipboard", "Book",
        "Clock", "Football", "Rugby ball",
        "Tennis ball", "Flag", "Bell",
        "Exclamation mark", "Car", "Bus",
        "Bicycle", "House", "Building"
    ]
    
    let accentColours = [
        Color.red.gradient, Color.orange.gradient,
        Color.yellow.gradient, Color.green.gradient,
        Color.mint.gradient, Color.blue.gradient,
        Color.purple.gradient, Color.brown.gradient,
        Color.white.gradient, Color.black.gradient
    ]
    let baseAccentColours = [
        Color.red, Color.orange,
        Color.yellow, Color.green,
        Color.mint, Color.blue,
        Color.purple, Color.brown,
        Color.white, Color.black
    ]
    let accentColourNames = [
        "Red", "Orange",
        "Yellow", "Green",
        "Mint", "Blue",
        "Purple", "Brown",
        "White", "Black"
    ]
    
    var body: some View {
        Form {
            Section {
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(accentColours[cell.colourIndex])
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 60)
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
            } header: {
                Text("Cell name")
            }
            
            Section {
                TextField("No notes", text: $cell.notes)
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
                    cell.name = "No name"
                    cell.notes = "No notes"
                    cell.colourIndex = 5
                    cell.iconIndex = 0
                } label: {
                    Label("Reset all", systemImage: "arrow.trianglehead.counterclockwise")
                }
            }
        }
        .navigationTitle(cell.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
