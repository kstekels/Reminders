//
//  ReminderListView.swift
//  Reminder
//
//  Created by Kārlis Štekels on 01/04/2023.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    var body: some View {
        List(reminders) { reminder in
            RemindersCellView(reminder: reminder) { event in
                switch event {
                case .onSelect(let reminder):
                    print("onSelect \(reminder)")
                case .onCheckChanged(let reminder):
                    print("onCheckChanged \(reminder)")
                case .onInfo:
                    print("onInfo")
                }
            }
        }
        .listStyle(.plain)
    }
}
