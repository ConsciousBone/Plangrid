//
//  GridCellDetailView.swift
//  Plangrid
//
//  Created by Evan Plant on 08/11/2025.
//

import SwiftUI

struct GridCellDetailView: View {
    var cellName: String
    var cellNotes: String
    var cellIconIndex: Int
    var cellColourIndex: Int
    
    var body: some View {
        Form {
            Section {
                Text(cellName)
            } header: {
                Text("Name")
            }
            
            Section {
                Text(cellNotes)
            } header: {
                Text("Notes")
            }
        }
        .navigationTitle(cellName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
