//
//  CheckBoxView.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import Foundation
import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    var handler: (() -> Void)

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square").frame(width: 36, height: 36, alignment: .center)
            .foregroundColor(checked ? Color.gray : Color.gray)
            .scaledToFill()
            .onTapGesture {
                self.checked.toggle()
                self.handler()
            }
    }
}
