//
//  ReminderDetailView.swift
//  Reminder
//
//  Created by karlis.stekels on 03/04/2023.
//

import SwiftUI

struct ReminderDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var reminder: Reminder
    @State var editConfig: ReminderEditConfig = ReminderEditConfig()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
                    }
                }
                
                Section {
                    Toggle(isOn: $editConfig.hasDate) {
                        Image(systemName: "calendar")
                            .foregroundColor(.red)
                    }
                    
                    if editConfig.hasDate {
                        DatePicker("Select Date", selection: $editConfig.remindersDate ?? Date(), displayedComponents: .date )
                    }
                    
                    Toggle(isOn: $editConfig.hasTime) {
                        Image(systemName: "clock")
                            .foregroundColor(.red)
                    }
                    
                    if editConfig.hasTime {
                        DatePicker("Select Time", selection: $editConfig.remindersTime ?? Date(), displayedComponents: .hourAndMinute)
                    }
                    
                    Section {
                        NavigationLink {
                            SelectListView(selectedList: $reminder.list)
                        } label: {
                            Text("List")
                            Spacer()
                            Text(reminder.list!.name)
                        }

                    }
                }
            }
            .onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Details")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        //TODO: - Implement
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ReminderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderDetailView(reminder: .constant(PreviewData.reminder))
    }
}
