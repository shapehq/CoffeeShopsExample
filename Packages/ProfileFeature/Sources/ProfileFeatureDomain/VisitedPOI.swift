import Foundation

public protocol VisitedPOI: Identifiable {
    var title: String { get }
    var latitude: Double { get }
    var longitude: Double { get }
    var rating: VisitedPOIRating { get }
    var note: String? { get }
}
