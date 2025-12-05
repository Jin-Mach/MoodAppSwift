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
            Form {
                HStack { Text("App Name:"); Spacer(); Text("Internet Speed Test") }
                HStack { Text("Version:"); Spacer(); Text("1.0") }
                HStack { Text("Author:"); Spacer(); Text("Jin-Mach") }
                HStack { Text("About me:"); Spacer(); Link("GitHub", destination: URL(string: "https://github.com/Jin-Mach")!)}
            }
            .padding()

            Text("""
                Mood App je jednoduchá aplikace, která ti umožňuje každý den zapisovat svoji náladu, úroveň energie a krátké poznámky.
                 Pomáhá ti sledovat, jak se cítíš a jak se mění tvoje denní rozpoložení.
                """)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Zavřít") {
                isVisible.toggle()
            }
            .padding()
        }
        .padding()
    }
}
