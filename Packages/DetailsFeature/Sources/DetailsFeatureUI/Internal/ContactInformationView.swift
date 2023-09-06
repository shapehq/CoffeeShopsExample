import SwiftUI

struct ContactInformationView: View {
    let phoneNumber: String?
    let websiteURL: URL?

    var body: some View {
        if phoneNumber != nil || websiteURL != nil {
            VStack(alignment: .leading) {
                Divider().padding(.leading)
                if let phoneNumber {
                    PhoneNumberButton(phoneNumber: phoneNumber)
                }
                if phoneNumber != nil && websiteURL != nil {
                    Divider().padding(.leading)
                }
                if let websiteURL {
                    WebsiteButton(websiteURL: websiteURL)
                }
                Divider().padding(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            EmptyView()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ContactInformationView(
        phoneNumber: "+44 20 7242 0467",
        websiteURL: URL(string: "https://prufrockcoffee.com")
    )
}
