import AuthenticationDomain

final class PreviewAuthenticator: Authenticating {
    private(set) var isSignedIn: Bool

    init(isSignedIn: Bool) {
        self.isSignedIn = isSignedIn
    }

    func signIn(withEmail email: String, password: String) async throws {
        isSignedIn = true
    }

    func signOut() {
        isSignedIn = false
    }
}
