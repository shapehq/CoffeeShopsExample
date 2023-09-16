public protocol Authenticating {
    var isSignedIn: Bool { get }
    func signIn(withEmail email: String, password: String) async throws
    func signOut()
}
