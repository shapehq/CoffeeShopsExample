import MapsAppOpenerDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedPOIListView<VisitedPOIsRepositoryType: VisitedPOIsRepository>: View {
    @Bindable var visitedPOIsRepository: VisitedPOIsRepositoryType
    let mapsAppOpener: MapsAppOpening

    var body: some View {
        List {
            ForEach(visitedPOIsRepository.visitedPOIs) { visitedPOI in
                VisitedPOIRow(
                    visitedPOI: visitedPOI,
                    mapsAppOpener: mapsAppOpener
                ) {
                    visitedPOIsRepository.deleteVisitedPOI(visitedPOI)
                }
            }
        }
    }
}
