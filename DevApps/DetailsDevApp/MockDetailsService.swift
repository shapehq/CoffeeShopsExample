import DetailsFeatureDomain

struct MockDetailsService: DetailsService {
    let rating: DetailsRating
    let note: String?

    init(rating: DetailsRating = .unavailable, note: String? = nil) {
        self.rating = rating
        self.note = note
    }

    func pointOfInterestDetails(for sparseDetails: SparseDetails) async throws -> MockDetails {
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
