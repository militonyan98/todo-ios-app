//
//  TaskDateView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 14.4.23..
//

import SwiftUI

struct TaskDateView: View {
    var dateText: String
    @Binding var date: Date
    
    var body: some View {
        DatePicker(dateText, selection: $date, in: Date.now...)
            .datePickerStyle(.graphical)
            .frame(maxHeight: 400)
    }
}

struct TaskDateView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDateView(dateText: "Date", date: .constant(Date.now))
    }
}
