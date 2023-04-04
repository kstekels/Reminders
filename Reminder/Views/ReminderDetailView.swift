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
    
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Title", text: $editConfig.title)
                        TextField("Notes", text: $editConfig.notes ?? "")
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
                    .onChange(of: editConfig.hasDate) { hasDate in
                        if hasDate {
                            editConfig.remindersDate = Date()
                        }
                    }
                    .onChange(of: editConfig.hasTime) { hasTime in
                        if hasTime {
                            editConfig.remindersTime = Date()
                        }
                    }
                }
                .listStyle(.insetGrouped)
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
                        do {
                            let _ = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                        } catch {
                            print(error)
                        }
                        dismiss()
                    }.disabled(!isFormValid)
                }
                ToolbarItem(placement: .navigationBarLeading) {
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
