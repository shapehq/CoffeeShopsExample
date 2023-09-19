import AuthenticationDomain

struct NullObjectAuthenticator: Authenticating {
    let isSignedIn = true

    func signIn(withEmail email: String, password: String) async throws {}

    func signOut() {}
}
