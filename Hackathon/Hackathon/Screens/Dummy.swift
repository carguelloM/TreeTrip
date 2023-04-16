import Foundation
import SwiftUI

public struct DummyView: View {
    public var body: some View {
        VStack {
            Text("Hello")
        }
    }
}

struct DummyView_Previews: PreviewProvider {
    static var previews: some View {
        DummyView()
            .previewDevice("iPhone 14 pro Max")
    }
}
