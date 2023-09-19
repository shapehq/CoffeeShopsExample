import MapsAppOpenerDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedCoffeeShopListView<VisitedCoffeeShopRepositoryType: VisitedCoffeeShopRepository>: View {
    @Bindable var visitedCoffeeShopRepository: VisitedCoffeeShopRepositoryType
    let mapsAppOpener: MapsAppOpening

    var body: some View {
        List {
            ForEach(visitedCoffeeShopRepository.visitedCoffeeShops) { visitedCoffeeShop in
                VisitedCoffeeShopRow(
                    visitedCoffeeShop: visitedCoffeeShop,
                    mapsAppOpener: mapsAppOpener
                ) {
                    visitedCoffeeShopRepository.deleteVisitedCoffeeShop(visitedCoffeeShop)
                }
            }
        }
    }
}
