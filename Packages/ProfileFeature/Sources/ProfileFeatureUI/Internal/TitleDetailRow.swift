import SwiftUI

struct TitleDetailRow: View {
    let title: String
    let detail: String?

    var body: some View {
        HStack {
            Text(title)
            if let detail {
                Spacer()
                Text(detail)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
