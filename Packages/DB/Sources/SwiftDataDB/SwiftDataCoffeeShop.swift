import DB
import Foundation
import SwiftData

@Model
public final class SwiftDataCoffeeShop: PersistedCoffeeShop {
    public let id: PersistedCoffeeShopID
    public let title: String
    public let latitude: Double
    public let longitude: Double
    public let websiteURL: URL?
    public let phoneNumber: String?
    public var rating: PersistedRating
    public var note: String?

    public init(
        title: String,
        latitude: Double,
        longitude: Double,
        websiteURL: URL?,
        phoneNumber: String?,
        rating: PersistedRating,
        note: String?
    ) {
        self.id = PersistedCoffeeShopID(latitude: latitude, longitude: longitude)
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.websiteURL = websiteURL
        self.phoneNumber = phoneNumber
        self.rating = rating
        self.note = note
    }
}
