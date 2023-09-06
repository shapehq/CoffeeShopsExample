import AuthenticationDomain
import Foundation
import Observation

@Observable
public final class UserDefaultsCredentialsStore: CredentialsStoring {
    private enum UserDefaultsKey {
        static let accessToken = "UserDefaultsCredentialsStore.AccessToken"
        static let refreshToken = "UserDefaultsCredentialsStore.RefreshToken"
    }

    public var credentials: Credentials? {
        didSet {
            if let credentials {
                writeCredentials(credentials)
            } else {
                removeCredentials()
            }
        }
    }

    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.credentials = readCredentials()
    }
}

private extension UserDefaultsCredentialsStore {
    private func readCredentials() -> Credentials? {
        guard let accessToken = userDefaults.string(forKey: UserDefaultsKey.accessToken) else {
            return nil
        }
        guard let refreshToken = userDefaults.string(forKey: UserDefaultsKey.refreshToken) else {
            return nil
        }
        return Credentials(accessToken: accessToken, refreshToken: refreshToken)
    }

    private func writeCredentials(_ credentials: Credentials) {
        userDefaults.setValue(credentials.accessToken, forKey: UserDefaultsKey.accessToken)
        userDefaults.setValue(credentials.refreshToken, forKey: UserDefaultsKey.refreshToken)
    }

    private func removeCredentials() {
        userDefaults.setValue(nil, forKey: UserDefaultsKey.accessToken)
        userDefaults.setValue(nil, forKey: UserDefaultsKey.refreshToken)
    }
}
