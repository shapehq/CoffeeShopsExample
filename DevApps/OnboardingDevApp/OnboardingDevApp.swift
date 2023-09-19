import OnboardingFeatureUI
import SwiftUI

@main
struct OnboardingDevApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView(authenticator: NullObjectAuthenticator()) {
                Text("Authenticated")
            }
        }
    }
}
