import DetailsFeatureDomain
import Foundation

@Observable
final class PreviewDetails: Details {
    let title: String
    let latitude: Double
    let longitude: Double
    let phoneNumber: String?
    let websiteURL: URL?
    var rating: DetailsRating
    var note: String?

    init(
        title: String,
        latitude: Double,
        longitude: Double,
        phoneNumber: String? = nil,
        websiteURL: URL? = nil,
        rating: DetailsRating = .unavailable,
        note: String? = nil
    ) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.phoneNumber = phoneNumber
        self.websiteURL = websiteURL
        self.rating = rating
        self.note = note
    }
}
