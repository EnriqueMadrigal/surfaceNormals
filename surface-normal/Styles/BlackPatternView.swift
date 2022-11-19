//
//  BlackPatternView.swift
//  surface-normal
//
//  Created by Algrthm on 17/11/22.
//

import Foundation
import SwiftUI

struct BlackPatternView : View{
    
    var dotx: CGFloat
    var doty: CGFloat
    var maxWidth: CGFloat
    var maxHeight: CGFloat
    
        
    var body: some View {
        VStack {
            
            Circle()
                .stroke(lineWidth: 1)
                .foregroundColor(.white)
                .position(x: dotx, y: doty)
        }.frame(width: maxWidth,height: maxHeight)
    }
                
}

