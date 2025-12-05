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
    
    @State private var moodValue: Int? = nil
    @State private var energy: Double = 0.0
    @State private var note: String = ""
    @State private var noteCount: Int = 0
    
    var body: some View {
        NavigationStack {
            
            Spacer()
            
            HStack {
                Image(systemName: "clock")
                    .font(Font.largeTitle)
                
                Text("Mood App")
                    .font(.largeTitle.bold())
            }
            .padding()
            
            HStack {
            
                Button {
                    moodValue = -1
                } label: {
                    Text("😢")
                        .font(.system(size: 60))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                }
                .background(moodValue == -1 ? Color.red : Color.clear)
                .foregroundColor(moodValue == -1 ? Color.white: Color.primary)
                .cornerRadius(10)
                
                Button {
                    moodValue = 0
                } label: {
                    Text("😐")
                        .font(.system(size: 60))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                }
                .background(moodValue == 0 ? Color.red : Color.clear)
                .foregroundColor(moodValue == 0 ? Color.white: Color.primary)
                .cornerRadius(10)
                
                Button{
                    moodValue = 1
                } label: {
                    Text("😃")
                        .font(.system(size: 60))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        
                }
                .background(moodValue == 1 ? Color.red : Color.clear)
                .foregroundColor(moodValue == 1 ? Color.white: Color.primary)
                .cornerRadius(10)
                
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
                    .frame(height: 100)
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
                MoodAppLogic.setMoodHistory(mood: moodValue!, energy: Int(energy), note: note)
                resetVariables()
            }
            .disabled(moodValue == nil)
            .font(Font.title)
            .padding()
            
            Spacer()
            
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
            HistoryView(isVisible: $showHistory)
        }
        .sheet(isPresented: $showAbout) {
            AboutView(isVisible: $showAbout)
        }
        .padding()
    }
    
    func resetVariables() -> Void {
            moodValue = nil
            energy = 0.0
            note = ""
        }
}

#Preview {
    ContentView()
}
