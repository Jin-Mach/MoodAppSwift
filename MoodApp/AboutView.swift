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
            
            Text("O aplikaci")
                .font(.title)
                .padding()
            
            Form {
                HStack { Text("App Name:"); Spacer(); Text("Mood App") }
                HStack { Text("Version:"); Spacer(); Text("1.0") }
                HStack { Text("Author:"); Spacer(); Text("Jin-Mach") }
                HStack { Text("About me:"); Spacer(); Link("GitHub", destination: URL(string: "https://github.com/Jin-Mach")!)}
            }

            Text("""
                Mood App je jednoduchá aplikace, která ti umožňuje každý den zapisovat svoji náladu, úroveň energie a krátké poznámky.
                 Pomáhá ti sledovat, jak se cítíš a jak se mění tvoje denní rozpoložení.
                """)
                .multilineTextAlignment(.leading)
                .padding()
            
            Button("Zavřít") {
                isVisible.toggle()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.top)
        }
        .padding()
    }
}
