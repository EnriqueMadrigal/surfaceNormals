//
//  ButtonsStyles.swift
//  CardClassifier
//
//  Created by Algrthm on 14/11/22.
//

import Foundation
import SwiftUI

public struct SegmentedButton: View {
    
    @Binding var selectedItem: String
    @Binding var isDisabled: Bool
     var items: [String]
    var selected: String = ""
    
    var handler: (() -> Void)
    
    var message: String = ""
    var size: CGFloat = 22
    var color: Color = Color.black
    
    
    public var body: some View {
        
        VStack {
            Picker(self.message, selection: $selectedItem){
                
                ForEach(items, id : \.self){
                    Text($0)
                        .font(.custom("Helvetica", size: size))
                        .foregroundColor(color)
                        .fontWeight(.black)
                        
                }.onAppear{
                    if selected.isEmpty {
                        selectedItem = items[0]
                    }
                    else {
                        selectedItem = selected
                    }
                }
                
                
            }
            .disabled(isDisabled)
            .pickerStyle(.segmented)
            .onChange(of: selectedItem) {  _ in
               handler()
            }
            
        }
        
        
    }
    
}





public struct StartButton: View {
    
    var text: String
    
    public var body: some View {
        
        HStack {
            Text(self.text)
                .foregroundColor(Color.blue)
                .padding(.top,12).padding(.bottom, 12).padding(.leading,20).padding(.trailing,20)
                .font(.custom("Helvetica", size: 18))
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.blue))
        }.cornerRadius(25)
    }
}



public struct StartStopButton: View {
    
    var text: String
    var handler: (() -> Void)
    
    public var body: some View {
        
        Button(action: handler, label: {
            Text(self.text)
                .foregroundColor(Color.blue)
                .padding(.top,12).padding(.bottom, 12).padding(.leading,20).padding(.trailing,20)
                .font(.custom("Helvetica", size: 18))
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.blue))
        }).cornerRadius(25)
    }
}

public struct CustomButton: View {
    
    var text: String
    var color: Color = Color.black
    var background: Color = Color.white
    
    var handler: (() -> Void)
    
    public var body: some View {
        
        Button(action: handler, label: {
            Text(self.text)
                .foregroundColor(self.color)
                .padding(12)
                .font(.custom("Helvetica", size: 16))
                .background(self.background)
                .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(self.color))
        }).cornerRadius(25)
    }
}

public struct AddButton: View {
    
   
    var background: Color = Color.white
    
    var handler: (() -> Void)
    
    public var body: some View {
        
        Button(action: handler, label: {
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 32, height: 32, alignment: .center)
            
        }).cornerRadius(15)
    }
}

public struct EditButton: View {
    
   
    var background: Color = Color.white
    
    var handler: (() -> Void)
    
    public var body: some View {
        
        Button(action: handler, label: {
            Image(systemName: "pencil.circle")
                .resizable()
                .frame(width: 32, height: 32, alignment: .center)
            
        }).cornerRadius(15)
    }
}

public struct ExportButton: View {
    
   
    var background: Color = Color.white
    
    var handler: (() -> Void)
    
    public var body: some View {
        
        Button(action: handler, label: {
            Image(systemName: "square.and.arrow.up.circle")
                .resizable()
                .frame(width: 32, height: 32, alignment: .center)
            
        }).cornerRadius(15)
    }
}


public struct ImportButton: View {
    
   
    var background: Color = Color.white
    
    var handler: (() -> Void)
    
    public var body: some View {
        
        Button(action: handler, label: {
            Image(systemName: "square.and.arrow.down")
                .resizable()
                .frame(width: 32, height: 32, alignment: .center)
            
        })
    }
}

public struct NextButton: View {
    
   
    var background: Color = Color.white
    
    var handler: (() -> Void)
    
    public var body: some View {
        
        Button(action: handler, label: {
            Image(systemName: "chevron.forward.square")
                .resizable()
                .frame(width: 24, height: 24, alignment: .center)
            
        })
    }
}


public struct PlayButton: View {
    
   
    var background: Color = Color.white
    
    var handler: (() -> Void)
    
    public var body: some View {
        
        Button(action: handler, label: {
            Image(systemName: "play.square")
                .resizable()
                .frame(width: 32, height: 32, alignment: .center)
            
        })
    }
}

public struct StopButton: View {
    
   
    var background: Color = Color.white
    
    var handler: (() -> Void)
    
    public var body: some View {
        
        Button(action: handler, label: {
            Image(systemName: "stop.fill")
                .resizable()
                .frame(width: 32, height: 32, alignment: .center)
            
        })
    }
}



public struct BackButton: View {
    
   
    var background: Color = Color.white
    
    var handler: (() -> Void)
    
    public var body: some View {
        HStack{
            
            Button(action: handler, label: {
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
                
            })
            
            Header2(text: "Back").frame(width: 64)
        }.frame(width: 96)
    }
    
}


public struct CameraButton: View {
    
   
    var background: Color = Color.white
    
    var handler: (() -> Void)
    
    public var body: some View {
        HStack{
            
            Button(action: handler, label: {
                Image(systemName: "camera")
                    .resizable()
                    .frame(width: 42, height: 32, alignment: .center)
                
            })
            
            Header3(text: "Camera").frame(width: 64, height: 38)
        }//.frame(width: 120).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
    }
    
}
public struct LibraryButton: View {
    
   
    var background: Color = Color.white
    
    var handler: (() -> Void)
    
    public var body: some View {
        HStack{
            
            Button(action: handler, label: {
                Image(systemName: "photo.on.rectangle.angled")
                    .resizable()
                    .frame(width: 42, height: 32, alignment: .center)
                
            })
            
            Header3(text: "Album").frame(width: 64, height: 38)
        }//.frame(width: 120).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
    }
    
}
