//
//  CameraCapture.swift
//  surface-normal
//
//  Created by Algrthm on 21/11/22.
//

import Foundation
import AVFoundation
import UIKit

enum Esposure {
        case min, normal, max
        
        func value(device: AVCaptureDevice) -> Float {
            switch self {
            case .min:
                return device.activeFormat.minISO
            case .normal:
                return AVCaptureDevice.currentISO
            case .max:
                return device.activeFormat.maxISO
            }
        }
    }



class CaptureModel: NSObject, ObservableObject {
    
    let kExposureDurationPower: Float64 = 5.0
    let kExposureMinDuration: Float64 = 1.0 / 1000
    
    
    let captureSession = AVCaptureSession()
    let photoOutput = AVCapturePhotoOutput()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    
    var currentCamera: AVCaptureDevice?
    //@Published var capturedImage: UIImage?

    @Published var rawData: Data?
    
    enum Status {
      case unconfigured
      case configured
      case unauthorized
      case failed
    }
    private var status = Status.unconfigured
    
    static let shared = CaptureModel()
    
    @Published var error: CameraError?
    
    var withRawFormat: Bool = false
    
    override init() {
        
        super.init()
        setupCaptureSession()
        setupDevices()
        
        
        setupInputOutput()
    }

    
    private func set(error: CameraError?) {
      DispatchQueue.main.async {
        self.error = error
      }
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }//setupCaptureSession

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

        currentCamera = frontCamera

    }//setupDevices

    func setupInputOutput() {

        do {
            //you only get here if there is a camera ( ! ok )
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            
            if captureSession.canAddInput(captureDeviceInput) {
                captureSession.addInput(captureDeviceInput)
            }
            else {
                throw CameraError.cannotAddInput
            }
            
            
            
            if captureSession.canAddOutput(photoOutput)
            {
                captureSession.addOutput(photoOutput)
            }
           else
            {
               throw CameraError.cannotAddOutput
            }
            
            
            /*
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: {(success, error) in
                
                //print("Image saved")
                
            })
            */
           
            photoOutput.isAppleProRAWEnabled = photoOutput.isAppleProRAWSupported
            
            
            captureSession.commitConfiguration()

        } catch {
            print("Error creating AVCaptureDeviceInput:", error)
            set(error: .cameraUnavailable)
        }

    }//setupInputOutput

    
   
    
    
    func startRunningCaptureSession() {
        
        //let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        
        let settings = AVCapturePhotoSettings()
        captureSession.startRunning()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }//startRunningCaptureSession

    
    func startRunningCaptureSessionRAW() {
        
        
            let query = photoOutput.isAppleProRAWEnabled ? {AVCapturePhotoOutput.isAppleProRAWPixelFormat($0)} : {AVCapturePhotoOutput.isBayerRAWPixelFormat($0)}
            
            guard let rawFormat = photoOutput.availableRawPhotoPixelFormatTypes.first(where: query) else {
                fatalError("No RAW format found.")
            }
            
            let processedFormat = [AVVideoCodecKey: AVVideoCodecType.hevc]
            let photoSettings = AVCapturePhotoSettings(rawPixelFormatType: rawFormat,processedFormat: processedFormat)
            
           // let delegate = RAWCap
            
            captureSession.startRunning()
            photoOutput.capturePhoto(with: photoSettings, delegate: self)
            
            
     
        
        //let settings = AVCapturePhotoSettings()

       
    }//startRunningCaptureSession
    
    
    func stopRunningCaptureSession() {
        captureSession.stopRunning()
    }//startRunningCaptureSession
    
    
    func set(exposure: Float, duration: Double) {
      
        //guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard let device = currentCamera else { return }
      
        // KEEp this for a slider
        /*
        let p = pow(Float64(duration),kExposureDurationPower)
        let minDurationSeconds =   max(CMTimeGetSeconds(device.activeFormat.minExposureDuration), kExposureMinDuration)
        let maxDurationSeconds = CMTimeGetSeconds(device.activeFormat.maxExposureDuration)
        let newDurationSeconds = p * (maxDurationSeconds - minDurationSeconds) + minDurationSeconds
        */
        let newDurationSeconds = Float64(duration)
        
           if device.isExposureModeSupported(.custom) {
               do{
                   try device.lockForConfiguration()
                   device.setExposureModeCustom(duration: CMTimeMakeWithSeconds(newDurationSeconds, preferredTimescale: 1000*1000*1000), iso: exposure) { (_) in
                       print("Done Esposure")
                   }
                   device.unlockForConfiguration()
               }
               catch{
                   print("ERROR: \(String(describing: error.localizedDescription))")
               }
           }
       }
    
    
    func setWB(wb: whiteBalance){
        
        var mode = AVCaptureDevice.WhiteBalanceMode.locked
        
        if wb == whiteBalance.locked{
            mode = AVCaptureDevice.WhiteBalanceMode.locked
        }

        if wb == whiteBalance.autoWhiteBalance{
            mode = AVCaptureDevice.WhiteBalanceMode.autoWhiteBalance
        }

        if wb == whiteBalance.continuosWhiteBalance{
            mode = AVCaptureDevice.WhiteBalanceMode.continuousAutoWhiteBalance
        }

        
        
        //guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard let device = currentCamera else { return }
        if device.isWhiteBalanceModeSupported(mode) {
            do{
                try device.lockForConfiguration()
                device.whiteBalanceMode = mode
                    print("Done WB")
                
                device.unlockForConfiguration()
            }
            catch{
                print("ERROR: \(String(describing: error.localizedDescription))")
            }
        }
        
        
        
        
    }
    
    
}

extension CaptureModel: AVCapturePhotoCaptureDelegate {
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
       
      
        
        let currentFormat = Common.shared.currrentSetting.formatFile
        
        /*
        guard let data = photo.fileDataRepresentation(),
             let image = UIImage(data: data)
                
                else {
            return
        }
        */
        
        if currentFormat == fileFormat.RAW {
       
            if photo.isRawPhoto {
                self.rawData = photo.fileDataRepresentation()
              
            }
           
            
        }
        
       
        else {
            if let data = photo.fileDataRepresentation()
            {
                //capturedImage = UIImage(data: data)
                self.rawData = data
               
            }
            
        }
     
        
        
        
    }
    /*
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        AudioServicesDisposeSystemSoundID(1108)
    }
    
    */
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
           // if isSilentModeOn {
               // print("[Camera]: Silent sound activated")
                AudioServicesDisposeSystemSoundID(1108)
            //}
            
        }
        func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
            //if isSilentModeOn {
                AudioServicesDisposeSystemSoundID(1108)
            //}
        }
    
    
    
    private func checkPermissions() {
      switch AVCaptureDevice.authorizationStatus(for: .video) {
      case .notDetermined:
        //sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: .video) { authorized in
          if !authorized {
            self.status = .unauthorized
            self.set(error: .deniedAuthorization)
          }
          //self.sessionQueue.resume()
        }
      case .restricted:
        status = .unauthorized
        set(error: .restrictedAuthorization)
      case .denied:
        status = .unauthorized
        set(error: .deniedAuthorization)
      case .authorized:
        break
      @unknown default:
        status = .unauthorized
        set(error: .unknownAuthorization)
      }
    }
    
    
}

