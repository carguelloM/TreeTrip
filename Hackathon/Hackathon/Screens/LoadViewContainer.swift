//
//  LoadViewContainer.swift
//  Hackathon
//
//  Created by Hadi DEBS on 4/16/23.
//

import Foundation
import SwiftUI

public struct LoadViewContainer: View {
    @ObservedObject var showScreen: screenView = screenView.shared
    let name: String
    let text: String
    
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
    
    
    public var body: some View {
        ZStack {
          
//            PushGps()
          
            
        }
    }
}

struct LoadViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        LoadViewContainer(name: "treeGif", text: "Trip in progress...").previewDevice("iPhone 14 pro Max")
    }
}
