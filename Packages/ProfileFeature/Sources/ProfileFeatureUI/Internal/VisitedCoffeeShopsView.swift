import MapsAppOpenerDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedCoffeeShopsView<VisitedCoffeeShopRepositoryType: VisitedCoffeeShopRepository>: View {
    @Bindable var visitedCoffeeShopRepository: VisitedCoffeeShopRepositoryType
    let mapsAppOpener: MapsAppOpening

    var body: some View {
        Group {
            if visitedCoffeeShopRepository.visitedCoffeeShops.isEmpty {
                ContentUnavailableView {
                    Label("No Coffee Shops", systemImage: "mug")
                } description: {
                    Text("You have not visited any coffee shops.")
                }
            } else {
                VisitedCoffeeShopListView(
                    visitedCoffeeShopRepository: visitedCoffeeShopRepository,
                    mapsAppOpener: mapsAppOpener
                )
            }
        }
        .navigationTitle("Visited Coffee Shops")
        .navigationBarTitleDisplayMode(.inline)
    }
}
