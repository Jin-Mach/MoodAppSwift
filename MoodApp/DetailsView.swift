//
//  DetailsView.swift
//  MoodApp
//
//  Created by Jindřich Machytka on 05.12.2025.
//

import SwiftUI

struct DetailsView: View {
    @Binding var isVisible: Bool
    
    let record: [String: Any]?
    let date: String
    let emojiMap: [Int: String]
    
    @State private var noteText: String = "Není zadána"
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form {
                    Section {
                        HStack {
                            Text("Datum")
                            Spacer()
                            Text(formattedDate(from: date))
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Nálada")
                            Spacer()
                            Text(emojiMap[record?["mood"] as? Int ?? 0] ?? "–")
                                .font(.title3)
                        }
                        
                        HStack {
                            Text("Energie")
                            Spacer()
                            Text("\(record?["energy"] as? Int ?? 0)%")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Section(header: Text("Poznámka")) {
                        if noteText == "Není zadána" {
                            Text("Není zadána")
                                .foregroundColor(.secondary)
                        } else {
                            ScrollView {
                                Text(noteText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 6)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                
                Button("Zavřít") {
                    isVisible.toggle()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.bottom)
            }
            .navigationTitle("Detail záznamu")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                noteText = record?["note"] as? String ?? "Není zadána"
            }
        }
    }
}
