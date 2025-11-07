//
//  PlangridApp.swift
//  Plangrid
//
//  Created by Evan Plant on 04/11/2025.
//

import SwiftUI
import SwiftData

@main
struct PlangridApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [GridCell.self])
    }
}
