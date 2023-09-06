import AuthenticationDomain
import Observation

@Observable
public final class InMemoryCredentialsStore: CredentialsStoring {
    public var credentials: Credentials?

    public init() {}
}
