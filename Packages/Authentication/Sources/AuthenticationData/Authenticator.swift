import AuthenticationDomain
import Foundation
import Observation

@Observable
public final class Authenticator: Authenticating {
    public var isSignedIn: Bool {
        credentialsStore.credentials != nil
    }

    private let credentialsStore: CredentialsStoring

    public init(credentialsStore: CredentialsStoring) {
        self.credentialsStore = credentialsStore
    }

    public func signIn(withEmail email: String, password: String) async throws {
        credentialsStore.credentials = Credentials(accessToken: "foo", refreshToken: "bar")
    }

    public func signOut() {
        credentialsStore.credentials = nil
    }
}
