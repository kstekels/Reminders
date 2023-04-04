//
//  ReminderListView.swift
//  Reminder
//
//  Created by Kārlis Štekels on 01/04/2023.
//

import SwiftUI

struct ReminderListView: View {
    
    @State private var selectedReminder: Reminder?
    @State private var showReminderDetail: Bool = false
    let reminders: FetchedResults<Reminder>
    
    private func reminderCheckedChanged(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        do {
            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
    }
    
    private func isReminderSelected(_ reminder: Reminder) -> Bool {
        selectedReminder?.objectID == reminder.objectID
    }
    
    private func deleteReminder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let reminder = reminders[index]
            do {
                try ReminderService.deleteReminder(reminder: reminder)
            } catch {
                print(error)
            }
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(reminders) { reminder in
                    RemindersCellView(reminder: reminder, isSelected: isReminderSelected(reminder)) { event in
                        switch event {
                        case .onSelect(let reminder):
                            selectedReminder = reminder
                        case .onCheckChanged(let reminder, let isCompleted):
                            reminderCheckedChanged(reminder: reminder, isCompleted: isCompleted)
                        case .onInfo:
                            showReminderDetail = true
                        }
                    }
                }
                .onDelete(perform: deleteReminder)
            }
            .listStyle(.plain)
        }
        .sheet(isPresented: $showReminderDetail) {
            ReminderDetailView(reminder: Binding($selectedReminder)!)
        }
    }
}


struct ReminderListView_Previews: PreviewProvider {
    
    struct ReminderListViewContainer: View {
        @FetchRequest(sortDescriptors: [])
        private var remindersResults: FetchedResults<Reminder>
        var body: some View {
            ReminderListView(reminders: remindersResults)
        }
    }

    static var previews: some View {
        ReminderListViewContainer()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistantContainer.viewContext)
    }
}
