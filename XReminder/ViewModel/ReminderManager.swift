//
//  ReminderManager.swift
//  XReminder
//
//  Created by Emile Wong on 8/5/2021.
//

import Foundation

class ReminderManager: ObservableObject {
    static let shared = ReminderManager()
    
    @Published var reminders = [Reminder]()
    
    // INITIALIZATION
    private init() {
        loadReminders()
    }
    
    // LOAD DATA
    private func loadReminders() {
        if let data = UserDefaults.standard.data(forKey: "reminders"),
           let reminders = try? JSONDecoder().decode([Reminder].self, from: data) {
            self.reminders = self.sort(reminders)
        }
        
    }
    
    
    // ADD REMINDER TO DATA
    func set(_ reminder: Reminder) {
        var reminders = self.reminders
        
        if !reminders.filter({ $0.id == reminder.id }).isEmpty {
            update(reminder)
        } else {
            reminders.append(reminder)
            save(reminders)
        }
    }
    
    // UPDATE THE REMINDER
    func update(_ reminder: Reminder) {
        var reminders = self.reminders
        
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index] = reminder
        }
        
        save(reminders)
    }
    
    // DELETE REMINDER
    func delete(_ reminder: Reminder) {
        let reminders = self.reminders.filter({$0.id != reminder.id})
        save(reminders)
    }
    
    // MOVE REMINDER
    func move(from source: IndexSet, to destination: Int) {
        var reminders = self.reminders
        reminders.move(fromOffsets: source, toOffset: destination)
        save(reminders)
    }
    
    // SAVE DATA FUNCTION
    func save(_ reminders: [Reminder]) {
        let encodedData = try? JSONEncoder().encode(reminders)
        UserDefaults.standard.set(encodedData, forKey: "reminders")
        
        self.reminders = self.sort(reminders)
    }
    
    
    // SORT REMINDER FUNCTION
    func sort(_ reminders: [Reminder]) -> [Reminder] {
        return reminders.sorted(by: { !$0.completed && $1.completed})
    }
    
    
}
