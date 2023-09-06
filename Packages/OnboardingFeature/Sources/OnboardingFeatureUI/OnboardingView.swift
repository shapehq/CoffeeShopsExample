import AuthenticationDomain
import SwiftUI

public struct OnboardingView: View {
    @State private var isSignInPresented = false
    @State private var isAuthenticating = false
    private let authenticator: Authenticating
    private var backgroundImageSize: CGSize {
        UIImage(resource: .coffeeShop).size
    }

    public init(authenticator: Authenticating) {
        self.authenticator = authenticator
    }

    public var body: some View {
        NavigationView {
            VStack {
                if isSignInPresented {
                    Spacer()
                }
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding([.leading, .trailing], isSignInPresented ? 75 : 50)
                    .padding([.top])
                    .shadow(radius: 10)
                if !isSignInPresented {
                    Spacer()
                }
                if isSignInPresented {
                    Spacer().frame(height: 15)
                    SignInFormView(showActivityIndicator: isAuthenticating) { email, password in
                        signIn(withEmail: email, password: password)
                    }
                    Spacer()
                }
                if !isSignInPresented {
                    OnboardingButtonsFooterView {
                        withAnimation {
                            isSignInPresented = true
                        }
                    }
                }
            }
            .background {
                OnboardingBackgroundView(isOffset: isSignInPresented, isDimmed: isSignInPresented)
            }
            .toolbar {
                if isSignInPresented {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation {
                                isSignInPresented = false
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                        .tint(.white)
                    }
                }
            }
        }
    }
}

private extension OnboardingView {
    private func signIn(withEmail email: String, password: String) {
        Task {
            isAuthenticating = true
            defer {
                isAuthenticating = false
            }
            try await authenticator.signIn(withEmail: email, password: password)
        }
    }
}

#Preview {
    OnboardingView(authenticator: NullObjectAuthenticator())
}
