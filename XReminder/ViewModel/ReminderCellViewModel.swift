//
//  ReminderCellViewModel.swift
//  XReminder
//
//  Created by Emile Wong on 8/5/2021.
//

import SwiftUI

class ReminderCellViewModel: ObservableObject {
    @Published var reminder: Reminder
    
    init(reminder: Reminder) {
        self.reminder = reminder
    }
    
    func setReminder() {
        ReminderManager.shared.set(reminder)
    }
    
    func deleteReminder() {
        ReminderManager.shared.delete(reminder)
    }
}
