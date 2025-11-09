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
                Text(greeting)
                    .font(.title)
            } header: {
                Text("\(appDisplayName) - version \(appVersion) build \(buildNumber)")
            }
        }
    }
}

#Preview {
    HomeView()
}
