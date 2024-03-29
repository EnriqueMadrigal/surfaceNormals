//
//  Extensions.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import Foundation
import SwiftUI

extension UIDevice {
    var feedbackSupportLevel: Int? {
        value(forKey: "_feedbackSupportLevel") as? Int
    }
    
}


extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

extension Date {
    func currentTimeMillis() -> Int64 {
        Int64(timeIntervalSince1970 * 1000)
    }
}

extension DispatchQueue {
    static func background(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1": return "iPod Touch 5"
        case "iPod7,1": return "iPod Touch 6"
        case "iPhone3,1","iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1": return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2": return "iPhone 5"
        case "iPhone5,3", "iPhone5,4": return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2": return "iPhone 5s"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3": return "iPhone 7"
        case "iPhone9,2", "iPhone9,4": return "iPhone 7 Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone10,1":  return "iPhone 8"
        case "iPhone10,2":  return "iPhone 8 Plus"
        case "iPhone10,3":  return "iPhone X Global"
        case "iPhone10,4":  return "iPhone 8"
        case "iPhone10,5":  return "iPhone 8 Plus"
        case "iPhone10,6":  return "iPhone X GSM"
        case "iPhone11,2":  return "iPhone XS"
        case "iPhone11,4":  return "iPhone XS Max"
        case "iPhone11,6":  return "iPhone XS Max Global"
        case "iPhone11,8":  return "iPhone XR"
        case "iPhone12,1":  return "iPhone 11"
        case "iPhone12,3":  return "iPhone 11 Pro"
        case "iPhone12,5":  return "iPhone 11 Pro Max"
        case "iPhone12,8":  return "iPhone SE 2nd Gen"
        case "iPhone13,1":  return "iPhone 12 Mini"
        case "iPhone13,2":  return "iPhone 12"
        case "iPhone13,3":  return "iPhone 12 Pro"
        case "iPhone13,4":  return "iPhone 12 Pro Max"
        case "iPhone14,2":  return "iPhone 13 Pro"
        case "iPhone14,3":  return "iPhone 13 Pro Max"
        case "iPhone14,4":  return "iPhone 13 Mini"
        case "iPhone14,5":  return "iPhone 13"
        case "iPhone14,6":  return "iPhone SE 3rd Gen"
        case "iPhone14,7":  return "iPhone 14"
        case "iPhone14,8":  return "iPhone 14 Plus"
        case "iPhone15,2":  return "iPhone 14 Pro"
        case "iPhone15,3":  return "iPhone 14 Pro Max"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3": return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6": return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3": return "iPad Air"
        case "iPad5,3", "iPad5,4": return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7": return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6": return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9": return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8": return "iPad Pro"
        case "AppleTV5,3":  return "Apple TV"
        case "i386", "x86_64":  return "Simulator"
        default:  return identifier
        }
    }
    
}

extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int) {
           assert(red >= 0 && red <= 255, "Invalid red component")
           assert(green >= 0 && green <= 255, "Invalid green component")
           assert(blue >= 0 && blue <= 255, "Invalid blue component")

           self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
       }

       convenience init(rgb: Int) {
           self.init(
               red: (rgb >> 16) & 0xFF,
               green: (rgb >> 8) & 0xFF,
               blue: rgb & 0xFF
           )
       }
    
    
    
    //Custom colors
    
        static let AppGray = UIColor(rgb: 0x707070)
        static let AppGray2 = UIColor(rgb: 0x7B7B7B)
        static let AppGray3 = UIColor(rgb: 0xDCDBDA)
      
    

}
