//
//  ContentView.swift
//  Plangrid
//
//  Created by Evan Plant on 04/11/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedAccentIndex") private var selectedAccentIndex = 5
    let accentColours = [
        Color.red.gradient, Color.orange.gradient,
        Color.yellow.gradient, Color.green.gradient,
        Color.mint.gradient, Color.blue.gradient,
        Color.purple.gradient, Color.brown.gradient,
        Color.white.gradient, Color.black.gradient
    ]
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Schedule", systemImage: "square.grid.2x2") {
                ScheduleView()
            }
            Tab("Events", systemImage: "list.bullet") {
                EventsView()
            }
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
        .tint(accentColours[selectedAccentIndex])
    }
}

#Preview {
    ContentView()
}
