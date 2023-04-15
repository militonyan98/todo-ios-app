//
//  SortType.swift
//  ToDo
//
//  Created by Hermine Militonyan on 15.4.23..
//

import Foundation

enum SortType: String, CaseIterable {
    var id: String { rawValue }
    
    case alphabetical, date, priority
}
