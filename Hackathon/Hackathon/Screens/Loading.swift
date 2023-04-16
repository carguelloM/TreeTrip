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
    
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        func makeUIView(context: Context) -> UIImageView {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            context.coordinator.loadGIF(named: name, into: imageView)
            return imageView
        }
        
        func updateUIView(_ uiView: UIImageView, context: Context) {
            // No updates needed
        }
        
        class Coordinator {
            var parent: LoadingView
            
            init(_ parent: LoadingView) {
                self.parent = parent
            }
            
            func loadGIF(named name: String, into imageView: UIImageView) {
                if let url = Bundle.main.url(forResource: name, withExtension: "gif"),
                   let data = try? Data(contentsOf: url),
                   let source = CGImageSourceCreateWithData(data as CFData, nil) {
                    let count = CGImageSourceGetCount(source)
                    var images = [UIImage]()
                    var duration: TimeInterval = 0
                    
                    for i in 0..<count {
                        if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                            let uiImage = UIImage(cgImage: image)
                            images.append(uiImage)
                            
                            let frameDuration = CGImageSourceGetGIFFrameDuration(source, i)
                            duration += frameDuration
                        }
                    }
                    
                    let animation = UIImage.animatedImage(with: images, duration: duration)
                    imageView.image = animation
                }
            }
            
            private func CGImageSourceGetGIFFrameDuration(_ source: CGImageSource, _ index: Int) -> TimeInterval {
                var frameDuration: TimeInterval = 0.1
                let cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
                if let frameProperties = cfFrameProperties as? [String: Any],
                   let gifProperties = frameProperties[kCGImagePropertyGIFDictionary as String] as? [String: Any],
                   let delayTimeUnclampedProp = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String] as? NSNumber {
                    frameDuration = delayTimeUnclampedProp.doubleValue
                }
                return frameDuration
            }
        }
    }




struct LoadingView_preview: PreviewProvider {
    static var previews: some View {
        LoadingView(name: "treeGif").previewDevice("iPhone 14 pro Max")
        
    }
}





