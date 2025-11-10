//
//  HomeView.swift
//  Plangrid
//
//  Created by Evan Plant on 04/11/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [
        SortDescriptor(\GridCell.column),
        SortDescriptor(\GridCell.row)
    ]) private var cells: [GridCell]
    
    @State private var randomCell: GridCell?
    
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
    
    let accentColours = [
        Color.red.gradient, Color.orange.gradient,
        Color.yellow.gradient, Color.green.gradient,
        Color.mint.gradient, Color.blue.gradient,
        Color.purple.gradient, Color.brown.gradient,
        Color.white.gradient, Color.black.gradient
    ]
    let baseAccentColours = [
        Color.red, Color.orange,
        Color.yellow, Color.green,
        Color.mint, Color.blue,
        Color.purple, Color.brown,
        Color.white, Color.black
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
                
                Section {
                    if let randomCell {
                        NavigationLink {
                            GridCellDetailView(cell: randomCell)
                        } label: {
                            HStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(accentColours[randomCell.colourIndex])
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 60)
                                    .overlay {
                                        Image(systemName: "\(cellIcons[randomCell.iconIndex])")
                                            .resizable()
                                            .foregroundStyle(baseAccentColours[randomCell.colourIndex].adaptedTextColor())
                                            .scaledToFit()
                                            .padding(15)
                                    }
                                
                                VStack(alignment: .leading) {
                                    Text(randomCell.name)
                                    Text(randomCell.notes)
                                        .foregroundStyle(.secondary)
                                    Text("Position (\(randomCell.row),\(randomCell.column))")
                                        .foregroundStyle(.secondary)
                                        .font(.footnote)
                                }
                            }
                        }
                    } else {
                        Text("No cells available.")
                    }
                    
                    Button {
                        randomCell = cells.randomElement()
                    } label: {
                        Label("Shuffle", systemImage: "shuffle")
                    }
                    .disabled(cells.isEmpty)
                } header: {
                    Text("Random cell")
                } footer: {
                    Text("This may show a cell outside of what is visible to you in the grid - you can show more cells by going into settings.")
                }
                .onAppear {
                    if randomCell == nil {
                        randomCell = cells.randomElement()
                    }
                }
                
                Section {
                    Button {
                        selectedTab = 2
                    } label: {
                        Label("Open settings", systemImage: "gear")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
