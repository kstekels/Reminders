//
//  CoreDataProvide.swift
//  Reminder
//
//  Created by karlis.stekels on 31/03/2023.
//

import Foundation
import CoreData


class CoreDataProvider {
    static let shared = CoreDataProvider()
    let persistantContainer: NSPersistentContainer
    
    private init() {
        
        //register custom transformers
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        
        persistantContainer = NSPersistentContainer(name: "RemindersModel")
        persistantContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("❌ Error initializing Reminders model ❌: \(error) ")
            }
        }
        
    }
}
