//
//  ImageUtils.swift
//  surface-normal
//
//  Created by Algrthm on 21/11/22.
//

import Foundation
import UIKit

func saveLocalImage(image: UIImage, name: String)-> URL{
    var filename: URL = URL(fileURLWithPath: "")
    
    if let data = image.jpegData(compressionQuality: 0.8) {
            filename = getDocumentsDirectory().appendingPathComponent(name)
           try? data.write(to: filename)
       }
    
    return filename
}


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

