//
//  Home.swift
//  Hackathon
//
//  Created by Hadi DEBS on 4/15/23.
//

import SwiftUI
import Foundation

// FOR car Make => carMake.carMakesArray
// FOR car model => carModel.carModelArray

let _backGroundColor = Color(red: 248/255, green: 248/255, blue: 248/255)
let _borderGreen =  Color(red: 0/255, green: 188/255, blue: 87/255)
let _shadowGreen = Color(red: 7/255, green: 149/255, blue: 81/255)
let _buttonColor = Color(red: 73/255, green: 211/255, blue: 148/255)


struct HomeView: View{

    

//   @State  var carMakes: [String] = []
    
    @State var makeIndex: Int = 0
    @ObservedObject var carMake: carMakeObj = carMakeObj.shared
    @ObservedObject var carModel: carModelObj = carModelObj.shared

    
    
    
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
//                    Boxes(customStrings: ["Select"] + (1...29).map { "String \($0)" }, content: "Make", geometry: geometry)
                    Boxes(selection: makeIndex,customStrings: ["Select"] + carMake.carMakesArray, content: "Make", geometry: geometry)
                       
                    Boxes1(customStrings: ["Select"] + (1...29).map { "String \($0)" }, content: "Model", geometry: geometry)
                    Boxes2(content: "Year",geometry: geometry)
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
        .onAppear{
            getMakes { (makeDisplays, error) in
                if let error = error {
                    print("Error decoding JSON: \(error.localizedDescription)")
                } else {
                    carMake.carMakesArray = makeDisplays!
//                    print(carMake.carMakesArray)
                    
                    
                    
                }
                
                 //TODO
                
//                print(selection)
                
                
                
            }
        }
        
    }
    
    
}

// MARK: - Boxes0

public struct Boxes: View{
    @State public var selection: Int = 0
    let customStrings: [String]
    var content: String
    var geometry: GeometryProxy
    
    @ObservedObject var carMake: carMakeObj = carMakeObj.shared
    @ObservedObject var carModel: carModelObj = carModelObj.shared
    
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
  
            HStack{
                ZStack {
                    
                    Picker(selection: $selection, label: Text(customStrings[selection])) {
                        ForEach(customStrings.indices, id: \.self) { index in
                            Text(customStrings[index])
                                .tag(index)
                            
                        }
                        
                    }
                    .fixedSize()
                    .frame(width: 90)
                    .padding(9)
                    .padding(.trailing, geometry.size.width * 0.58 )
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.green, lineWidth: 4))
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.white))
                    .cornerRadius(14)
                    .shadow(color: Color.green.opacity(0.25), radius: 10, x: 0, y: 10)
                    .onReceive([self.selection].publisher.first()) { (value) in
            
                        if(carMake.carMakesArray.count != 0 && value != 0)
                        {
                            getModels(from: carMake.carMakesArray[value-1]) { (modelDisplays, error) in
                                if let error = error {
                                    print("Error decoding JSON: \(error.localizedDescription)")
                                } else {
                                    carModel.carModelArray = modelDisplays!}
 
                            }
                        }

                      }

                }
                Spacer()
            }
            
        }
        .padding(.leading,  geometry.size.width * 0.08)
        
    }
    
}



