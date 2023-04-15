//
//  Priority.swift
//  ToDo
//
//  Created by Hermine Militonyan on 15.4.23..
//

import SwiftUI

public enum Priority: Int, Identifiable, CaseIterable {
    public var id: Int { rawValue }
    
    case normal, medium, high
    
    var title: String {
        switch self {
        case .normal:
            return "Normal"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var color: Color {
        switch self {
        case .normal:
            return .blue
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}
