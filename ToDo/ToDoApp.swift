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

extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = (connectedScenes.first as? UIWindowScene)?.windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
