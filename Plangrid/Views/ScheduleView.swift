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
        Color.white.gradient, Color.black.gradient
    ]
    let baseAccentColours = [ // used for the adaptive colour calc
        Color.red, Color.orange, Color.yellow,
        Color.green, Color.mint, Color.blue,
        Color.purple, Color.brown, Color.white,
        Color.black
    ]
    
    let cellIcons = [
        "document", "clipboard", "book",
        "clock", "soccerball", "rugbyball",
        "tennisball", "flag", "bell",
        "exclamationmark", "car", "bus",
        "bicycle", "house", "building"
    ]
    
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: columns) {
                ForEach(0..<gridColumns, id: \.self) { index in
                    Text(colLabelText(for: index))
                }
                
                ForEach(0..<gridColumns * (eventsPerColumn + 1), id: \.self) { index in
                    let col = index % gridColumns
                    let row = index / gridColumns
                    let trueRow = row - 1
                    let cell = cellAt(column: col, row: trueRow)
                    let background = accentColours[cell?.colourIndex ?? 5]
                    let bgBaseColour = baseAccentColours[cell?.colourIndex ?? 5]
                    
                    NavigationLink {
                        GridCellDetailView(
                            cellName: cell?.name ?? "No name",
                            cellNotes: cell?.notes ?? "No notes"
                        )
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(background)
                            .aspectRatio(1, contentMode: .fill)
                            .frame(maxWidth: 100)
                            .overlay {
                                Image(systemName: cellIcons[cell?.iconIndex ?? 0])
                                    .foregroundStyle(bgBaseColour.adaptedTextColor())
                            }
                    }
                    .onAppear {
                        checkCellExists(column: col, row: trueRow)
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
    
    private func checkCellExists(column: Int, row: Int) {
        if cellAt(column: column, row: row) == nil {
            let new = GridCell(column: column, row: row)
            modelContext.insert(new)
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

// thank you YT tutorial!
// https://www.youtube.com/shorts/nlJpnLkLymw
// https://gist.github.com/pitt500/1958982f02641de84024d6a321a95f68
extension Color {
    func luminance() -> Double {
        // Convert SwiftUI Color to UIColor
        let uiColor = UIColor(self)
        
        // Extract RGB values
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Compute luminance.
        return 0.2126 * Double(red) + 0.7152 * Double(green) + 0.0722 * Double(blue)
    }
    
    func isLight() -> Bool {
        return luminance() > 0.5
    }
    
    func adaptedTextColor() -> Color {
        return isLight() ? Color.black : Color.white
    }
}

#Preview {
    ScheduleView()
}
