import MapFeatureUI
import SwiftUI

@main
struct MapDevApp: App {
    var body: some Scene {
        WindowGroup {
            MapView(
                mapPOIService: MockMapPOIService(),
                childViewFactory: MapDevAppChildViewFactory()
            )
        }
    }
}
