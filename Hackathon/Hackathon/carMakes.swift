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
    var selectedCar: String = ""
}

class carModelObj: ObservableObject{
    static let shared = carModelObj()
    @Published var carModelArray: [String] = []
    @Published var selectedModel: String = ""
}

class carYear: ObservableObject{
    static let shared = carYear()
    @Published var sselectedYear: String = ""
}

class screenView: ObservableObject{
    static let shared = screenView()
    @Published var showHomeScreen: Bool = true
    @Published var showLoadingScreen: Bool = false
    @Published var showResultScreen: Bool = false
}

class bottomSheetView: ObservableObject{
    static let shared = bottomSheetView()
    @Published var showBottomSheet: Bool = false
}


