//
//  TaskView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 10.3.23..
//

import SwiftUI

struct TaskView: View {
    @ObservedObject var tasksVM: TaskViewModel
    var task: Task
    @State private var isEditPresented = false
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Task")
                        .font(.caption)
                    Text(task.name)
                        .font(.title3)
                        .bold()
                }
                //.padding(.bottom)
                
                Divider()
                    .overlay(.white.opacity(1))
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.caption)
                    Text(task.description)
                        .font(.headline)
                        .fontWeight(.semibold)
                        //.bold()
                        .italic()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            
            //Spacer()
            Divider()
                .overlay(.white.opacity(1))
            
            VStack(alignment: .trailing) {
                VStack(alignment: .leading) {
                    Text("Date")
                        .font(.caption)
                    Text(task.date, format: .dateTime.day().month().year())
                        .font(.headline)
                        .fontWeight(.regular)
                        .scaledToFill()
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
                //.padding()
            }
            .frame(maxWidth: .infinity)
            .padding(10) //

        }
        .frame(width: 350.0, height: 100)
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(task.priority.color.opacity(0.4))
                //.stroke(task.priority.color, lineWidth: 2)
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(tasksVM: TaskViewModel(), task: Task.sampleTask)
    }
}
