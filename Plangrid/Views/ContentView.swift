//
//  ContentView.swift
//  Plangrid
//
//  Created by Evan Plant on 04/11/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") private var selectedTab = 0
    
    @AppStorage("selectedAccentIndex") private var selectedAccentIndex = 5
    let accentColours = [
        Color.red.gradient, Color.orange.gradient,
        Color.yellow.gradient, Color.green.gradient,
        Color.mint.gradient, Color.blue.gradient,
        Color.purple.gradient, Color.brown.gradient,
        Color.white.gradient, Color.black.gradient
    ]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag(0)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ScheduleView()
                .tag(1)
                .tabItem {
                    Label("Schedule", systemImage: "square.grid.2x2")
                }
            
            SettingsView()
                .tag(2)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .tint(accentColours[selectedAccentIndex])
    }
}

#Preview {
    ContentView()
}
