//
//  MoodAppLogic.swift
//  MoodApp
//
//  Created by Jindřich Machytka on 05.12.2025.
//

import Foundation

struct MoodAppLogic {
    
    static func setMoodHistory(mood: Int, energy: Int, note: String) -> Void {
        
        let structure: [String: Any] = [
            "mood": mood,
            "energy": energy,
            "note": note
        ]
        
        var history = UserDefaults.standard.dictionary(forKey: "moodHistory") ?? [:]
        history["\(Date().timeIntervalSince1970)"] = structure
        UserDefaults.standard.set(history, forKey: "moodHistory")
        
    }
    
    static func getMoodHistory() {
        let history = UserDefaults.standard.dictionary(forKey: "moodHistory") ?? [:]
        print(history)
        
    }
    
    static func clearHistory() {
        UserDefaults.standard.removeObject(forKey: "moodHistory")
    }
    
}
