//
//  InputStyles.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import Foundation
import SwiftUI
import Combine

struct InputGeneral : View{
    var text: String
    var color: Color = Color.gray
    var size: CGFloat = 16
    
    //var binding: Binding<String>
    @Binding var binding: String
        
    var body: some View {
    
        TextField(self.text, text: $binding)
            .padding(.top, 10).padding(.bottom, 10).padding(.leading ,10)
            .font(.custom("Helvetica", size: size))
            .foregroundColor(self.color)
            .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(self.color))
    }
                
}


struct InputGeneralDisabled : View{
    var text: String
    var color: Color = Color.gray
    var size: CGFloat = 16
    
    //var binding: Binding<String>
    @Binding var binding: String
    @Binding var isDisabled: Bool
        
    var body: some View {
    
        TextField(self.text, text: $binding)
            .padding(.top, 10).padding(.bottom, 10).padding(.leading ,10)
            .font(.custom("Helvetica", size: size))
            .foregroundColor(self.color)
            .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(self.color))
            .disabled(isDisabled)
    }
                
}


struct InputGeneralNumberDouble : View{
    var text: String
    var color: Color = Color.gray
    var size: CGFloat = 16
    @State var value: String
    
    //var binding: Binding<String>
    @Binding var binding: Double
        
    var body: some View {
    
        TextField(self.text, text: $value)
        {UIApplication.shared.endEditing()}
            .padding(.top, 10).padding(.bottom, 10).padding(.leading ,10)
            .font(.custom("Helvetica", size: size))
            .foregroundColor(self.color)
            .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(self.color))
            //.keyboardType(.decimalPad)
            .onReceive(Just(value)){newvalue in
                let filtered = newvalue.filter {"0123456789.".contains($0)}
                if filtered != newvalue {
                    self.value = filtered
                    self.binding = Double(value) ?? 0.0
                }
                
            }
      
    }
                
}




struct InputGeneralNumber : View{
    var text: String
    var color: Color = Color.gray
    var size: CGFloat = 16
    var value: String = ""
    
    //var binding: Binding<String>
    @Binding var binding: String
        
    var body: some View {
    
        TextField(self.text, text: $binding)
        {UIApplication.shared.endEditing()}
            .padding(.top, 10).padding(.bottom, 10).padding(.leading ,10)
            .font(.custom("Helvetica", size: size))
            .foregroundColor(self.color)
            .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(self.color))
            //.keyboardType(.decimalPad)
            .onReceive(Just(binding)){newvalue in
                let filtered = newvalue.filter {"0123456789.".contains($0)}
                if filtered != newvalue {
                    self.binding = filtered
                }
                
            }
    }
                
}
