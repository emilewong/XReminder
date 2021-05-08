//
//  ReminderModel.swift
//  XReminder
//
//  Created by Emile Wong on 8/5/2021.
//

import Foundation

struct Reminder: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var completed: Bool
    
    static func new() -> Reminder {
        return Reminder(name: "", completed: false)
    }
}



#if DEBUG
let mockReminder = [
    Reminder(name: "Set appointment with Tim", completed: false),
    Reminder(name: "Pick up groceries", completed: false),
    Reminder(name: "Dinner with Bob", completed: false),
    Reminder(name: "Search holiday gift", completed: false),
    Reminder(name: "Buy a new apple watch", completed: false),
    Reminder(name: "Go to gym", completed: false)
]#endif
