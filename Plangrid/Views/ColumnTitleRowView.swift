//
//  ColumnTitleRowView.swift
//  Plangrid
//
//  Created by Evan Plant on 06/11/2025.
//

import SwiftUI

struct ColumnTitleRowView: View {
    var num: String
    var placeholder: String
    @Binding var variable: String
    
    var body: some View {
        HStack {
            Text("Column \(num)")
            Spacer()
            TextField(placeholder, text: $variable)
                .multilineTextAlignment(.trailing)
                .autocorrectionDisabled()
        }
    }
}
