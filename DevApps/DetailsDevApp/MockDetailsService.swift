import DetailsFeatureDomain

struct MockDetailsService: DetailsService {
    let rating: DetailsRating
    let note: String?

    init(rating: DetailsRating = .unavailable, note: String? = nil) {
        self.rating = rating
        self.note = note
    }

    func coffeeShopDetails(for sparseDetails: SparseDetails) async throws -> some Details & AnyObject {
        MockDetails(
            title: sparseDetails.title,
            latitude: sparseDetails.latitude,
            longitude: sparseDetails.longitude,
            phoneNumber: sparseDetails.phoneNumber,
            websiteURL: sparseDetails.websiteURL,
            rating: rating,
            note: note
        )
    }
}
