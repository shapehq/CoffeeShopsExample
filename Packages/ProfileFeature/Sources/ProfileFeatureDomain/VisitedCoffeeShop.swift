import Foundation

public protocol VisitedCoffeeShop: Identifiable {
    var title: String { get }
    var latitude: Double { get }
    var longitude: Double { get }
    var rating: VisitedCoffeeShopRating { get }
    var note: String? { get }
}
