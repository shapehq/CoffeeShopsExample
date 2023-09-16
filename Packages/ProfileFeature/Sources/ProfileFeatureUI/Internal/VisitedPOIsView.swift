import MapsLauncherDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedPOIsView<VisitedPOIsRepositoryType: VisitedPOIsRepository>: View {
    @Bindable var visitedPOIsRepository: VisitedPOIsRepositoryType
    let mapsLauncher: MapsLaunching

    var body: some View {
        Group {
            if visitedPOIsRepository.visitedPOIs.isEmpty {
                ContentUnavailableView {
                    Label("No Coffee Shops", systemImage: "mug")
                } description: {
                    Text("You have not visited any coffee shops.")
                }
            } else {
                VisitedPOIListView(
                    visitedPOIsRepository: visitedPOIsRepository,
                    mapsLauncher: mapsLauncher
                )
            }
        }
        .navigationTitle("Visited Coffee Shops")
        .navigationBarTitleDisplayMode(.inline)
    }
}
