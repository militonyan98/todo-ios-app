//
//  TaskNameTextFieldView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 14.4.23..
//

import SwiftUI

struct TaskNameTextFieldView: View {
    var taskName: String
    @Binding var text: String
    
    var body: some View {
        TextField(taskName, text: $text)
            .limitInputLength(value: $text, length: 20)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.sentences)
            .submitLabel(.done)
    }
}

struct TaskNameTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TaskNameTextFieldView(taskName: "Task name", text: .constant("Task"))
    }
}
