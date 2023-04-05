//
//  TaskModel.swift
//  ToDo
//
//  Created by Hermine Militonyan on 10.3.23..
//

import SwiftUI

struct Task: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var description: String
    var priority: Priority
    var date: Date
    
    static var sampleTask = Task(name: "Task", description: "Description", priority: Priority.normal, date: Date.now)
    static var sampleTaskList = [
        Task(name: "Normal Task", description: "Normal priority task", priority: Priority.normal, date: Date.now),
        Task(name: "Medium Task", description: "Medium priority task", priority: Priority.medium, date: Date.now),
        Task(name: "Important Task", description: "High priority task", priority: Priority.high, date: Date.now)
    ]
}

public enum Priority: Int, Identifiable, CaseIterable {
    public var id: Int { rawValue }
    
    case normal, medium, high
    
    var title: String {
        switch self {
        case .normal:
            return "Normal"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var color: Color {
        switch self {
        case .normal:
            return .blue
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}

enum SortType: String, CaseIterable {
    var id: String { rawValue }
    
    case alphabetical, date, priority
}
