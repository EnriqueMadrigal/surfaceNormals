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
    var photoInterval: Double = 1.0
    
    var photoCounter:Double = 0.0
    
    var currentFileFormat = fileFormat.PNG
    var description: String = ""
    
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
        let currentIso = Common.shared.currrentSetting.iso
        
        self.currentFileFormat = Common.shared.currrentSetting.formatFile
        self.description = Common.shared.currrentSetting.desc
        if self.description.count == 0 {
            self.description = "img"
        }
     
        
        CameraManager.set(exposure: currentIso, duration: currentDuration)
        CameraManager.setWB(wb: Common.shared.currrentSetting.white_balance)
        //CameraManager.startRunningCaptureSession()
        
       // setupSubscriptions()
        self.photoCounter = 0.0
        
        if self.currentFileFormat == fileFormat.RAW
        {
            self.CameraManager.startRunningCaptureSessionRAW()
        }
        else {
            self.CameraManager.startRunningCaptureSession()
        }
        
        
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
        
        self.patternTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) -> Void in
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
                
                self.photoCounter += 0.1
                
                
               
              
                
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
        
        self.curDotX = Int(self.randomx)
        self.curDotY = Int(self.randomy)
        
   
        
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
        
        
        
       
        //CameraManager.setWB(wb: Common.shared.currrentSetting.white_balance)
    
          
            
        if self.currentFileFormat == fileFormat.RAW
        {
            self.CameraManager.startRunningCaptureSessionRAW()
        }
        else {
            self.CameraManager.startRunningCaptureSession()
        }
         
        
            self.CameraManager.rawData.map { imageData in
                
               
               
                
                var xpos: String = "\(self.curDotX)"
                var ypos: String = "\(self.curDotY)"
                
                
             
                
                if self.randomx == 1000 {
                    xpos = "0"
                }
                
                if self.randomy == 1000 {
                    ypos = "0"
                }
               
                
                let imageName =  self.description + "_" + xpos + "_" + ypos + "-\(self.curPattern)"
                
                if self.currentFileFormat == fileFormat.PNG {
                    if let captureImage = UIImage(data: imageData){
                        DispatchQueue.main.async{
                            ImageUtils.shared.saveLocalImagePNG(image: captureImage, name: imageName)
                        }
                    }
                }
                else if self.currentFileFormat == fileFormat.JPG {
                    if let captureImage = UIImage(data: imageData){
                        DispatchQueue.main.async{
                            ImageUtils.shared.saveLocalImageJPG(image: captureImage, name: imageName)
                        }
                    }
                }
                
                else if self.currentFileFormat == fileFormat.RAW {
                    
                   var filename = ImageUtils.shared.getImagePath()
                    
                        filename = filename.appendingPathComponent(imageName)
                     
                    filename = filename.appendingPathExtension("dng")
                 
                    do {
                     
                       try imageData.write(to: filename)
                    }
                    
                    catch {
                        fatalError("Couldn't write to DNG File to the URL")
                    }
                    
                }
                
                
            }
        
        
        
        
        
        
    }
                                              
}
