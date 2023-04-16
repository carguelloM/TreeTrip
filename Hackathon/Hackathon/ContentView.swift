//
//  ContentView.swift
//  Hackathon
//
//  Created by Hadi DEBS on 4/15/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var show: screenView = screenView.shared
    var body: some View {
        if (show.showHomeScreen == true)
        {
            HomeView()
        }
        else if (show.showLoadingScreen == true)
        {
//            LoadViewContainer(name: "treeGif", text: "Trip in progress...")
            PushGps()
        }
        else if (show.showDummyScreen == true)
        {
            DummyView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
