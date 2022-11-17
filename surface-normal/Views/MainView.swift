//
//  MainView.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import SwiftUI

struct MainView: View {
    
    @State private var takePhoto: Bool = false
    
    
    var body: some View {
       
        NavigationView{
            VStack {
                
                HStack {
                    Spacer().onAppear{
                                     }
                    Header1(text: "Surface Model")
                        .padding(.top, 20)
                    Spacer()
                    
                }
                
                
                HStack{
                    Spacer()
                    
                    CustomButton(text: "Start") {
                        self.takePhoto = true
                    }
                    
                    Spacer()
                    
                }.padding(.top,40)
                
                
                NavigationLink(destination: AddPatternView(), isActive: $takePhoto)
                {EmptyView()}.navigationBarHidden(true)
                
                Spacer()
                
            } //Vstack
            
        }// Navigation
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
