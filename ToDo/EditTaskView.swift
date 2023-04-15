//
//  EditTaskView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 30.3.23..
//

import SwiftUI
import CoreData

struct EditTaskView: View {
    @ObservedObject var tasksVM: TaskViewModel
    var taskID: String
    @State private var task = ""
    @State private var description = ""
    @State private var priority: Priority = .normal
    @State private var date = Date.now
    
    var disabledSave: Bool {
        self.task.isEmpty || self.description.isEmpty
    }
    
    var body: some View {
        VStack {
            TaskFormView(task: $task, description: $description, priority: $priority, date: $date)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ButtonView(roll: .save, action: updateTask, disabledSave: disabledSave)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                ButtonView(roll: .cancel)
            }
        }
        .onAppear {
            let taskModel = tasksVM.findByID(id: taskID)
            task = taskModel?.name ?? ""
            description = taskModel?.description ?? ""
            priority = taskModel?.priority ?? .normal
            date = taskModel?.date ?? Date.now
        }
    }
    
    func updateTask() {
        tasksVM.updateTask(id: taskID, name: task, description: description, priority: priority, date: date)
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(tasksVM: TaskViewModel(), taskID: String())
    }
}
