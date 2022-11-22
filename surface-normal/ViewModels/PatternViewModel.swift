//
//  PatternViewModel.swift
//  surface-normal
//
//  Created by Algrthm on 17/11/22.
//

//import Foundation
import SwiftUI
import CoreImage

class PatternViewModel: ObservableObject {
    
    
    @Published var showProgressView = true
  
    
    var curDotX: Int = 0
    var curDotY: Int = 0
    
    var isBlackScreen = false
    
    @Published var dotSize: CGFloat = 0.0
    
    var screenWidth: Double = 0.0
    var screenHeight: Double = 0.0
    
    @Published var randomx: Double = 1000.0
    @Published var randomy: Double = 1000.0
    
    @Published var didFinish: Bool = false
    var onlyFirstOneBlack: Bool = false
    
    var patternTimer: Timer = Timer()
    
    var curPattern = 1
    var numberOfPhotos = 1
    var photoInterval = 1
    
    var photoCounter = 1
    
    
    @Published var error: Error?

    private let CameraManager = CaptureModel.shared
    
   // private let cameraManager = CameraManager.shared
   // private let frameManager = FrameManager.shared
    
   // @Published var frame: CGImage?
   // private let context = CIContext()
    
    
    var currentAmbient: measureAmbient = measureAmbient.none
    
    
    init()
    {
        
        dotSize = CGFloat(Common.shared.currrentSetting.dot_radius)
    
        self.numberOfPhotos = Common.shared.currrentSetting.photos_number
        self.photoInterval = Common.shared.currrentSetting.photo_interval
        
        self.currentAmbient = Common.shared.currrentSetting.ambient
        
        //Get Screen Size
        let screenSize: CGRect = UIScreen.main.bounds
        
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        
        let currentDuration = Common.shared.currrentSetting.shutterSpeed
        
        CameraManager.set(exposure: .max, duration: currentDuration)
        CameraManager.setWB(wb: Common.shared.currrentSetting.white_balance)
        //CameraManager.startRunningCaptureSession()
        
       // setupSubscriptions()
               
        startPatterns()
     
    }
    /*
    func setupSubscriptions() {
      // swiftlint:disable:next array_init
      cameraManager.$error
        .receive(on: RunLoop.main)
        .map { $0 }
        .assign(to: &$error)

      frameManager.$current
        .receive(on: RunLoop.main)
        .compactMap { buffer in
          guard let image = CGImage.create(from: buffer) else {
              return (self.drawMyImage())
             
              
          }

          var ciImage = CIImage(cgImage: image)


          return self.context.createCGImage(ciImage, from: ciImage.extent)
        }
        .assign(to: &$frame)
    }
    */
    
    func startPatterns()
    {
       
        if self.currentAmbient == measureAmbient.beginning {
            self.onlyFirstOneBlack = true
        }
        
        if self.currentAmbient == measureAmbient.none{
            self.updateDotPosition()
        }
        
        //get RandomPoints
        
      
        //let maxposx: CGFloat = 200
        //let maxpoxy: CGFloat = 290
        
        
        
        
        //self.randomx = -195.0
        //self.randomy = 1.0
        
        self.patternTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (Timer) -> Void in
            DispatchQueue.main.async {
                //self.randomx += 1.0
                //self.randomy += 1.0
                
                if self.curPattern > self.numberOfPhotos {
                    self.StopPatterns()
                    return
                }
                
                if self.photoCounter >= self.photoInterval {
                    
                    self.saveImage()
                    self.updateDotPosition()
                    self.photoCounter = 0
                    self.curPattern += 1
                    
                }
                
                self.photoCounter += 1
                
                
               
              
                
                // If it is Beguining
                
                if self.onlyFirstOneBlack{
                    self.onlyFirstOneBlack = false
                    
                    //dissapear the dots
                    self.randomx = 1000
                    self.randomy = 1000
                    
                }
                
                
                if self.currentAmbient == measureAmbient.continuous {
                    
                    self.isBlackScreen = !self.isBlackScreen
                    
                    if self.isBlackScreen{
                        
                        //dissapear the dots
                        self.randomx = 1000
                        self.randomy = 1000
                        
                    }
                    
                    
                }
                
             
              
            }
            
        })
        
        
     
        
    }
    
    func updateDotPosition(){
        
        
        let dotHalf = CGFloat(self.dotSize)
        let maxposx = self.screenWidth - dotHalf
        let maxposy = self.screenHeight - dotHalf
        
        
        self.randomx = CGFloat.random(in: dotHalf..<maxposx)
        self.randomy = CGFloat.random(in: dotHalf..<maxposy)
        
        self.randomx = self.randomx - (maxposx / 2)
        self.randomy = self.randomy - (maxposy / 2)
       
        
        
    }
    
    
    
    func StopPatterns()
    {
        self.randomx = 1000
        self.randomy = 1000
        
        if (patternTimer.isValid) {
            patternTimer.invalidate()
        }
        self.didFinish = true
        self.photoInterval = 1
        self.photoCounter = 1
        
    }
    
    func viewWillDissapear() {
        self.StopPatterns()
        self.CameraManager.stopRunningCaptureSession()
    }
    
    func goodBytesPerRow(_ width: Int) -> Int {
        return (((width * 4) + 15) / 16) * 16
    }

    func drawMyImage() -> CGImage? {
        let bounds = CGRect(x: 0, y:0, width: 200, height: 200)
        let intWidth = Int(ceil(bounds.width))
        let intHeight = Int(ceil(bounds.height))
        let bitmapContext = CGContext(data: nil,
                                      width: intWidth, height: intHeight,
                                      bitsPerComponent: 8,
                                      bytesPerRow: goodBytesPerRow(intWidth),
                                      space: CGColorSpace(name: CGColorSpace.sRGB)!,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)

        if let cgContext = bitmapContext {
            cgContext.saveGState()
            cgContext.setFillColor(gray: 0, alpha: 1.0)
            cgContext.fill(bounds)

        

            cgContext.restoreGState()

            return cgContext.makeImage()
        }

        return nil
    }

     /*
    func saveImage() ->Void{
        
        if let image = self.frame {
            
           let img = UIImage(cgImage: image)
            
           let curUrl =  saveLocalImage(image: img)
            print ("Image saved")
        }
        
        
    }
    */
    
    
    func saveImage()
    {
        self.CameraManager.startRunningCaptureSession()
        //CameraManager.setWB(wb: Common.shared.currrentSetting.white_balance)
        self.CameraManager.capturedImage.map { captureImage in
            
            let imageName =  "img-\(self.curPattern).jpg"
            print("Getting photo")
            saveLocalImage(image: captureImage, name: imageName)
            
            
        }
        
        
        
    }
                                              
}
