//
//  TaskFormView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 14.4.23..
//

import SwiftUI

struct TaskFormView: View {
    @FocusState private var focusedField: FocusedField?
    
    @Binding var task: String
    @Binding var description: String
    @Binding var priority: Priority
    @Binding var date: Date
    
    var body: some View {
        Form {
            Section("Task") {
                TaskNameTextFieldView(taskName: "Task", text: $task)
                    .focused($focusedField, equals: .task)
                TaskDescriptionTextFieldView(taskDescription: "Description", text: $description)
                    .focused($focusedField, equals: .description)
            }
            
            Section("Priority") {
                TaskPriorityPickerView(pickerText: "Priority", priority: $priority)
            }
            
            Section("Date") {
                TaskDateView(dateText: "Date", date: $date)
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
}

struct TaskFormView_Previews: PreviewProvider {
    static var previews: some View {
        TaskFormView(task: .constant("Task"), description: .constant("Description"), priority: .constant(.normal), date: .constant(Date.now))
    }
}
