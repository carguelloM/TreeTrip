//
//  Results.swift
//  Hackathon
//
//  Created by Hadi DEBS on 4/16/23.
//


import Foundation
import SwiftUI

public struct ResultView: View {
    @ObservedObject var showSheet: bottomSheetView = bottomSheetView.shared
    @ObservedObject var distCal: distanceObj = distanceObj.shared
    
    @State private var distance: Int = 0
    @State private var numTrees: Int = 0
    @State private var emissions: Int = 0
    @State private var typeTree: String = "A"
    
    private let buttonColor = Color.green
    private let shadowGreen = Color.green
    
    struct DataModel: Codable {
        let amount_of_trees: Int
        let distance: Float
        let emissions: Float
        let tree : String
       
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image("Ellipse")
                //                .background(Color.red)
                    .padding(.top, geometry.size.height * 0.2)
                
                
//                Text("You drove \(round(distCal.mydist, 2)) miles, emitting \(round(distCal.myEmission, 2)) Kgs of CO2")
                Text("You drove \(String(format: "%.2f", distCal.mydist)) miles, emitting \(String(format: "%.2f", distCal.myEmission)) Kgs of CO2")
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .frame(width: 350)
                    .padding(.bottom,geometry.size.height * 0.9 )
                    .padding(.trailing,geometry.size.width * 0.15 )
                //                    .background(Color.red)
                
                Text("You need to plant \(distCal.numTress) trees to offset your emissions")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .opacity(0.5)
                    .frame(width: 250)
                    .padding(.bottom,geometry.size.height * 0.55  )
                //                    .background(Color.red)
                
                Image("fullTree")
                    .padding(.bottom,geometry.size.height * 0.1 )
                //                    .background(Color.red)
                
                HStack {
                    Button{
                        // TODO
                        showSheet.showBottomSheet.toggle()
                    }label: {
                        Text("Plant now")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .foregroundColor(Color.white)
                            .padding()
                            .padding(.trailing, geometry.size.width * 0.15)
                            .padding(.leading, geometry.size.width * 0.15)
                            .background(_buttonColor)
                            .cornerRadius(14)
                            .shadow(color: _shadowGreen.opacity(0.25), radius: 10, x: 0, y: 10)
                        
                        
                        
                    }
                    .padding(.top,geometry.size.height * 0.4 )
                }
                .sheet(isPresented: Binding(
                    get: { self.showSheet.showBottomSheet },
                    set: { self.showSheet.showBottomSheet = $0 }
                )){
                    // detents only work for IOS 16 or higher
                    if #available(iOS 16, *){
                        BottomSheet()
                            .presentationDetents([.fraction(0.6)])
                            .presentationDragIndicator(.visible)
                    }
                    else{
                        BottomSheet()
                    }
                }
                
                
                Button{
                    // TODO
                }label: {
                    Text("Or you want to plant the trees yourself?")
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .foregroundColor(Color.blue)
                        .opacity(0.85)
                }
                .padding(.top,  geometry.size.width * 1.2)
                //                .background(Color.red)
                
            }        }
        .onAppear(perform: loadData)
    }
    
    private func loadData() {
        print("LOAD DATA")
        guard let url = URL(string: "http://10.28.54.95:5000/get_stats") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(DataModel.self, from: data) {
                    DispatchQueue.main.async {
                       print("Data HEREEE")
                        print(decodedData.distance)
                        print(decodedData.emissions)
                        distCal.mydist = decodedData.distance
                        distCal.myEmission = decodedData.emissions
                        distCal.numTress = decodedData.amount_of_trees
                    }
                    return
                }
                else
                {
                    print("BIG PROBLEM")
                }
            }
        }.resume()
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView().previewDevice("iPhone 14 Pro Max")
    }
}
