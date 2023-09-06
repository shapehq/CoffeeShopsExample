import Foundation

public struct DBPOIID: Hashable, Codable {
    public let rawValue: String

    public init(latitude: Double, longitude: Double) {
        rawValue = "\(latitude);\(longitude)"
    }
}
