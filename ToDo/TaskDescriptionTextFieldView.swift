//
//  TaskDescriptionTextFieldView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 14.4.23..
//

import SwiftUI

struct TaskDescriptionTextFieldView: View {
    var taskDescription: String
    @Binding var text: String
    
    var body: some View {
        TextField(taskDescription, text: $text, axis: .vertical)
            .limitInputLength(value: $text, length: 100)
            .textInputAutocapitalization(.sentences)
            .lineLimit(3, reservesSpace: true)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.sentences)
            .submitLabel(.done)
    }
}

struct TaskDescriptionTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDescriptionTextFieldView(taskDescription: "Description", text: .constant("Description"))
    }
}
