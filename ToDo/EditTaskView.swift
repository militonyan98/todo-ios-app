//
//  EditTaskView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 30.3.23..
//

import SwiftUI
import CoreData

struct EditTaskView: View {
    enum FocusedField {
        case task, description
    }
    
    @FocusState private var focusedField: FocusedField?
    
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
        VStack {
            Form {
                Section("Task") {
                    TextField("Task", text: $task)
                        .limitInputLength(value: $task, length: 20)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.sentences)
                        .submitLabel(.done)
                        .focused($focusedField, equals: .task)
                    TextField("Description", text: $description, axis: .vertical)
                        .limitInputLength(value: $description, length: 100)
                        .textInputAutocapitalization(.sentences)
                        .lineLimit(3, reservesSpace: true)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.sentences)
                        .submitLabel(.done)
                        .focused($focusedField, equals: .description)
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
            .onAppear {
                focusedField = .task
            }
            .onSubmit {
                switch focusedField {
                case .task:
                    focusedField = .description
                default:
                    print("Done!")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    tasksVM.updateTask(id: taskID, name: task, description: description, priority: priority, date: date)
                    dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(disabledSave)
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
        
        .onAppear {
            let taskModel = tasksVM.findByID(id: taskID)
            task = taskModel?.name ?? ""
            description = taskModel?.description ?? ""
            priority = taskModel?.priority ?? .normal
            date = taskModel?.date ?? Date.now
        }
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(tasksVM: TaskViewModel(), taskID: String())
    }
}
