//
//  ReminderService.swift
//  Reminder
//
//  Created by karlis.stekels on 31/03/2023.
//

import Foundation
import CoreData
import UIKit

class ReminderService {
    static var viewContext: NSManagedObjectContext {
        CoreDataProvider.shared.persistantContainer.viewContext
    }
    
    static func save() throws {
        try viewContext.save()
    }
    
    static func saveMyList(_ name: String, _ color: UIColor) throws {
        let myList = MyList(context: viewContext)
        myList.name = name
        myList.color = color
        try save()
    }
    
    static func updateReminder(reminder: Reminder, editConfig: ReminderEditConfig) throws -> Bool {
        let reminderToUpdate = reminder
        reminderToUpdate.isCompleted = editConfig.isCompleted
        reminderToUpdate.title = editConfig.title
        reminderToUpdate.notes = editConfig.notes
        reminderToUpdate.reminderDate = editConfig.hasDate ? editConfig.remindersDate: nil
        reminderToUpdate.reminderTime = editConfig.hasTime ? editConfig.remindersTime: nil
        
        try save()
        return true
        
    }
    
    static func deleteReminder(reminder: Reminder) throws {
        viewContext.delete(reminder)
        try save()
    }
    
    static func getRemindersBySearchTerm(_ searchTerm: String) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchTerm)
        return request
    }
    
    static func saveReminderToMyList(myList: MyList, reminderTitle: String) throws {
        let reminder = Reminder(context: viewContext)
        reminder.title = reminderTitle
        myList.addToReminders(reminder)
        try save()
    }
    
    static func getRemindersByList(myList: MyList) -> NSFetchRequest<Reminder> {
        let request = Reminder.fetchRequest()
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "list = %@ AND isCompleted = false ", myList)
        return request
    }
}
