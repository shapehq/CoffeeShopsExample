import Foundation

public protocol PersistedCoffeeShop: AnyObject, Observable {
    var id: PersistedCoffeeShopID { get }
    var title: String { get }
    var latitude: Double { get }
    var longitude: Double { get }
    var websiteURL: URL? { get }
    var phoneNumber: String? { get }
    var rating: PersistedRating { get set }
    var note: String? { get set }
}
