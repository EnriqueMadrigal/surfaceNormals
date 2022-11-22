//
//  Common.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import Foundation


enum measureAmbient : CustomStringConvertible{
    case none
    case beginning
    case continuous
    
    
    var description: String {
    
        switch self {
        case .none: return "None"
        case .beginning: return "Beginning"
        case .continuous: return "Continuous"
        }
        
    }
    
}


enum whiteBalance : CustomStringConvertible{
    case locked
    case autoWhiteBalance
    case continuosWhiteBalance
    
    
    var description: String {
    
        switch self {
        case .locked: return "Locked WB"
        case .autoWhiteBalance: return "Auto WB"
        case .continuosWhiteBalance: return "Continuos WB"
            
        }
        
    }
    
}


enum shutterSpeed : CustomStringConvertible{
    case onethird
    case oneeight
    case onethirty
    case one125
    case one500
    case one1000
    case one2000
    case one4000
    case one8000
    
    
    var description: String {
    
        switch self {
        case .onethird: return "1/3"
        case .oneeight: return "1/8"
        case .onethirty: return "1/30"
        case .one125: return "1/125"
        case .one500: return "1/500"
        case .one1000: return "1/1000"
        case .one2000: return "1/2000"
        case .one4000: return "1/4000"
        case .one8000: return "1/8000"
            
        }
        
    }
    
}




class Common {
  
    public var currrentSetting: InputSettings
    
    init() {
        
        //Default settings
        
        self.currrentSetting = InputSettings(id: 0, name: "", desc: "", ambient: measureAmbient.none, dot_radius: 0, photos_number: 0, photo_interval: 0, aperture: 0.0, shutter_speed: shutterSpeed.one8000, white_balance: whiteBalance.locked, shutterSpeed: 0.0)
        
        
    }
    
    
    
    static let shared = Common()
    
}
