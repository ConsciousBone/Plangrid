//
//  GridCellDetailView.swift
//  Plangrid
//
//  Created by Evan Plant on 08/11/2025.
//

import SwiftUI

struct GridCellDetailView: View {
    @State var cellName: String
    @State var cellNotes: String
    @State var cellIconIndex: Int
    @State var cellColourIndex: Int
    
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
                    RoundedRectangle(cornerRadius: 17)
                        .foregroundStyle(accentColours[cellColourIndex])
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 100)
                        .overlay {
                            Image(systemName: "\(cellIcons[cellIconIndex])")
                                .resizable()
                                .foregroundStyle(.blue.adaptedTextColor())
                                .scaledToFit()
                                .padding(32)
                        }
                    VStack {
                        Text(cellName)
                        Text(cellNotes)
                            .foregroundStyle(.secondary)
                    }
                    .padding(5)
                }
            }
        }
        .navigationTitle(cellName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
