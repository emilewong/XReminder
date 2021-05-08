//
//  ReminderList.swift
//  XReminder
//
//  Created by Emile Wong on 8/5/2021.
//

import SwiftUI

struct ReminderList: View {
    // MARK: - PROPERTIES
    @ObservedObject var reminderManager = ReminderManager.shared
    @State private var hideCompleted = false
    @State private var addReminder = false

    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10){
                List {
                    Toggle("Hide completed", isOn: $hideCompleted)
                    ForEach(reminderManager.reminders, id: \.id) { reminder in
                        if !hideCompleted || !reminder.completed {
                            ReminderCell(vm: ReminderCellViewModel(reminder: reminder))
                        }
                    } //: LOOP
                    .onDelete(perform: self.removeRow)
                    .onMove(perform: self.move)
                    
                    if addReminder {
                        ReminderCell(vm: ReminderCellViewModel(reminder: Reminder.new()))
                    }
                } //: LIST
                .padding(.horizontal, (-20))
                
                HStack{
                    if addReminder{
                        Button(action: {self.toggleAddForm()}, label: {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Text("Done")
                            } //: HSSTACK
                            .padding()
                        }) //: Button

                    } else {
                        Button(action: { toggleAddForm() }, label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Text("New Reminder")
                            } //: HSTACK
                            .padding()
                        
                    }) //: BUTTON
                    } //: CONDITION
                } //: HSTACK
            } //: VSTACK
            .navigationBarTitle("Reminder")
            .navigationBarItems(trailing: EditButton())
            
        } //: NAVIAGATION
    }
    
    // TOGGLE TO DISPLAY OR HIDE THE ADDFORM
    private func toggleAddForm() {
        addReminder.toggle()
    }
    // DELETE REMINDER
    private func removeRow(at offsets: IndexSet) {
        for offset in offsets {
            let reminder = reminderManager.reminders[offset]
            reminderManager.delete(reminder)
        }
    }
    
    // MOVE REMINDER TO NEW LOCATION
    private func move(from source: IndexSet, to destination: Int) {
        reminderManager.move(from: source, to: destination)
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderList()
    }
}
