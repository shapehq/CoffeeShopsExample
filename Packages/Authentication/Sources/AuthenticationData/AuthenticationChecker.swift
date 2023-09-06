import AuthenticationDomain

public struct AuthenticationChecker: AuthenticationChecking {
    public var isAuthenticated: Bool {
        credentialsStore.credentials != nil
    }

    private let credentialsStore: CredentialsStoring

    public init(credentialsStore: CredentialsStoring) {
        self.credentialsStore = credentialsStore
    }
}
