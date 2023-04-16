//
//  Results.swift
//  Hackathon
//
//  Created by Hadi DEBS on 4/16/23.
//

import Foundation
import SwiftUI

public struct ResultView: View {
    
    public var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                Image("Ellipse")
                //                .background(Color.red)
                    .padding(.top, geometry.size.height * 0.2)
                
                
                
                Text("You drove 25 miles, emitting 8000 grams of CO2")
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .frame(width: 350)
                    .padding(.bottom,geometry.size.height * 0.9 )
//                    .background(Color.red)
                
                    
            }
            
        }
        
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView().previewDevice("iPhone 14 Pro Max")
    }
}
