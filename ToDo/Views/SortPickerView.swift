//
//  SortPickerView.swift
//  ToDo
//
//  Created by Hermine Militonyan on 10.3.23..
//

import SwiftUI

struct SortPickerView: View {
    @Binding var sortType: SortType
    
    var body: some View {
        Picker("Sort", selection: $sortType) {
            ForEach(SortType.allCases, id: \.id) {
                Text($0.rawValue.uppercased())
                    .tag($0)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

//struct SortPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SortPickerView()
//    }
//}
