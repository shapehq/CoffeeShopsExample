import DetailsFeatureDomain

struct PreviewDetailsService: DetailsService {
    private let rating: DetailsRating
    private let note: String?

    init(rating: DetailsRating = .unavailable, note: String? = nil) {
        self.rating = rating
        self.note = note
    }

    func pointOfInterestDetails(for sparseDetails: SparseDetails) async throws -> some Details {
        PreviewDetails(
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
