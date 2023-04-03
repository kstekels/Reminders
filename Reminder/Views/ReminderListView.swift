//
//  ReminderListView.swift
//  Reminder
//
//  Created by Kārlis Štekels on 01/04/2023.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    private func reminderCheckedChanged(reminder: Reminder) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = !reminder.isCompleted
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        List(reminders) { reminder in
            RemindersCellView(reminder: reminder) { event in
                switch event {
                case .onSelect(let reminder):
                    print("onSelect \(reminder)")
                case .onCheckChanged(let reminder):
                    reminderCheckedChanged(reminder: reminder)
                case .onInfo:
                    print("onInfo")
                }
            }
        }
        .listStyle(.plain)
    }
}
