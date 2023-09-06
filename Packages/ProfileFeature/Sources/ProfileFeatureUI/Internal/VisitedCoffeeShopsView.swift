import MapsLauncherDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedCoffeeShopsView<VisitedCoffeeShopsRepositoryType: VisitedCoffeeShopsRepository>: View {
    @Bindable var visitedCoffeeShopsRepository: VisitedCoffeeShopsRepositoryType
    let mapsLauncher: MapsLaunching

    var body: some View {
        Group {
            if visitedCoffeeShopsRepository.visitedCoffeeShops.isEmpty {
                ContentUnavailableView {
                    Label("No Coffee Shops", systemImage: "mug")
                } description: {
                    Text("You have not visited any coffee shops.")
                }
            } else {
                VisitedCoffeeShopListView(
                    visitedCoffeeShopsRepository: visitedCoffeeShopsRepository,
                    mapsLauncher: mapsLauncher
                )
            }
        }
        .navigationTitle("Visited Coffee Shops")
        .navigationBarTitleDisplayMode(.inline)
    }
}
