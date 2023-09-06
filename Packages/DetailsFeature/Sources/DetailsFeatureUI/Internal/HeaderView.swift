import SwiftUI

struct HeaderView: View {
    let title: String
    let openInMaps: () -> Void

    var body: some View {
        ZStack {
            HStack {
                DismissButton()
                    .tint(.secondary)
                Spacer()
                Button {
                    openInMaps()
                } label: {
                    Image(systemName: "map")
                        .padding()
                        .font(.title2)
                }
            }
            Text(title)
                .font(.headline)
                .padding([.leading, .trailing])
        }
        .padding(.top)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HeaderView(title: "Prufrock Coffee", openInMaps: {})
}
