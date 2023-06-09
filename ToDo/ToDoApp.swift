//
//  ToDoApp.swift
//  ToDo
//
//  Created by Hermine Militonyan on 10.3.23..
//

import SwiftUI

@main
struct ToDoApp: App {
    @StateObject private var dataController = DataController()
    
    @State private var task = ""
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
                .onAppear{
                    UIApplication.shared.addTapGestureRecognizer()
                }
        }
    }
}
