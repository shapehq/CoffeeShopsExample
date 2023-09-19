import ProfileFeatureDomain
import SwiftUI

struct VisitedCoffeeShopsView<VisitedCoffeeShopRepositoryType: VisitedCoffeeShopRepository>: View {
    @Bindable var visitedCoffeeShopRepository: VisitedCoffeeShopRepositoryType

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
                    visitedCoffeeShopRepository: visitedCoffeeShopRepository
                )
            }
        }
        .navigationTitle("Visited Coffee Shops")
        .navigationBarTitleDisplayMode(.inline)
    }
}
