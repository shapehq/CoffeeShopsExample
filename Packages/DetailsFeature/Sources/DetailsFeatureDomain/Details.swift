import Foundation

public protocol Details: AnyObject, Observable {
    var title: String { get }
    var latitude: Double { get }
    var longitude: Double { get }
    var phoneNumber: String? { get }
    var websiteURL: URL? { get }
    var rating: DetailsRating { get set }
    var note: String? { get set }
}
