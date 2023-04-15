//
//  TaskListView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 10.3.23..
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var tasksVM: TaskViewModel
    @State private var showEdit = false
    
    var body: some View {
        List {
            ForEach(0..<tasksVM.sortedTasks.count, id: \.self) { task in
                ProcessTaskRowView(task: tasksVM.sortedTasks[task],tasksVM: tasksVM, index: task)
                    .tag(tasksVM.sortedTasks[task].id)
                    .listRowSeparator(.hidden)
            }
            .onDelete(perform: tasksVM.remove)
        }
        .listStyle(.plain)
        .toolbar {
            EditButton()
                .disabled(tasksVM.sortedTasks.isEmpty)
                .foregroundColor(tasksVM.sortedTasks.isEmpty ? .secondary.opacity(0) : .blue)
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(tasksVM: TaskViewModel())
    }
}
