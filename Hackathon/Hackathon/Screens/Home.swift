//
//  Home.swift
//  Hackathon
//
//  Created by Hadi DEBS on 4/15/23.
//

import SwiftUI

let _backGroundColor = Color(red: 248/255, green: 248/255, blue: 248/255)
let _borderGreen =  Color(red: 0/255, green: 188/255, blue: 87/255)
let _shadowGreen = Color(red: 7/255, green: 149/255, blue: 81/255)
let _buttonColor = Color(red: 73/255, green: 211/255, blue: 148/255)


struct HomeView: View{
    var body: some View{
        
        
        GeometryReader { geometry in
            ZStack{
                
                
                // background image
                Image("Ellipse")
    //                .background(Color.red)
                    .padding(.top, geometry.size.height * 0.2)

                    
                    
                Image("treeImg")
    //                .background(Color.red)
                    .padding(.top, geometry.size.height * 0.38)
                    .padding(.leading, geometry.size.width * 0.21)
                    
                
                VStack {
                    Text("What is your car model?")
                        .font(.system(size: 36, weight: .bold, design: .default))
                        .frame(width: 232)
                        .padding(.top, geometry.size.height * 0.03)
                        .padding(.trailing, geometry.size.width * 0.32)
//                        .background(Color.red)
                    
                    Spacer()
                }
                
                
                
                VStack(spacing: 60){
                    Boxes(content: "Make", geometry: geometry)
                    Boxes(content: "Model", geometry: geometry)
                    Boxes(content: "Year", geometry: geometry)
                }
                .padding(.bottom, geometry.size.height * 0.2)
//                .background(Color.red)
                
                // init button
                ZStack {
                    
                    Button{
                        // TODO
                    }label: {
                        Text("Start trip")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .foregroundColor(Color.white)
                            .padding()
                            .padding(.trailing, geometry.size.width * 0.15)
                            .padding(.leading, geometry.size.width * 0.15)
                            .background(_buttonColor)
                            .cornerRadius(14)
                            .shadow(color: _shadowGreen.opacity(0.25), radius: 10, x: 0, y: 10)
                        
                        
                        
                    }
                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.87)
                    
                }
                
                
            }
        }
    }
    
    
}

// MARK: - Boxes

public struct Boxes: View{
    
    var content: String
    var geometry: GeometryProxy
    
    public var body: some View{
        
        
        VStack{
            HStack {
                Text(content)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .opacity(0.75)
                    .padding(.trailing, geometry.size.width * 0.65)
                //                            .background(Color.red)
                Spacer()
            }
            
            
            HStack {
                Button {
                    // TODO
                } label: {
                    ZStack {
                        HStack {
                            Text("Select")
                                .padding()
                                
                            Image("Arrow")
                                .frame(width: 18, height: 18)
                                .padding(.leading, geometry.size.width * 0.55)
                                .padding(.trailing, geometry.size.width * 0.05)
                            //                                        .background(Color.red)
                            
                            
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(_borderGreen, lineWidth: 4))
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.white))
                        .cornerRadius(14)
                        .shadow(color: _shadowGreen.opacity(0.25), radius: 10, x: 0, y: 10)
                        // Adjust the value to match the arrow image width and padding
                        
                        // Adjust the trailing padding as needed
                    }
                }
                
                
                Spacer()
            }
            
        }
        .padding(.leading,  geometry.size.width * 0.08)
    }
    
}


struct HomeVeiw: PreviewProvider {
    static var previews: some View {
        HomeView().previewDevice("iPhone 14 pro Max")
            .background(_backGroundColor)
        
    }
}


