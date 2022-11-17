//
//  ResultError.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import Foundation
class ResultData: ObservableObject {
 
    init() {
        
    }
    
    
    enum ResultError: Error, LocalizedError, Identifiable {
        
        case dataerror
        case unknownError
        
        
        case failedUpload
        case datafailedUpload
        case encodeJasonError
       
        case noImageSelected
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            
            switch self {
                
            case .dataerror:
                return NSLocalizedString("Data Error", comment: "")
                
            case .unknownError:
                return NSLocalizedString("Unknown Error", comment: "")
                
                
            case .failedUpload:
                return "Unable to upload image to server"
                
            case .datafailedUpload:
                return "Unable to upload haptic data to server"
                
            case .encodeJasonError:
                return "Error encoding data to Json"
                
            case .noImageSelected:
                return "Image not selected"
                
            }
                
        }
        
    }
}