//public struct Boxes: View {
//    @State public var selection: Int = 0
//    let customStrings: [String]
//    var content: String
//    var geometry: GeometryProxy
//
//    @ObservedObject var carMake: carMakeObj = carMakeObj.shared
//    @ObservedObject var carModel: carModelObj = carModelObj.shared
//
//    public var body: some View {
//        VStack {
//            HStack {
//                Text(content)
//                    .font(.system(size: 20, weight: .medium, design: .default))
//                    .opacity(0.75)
//                    .padding(.trailing, geometry.size.width * 0.65)
//                Spacer()
//            }
//
//            HStack {
//                ZStack {
//                    Picker(selection: $selection, label: EmptyView()) {
//                        ForEach(customStrings.indices, id: \.self) { index in
//                            Text(customStrings[index])
//                                .tag(index)
//                        }
//                    }
//                    .fixedSize()
//                    .padding(9)
//                    .padding(.trailing, geometry.size.width * 0.58)
//                    .background(
//                        RoundedRectangle(cornerRadius: 14)
//                            .stroke(Color.green, lineWidth: 4))
//                    .background(
//                        RoundedRectangle(cornerRadius: 14)
//                            .fill(Color.white))
//                    .cornerRadius(14)
//                    .shadow(color: Color.green.opacity(0.25), radius: 10, x: 0, y: 10)
//                    .onReceive([self.selection].publisher.first()) { (value) in
//                        print(value)
//                        if carMake.carMakesArray.count != 0 && value != 0 {
//                            print(carMake.carMakesArray[value - 1])
//                        }
//                    }
//                    
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        Text(customStrings[selection])
//                            .padding(.horizontal, 10)
//                    }
//                    .frame(width: 90, height: 30)
//                    .background(
//                        RoundedRectangle(cornerRadius: 14)
//                            .stroke(Color.green, lineWidth: 4))
//                    .background(
//                        RoundedRectangle(cornerRadius: 14)
//                            .fill(Color.white))
//                    .cornerRadius(14)
//                }
//                Spacer()
//            }
//        }
//        .padding(.leading, geometry.size.width * 0.08)
//    }
//}








// MARK: - Boxes1

public struct Boxes1: View{
    @State public var selection: Int = 0
    let customStrings: [String]
    var content: String
    var geometry: GeometryProxy
    
    @ObservedObject var carMake: carMakeObj = carMakeObj.shared
    @ObservedObject var carModel: carModelObj = carModelObj.shared
    
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
  
            HStack{
                ZStack {
                    
                    Picker(selection: $selection, label: Text(customStrings[selection])) {
                        ForEach(customStrings.indices, id: \.self) { index in
                            Text(customStrings[index])
                                .tag(index)
                            
                        }
                        
                    }
                    .fixedSize()
                    .frame(width: 90)
                    .padding(9)
                    .padding(.trailing, geometry.size.width * 0.58 )
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.green, lineWidth: 4))
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.white))
                    .cornerRadius(14)
                    .shadow(color: Color.green.opacity(0.25), radius: 10, x: 0, y: 10)
                    

                }
                Spacer()
            }
            
        }
        .padding(.leading,  geometry.size.width * 0.08)
        
    }
    
}

// MARK: - Boxes2

public struct Boxes2: View {
    @State public var selection: Int = 0
    let years: [String] = (2000...2023).map { String($0) }
    var content: String
    var geometry: GeometryProxy

    @ObservedObject var carMake: carMakeObj = carMakeObj.shared
    @ObservedObject var carModel: carModelObj = carModelObj.shared

    public var body: some View {
        VStack {
            HStack {
                Text(content)
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .opacity(0.75)
                    .padding(.trailing, geometry.size.width * 0.65)
                Spacer()
            }

            HStack {
                ZStack {
                    Picker(selection: $selection, label: Text(years[selection])) {
                        ForEach(years.indices, id: \.self) { index in
                            Text(years[index])
                                .tag(index)
                        }
                    }
                    .fixedSize()
                    .frame(width: 90)
                    .padding(9)
                    .padding(.trailing, geometry.size.width * 0.58 )
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.green, lineWidth: 4))
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.white))
                    .cornerRadius(14)
                    .shadow(color: Color.green.opacity(0.25), radius: 10, x: 0, y: 10)
                    .onReceive([self.selection].publisher.first()) { (value) in
                        print(value)
                        print(years[value])
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
        HomeView(makeIndex: 0).previewDevice("iPhone 14 pro Max")
            .background(_backGroundColor)
        
    }
}




