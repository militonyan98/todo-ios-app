//
//  TaskPriorityPickerView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 14.4.23..
//

import SwiftUI

struct TaskPriorityPickerView: View {
    var pickerText: String
    @Binding var priority: Priority
    
    var body: some View {
        Picker(pickerText, selection: $priority) {
            ForEach(Priority.allCases, id: \.id) {
                Text($0.title)
                    .foregroundColor($0.color)
                    .tag($0)
            }
        }
    }
}

struct TaskPriorityPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TaskPriorityPickerView(pickerText: "Priority", priority: .constant(.normal))
    }
}
