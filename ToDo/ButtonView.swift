//
//  ButtonView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 14.4.23..
//

import SwiftUI

enum ButtonRoll {
    case save, cancel
}

struct ButtonView: View {
    @Environment(\.dismiss) var dismiss
    var roll: ButtonRoll
    var action: (() -> Void)?
    var disabledSave: Bool?
    
    var body: some View {
        Button {
            (action ?? {})()
            dismiss()
        } label: {
            Text(roll == .save ? "Save" : "Cancel")
        }
        .foregroundColor(roll == .cancel ? .red : (disabledSave! ? .gray : .blue))
        .disabled(disabledSave ?? false)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(roll: .save)
    }
}
