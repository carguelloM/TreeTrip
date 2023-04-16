//
//  carMakes.swift
//  Hackathon
//
//  Created by Cesar Arguello on 4/15/23.
//

import Foundation
import SwiftUI

class carMakeObj: ObservableObject{
    static let shared = carMakeObj()
    @Published  var carMakesArray: [String] = []
}

class carModelObj: ObservableObject{
    static let shared = carModelObj()
    @Published var carModelArray: [String] = []
     @Published var carNum : Int = 0
}

class carYear: ObservableObject{
    static let shared = carYear()
    @Published var year: Int = 0
}


