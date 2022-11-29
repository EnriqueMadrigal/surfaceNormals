//
//  MainView.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import SwiftUI

struct MainView: View {
    
    @State private var takePhoto: Bool = false
    
    @State private var confirmationShow: Bool = false
    
    @StateObject private var viewModel = MainViewModel()
    
    
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
               
                
                HStack{
                    Spacer()
                    
                    CustomButton(text: "Delete images") {
                        self.confirmationShow = true
                    }
                    
                    Spacer().alert(isPresented: $confirmationShow) {
                        
                        Alert(title: Text("! Warning !"), message: Text("Are you sure you want to delete the image files ?"),
                              primaryButton: .destructive(Text("Confirm"), action: {
                               
                            self.viewModel.deleteFiles()
                                
                              }),
                              secondaryButton: .cancel(Text("Cancel"), action: {}))
                        
                    }
                    
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
