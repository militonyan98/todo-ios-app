//
//  TextFieldLimitInputLenghtExtension.swift
//  ToDo
//
//  Created by Hermine Militonyan on 15.4.23..
//

import SwiftUI

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}
