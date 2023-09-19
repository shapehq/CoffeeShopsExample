import MapsAppOpenerDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedPOIListView<VisitedPOIRepositoryType: VisitedPOIRepository>: View {
    @Bindable var visitedPOIRepository: VisitedPOIRepositoryType
    let mapsAppOpener: MapsAppOpening

    var body: some View {
        List {
            ForEach(visitedPOIRepository.visitedPOIs) { visitedPOI in
                VisitedPOIRow(
                    visitedPOI: visitedPOI,
                    mapsAppOpener: mapsAppOpener
                ) {
                    visitedPOIRepository.deleteVisitedPOI(visitedPOI)
                }
            }
        }
    }
}
