import Foundation

public protocol DBPOI: AnyObject, Observable {
    var id: DBPOIID { get }
    var title: String { get }
    var latitude: Double { get }
    var longitude: Double { get }
    var websiteURL: URL? { get }
    var phoneNumber: String? { get }
    var rating: DBRating { get set }
    var note: String? { get set }
}
