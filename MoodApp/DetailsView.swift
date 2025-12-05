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
    
    @State private var noteText: String = "Not provided"
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form {
                    Section {
                        HStack {
                            Text("Date")
                            Spacer()
                            Text(formattedDate(from: date))
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Mood")
                            Spacer()
                            Text(emojiMap[record?["mood"] as? Int ?? 0] ?? "–")
                                .font(.title3)
                        }
                        
                        HStack {
                            Text("Energy")
                            Spacer()
                            Text("\(record?["energy"] as? Int ?? 0)%")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Section(header: Text("Note")) {
                        if noteText == "Not provided" {
                            Text("Not provided")
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
                
                Button("Close") {
                    isVisible.toggle()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.bottom)
            }
            .navigationTitle("Record Details")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                noteText = record?["note"] as? String ?? "Not provided"
            }
        }
    }
}
