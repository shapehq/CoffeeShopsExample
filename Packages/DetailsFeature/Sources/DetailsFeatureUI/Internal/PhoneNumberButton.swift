import SwiftUI

struct PhoneNumberButton: View {
    let phoneNumber: String

    private var url: URL {
        URL(string: "tel://" + phoneNumber.replacingOccurrences(of: " ", with: ""))!
    }

    var body: some View {
        Link(destination: url) {
            HStack {
                Image(systemName: "phone.fill")
                Text(phoneNumber)
                    .multilineTextAlignment(.leading)
            }
            .padding()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PhoneNumberButton(phoneNumber: "+44 20 7242 0467")
}
