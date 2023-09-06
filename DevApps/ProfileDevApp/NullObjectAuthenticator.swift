import AuthenticationDomain

struct NullObjectAuthenticator: Authenticating {
    func signIn(withEmail email: String, password: String) async throws {}

    func signOut() {}
}
