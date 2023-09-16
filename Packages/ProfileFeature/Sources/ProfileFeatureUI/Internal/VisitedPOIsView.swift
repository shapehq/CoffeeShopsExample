import MapsAppOpenerDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedPOIsView<VisitedPOIsRepositoryType: VisitedPOIsRepository>: View {
    @Bindable var visitedPOIsRepository: VisitedPOIsRepositoryType
    let mapsAppOpener: MapsAppOpening

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
                    mapsAppOpener: mapsAppOpener
                )
            }
        }
        .navigationTitle("Visited Coffee Shops")
        .navigationBarTitleDisplayMode(.inline)
    }
}
