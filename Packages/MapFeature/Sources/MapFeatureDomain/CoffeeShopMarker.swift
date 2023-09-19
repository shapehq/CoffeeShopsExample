import Foundation

public struct CoffeeShopMarker: Identifiable, Hashable {
    // swiftlint:disable:next type_name
    public struct ID: Hashable {
        public var rawValue: String

        public init(latitude: Double, longitude: Double) {
            self.rawValue = "\(latitude);\(longitude)"
        }
    }

    public enum Color {
        case black
        case red
        case orange
        case yellow
        case green
        case blue
    }

    public let id: ID
    public let title: String
    public let latitude: Double
    public let longitude: Double
    public let phoneNumber: String?
    public let websiteURL: URL?
    public let color: Color

    public init(
        title: String,
        latitude: Double,
        longitude: Double,
        phoneNumber: String? = nil,
        websiteURL: URL? = nil,
        color: Color
    ) {
        self.id = ID(latitude: latitude, longitude: longitude)
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.phoneNumber = phoneNumber
        self.websiteURL = websiteURL
        self.color = color
    }
}
