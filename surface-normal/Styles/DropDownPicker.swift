//
//  DropDownPicker.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import Foundation
import SwiftUI


struct DropDownPicker: View {
    
    var label: String
    var color: Color = Color.black
    var size: CGFloat = 18
    var size2: CGFloat = 14
    
    @State var isExpanded = false
    @Binding var options: [CustomModel]
    @Binding var selectedNum: Int64
     
    var handler: (() -> Void)
    //var options = Common.getCountries()
    
    @State var selectedName: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15){
            
                  
            Text(self.label)
                .font(.custom("Helvetica", size: size2))
                .foregroundColor(self.color)
                .fontWeight(.black).onAppear{
                    var id: Int64 = 0
                    var name = ""
                    
                    if options.count > 0 {
                        id = Int64(options[0].id)
                        name = options[0].name
                    }
                    
                    self.selectedName = name
                    self.selectedNum = id
                }
            DisclosureGroup("\(selectedName)", isExpanded: $isExpanded)
            {
                VStack{
                    
                    ScrollView {
                    ForEach(self.options) { c in
                        Text(c.name)
                            .font(.custom("Helvetica", size: size2))
                            .foregroundColor(self.color)
                            .fontWeight(.black)
                            .padding(.all)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                self.selectedName = c.name
                                self.selectedNum = Int64(c.id)
                                withAnimation{
                                    self.isExpanded.toggle()
                                }
                                self.handler()
                            }
                        
                    }
                    
                    }//ScrollView
                }.frame(height: 150)// VStack
                
            }.accentColor(self.color)
            .font(.custom("Helvetica", size: size2))
            .foregroundColor(self.color)
            .padding(.all)
            .background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(self.color))
            
            
          Spacer()
            
            
        }//.padding(.all)
        
        
        
    }
    
    
    
}
