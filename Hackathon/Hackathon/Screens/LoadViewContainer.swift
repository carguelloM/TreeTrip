//
//  LoadViewContainer.swift
//  Hackathon
//
//  Created by Hadi DEBS on 4/16/23.
//

import Foundation
import SwiftUI

public struct LoadViewContainer: View {
    
    let name: String
    let text: String
    
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
    
    
    public var body: some View {
        ZStack {
            
            
            LoadingView(name: name)
                .padding(.top, 250)
            
            
            Text(text)
                .font(.system(size: 36, weight: .bold, design: .default))
                .foregroundColor(.black)
                .padding(.bottom, 650)
            
            PushGps()
            
        }
    }
}

struct LoadViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        LoadViewContainer(name: "treeGif", text: "Trip in progress...").previewDevice("iPhone 14 pro Max")
    }
}
