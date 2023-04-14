//
//  AddTaskView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 10.3.23..
//

import SwiftUI
import CoreData

struct AddTaskView: View {
    enum FocusedField {
        case task, description
    }
    
    @FocusState private var focusedField: FocusedField?
    
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newTask = Task(name: task, description: description, priority: priority, date: date)
                        self.tasksVM.add(task: newTask)
                        
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
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(tasksVM: TaskViewModel())
    }
}
