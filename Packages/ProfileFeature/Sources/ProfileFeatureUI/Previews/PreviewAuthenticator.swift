import AuthenticationDomain

struct PreviewAuthenticator: Authenticating {
    func signIn(withEmail email: String, password: String) async throws {}

    func signOut() {}
}
