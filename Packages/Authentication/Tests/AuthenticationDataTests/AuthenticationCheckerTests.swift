import AuthenticationData
import AuthenticationDomain
import XCTest

final class AuthenticationCheckerTests: XCTestCase {
    func testItReturnsUnauthenticatedWhenCredentialsStoreIsEmpty() {
        let credentialsStore = MockCredentialsStore()
        let authenticationChecker = AuthenticationChecker(credentialsStore: credentialsStore)
        XCTAssertFalse(authenticationChecker.isAuthenticated)
    }

    func testItReturnsAuthenticatedWhenCredentialsExist() {
        let credentialsStore = MockCredentialsStore()
        let authenticationChecker = AuthenticationChecker(credentialsStore: credentialsStore)
        credentialsStore.credentials = Credentials(accessToken: "foo", refreshToken: "bar")
        XCTAssertTrue(authenticationChecker.isAuthenticated)
    }
}
