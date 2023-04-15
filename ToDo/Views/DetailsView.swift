//
//  DetailsView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 11.4.23..
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var tasksVM: TaskViewModel
    @Environment(\.dismiss) var dismiss
    var taskID: String
    @State private var task = ""
    @State private var description = ""
    @State private var priority: Priority = .normal
    @State private var date = Date.now
    
    var body: some View {
            VStack {
                Spacer()
                
                VStack {
                    Text("Task: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                    
                    Text("\(task)")
                }
                .padding()
                
                Divider()
                
                VStack {
                    Text("Description: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                    
                    Text("\(description)")
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                .frame(height: 120)
                .padding()
                
                Divider()
                
                VStack {
                    Text("Priority: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                    
                    Text("\(priority.title)")
                        .foregroundColor(tasksVM.findByID(id: taskID)?.priority.color ?? .primary)
                        .fontWeight(.semibold)
                    
                }
                .padding()
                
                Divider()
                
                VStack {
                    Text("Date: ")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                    
                    Text("\(date.formatted())")
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle(task)
            .navigationBarTitleDisplayMode(.inline)
            .frame(width: 350, height: 550)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(tasksVM.findByID(id: taskID)?.priority.color.opacity(0.2) ?? .blue.opacity(0.2))
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

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(tasksVM: TaskViewModel(), taskID: String())
    }
}
