import MapsLauncherDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedCoffeeShopListView<VisitedCoffeeShopsRepositoryType: VisitedCoffeeShopsRepository>: View {
    @Bindable var visitedCoffeeShopsRepository: VisitedCoffeeShopsRepositoryType
    let mapsLauncher: MapsLaunching

    var body: some View {
        List {
            ForEach(visitedCoffeeShopsRepository.visitedCoffeeShops) { visitedCoffeeShop in
                VisitedCoffeeShopRow(
                    visitedCoffeeShop: visitedCoffeeShop,
                    mapsLauncher: mapsLauncher
                ) {
                    visitedCoffeeShopsRepository.deleteVisitedCoffeeShop(visitedCoffeeShop)
                }
            }
        }
    }
}
