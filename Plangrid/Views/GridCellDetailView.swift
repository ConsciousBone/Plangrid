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
    let accentColours = [
        Color.red.gradient, Color.orange.gradient,
        Color.yellow.gradient, Color.green.gradient,
        Color.mint.gradient, Color.blue.gradient,
        Color.purple.gradient, Color.brown.gradient,
        Color.white.gradient, Color.black.gradient
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
                                .foregroundStyle(.blue.adaptedTextColor())
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
        }
        .navigationTitle(cell.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
