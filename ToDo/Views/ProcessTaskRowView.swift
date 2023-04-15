//
//  ProcessTaskRowView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 15.4.23..
//

import SwiftUI

struct ProcessTaskRowView: View {
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
                    }
                    .tint(.yellow)
                }
        }
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

//struct ProcessTaskRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProcessTaskRowView()
//    }
//}
