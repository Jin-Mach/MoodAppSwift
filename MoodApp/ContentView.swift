//
//  ContentView.swift
//  MoodApp
//
//  Created by Jindřich Machytka on 03.12.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showHistory: Bool = false
    @State private var showAbout: Bool = false
    
    @State private var energy: Double = 0.0
    @State private var note: String = ""
    @State private var noteCount: Int = 0
    
    var body: some View {
        NavigationStack {
            
            HStack {
                Image(systemName: "clock")
                    .font(Font.largeTitle)
                
                Text("Mood App")
                    .font(.largeTitle.bold())
            }
            .padding()
            
            HStack {
            
                Button {
                    print("sad")
                } label: {
                    Text("😢")
                        .font(.largeTitle)
                }
                .padding()
                
                Button {
                    print("neutral")
                } label: {
                    Text("😐")
                        .font(Font.largeTitle)
                }
                .padding()
                
                Button{
                    print("happy")
                } label: {
                    Text("😃")
                        .font(Font.largeTitle)
                        
                }
                .padding()
                
            }
            .padding()
            
            VStack {
                HStack {
                    Image(systemName: "bolt.fill")
                        .font(Font.title)
                    
                    Text("Energie: \(Int(energy)) %")
                }
                .padding()
                
                Slider(value: $energy, in: 0...100, step: 1)
                    .padding()
            }
            .padding()
            
            VStack(alignment: .leading) {
                
                Text("Poznámky: (nepovinné)")
                    .font(.headline)
                
                TextEditor(text: $note)
                    .frame(minHeight: 200)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5))
                    )
                    .onChange(of: note) {
                        noteCount = note.count
                        if note.count > 100 {
                            note = String(note.prefix(100))
                        }
                    }
                
                Text("délka: \(noteCount)/100")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
            }
            .padding()
            
            Button("Zapsat") {
                print("zapsat")
            }
            .font(Font.title)
            .padding()
            
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showHistory.toggle()
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAbout.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $showHistory) {
            HistoryView()
        }
        .sheet(isPresented: $showAbout) {
            AboutView(isVisible: $showAbout)
        }
    }
}

#Preview {
    ContentView()
}
