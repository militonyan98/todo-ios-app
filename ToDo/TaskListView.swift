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
                ProcessTaskRowView(task: tasksVM.sortedTasks[task],tasksVM: tasksVM, index: task).tag(tasksVM.sortedTasks[task].id)
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


struct ProcessTaskRowView: View {
    enum Action {
        case view
        case edit
    }
    @State private var isActive = false
    @State private var action: Action?
    let task: Task
    let tasksVM: TaskViewModel
    let index: Int

    var body: some View {
        // by default navigate as-is
        ZStack {
            NavigationLink(destination: destination, isActive: $isActive) {
                EmptyView()
            }
            .opacity(0)
            
            TaskView(tasksVM: tasksVM, task: tasksVM.sortedTasks[index])
                .contextMenu {
                    Button(role: .destructive) {
                        tasksVM.remove(at: IndexSet(arrayLiteral: index))
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                    
                    Button {
                        action = .edit    // specific action
                        isActive = true
                    } label: {
                        Label("Edit", systemImage: "pencil")
                            //.frame(width: 100)
                    }
                    .tint(.yellow)
                }

                //.listRowSeparator(.hidden)
        }
        //.listRowSeparator(.hidden)
        .swipeActions() {
            Button(role: .destructive) {
                tasksVM.remove(at: IndexSet(arrayLiteral: index))
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }

            Button {
                action = .edit    // specific action
                isActive = true
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.yellow)
        }
        .onChange(of: isActive) {
            if !$0 {
                action = nil  // reset back
            }
        }
    }

    @ViewBuilder
    private var destination: some View {
        // construct destination depending on action
        if case .edit = action {
            EditTaskView(tasksVM: tasksVM, taskID: tasksVM.sortedTasks[index].id)
        } else {
            // just to demo different type destinations
            DetailsView(tasksVM: tasksVM, taskID: tasksVM.sortedTasks[index].id)
        }
    }
}


struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(tasksVM: TaskViewModel())
    }
}
