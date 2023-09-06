public protocol Authenticating {
    func signIn(withEmail email: String, password: String) async throws
    func signOut()
}
