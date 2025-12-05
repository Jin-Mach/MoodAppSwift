//
//  MoodAppHlepers.swift
//  MoodApp
//
//  Created by Jindřich Machytka on 05.12.2025.
//

import Foundation

func formattedDate(from key: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy - HH:mm"
    if let timeInterval = TimeInterval(key) {
        return formatter.string(from: Date(timeIntervalSince1970: timeInterval))
    }
    return key
}
