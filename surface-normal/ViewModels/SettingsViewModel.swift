//
//  SettingsViewModel.swift
//  surface-normal
//
//  Created by Algrthm on 16/11/22.
//

import Foundation
import AVFoundation

class SettingsViewModel: ObservableObject {
    

    
    
    @Published var name: String
    @Published var desc: String
    
    @Published var dot_radius: Double
    @Published var photos_number: Double
    @Published var photo_interval: Double
    @Published var aperture: Double
    
    @Published var ambient: measureAmbient = measureAmbient.none
    @Published var fileformat: fileFormat = fileFormat.PNG
    
    @Published var white_balanceDesc: String = ""
    
    @Published var shutterDesc: String = ""
    @Published var minIsoValue: Double
    @Published var maxIsoValue: Double
    @Published var Iso: Double
    
    @Published var minExposureDuration: Double
    @Published var maxExposureDuration: Double
    
    
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    
    
    @Published var shutter_speed: Double = 1.0 {
        didSet{
                /*
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
            */
            
            let curValue = pow(shutter_speed , 1 / 5.0)
            self.shutterDesc = String(format: "%.6f", curValue)
            
        }
    }
    
    @Published var white_balance: Double = 1.0 {
        didSet {
            
            switch white_balance {
            case 1.0: self.white_balanceDesc = whiteBalance.locked.description
            case 2.0: self.white_balanceDesc = whiteBalance.autoWhiteBalance.description
            case 3.0: self.white_balanceDesc = whiteBalance.continuosWhiteBalance.description
          
            default:
                self.white_balanceDesc = ""
                
                
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
        self.white_balance = 1.0
        self.white_balanceDesc = whiteBalance.locked.description
        
        self.minIsoValue = 0.0
        self.maxIsoValue = 0.0
        self.Iso = 0.0
        
        let kExposureMinDuration: Float64 = 1.0 / 1000
        self.minExposureDuration = Double(kExposureMinDuration)
        self.maxExposureDuration = 1.0
        
        self.setupDevices()
       
       
        
        if let currentCamera = frontCamera {
            self.minIsoValue = Double(Esposure.min.value(device: currentCamera)) + 100
            self.maxIsoValue = Double(Esposure.max.value(device: currentCamera))
            self.Iso = self.minIsoValue
       
            let minDurationSeconds = max(CMTimeGetSeconds(currentCamera.activeFormat.minExposureDuration), kExposureMinDuration)
            let maxDurationSeconds = CMTimeGetSeconds(currentCamera.activeFormat.maxExposureDuration)
            
            self.minExposureDuration = Double(minDurationSeconds)
            self.maxExposureDuration = Double(maxDurationSeconds)
            
            print(self.minIsoValue)
            print(self.maxIsoValue)
            
        }
       
    }
    
    
    func setupDevices() {

        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: .video, position: .unspecified)

        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }//if else
        }//for in

       

    }//setupDevices

    
    
    func SaveCommonData()
    {
        
        var currentSettings = InputSettings(id: 0, name: "", desc: "", ambient: measureAmbient.none, dot_radius: 0, photos_number: 0, photo_interval: 0, aperture: 0.0, shutter_speed: shutterSpeed.one8000, white_balance: whiteBalance.locked, iso: 0.0, shutterSpeed: shutter_speed, formatFile: fileFormat.PNG)
        
        currentSettings.dot_radius = Int(self.dot_radius)
        currentSettings.photos_number = Int(self.photos_number)
        currentSettings.photo_interval = self.photo_interval
        
        currentSettings.ambient = self.ambient
        currentSettings.iso = Float(self.Iso)
        currentSettings.desc = self.desc
        currentSettings.formatFile = self.fileformat
        Common.shared.currrentSetting = currentSettings
        
        
    }
    
    
    
    
}
