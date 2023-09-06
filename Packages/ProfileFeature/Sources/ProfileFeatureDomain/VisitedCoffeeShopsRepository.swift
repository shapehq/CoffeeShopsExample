import AnyAsync
import Observation

public protocol VisitedCoffeeShopsRepository: AnyObject, Observable {
    associatedtype VisitedCofeeShopType: VisitedCofeeShop
    var visitedCoffeeShops: [VisitedCofeeShopType] { get }
    func deleteVisitedCoffeeShop(_ coffeeShop: VisitedCofeeShopType)
}
