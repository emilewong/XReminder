//
//  ReminderCell.swift
//  XReminder
//
//  Created by Emile Wong on 8/5/2021.
//

import SwiftUI

struct ReminderCell: View {
    // MARK: - PREVIEW
    
    @ObservedObject private var _reminderVM: ReminderCellViewModel
    
    // MARK: - INTIALIZE REMINDER
    init(vm: ReminderCellViewModel) {
        self._reminderVM = vm
    }
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Image(systemName: _reminderVM.reminder.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(_reminderVM.reminder.completed
                                    ? .red
                                    :Color(UIColor.lightGray))
                .onTapGesture {
                    _reminderVM.reminder.completed.toggle()
                    _reminderVM.setReminder()
                }
            
            TextField("Enter new reminder",
                      text: $_reminderVM.reminder.name,
                      onEditingChanged: {_ in},
                      onCommit: {
                        let reminder  = _reminderVM.reminder
                        
                        if reminder.name.isEmpty {
                            _reminderVM.deleteReminder()
                        } else {
                            _reminderVM.setReminder()
                        }
                      })
        } //: HSTACK
    }
}

// MARK: - PREVIEW
struct ReminderCell_Previews: PreviewProvider {
    static var previews: some View {
        let reminder = mockReminder[0]
        ReminderCell(vm: ReminderCellViewModel(reminder: reminder))
    }
}
