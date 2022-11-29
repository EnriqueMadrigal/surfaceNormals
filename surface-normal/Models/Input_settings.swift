//
//  input_settings.swift
//  surface-normal
//
//  Created by Algrthm on 16/11/22.
//

import Foundation

struct InputSettings: Identifiable {
    var id: Int64
    var name: String
    var desc: String
    
    var ambient: measureAmbient
   var dot_radius: Int
    var photos_number: Int
    var photo_interval: Double
    var aperture: Double
    var shutter_speed: shutterSpeed
    var white_balance: whiteBalance
 
    var iso: Float
    var shutterSpeed: Double
    var formatFile: fileFormat
    
}
