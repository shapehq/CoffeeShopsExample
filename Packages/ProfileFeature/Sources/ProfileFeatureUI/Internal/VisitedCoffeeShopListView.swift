import ProfileFeatureDomain
import SwiftUI

struct VisitedCoffeeShopListView<VisitedCoffeeShopRepositoryType: VisitedCoffeeShopRepository>: View {
    @Bindable var visitedCoffeeShopRepository: VisitedCoffeeShopRepositoryType

    var body: some View {
        List {
            ForEach(visitedCoffeeShopRepository.visitedCoffeeShops) { visitedCoffeeShop in
                VisitedCoffeeShopRow(visitedCoffeeShop: visitedCoffeeShop) {
                    visitedCoffeeShopRepository.deleteVisitedCoffeeShop(visitedCoffeeShop)
                }
            }
        }
    }
}
