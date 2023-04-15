//
//  AddTaskView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 10.3.23..
//

import SwiftUI
import CoreData

struct AddTaskView: View {
    @ObservedObject var tasksVM: TaskViewModel
    @Environment(\.dismiss) var dismiss
    @State private var task = ""
    @State private var description = ""
    @State private var priority: Priority = .normal
    @State private var date = Date.now
    
    var disabledSave: Bool {
        self.task.isEmpty || self.description.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TaskFormView(task: $task, description: $description, priority: $priority, date: $date)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ButtonView(roll: .save, action: addTaskAction, disabledSave: disabledSave)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    ButtonView(roll: .cancel, action: { dismiss() })
                }
            }
        }
    }
    
    func addTaskAction() {
        let newTask = Task(name: task, description: description, priority: priority, date: date)
        self.tasksVM.add(task: newTask)
        
        dismiss() //Explicitely dismiss because we use sheet
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(tasksVM: TaskViewModel())
    }
}
