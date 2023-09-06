import AuthenticationData
import AuthenticationDomain
import DB
import DetailsFeatureData
import DetailsFeatureDomain
import DetailsFeatureUI
import MapFeatureData
import MapFeatureDomain
import MapFeatureUI
import MapsLauncherData
import MapsLauncherDomain
import OnboardingFeatureUI
import ProfileFeatureData
import ProfileFeatureUI
import SwiftData
import SwiftDataDB
import SwiftUI

@main
struct CoffeeShopsApp: App {
    private let credentialsStore = UserDefaultsCredentialsStore(userDefaults: .standard)
    private let db = SwiftDataDB(isStoredInMemoryOnly: false)
    private let authenticationChecker: AuthenticationChecking

    init() {
        authenticationChecker = AuthenticationChecker(credentialsStore: credentialsStore)
    }

    var body: some Scene {
        WindowGroup {
            if authenticationChecker.isAuthenticated {
                TabView {
                    mapView
                    profileView
                }
            } else {
                onboardingView
            }
        }
    }
}

private extension CoffeeShopsApp {
    private var mapView: some View {
        let dbPOIRepository = self.dbPOIRepository
        return MapView(
            mapPOIService: DebouncingMapPOIService(
                decorating: CachingMapPOIService(
                    decorating: DBMapPOIService(
                        decorating: MapKitMapPOIService(),
                        dbPOIRepository: dbPOIRepository
                    )
                )
            ),
            childViewFactory: AppMapChildViewFactory(
                detailsService: DBDetailsService(
                    dbPOIRepository: dbPOIRepository
                ),
                lookAroundSceneLoader: MapKitLookAroundSceneLoader(),
                mapsLauncher: mapsLauncher
            )
        )
    }

    private var profileView: some View {
        ProfileView(
            authenticator: authenticator,
            visitedCoffeeShopsRepository: DBVisitedCoffeeShopsRepository(
                dbPOIRepository: dbPOIRepository
            ),
            mapsLauncher: mapsLauncher
        )
    }

    private var onboardingView: some View {
        OnboardingView(authenticator: authenticator)
    }
}

private extension CoffeeShopsApp {
    private var mapsLauncher: some MapsLaunching {
        MapKitMapsLauncher()
    }

    private var authenticator: some Authenticating {
        Authenticator(credentialsStore: credentialsStore)
    }

    private var dbPOIRepository: some DBPOIRepository {
        SwiftDataPOIRepository(modelContext: modelContext)
    }

    private var modelContext: ModelContext {
        ModelContext(db.modelContainer)
    }
}
