//
//  ScheduleView.swift
//  Plangrid
//
//  Created by Evan Plant on 04/11/2025.
//

import SwiftUI

struct ScheduleView: View {
    @AppStorage("gridColumns") private var gridColumns = 5
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: gridColumns)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                Text("placeholder")
            }
            .padding()
        }
    }
}

#Preview {
    ScheduleView()
}
