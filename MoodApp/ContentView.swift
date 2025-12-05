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
            
            HStack {
                Image(systemName: "face.smiling")
                    .font(Font.largeTitle)
                
                Text("Mood App")
                    .font(.largeTitle.bold())
            }
            .padding(.top, 20)
            
            Spacer()
                .frame(height: 60)
            
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
            .padding(.horizontal)
            
            VStack {
                HStack {
                    Image(systemName: "bolt.fill")
                        .font(Font.title)
                    
                    Text("Energy: \(Int(energy)) %")
                }
                .padding()
                
                Slider(value: $energy, in: 0...100, step: 1)
                    .padding()
            }
            .padding()
            
            VStack(alignment: .leading) {
                
                Text("Notes: (optional)")
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
                
                Text("length: \(noteCount)/100")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
            }
            .padding(.horizontal)
            
            Button("Submit") {
                MoodAppLogic.setMoodHistory(mood: moodValue!, energy: Int(energy), note: note)
                resetVariables()
            }
            .disabled(moodValue == nil)
            .controlSize(.large)
            .font(.title2.bold())
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(Color.blue.opacity(moodValue == nil ? 0.3 : 1))
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.top, 10)
            
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
