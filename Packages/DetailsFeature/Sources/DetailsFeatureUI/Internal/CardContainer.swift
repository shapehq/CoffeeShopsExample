import SwiftUI

struct CardContainer<Content: View>: View {
    private let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
                .background(.regularMaterial)
                .edgesIgnoringSafeArea(.all)
            content()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CardContainer {
        Text("Hello world!")
    }
}
