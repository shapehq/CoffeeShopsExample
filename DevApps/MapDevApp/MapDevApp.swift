import MapFeatureUI
import SwiftUI

@main
struct MapDevApp: App {
    var body: some Scene {
        WindowGroup {
            MapView(mapCoffeeShopService: MockCoffeeShopMarkerService()) { _ in
                ZStack(alignment: .topLeading) {
                    Color.clear
                        .background(.regularMaterial)
                        .edgesIgnoringSafeArea(.all)
                    Text("Mock Details")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
    }
}
