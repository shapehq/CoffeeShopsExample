import MapsAppOpenerData
import ProfileFeatureUI
import SwiftUI

@main
struct ProfileDevApp: App {
    var body: some Scene {
        WindowGroup {
            ProfileView(
                authenticator: NullObjectAuthenticator(),
                visitedCoffeeShopsRepository: MockVisitedCoffeeShopsRepository(),
                mapsAppOpener: MapKitMapsAppOpener()
            )
        }
    }
}
