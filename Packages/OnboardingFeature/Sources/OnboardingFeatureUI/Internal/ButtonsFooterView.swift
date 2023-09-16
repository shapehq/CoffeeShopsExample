import SwiftUI

struct OnboardingButtonsFooterView: View {
    let onSignIn: () -> Void

    var body: some View {
        Button {

        } label: {
            Text("Create Account")
                .font(.title3)
                .foregroundStyle(.black)
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 5)
        }
        .buttonStyle(.borderedProminent)
        .tint(.white)
        Button {
            onSignIn()
        } label: {
            Text("Sign In")
                .font(.title3.bold())
                .padding()
        }
        .tint(.white)
    }
}
