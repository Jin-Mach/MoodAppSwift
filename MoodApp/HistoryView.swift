//
//  HistoryView.swift
//  MoodApp
//
//  Created by Jindřich Machytka on 03.12.2025.
//

import SwiftUI

struct HistoryView: View {
    
    @Binding var isVisible: Bool
    
    @State private var history: [String: Any] = [:]
    @State private var showDelete: Bool = false
    
    private let emojiMap: [Int: String] = [-1: "😢", 0: "😐", 1: "😃"]
    private var availableRecords: Bool { history.isEmpty }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                
                if history.isEmpty {
                    Text("Žádné záznamy")
                        .font(.title)
                        .padding()
                } else {
                    List(history.keys.sorted(), id: \.self) { key in
                        if let results = history[key] as? [String: Any] {
                            NavigationLink(destination: DetailsView(
                                isVisible: .constant(true),
                                record: results,
                                date: key,
                                emojiMap: emojiMap
                            )) {
                                HStack {
                                    Text(formattedDate(from: key))
                                    Spacer()
                                    if let moodNumber = results["mood"] as? NSNumber,
                                       let emoji = emojiMap[moodNumber.intValue] {
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
                
                Button("Smazat historii") {
                    showDelete = true
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(.red)
                .disabled(availableRecords)
                .alert("Opravdu smazat?", isPresented: $showDelete) {
                    Button("Ano", role: .destructive) {
                        MoodAppLogic.clearHistory()
                        history = [:]
                    }
                    Button("Ne", role: .cancel) { }
                }
                .padding(.bottom, 4)
                
                Button("Zavřít") {
                    isVisible.toggle()
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Historie")
                        .font(.headline.bold())
                }
            }
            .onAppear {
                history = MoodAppLogic.getMoodHistory()
            }
        }
    }
}
