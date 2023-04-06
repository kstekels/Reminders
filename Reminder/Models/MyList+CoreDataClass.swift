//
//  MyList+CoreDataClass.swift
//  Reminder
//
//  Created by karlis.stekels on 31/03/2023.
//

import Foundation
import CoreData

@objc(MyList)
public class MyList: NSManagedObject {
    var remindersArray: [Reminder] {
        reminders?.allObjects.compactMap {( $0 as! Reminder )} ?? []
    }
}
