//
//  Task+CoreDataProperties.swift
//  ToDo App
//
//  Created by Pratyush Srivastava on 26/01/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var task: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var date: String?

}

extension Task : Identifiable {

}
