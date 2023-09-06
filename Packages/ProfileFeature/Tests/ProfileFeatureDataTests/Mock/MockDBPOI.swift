import DB
import Foundation

final class MockDBPOI: DBPOI {
    let id: DBPOIID
    let title: String
    let latitude: Double
    let longitude: Double
    let websiteURL: URL?
    let phoneNumber: String?
    var rating: DBRating
    var note: String?

    init(
        id: DBPOIID,
        title: String,
        latitude: Double,
        longitude: Double,
        websiteURL: URL? = nil,
        phoneNumber: String? = nil,
        rating: DBRating = .unavailable,
        note: String? = nil
    ) {
        self.id = id
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.websiteURL = websiteURL
        self.phoneNumber = phoneNumber
        self.rating = rating
        self.note = note
    }
}
