import ProfileFeatureDomain

struct PreviewVisitedPOI: VisitedPOI, Equatable {
    var id: String {
        title
    }
    let title: String
    let latitude: Double
    let longitude: Double
    let rating: VisitedPOIRating
    let note: String?
}
