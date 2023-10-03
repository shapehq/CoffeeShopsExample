import MapFeatureUI
import SwiftUI

@main
struct MapDevApp: App {
    var body: some Scene {
        WindowGroup {
            MapView(markerService: MockCoffeeShopMarkerService()) { _ in
                MockDetailsView()
            }
        }
    }
}
