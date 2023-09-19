import MapsAppOpenerDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedPOIsView<VisitedPOIRepositoryType: VisitedPOIRepository>: View {
    @Bindable var visitedPOIRepository: VisitedPOIRepositoryType
    let mapsAppOpener: MapsAppOpening

    var body: some View {
        Group {
            if visitedPOIRepository.visitedPOIs.isEmpty {
                ContentUnavailableView {
                    Label("No Coffee Shops", systemImage: "mug")
                } description: {
                    Text("You have not visited any coffee shops.")
                }
            } else {
                VisitedPOIListView(
                    visitedPOIRepository: visitedPOIRepository,
                    mapsAppOpener: mapsAppOpener
                )
            }
        }
        .navigationTitle("Visited Coffee Shops")
        .navigationBarTitleDisplayMode(.inline)
    }
}
