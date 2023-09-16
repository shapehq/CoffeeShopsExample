import ProfileFeatureDomain
import SwiftUI

struct RatingView: View {
    let rating: VisitedPOIRating

    var body: some View {
        HStack {
            RatingStar(isFilled: rating >= .one)
            RatingStar(isFilled: rating >= .two)
            RatingStar(isFilled: rating >= .three)
            RatingStar(isFilled: rating >= .four)
            RatingStar(isFilled: rating >= .five)
        }
    }
}

private struct RatingStar: View {
    let isFilled: Bool

    var body: some View {
        Image(systemName: isFilled ? "star.fill" : "star")
            .font(.footnote)
            .foregroundColor(.secondary)
    }
}

#Preview("Unavailable", traits: .sizeThatFitsLayout) {
    RatingView(rating: .unavailable)
}

#Preview("One", traits: .sizeThatFitsLayout) {
    RatingView(rating: .one)
}

#Preview("Two", traits: .sizeThatFitsLayout) {
    RatingView(rating: .two)
}

#Preview("Three", traits: .sizeThatFitsLayout) {
    RatingView(rating: .three)
}

#Preview("Four", traits: .sizeThatFitsLayout) {
    RatingView(rating: .four)
}

#Preview("Five", traits: .sizeThatFitsLayout) {
    RatingView(rating: .five)
}
