import DetailsFeatureDomain
import SwiftUI

struct RatingView: View {
    @Binding private var selection: DetailsRating

    init(selection: Binding<DetailsRating>) {
        self._selection = selection
    }

    var body: some View {
        HStack {
            RatingStar(representedItem: .one, selection: $selection)
            RatingStar(representedItem: .two, selection: $selection)
            RatingStar(representedItem: .three, selection: $selection)
            RatingStar(representedItem: .four, selection: $selection)
            RatingStar(representedItem: .five, selection: $selection)
        }
    }
}

private struct RatingStar: View {
    let representedItem: DetailsRating
    @Binding var selection: DetailsRating

    private var isFilled: Bool {
        selection >= representedItem
    }

    var body: some View {
        Button {
            selection = representedItem
        } label: {
            Image(systemName: isFilled ? "star.fill" : "star")
                .font(.title)
        }
    }
}
