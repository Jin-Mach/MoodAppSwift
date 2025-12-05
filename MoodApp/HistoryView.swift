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
    
    private let emojiMap: [Int: String] = [-1: "😢", 0: "😐", 1: "😃"]
    
    var body: some View {
        NavigationView {
            VStack {
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
                                    } else {
                                        Text("–")
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                
                Spacer()
                
                Button("Smazat historii") {
                    MoodAppLogic.clearHistory()
                    history = [:] // ihned aktualizujeme UI
                }
                .padding()
                
                Button("Zavřít") {
                    isVisible.toggle()
                }
                .padding()
            }
            .navigationTitle("Historie")
            .onAppear {
                history = MoodAppLogic.getMoodHistory()
            }
        }
    }
}
