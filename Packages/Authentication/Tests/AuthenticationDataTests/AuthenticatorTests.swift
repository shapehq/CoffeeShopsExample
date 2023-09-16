import AuthenticationData
import AuthenticationDomain
import XCTest

final class AuthenticatorTests: XCTestCase {
    func testStoresCredentialsWhenSigningIn() async throws {
        let credentialsStore = MockCredentialsStore()
        let authenticator = Authenticator(credentialsStore: credentialsStore)
        try await authenticator.signIn(withEmail: "foo@example.com", password: "bar")
        XCTAssertNotNil(credentialsStore.credentials)
    }

    func testItRemovesCredentialsWhenSigningOut() {
        let credentialsStore = MockCredentialsStore()
        credentialsStore.credentials = Credentials(accessToken: "foo", refreshToken: "bar")
        let authenticator = Authenticator(credentialsStore: credentialsStore)
        authenticator.signOut()
        XCTAssertNil(credentialsStore.credentials)
    }

    func testItReturnsUnauthenticatedWhenCredentialsStoreIsEmpty() {
        let credentialsStore = MockCredentialsStore()
        let authenticator = Authenticator(credentialsStore: credentialsStore)
        XCTAssertFalse(authenticator.isSignedIn)
    }

    func testItReturnsAuthenticatedWhenCredentialsExist() {
        let credentialsStore = MockCredentialsStore()
        let authenticator = Authenticator(credentialsStore: credentialsStore)
        credentialsStore.credentials = Credentials(accessToken: "foo", refreshToken: "bar")
        XCTAssertTrue(authenticator.isSignedIn)
    }
}
