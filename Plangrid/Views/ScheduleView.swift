//
//  ScheduleView.swift
//  Plangrid
//
//  Created by Evan Plant on 04/11/2025.
//

import SwiftUI

struct ScheduleView: View {
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
    
    var body: some View {
        //ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(0..<gridColumns, id: \.self) { index in
                    Text(colLabelText(for: index))
                }
                ForEach(0..<gridColumns * eventsPerColumn, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.blue)
                        .aspectRatio(1, contentMode: .fill)
                        .frame(maxWidth: 100)
                }
            }
            .padding(25)
        //}
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
