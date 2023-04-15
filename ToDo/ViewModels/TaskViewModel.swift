//
//  TaskViewModel.swift
//  ToDo
//
//  Created by Hermine Militonyan on 10.3.23..
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    var tasksDB: [TaskDB] = []
    var dataController: DataController? = nil
    @Published private var tasks: [Task] = []
    @Published var searchText = ""
    @Published var sortType: SortType = .alphabetical
    
    
    func fetchTaskData() {
        do {
            tasksDB = try dataController!.moc.fetch(TaskDB.fetchRequest())
            tasks.removeAll()
            for index in 0..<tasksDB.count {
                let taskDB = tasksDB[index]
                var task = Task(id: taskDB.unwrappedId.uuidString, name: taskDB.unwrappedName, description: taskDB.unwrappedDescription, priority: taskDB.unwrappedPriority, date: taskDB.unwrappedDate)
                task.id = taskDB.unwrappedId.uuidString
                tasks.append(task)
            }
        } catch {
            print("An error occured while fetching")
        }
    }
    
    func setDataController(data: DataController){
        self.dataController = data
        fetchTaskData()
    }
    
    var filteredTasks: [Task] {
        if searchText.isEmpty {
            return tasks
        } else {
            return tasks.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var sortedTasks: [Task] {
        if sortType == .alphabetical {
            return filteredTasks.sorted { $0.name.lowercased() < $1.name.lowercased() }
        }
        
        if sortType == .date {
            return filteredTasks.sorted { $0.date < $1.date }
        }
        
        if sortType == .priority {
            return filteredTasks.sorted { $0.priority.rawValue > $1.priority.rawValue }
        }
        
        return filteredTasks
    }
    
    func add(task: Task) {
        if(dataController==nil){
            print("Data controller not initialized")
            return
        }
        
        let moc = dataController!.moc
        
        let newTask = TaskDB(context: moc)
        newTask.id = UUID(uuidString: task.id)
        newTask.taskName = task.name
        newTask.taskDescription = task.description
        newTask.priority = Int32(task.priority.rawValue)
        newTask.date = task.date
        
        save()
    }
    
    func remove(at offsets: IndexSet) {
        if(dataController==nil){
            print("Data controller not initialized")
            return
        }
        
        let moc = dataController!.moc
        
        for offset in offsets {
            let taskModel = sortedTasks[offset]
            
            for index in 0..<tasksDB.count {
                let task = tasksDB[index]
                if task.unwrappedId.uuidString == taskModel.id {
                    moc.delete(task)
                    break
                }
            }
        }
        
        save()
    }
    
    func save() {
        let moc = dataController!.moc
        try? moc.save()
        
        fetchTaskData()
    }
    
    func findByID(id: String) -> Task? {
        for task in tasks {
            if task.id == id {
                return task
            }
        }
        
        return nil
    }
    
    func updateTask(id: String, name: String, description: String, priority: Priority, date: Date) {
        for index in 0..<tasksDB.count {
            let task = tasksDB[index]
            if task.unwrappedId.uuidString == id {
                task.taskName = name
                task.taskDescription = description
                task.priority = Int32(priority.rawValue)
                task.date = date
                break
            }
        }
        
        save()
    }
}
