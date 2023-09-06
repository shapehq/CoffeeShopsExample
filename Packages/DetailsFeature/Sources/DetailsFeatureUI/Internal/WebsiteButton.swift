import SwiftUI

struct WebsiteButton: View {
    let websiteURL: URL

    private var title: String {
        websiteURL.host() ?? websiteURL.absoluteString
    }

    var body: some View {
        Link(destination: websiteURL) {
            HStack {
                Image(systemName: "globe")
                Text(title)
            }
            .padding()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    WebsiteButton(websiteURL: URL(string: "https://prufrockcoffee.com")!)
}
