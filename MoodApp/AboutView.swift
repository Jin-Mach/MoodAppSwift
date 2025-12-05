//
//  AboutView.swift
//  MoodApp
//
//  Created by Jindřich Machytka on 03.12.2025.
//

import SwiftUI

struct AboutView: View {
    
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack {
            
            Text("About")
                .font(.title)
                .padding()
            
            Form {
                HStack { Text("App Name:"); Spacer(); Text("Mood App") }
                HStack { Text("Version:"); Spacer(); Text("1.0") }
                HStack { Text("Author:"); Spacer(); Text("Jin-Mach") }
                HStack { Text("About me:"); Spacer(); Link("GitHub", destination: URL(string: "https://github.com/Jin-Mach")!)}
            }

            Text("""
                Mood App is a simple application that allows you to record your mood, energy level, and short notes every day.
                It helps you track how you feel and how your daily mood changes.
                """)
                .multilineTextAlignment(.leading)
                .padding()
            
            Button("Close") {
                isVisible.toggle()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.top)
        }
        .padding()
    }
}
