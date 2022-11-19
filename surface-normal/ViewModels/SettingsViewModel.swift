//
//  SettingsViewModel.swift
//  surface-normal
//
//  Created by Algrthm on 16/11/22.
//

import Foundation


class SettingsViewModel: ObservableObject {
    

    
    
    @Published var name: String
    @Published var desc: String
    
    @Published var dot_radius: Double
    @Published var photos_number: Double
    @Published var photo_interval: Double
    @Published var aperture: Double
    
    @Published var ambient: measureAmbient = measureAmbient.none
    
    @Published var white_balanceDesc: String = ""
    
    @Published var shutterDesc: String = ""
    
    
    
    @Published var shutter_speed: Double = 0.0 {
        didSet{

            switch shutter_speed {
            case 1.0: self.shutterDesc = shutterSpeed.onethird.description
            case 2.0: self.shutterDesc = shutterSpeed.oneeight.description
            case 3.0: self.shutterDesc = shutterSpeed.onethirty.description
            case 4.0: self.shutterDesc = shutterSpeed.one125.description
            case 5.0: self.shutterDesc = shutterSpeed.one500.description
            case 6.0: self.shutterDesc = shutterSpeed.one1000.description
            case 7.0: self.shutterDesc = shutterSpeed.one2000.description
            case 8.0: self.shutterDesc = shutterSpeed.one4000.description
            case 9.0: self.shutterDesc = shutterSpeed.one8000.description
            default:
                self.shutterDesc = ""
            }
            
            
        }
    }
    
    @Published var white_balance: Double {
        didSet {
            
            switch white_balance {
            case 1.0: self.white_balanceDesc = whiteBalance.candlelight.description
            case 2.0: self.white_balanceDesc = whiteBalance.tungstenbulb.description
            case 3.0: self.white_balanceDesc = whiteBalance.sunrise.description
            case 4.0: self.white_balanceDesc = whiteBalance.flourescent.description
            case 5.0: self.white_balanceDesc = whiteBalance.flash.description
            case 6.0: self.white_balanceDesc = whiteBalance.daylight.description
            case 7.0: self.white_balanceDesc = whiteBalance.moderately.description
            case 8.0: self.white_balanceDesc =  whiteBalance.shade.description
            default:
                self.shutterDesc = ""
                
                
            }
            
        }
        
        
    }
    
    
    
    
    init () {
        
        self.name = ""
        self.desc = ""
        self.dot_radius = 1.0
        self.photos_number = 1.0
        self.photo_interval = 1.0
        self.aperture = 0.0
        //self.shutter_speed = 0.0
        self.white_balance = 1
        
       
    }
    
    func SaveCommonData()
    {
        
        var currentSettings = InputSettings(id: 0, name: "", desc: "", ambient: measureAmbient.none, dot_radius: 0, photos_number: 0, photo_interval: 0, aperture: 0.0, shutter_speed: shutterSpeed.one8000, white_balance: whiteBalance.daylight)
        
        currentSettings.dot_radius = Int(self.dot_radius)
        currentSettings.photos_number = Int(self.photos_number)
        currentSettings.photo_interval = Int(self.photo_interval)
        
        currentSettings.ambient = self.ambient
        
        Common.shared.currrentSetting = currentSettings
        
    }
    
    
    
    
}
