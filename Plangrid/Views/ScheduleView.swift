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
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(0...gridColumns * eventsPerColumn - 1, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.blue)
                        .aspectRatio(1, contentMode: .fill)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ScheduleView()
}
