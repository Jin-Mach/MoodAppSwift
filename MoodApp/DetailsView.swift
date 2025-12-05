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
        VStack {
            Form {
                HStack {
                    Text("Datum:")
                    Spacer()
                    Text(formattedDate(from: date))
                }
                HStack {
                    Text("Nálada:")
                    Spacer()
                    Text(emojiMap[record?["mood"] as? Int ?? 0] ?? "–")
                }
                HStack {
                    Text("Energie:")
                    Spacer()
                    Text("\(record?["energy"] as? Int ?? 0)%")
                }
                VStack(alignment: .leading) {
                    Text("Poznámka:")
                        .font(.headline)
                    TextEditor(text: $noteText)
                        .frame(height: 100)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.5))
                        )
                }
            }
            
            Button("Zavřít") {
                isVisible.toggle()
            }
            .padding()
        }
        .onAppear {
            noteText = record?["note"] as? String ?? "Není zadána"
        }
    }
}
