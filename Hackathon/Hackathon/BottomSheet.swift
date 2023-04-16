//
//  BottomSheet.swift
//  Hackathon
//
//  Created by Hadi DEBS on 4/16/23.
//

import Foundation
import SwiftUI

public struct BottomSheet: View{
    @ObservedObject var showSheet: bottomSheetView = bottomSheetView.shared
    public var body: some View{
        GeometryReader { geometry in
            ZStack {
                Image("paySheet")
                    .resizable()
                    .frame(width: 470, height: 620)
//                    .padding(.top, geometry.size.height * 0.3)
//                .padding(.leading, 40)
                
                Button{
                    showSheet.showBottomSheet = false
                }label: {
                    Text("hello")
                        .font(.system(size: 50))
                        
                        .padding(.bottom, geometry.size.height * 0.65)
                        .padding(.leading, geometry.size.height * 0.5)
//                        .background(Color.red)
                        .opacity(0.0)
                    Spacer()

                }
            }
            Spacer()
        }
//            .background(Color.red)

    }
}

struct BottomSheet_preview: PreviewProvider {
    static var previews: some View {
        BottomSheet().previewDevice("iPhone 14 pro Max")
    }
}
