//
//  HistoryView.swift
//  MoodApp
//
//  Created by Jindřich Machytka on 03.12.2025.
//

import SwiftUI

struct HistoryView: View {
    
    @Binding var isVisible: Bool
    
    @State private var history: [String: [String: Any]] = [:]
    @State private var showDelete: Bool = false
    
    private let emojiMap: [Int: String] = [-1: "😢", 0: "😐", 1: "😃"]
    private var availableRecords: Bool { history.isEmpty }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                
                if history.isEmpty {
                    Text("No records")
                        .font(.title)
                        .padding()
                } else {
                    List(history.keys.sorted(by: >), id: \.self) { key in
                        if let results = history[key] {
                            NavigationLink(destination: DetailsView(
                                isVisible: .constant(true),
                                record: results,
                                date: key,
                                emojiMap: emojiMap
                            )) {
                                HStack {
                                    Text(formattedDate(from: key))
                                    Spacer()
                                    if let moodNumber = results["mood"] as? Int,
                                       let emoji = emojiMap[moodNumber] {
                                        Text(emoji)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
                
                Spacer()
                
                Button("Delete History") {
                    showDelete = true
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.red)
                .disabled(availableRecords)
                .alert("Are you sure?", isPresented: $showDelete) {
                    Button("Yes", role: .destructive) {
                        MoodAppLogic.clearHistory()
                        history = [:]
                    }
                    Button("No", role: .cancel) { }
                }
                .padding(.bottom, 4)
                
                Button("Close") {
                    isVisible.toggle()
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("History")
                        .font(.headline.bold())
                }
            }
            .onAppear {
                history = MoodAppLogic.getMoodHistory()
            }
        }
    }
}
