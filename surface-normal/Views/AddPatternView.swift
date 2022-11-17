//
//  AddPatternView.swift
//  CoreLocationMotion-Data-Logger
//
//  Created by Algrthm on 30/09/22.
//  Copyright © 2022 Pyojin Kim. All rights reserved.
//

import SwiftUI

struct AddPatternView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject private var settings = SettingsViewModel()

       
    private var options1: [String] = [measureAmbient.none.description, measureAmbient.beginning.description, measureAmbient.continuous.description]
     
     @State private var selectedOption1 = ""
    @State private var selected_value = "0"
    
    @State private var disabledSegment: Bool = false
    
  
  
    

    
    var body: some View {
        
        VStack{
            
            VStack{
            Header1(text: "Setting for this measurment")
                
                Divider()
                
                Header2(text: "Measure Ambient")
                
                HStack {
                    Spacer().onAppear{
                    }
                    
                    SegmentedButton(selectedItem: $selectedOption1, isDisabled: $disabledSegment, items: options1){}
                      .padding(.leading, 20).padding(.trailing, 20)
                    Spacer()
                }
                
               
                
                VStack {
                    Slider(value: $settings.dot_radius, in: 1...100,step: 1)
                    Header3(text: "Dot Radius: \(settings.dot_radius) Pixels")
                }.padding(.top,20).padding(.leading,20).padding(.trailing,20)
                
                VStack {
                    Slider(value: $settings.photos_number, in: 1...100,step: 1)
                    Header3(text: "Number of photos: \(settings.photos_number) Photos")
                }.padding(.top,0).padding(.leading,20).padding(.trailing,20)
                
                VStack {
                    Slider(value: $settings.photo_interval, in: 0...100,step: 1)
                    Header3(text: "Interval between photos: \(settings.photo_interval) Seconds")
                }.padding(.top,0).padding(.leading,20).padding(.trailing,20)
                
             
            }.padding(.top,30)
            
            
            
            Header2(text: "Exposure settings :").padding(.top,20)
            Divider()
            
            VStack {
                
                Group {
                    VStack {
                        Slider(value: $settings.shutter_speed, in: 1...9,step: 1)
                        Header3(text: "Shutter Speed: \(settings.shutterDesc) ms")
                    }.padding(.top,0).padding(.leading,20).padding(.trailing,20)
                    
                    VStack {
                        Slider(value: $settings.white_balance, in: 1...8,step: 1)
                        Header3(text: "White Balance: \(settings.white_balanceDesc)")
                    }.padding(.top,0).padding(.leading,20).padding(.trailing,20)
                    
                    
                }
                
            }
            
            
            
            
            Spacer()
            
            CustomButton(text: "Begin Measurement") {
               
                
                self.presentationMode.wrappedValue.dismiss()
            }.padding(.bottom,40)
            
            
        }//VStack
    }
}


struct AddPatternView_Previews: PreviewProvider {
    static var previews: some View {
        AddPatternView()
    }
}

