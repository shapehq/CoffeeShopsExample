import Foundation

public protocol CredentialsStoring: AnyObject {
    var credentials: Credentials? { get set }
}
