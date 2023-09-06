import AuthenticationDomain

struct NullObjectAuthenticator: Authenticating {
    func signIn(withEmail email: String, password: String) async throws {
        try await Task.sleep(for: .seconds(2))
    }

    func signOut() {}
}
