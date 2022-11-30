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
    @State private var startMeasurement = false
       
    private var options1: [String] = [measureAmbient.none.description, measureAmbient.beginning.description, measureAmbient.continuous.description]
     
    private var options2: [String] = [fileFormat.RAW.description, fileFormat.PNG.description,fileFormat.JPG.description]
    
     @State private var selectedOption1 = measureAmbient.none.description
    @State private var selectedOption2 = fileFormat.RAW.description
    @State private var selected_value = "0"
    
    @State private var disabledSegment: Bool = false
    @State private var showProgreeView = false
    @State private var timerCounter = 0.0
  
    @State private var duration: String = ""
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    

    
    var body: some View {
        
        ScrollView {
            ZStack {
                
                VStack{
                    
                    VStack{
                        Header1(text: "Setting for this measurment")
                        
                        Divider()
                        
                        VStack {
                            
                            
                            Header3(text: "Description:")
                            InputGeneral(text: "", binding: $settings.desc).frame(width: 240)
                       
                          
                          
                            //Header3(text: "Shutter Speed: \(settings.shutterDesc) ms")
                            
                        }.padding(.top,20).padding(.leading,20).padding(.trailing,20)
                        
                        
                        
                        Divider()
                        
                        Header2(text: "Measure Ambient").onAppear{
                            self.selectedOption1 =  measureAmbient.none.description
                          
                            self.duration =  String(format: "%.4f",settings.minExposureDuration)
                        }
                        
                        HStack {
                            Spacer().onAppear{
                            }
                            
                            SegmentedButton(selectedItem: $selectedOption1, isDisabled: $disabledSegment, items: options1){}
                                .padding(.leading, 20).padding(.trailing, 20)
                            Spacer()
                        }
                     
                        Group {
                            
                            VStack {
                                Slider(value: $settings.dot_radius, in: 1...100,step: 1)
                                Header3(text: "Dot Radius: \(settings.dot_radius) Pixels")
                            }.padding(.top,20).padding(.leading,20).padding(.trailing,20)
                            
                            VStack {
                                Slider(value: $settings.photos_number, in: 1...100,step: 1)
                                Header3(text: "Number of photos: \(settings.photos_number) Photos")
                            }.padding(.top,0).padding(.leading,20).padding(.trailing,20)
                            
                            VStack {
                                Slider(value: $settings.photo_interval, in: 0.1...1,step: 0.1)
                                Header3(text: "Interval between photos: " + String(format: "%.2f", settings.photo_interval) + " secs")
                            }.padding(.top,0).padding(.leading,20).padding(.trailing,20)
                            
                            HStack {
                                Spacer()
                                
                                SegmentedButton(selectedItem: $selectedOption2, isDisabled: $disabledSegment, items: options2){}
                                    .padding(.leading, 20).padding(.trailing, 20)
                                Spacer()
                            }
                         
                            
                            
                            
                        }
                        
                    }.padding(.top,0)
                    
                    
                    
                    
                    
                    Header2(text: "Exposure settings :").padding(.top,20)
                    Divider()
                    
                    
                    
                    VStack {
                        
                        Group {
                            
                            VStack {
                                Slider(value: $settings.Iso, in: settings.minIsoValue...settings.maxIsoValue,step: 100)
                                Header3(text: "ISO: \(settings.Iso)")
                            }.padding(.top,0).padding(.leading,20).padding(.trailing,20)
                            
                            VStack {
                                
                                
                                //Slider(value: $settings.shutter_speed, in: 0...1,step: 0.01)
                                InputGeneral(text: "", binding: $duration).frame(width: 240)
                                Header3(text: "Shutter Speed:")
                                
                                Header3(text: String(format: "Min Value:(%.4f)", settings.minExposureDuration) + " " + String(format: "Max Value:(%.4f)", settings.maxExposureDuration))
                                
                                //Header3(text: "Shutter Speed: \(settings.shutterDesc) ms")
                                
                            }.padding(.top,20).padding(.leading,20).padding(.trailing,20)
                            
                            
                            
                            VStack {
                                Slider(value: $settings.white_balance, in: 1...3,step: 1)
                                Header3(text: "White Balance: \(settings.white_balanceDesc)")
                            }.padding(.top,0).padding(.leading,20).padding(.trailing,20)
                            
                            
                        }
                        
                    }
                    
                    NavigationLink(destination: PatternView(), isActive: $startMeasurement)
                    {EmptyView()}.navigationBarHidden(true)
                    
                    
                    Spacer()
                    
                    CustomButton(text: "Begin Measurement") {
                        print(self.selectedOption1)
                        if self.selectedOption1 == measureAmbient.continuous.description {
                            settings.ambient = measureAmbient.continuous
                        }
                        if self.selectedOption1 == measureAmbient.beginning.description {
                            settings.ambient = measureAmbient.beginning
                        }
                        
                        if self.selectedOption1 == measureAmbient.none.description {
                            settings.ambient = measureAmbient.none
                        }
                        
                        if self.selectedOption2 == fileFormat.PNG.description{
                            settings.fileformat = fileFormat.PNG
                        }
                        
                        if self.selectedOption2 == fileFormat.JPG.description{
                            settings.fileformat = fileFormat.JPG
                        }
                        
                        if self.selectedOption2 == fileFormat.RAW.description{
                            settings.fileformat = fileFormat.RAW
                        }
                        
                        if let curDuration = Double(self.duration){
                            
                            if curDuration > settings.maxExposureDuration{
                                settings.shutter_speed = settings.maxExposureDuration
                            }
                            
                            if curDuration < settings.minExposureDuration{
                                settings.shutter_speed = settings.minExposureDuration
                            }
                            
                        }
                        else {
                            settings.shutter_speed = settings.minExposureDuration
                        }
                        
                        settings.SaveCommonData()
                        
                        self.showProgreeView = true
                        
                        
                        //self.delayButton()
                        
                        //self.startMeasurement = true
                        // self.presentationMode.wrappedValue.dismiss()
                    }.padding(.bottom,40)
                    
                    
                    
                    
                    
                }   // VSTACK
                
                
                VStack {
                    
                    Spacer()
                    
                    if self.showProgreeView{
                        //ProgressView().scaleEffect(x: 2, y:2, anchor: .center)
                        ProgressView("Wait " + String(format: "%.0f", self.timerCounter) ,value: timerCounter, total: 10).onReceive(timer) { _ in
                            if timerCounter < 10 {
                                timerCounter += 1
                            }
                            else {
                                self.showProgreeView = false
                                self.startMeasurement = true
                                self.timerCounter = 1
                                
                            }
                            
                        }.padding(.leading,20).padding(.trailing,20)
                    }
                    
                    Spacer()
                    
                }.padding(.top,0)
                
                
            }//zStack
            
        }.navigationBarHidden(false)
            .statusBarHidden(false)
        
        
    }
    
    
    private func delayButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0){
            self.startMeasurement = true
        }
    }
    
}


struct AddPatternView_Previews: PreviewProvider {
    static var previews: some View {
        AddPatternView()
    }
}

