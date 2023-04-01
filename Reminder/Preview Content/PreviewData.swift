//
//  PreviewData.swift
//  Reminder
//
//  Created by karlis.stekels on 31/03/2023.
//

import Foundation
import CoreData

class PreviewData {
    static var reminder: Reminder {
        let viewContext = CoreDataProvider.shared.persistantContainer.viewContext
        let request = Reminder.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? Reminder(context: viewContext)
    }
    static var myList: MyList {
        let viewContext = CoreDataProvider.shared.persistantContainer.viewContext
        let request = MyList.fetchRequest()
        return (try? viewContext.fetch(request).first) ?? MyList()
    }
    
}
