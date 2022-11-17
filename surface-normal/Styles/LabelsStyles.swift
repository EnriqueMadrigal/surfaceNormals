//
//  LabelsStyles.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import Foundation
import SwiftUI

struct Header1: View {
    var text: String
    var color: Color = Color.black
    var size: CGFloat = 22
    
    var body: some View {
        
        Text(self.text)
            .font(.custom("Helvetica", size: size))
            .foregroundColor(self.color)
            .fontWeight(.bold)
    }
    
}

struct Header2: View {
    var text: String
    var color: Color = Color.black
    var size: CGFloat = 18
    
    var body: some View {
        
        Text(self.text)
            .font(.custom("Helvetica", size: size))
            .foregroundColor(self.color)
            .fontWeight(.heavy)
    }
    
}

struct Header3: View {
    var text: String
    var color: Color = Color.black
    var size: CGFloat = 14
    
    var body: some View {
        
        Text(self.text)
            .font(.custom("Helvetica", size: size))
            .foregroundColor(self.color)
            .fontWeight(.heavy)
    }
    
}

