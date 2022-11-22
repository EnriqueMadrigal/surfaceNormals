//
//  PatternView.swift
//  surface-normal
//
//  Created by Algrthm on 17/11/22.
//

import SwiftUI

struct PatternView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
    @StateObject private var pattern = PatternViewModel()
  
    
    var body: some View {
        ZStack {
            VStack {
                
                GeometryReader { geometry in
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .overlay{
                            Circle()
                                .fill(.white)
                                .foregroundColor(.white)
                                .position(x: pattern.randomx, y: pattern.randomy)
                                .frame(width: pattern.dotSize, height: pattern.dotSize)
                            
                        }
                    
                    
                }
                
                
                
            } //VStack
            .onTapGesture {
                self.pattern.StopPatterns()
                //self.pattern.didFinish = true
            }
            
            ErrorView(error: pattern.error)
            
            /*
            FrameView(image: pattern.frame)
                .edgesIgnoringSafeArea(.all).frame(width: 160, height: 200,alignment: .center)
            */
            
            VStack {
                
                Spacer()
                
                if self.pattern.didFinish {
                    HStack{
                        Spacer()
                        CustomButton(text: "Done with the patterns") {
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                        Spacer()
                        
                    }.padding(.leading,20).padding(.trailing,20)
                        
                }
                
                Spacer()
                
                
            }
            
            
          
            
            
        }//Zstack
        .background(.black)
            .onDisappear{
                self.pattern.viewWillDissapear()
            }.navigationBarHidden(true)
                .statusBarHidden(true)
        
    }
}

struct PatternView_Previews: PreviewProvider {
    static var previews: some View {
        PatternView()
    }
}
