//
//  AboutView.swift
//  Plangrid
//
//  Created by Evan Plant on 10/11/2025.
//

import SwiftUI

struct AboutView: View {
    let appDisplayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "Plangrid"
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown"
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        Form {
            Section {
                Text(appDisplayName)
                    .font(.largeTitle)
            }
            
            Section {
                Text("Version \(appVersion)")
                Text("Build \(buildNumber)")
            }
            
            Section {
                Text("""
                    This app was built for Hack Club's Siege Week 10, following the theme of "Grid".
                    """)
                
                Button {
                    if #available(iOS 26, *) {
                        openURL(URL(string: "https://hackclub.com/")!, prefersInApp: true)
                    } else {
                        openURL(URL(string: "https://hackclub.com/")!)
                    }
                } label: {
                    Label("Learn more about Hack Club", systemImage: "apple.terminal")
                }
                Button {
                    if #available(iOS 26, *) {
                        openURL(URL(string: "https://siege.hackclub.com/")!, prefersInApp: true)
                    } else {
                        openURL(URL(string: "https://siege.hackclub.com/")!)
                    }
                } label: {
                    Label("Learn more about Siege", systemImage: "crown")
                }
            }
        }
        .navigationTitle("About \(appDisplayName)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AboutView()
}
