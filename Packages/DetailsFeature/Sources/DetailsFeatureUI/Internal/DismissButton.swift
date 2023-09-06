import SwiftUI

struct DismissButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .padding()
                .font(.title2)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DismissButton()
}
