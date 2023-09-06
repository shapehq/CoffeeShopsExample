import DB
import Foundation
import SwiftData

@Model
public final class SwiftDataPOI: DBPOI {
    public let id: DBPOIID
    public let title: String
    public let latitude: Double
    public let longitude: Double
    public let websiteURL: URL?
    public let phoneNumber: String?
    public var rating: DBRating
    public var note: String?

    public init(
        title: String,
        latitude: Double,
        longitude: Double,
        websiteURL: URL?,
        phoneNumber: String?,
        rating: DBRating,
        note: String?
    ) {
        self.id = DBPOIID(latitude: latitude, longitude: longitude)
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.websiteURL = websiteURL
        self.phoneNumber = phoneNumber
        self.rating = rating
        self.note = note
    }
}
