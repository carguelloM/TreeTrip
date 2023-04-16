//
//  Results.swift
//  Hackathon
//
//  Created by Hadi DEBS on 4/16/23.
//


import Foundation
import SwiftUI

public struct ResultView: View {
    @State private var distance: Int = 0
    @State private var numTrees: Int = 0
    @State private var emissions: Int = 0
    @State private var typeTree: String = "A"
    
    private let buttonColor = Color.green
    private let shadowGreen = Color.green
    
    struct DataModel: Codable {
        let distance: Int
        let emissions: Int
        let tree: String
        let amount_of_trees: Int
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack{
                            Image("Ellipse")
                            //                .background(Color.red)
                                .padding(.top, geometry.size.height * 0.2)
                            
                            
                            Text("You drove \(distance) miles, emitting \(emissions) grams of CO2")
                                .font(.system(size: 32, weight: .bold, design: .default))
                                .frame(width: 350)
                                .padding(.bottom,geometry.size.height * 0.9 )
                                .padding(.trailing,geometry.size.width * 0.15 )
            //                    .background(Color.red)
                            
                            Text("You need to plant \(numTrees) trees to offset your emissions")
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .multilineTextAlignment(.center)
                                .opacity(0.5)
                                .frame(width: 250)
                                .padding(.bottom,geometry.size.height * 0.55  )
            //                    .background(Color.red)
                            
                            Image("fullTree")
                                .padding(.bottom,geometry.size.height * 0.1 )
            //                    .background(Color.red)
                            
                            Button{
                                // TODO
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
        guard let url = URL(string: "http://10.28.54.95:5000/get_stats") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedData = try? JSONDecoder().decode(DataModel.self, from: data) {
                    DispatchQueue.main.async {
                        self.distance = decodedData.distance
                        self.emissions = decodedData.emissions
                        self.typeTree = decodedData.tree
                        self.numTrees = decodedData.amount_of_trees
                    }
                    return
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