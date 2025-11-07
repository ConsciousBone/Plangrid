//
//  GridCell.swift
//  Plangrid
//
//  Created by Evan Plant on 07/11/2025.
//

import Foundation
import SwiftData

@Model class GridCell {
    var column: Int
    var row: Int
    var iconIndex: Int // sf symbol, will pull from a list
    var colourIndex: Int // swiftui, again will pull from list
    var name: String
    var notes: String
    
    init(
        column: Int,
        row: Int,
        iconIndex: Int,
        colourIndex: Int,
        name: String,
        notes: String
    ){
        self.column = column
        self.row = row
        self.iconIndex = iconIndex
        self.colourIndex = colourIndex
        self.name = name
        self.notes = notes
    }
}
