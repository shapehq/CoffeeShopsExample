import DB
import Foundation

final class MockPersistedCoffeeShop: PersistedCoffeeShop {
    let id: PersistedCoffeeShopID
    let title: String
    let latitude: Double
    let longitude: Double
    let websiteURL: URL?
    let phoneNumber: String?
    var rating: PersistedRating
    var note: String?

    init(
        id: PersistedCoffeeShopID,
        title: String,
        latitude: Double,
        longitude: Double,
        websiteURL: URL? = nil,
        phoneNumber: String? = nil,
        rating: PersistedRating = .unavailable,
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
