import MapsLauncherData
import ProfileFeatureUI
import SwiftUI

@main
struct ProfileDevApp: App {
    var body: some Scene {
        WindowGroup {
            ProfileView(
                authenticator: NullObjectAuthenticator(),
                visitedCoffeeShopsRepository: MockVisitedCoffeeShopsRepository(),
                mapsLauncher: MapKitMapsLauncher()
            )
        }
    }
}
