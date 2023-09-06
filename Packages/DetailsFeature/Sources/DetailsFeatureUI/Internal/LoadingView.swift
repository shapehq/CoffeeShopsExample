import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(2)
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LoadingView()
}
