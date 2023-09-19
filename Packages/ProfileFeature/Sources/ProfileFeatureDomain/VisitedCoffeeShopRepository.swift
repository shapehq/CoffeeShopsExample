import AnyAsync
import Observation

public protocol VisitedCoffeeShopRepository: AnyObject, Observable {
    associatedtype VisitedCoffeeShopType: VisitedCoffeeShop
    var visitedCoffeeShops: [VisitedCoffeeShopType] { get }
    func deleteVisitedCoffeeShop(_ coffeeShop: VisitedCoffeeShopType)
}
