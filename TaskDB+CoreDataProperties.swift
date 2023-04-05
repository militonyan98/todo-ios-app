//
//  TaskDB+CoreDataProperties.swift
//  ToDo
//
//  Created by Hermine Militonyan on 22.3.23..
//
//

import Foundation
import CoreData


extension TaskDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskDB> {
        return NSFetchRequest<TaskDB>(entityName: "TaskDB")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var taskName: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var priority: Int32
    @NSManaged public var date: Date?
    
    public var unwrappedId: UUID {
        return id ?? UUID()
    }
    
    public var unwrappedName: String {
        return taskName ?? "Unknown name"
    }
    
    public var unwrappedDescription: String {
        return taskDescription ?? "Unknown description"
    }
    public var unwrappedPriority: Priority {
        return Priority(rawValue: Int(priority)) ?? Priority.normal
    }
    
    public var unwrappedDate: Date {
        return date ?? Date.now
    }

}

extension TaskDB : Identifiable {

}
