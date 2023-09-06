import SwiftUI

struct OnboardingBackgroundView: View {
    let isOffset: Bool
    let isDimmed: Bool

    var body: some View {
        GeometryReader { geometry in
            Image(.coffeeShop)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width)
                .offset(x: isOffset ? 0 : 200)
            .overlay(
                Color.black.opacity(isDimmed ? 0.5 : 0.2)
            )
        }
        .ignoresSafeArea(.all)
    }
}
