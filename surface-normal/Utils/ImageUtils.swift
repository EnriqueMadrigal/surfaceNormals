//
//  ImageUtils.swift
//  surface-normal
//
//  Created by Algrthm on 21/11/22.
//

import Foundation
import UIKit

func saveLocalImageJPG(image: UIImage, name: String)-> URL{
    var filename: URL = URL(fileURLWithPath: "")
    filename = getDocumentsDirectory().appendingPathComponent("surface-normal")
    if let data = image.jpegData(compressionQuality: 0.8) {
            filename = filename.appendingPathComponent(name)
           try? data.write(to: filename)
       }
    
    return filename
}


func saveLocalImagePNG(image: UIImage, name: String)-> URL{
    var filename: URL = URL(fileURLWithPath: "")
    filename = getDocumentsDirectory().appendingPathComponent("surface-normal")
    
    if let data = image.pngData() {
        filename = filename.appendingPathComponent(name)
           try? data.write(to: filename)
       }
    
    return filename
}


func CreateSurfaceDirectory() ->Void {
    
    let filemanager = FileManager.default
    let documentsURL = getDocumentsDirectory()
    
    let imagePath =  documentsURL.appendingPathComponent("surface-normal")
    
    
    do {
        try filemanager.createDirectory(atPath: imagePath.path, withIntermediateDirectories: true, attributes: nil)
    }
    
    catch let error as NSError{
        NSLog("Unable to create directory \(error.debugDescription)")
    }
    
}


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func deleteImageFiles()->Void{
    let filemanager = FileManager.default
    
    let documentsURL = getDocumentsDirectory()
    
    let imagePath =  documentsURL.appendingPathComponent("surface-normal")
    
    do {
        let filePaths = try filemanager.contentsOfDirectory(atPath: imagePath.path)
        
        for filePath in filePaths {
            let fileUrl = imagePath.appendingPathComponent(filePath)
            try filemanager.removeItem(at: fileUrl)
            
        }
    }
    
    catch let error as NSError{
        NSLog("Unable to create directory \(error.debugDescription)")
    }
    
    
}
