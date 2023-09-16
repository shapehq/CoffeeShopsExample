import AuthenticationDomain
import SwiftUI

public struct OnboardingView<AuthenticatedView: View>: View {
    private let authenticator: Authenticating
    private let makeAuthenticatedView: () -> AuthenticatedView

    public init(
        authenticator: Authenticating,
        @ViewBuilder makeAuthenticatedView: @escaping () -> AuthenticatedView
    ) {
        self.authenticator = authenticator
        self.makeAuthenticatedView = makeAuthenticatedView
    }

    public var body: some View {
        if authenticator.isSignedIn {
            makeAuthenticatedView()
        } else {
            LandingPageView(authenticator: authenticator)
        }
    }
}

#Preview("Not Signed In") {
    OnboardingView(authenticator: PreviewAuthenticator(isSignedIn: false)) {
        Text("Signed In")
    }
}

#Preview("Signed In") {
    OnboardingView(authenticator: PreviewAuthenticator(isSignedIn: true)) {
        Text("Signed In")
    }
}
