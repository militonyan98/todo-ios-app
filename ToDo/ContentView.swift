//
//  ContentView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 10.3.23..
//

import SwiftUI

struct ContentView: View {
    @StateObject var tasksVM: TaskViewModel = TaskViewModel()
    @State private var isAddPresented = false
    @State private var isEditPresented = false
    
    @EnvironmentObject var dataController : DataController
    
    var body: some View {
        NavigationView {
            VStack {
//                Section("Priority"){
//                    Picker("Priority", selection: $testing) {
//                        Text("Test1")
//                            .tag("1")
//                        Text("Text2")
//                            .tag("2")
//                    }
//                }
                SortPickerView(sortType: $tasksVM.sortType)
                TaskListView(tasksVM: tasksVM)
            }
            .navigationTitle("Tasks")
            .sheet(isPresented: $isAddPresented,
                   onDismiss: { self.isAddPresented = false }) {
                AddTaskView(tasksVM: tasksVM)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        isAddPresented = true
                    }
                }
                
//                ToolbarItem {
//                    Button("Edit") {
//                        isEditPresented = true
//                    }
//                }
            }
        }
        .onAppear {
            tasksVM.setDataController(data: dataController)
        }
        .searchable(text: $tasksVM.searchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
