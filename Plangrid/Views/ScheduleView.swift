//
//  ScheduleView.swift
//  Plangrid
//
//  Created by Evan Plant on 04/11/2025.
//

import SwiftUI
import SwiftData

struct ScheduleView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [
        SortDescriptor(\GridCell.column),
        SortDescriptor(\GridCell.row)
    ]) private var cells: [GridCell]
    
    @AppStorage("gridColumns") private var gridColumns = 5
    @AppStorage("eventsPerColumn") private var eventsPerColumn = 5
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: gridColumns)
    }
    
    @AppStorage("scheduleIconsPadding") private var scheduleIconsPadding: Double = 18 // min 10 max 25
    
    // ew bad code ew
    @AppStorage("column1Label") private var column1Label = "Mon"
    @AppStorage("column2Label") private var column2Label = "Tue"
    @AppStorage("column3Label") private var column3Label = "Wed"
    @AppStorage("column4Label") private var column4Label = "Thu"
    @AppStorage("column5Label") private var column5Label = "Fri"
    @AppStorage("column6Label") private var column6Label = "Sat"
    @AppStorage("column7Label") private var column7Label = "Sun"
    
    let accentColours = [
        Color.red.gradient, Color.orange.gradient,
        Color.yellow.gradient, Color.green.gradient,
        Color.mint.gradient, Color.blue.gradient,
        Color.purple.gradient, Color.brown.gradient,
        Color.white.gradient, Color.black.gradient,
        Color.gray.gradient
    ]
    let baseAccentColours = [ // used for the adaptive colour calc
        Color.red, Color.orange, Color.yellow,
        Color.green, Color.mint, Color.blue,
        Color.purple, Color.brown, Color.white,
        Color.black, Color.gray
    ]
    
    let cellIcons = [
        "doc", "clipboard", "book",
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
    
    // ios =>18 have some differences in grids to ios =<26 so
    // this bascially stops that from happening :)
    // idk why on =>18 it says the top left is pos (-1,0),
    // and i aint got time to fix it, so deal with it :p
    var fixedEventsPerColumn: Int {
        if #available(iOS 26, *) {
            return eventsPerColumn + 1
        } else {
            return eventsPerColumn
        }
    }
    
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: columns) {
                ForEach(0..<gridColumns, id: \.self) { index in
                    Text(colLabelText(for: index))
                }
                
                ForEach(0..<gridColumns * (fixedEventsPerColumn), id: \.self) { index in
                    let col = index % gridColumns
                    let row = index / gridColumns
                    let trueRow = row - 1
                    let cell = ensureCell(column: col, row: trueRow)
                    let background = accentColours[cell.colourIndex]
                    let bgBaseColour = baseAccentColours[cell.colourIndex]
                    
                    NavigationLink {
                        GridCellDetailView(cell: cell)
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(background)
                            .aspectRatio(1, contentMode: .fill)
                            .frame(maxWidth: 100)
                            .overlay {
                                Image(systemName: cellIcons[cell.iconIndex])
                                    .resizable()
                                    .scaledToFit()
                                    .padding(scheduleIconsPadding)
                                    .foregroundStyle(bgBaseColour.adaptedTextColor())
                            }
                    }
                }
            }
            .id(gridColumns) // ensures it updates when the var is changed
            .padding(25)
        }
    }
    
    private func cellAt(column: Int, row: Int) -> GridCell? {
        cells.first {
            $0.column == column && $0.row == row
        }
    }
    
    private func ensureCell(column: Int, row: Int) -> GridCell {
        if let existing = cellAt(column: column, row: row) {
            return existing
        } else {
            let new = GridCell(column: column, row: row)
            modelContext.insert(new)
            return new
        }
    }
    
    private func colLabelText(for index: Int) -> String {
        switch index {
        case 0: return column1Label
        case 1: return column2Label
        case 2: return column3Label
        case 3: return column4Label
        case 4: return column5Label
        case 5: return column6Label
        case 6: return column7Label
        default: return column1Label
        }
    }
}

#Preview {
    ScheduleView()
}
