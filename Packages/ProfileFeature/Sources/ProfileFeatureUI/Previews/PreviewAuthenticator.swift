import AuthenticationDomain

struct PreviewAuthenticator: Authenticating {
    let isSignedIn = true

    func signIn(withEmail email: String, password: String) async throws {}

    func signOut() {}
}
