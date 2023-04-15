//
//  Loading.swift
//  Hackathon
//
//  Created by Hadi DEBS on 4/15/23.
//

import SwiftUI
import WebKit

struct LoadingView: UIViewRepresentable {
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
    
    
    typealias UIViewType = WKWebView
   
}




struct LoadingView_preview: PreviewProvider {
    static var previews: some View {
        LoadingView(name: "treeGif").previewDevice("iPhone 14 pro Max")
        
    }
}





