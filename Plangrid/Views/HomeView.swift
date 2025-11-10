//
//  HomeView.swift
//  Plangrid
//
//  Created by Evan Plant on 04/11/2025.
//

import SwiftUI

struct HomeView: View {
    // app version stuff, tyvm searchino!
    let appDisplayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "Plangrid"
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown"
    
    @AppStorage("selectedTab") private var selectedTab = 0
    
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12:
            return "Good morning!"
        case 12..<17:
            return "Good afternoon!"
        default:
            return "Good evening!"
        }
    }
    
    
    var body: some View {
        Form {
            Section {
                let date = Date()
                let formattedDate = date.formatted(date: .complete, time: .omitted)
                let day = date.formatted(.dateTime.weekday(.wide))
                VStack(alignment: .leading) {
                    Text(greeting)
                        .font(.title)
                        .padding(.bottom, 2)
                    Text("Today's date is \(formattedDate).")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Text("Happy \(day)!")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("\(appDisplayName) - version \(appVersion) build \(buildNumber)")
            }
            .listRowSeparator(.hidden)
            
            Section {
                Button {
                    selectedTab = 1
                } label: {
                    Label("Open schedule", systemImage: "square.grid.2x2")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
