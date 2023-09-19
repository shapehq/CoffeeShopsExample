import AuthenticationDomain

final class NullObjectAuthenticator: Authenticating {
    private(set) var isSignedIn = false

    func signIn(withEmail email: String, password: String) async throws {
        try await Task.sleep(for: .seconds(2))
        isSignedIn = true
    }

    func signOut() {
        isSignedIn = false
    }
}
