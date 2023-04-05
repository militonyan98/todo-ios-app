//
//  EditTaskView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 30.3.23..
//

import SwiftUI

import CoreData

struct EditTaskView: View {
    //@FetchRequest (sortDescriptors: []) var taskDB: FetchedResults<TaskDB>
    @ObservedObject var tasksVM: TaskViewModel
    @Environment(\.dismiss) var dismiss
    var taskID: String
    @State private var task = ""
    @State private var description = ""
    @State private var priority: Priority = .normal
    @State private var date = Date.now
    
    var disabledSave: Bool {
        if !self.task.isEmpty && !self.description.isEmpty {
            return false
        }
        
        return true
    }
    
    var body: some View {
        //NavigationView {
            VStack {
                Form {
                    Section("Task") {
                        TextField("Task", text: $task)
                            .limitInputLength(value: $task, length: 15)
                        TextField("Description", text: $description)
                    }
                    
                    Section("Priority") {
                        Picker("Priority", selection: $priority) {
                            ForEach(Priority.allCases, id: \.id) {
                                Text($0.title)
                                    .foregroundColor($0.color)
                                    .tag($0)
                            }
                        }
                    }
                    
                    Section("Date") {
                        DatePicker("Date", selection: $date, in: Date.now...)
                            .datePickerStyle(.graphical)
                            .frame(maxHeight: 400)
                    }
                }
            }
//            .onTapGesture {
//                hideKeyboard()
//            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        tasksVM.updateTask(id: taskID, name: task, description: description, priority: priority, date: date)
                        dismiss()
                    } label: {
                        Text("Save")
                            .disabled(disabledSave)
                            //.foregroundColor(disabledSave ? .gray : .blue)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
            }
        //}
        .onAppear {
            let taskModel = tasksVM.findByID(id: taskID)
            task = taskModel?.name ?? ""
            description = taskModel?.description ?? ""
            priority = taskModel?.priority ?? .normal
            date = taskModel?.date ?? Date.now
        }
    }
}

//#if canImport(UIKit)
//extension View {
//    func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
//#endif

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(tasksVM: TaskViewModel(), taskID: String())
    }
}
