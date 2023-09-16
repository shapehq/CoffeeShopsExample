import MapsLauncherDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedPOIListView<VisitedPOIsRepositoryType: VisitedPOIsRepository>: View {
    @Bindable var visitedPOIsRepository: VisitedPOIsRepositoryType
    let mapsLauncher: MapsLaunching

    var body: some View {
        List {
            ForEach(visitedPOIsRepository.visitedPOIs) { visitedPOI in
                VisitedPOIRow(
                    visitedPOI: visitedPOI,
                    mapsLauncher: mapsLauncher
                ) {
                    visitedPOIsRepository.deleteVisitedPOI(visitedPOI)
                }
            }
        }
    }
}
