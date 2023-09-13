import Foundation

public struct SparseDetails: Equatable {
    public let title: String
    public let latitude: Double
    public let longitude: Double
    public let phoneNumber: String?
    public let websiteURL: URL?

    public init(
        title: String,
        latitude: Double,
        longitude: Double,
        phoneNumber: String? = nil,
        websiteURL: URL? = nil
    ) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.phoneNumber = phoneNumber
        self.websiteURL = websiteURL
    }
}
