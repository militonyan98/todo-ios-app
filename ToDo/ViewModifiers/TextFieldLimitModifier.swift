//
//  TextFieldLimitModifier.swift
//  ToDo
//
//  Created by Hermine Militonyan on 30.3.23..
//

import SwiftUI

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}
