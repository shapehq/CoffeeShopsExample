import MapsAppOpenerDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedPOIRow<VisitedPOIType: VisitedPOI>: View {
    let visitedPOI: VisitedPOIType
    let mapsAppOpener: MapsAppOpening
    let onDelete: () -> Void

    var body: some View {
        Button {
            mapsAppOpener.openMaps(
                showingLatitude: visitedPOI.latitude,
                longitude: visitedPOI.longitude
            )
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(visitedPOI.title)
                    Spacer()
                    RatingView(rating: visitedPOI.rating)
                }
                if let note = visitedPOI.note {
                    Text(note)
                        .font(.footnote)
                }
            }
            .padding([.top, .bottom], 2)
        }
        .tint(.primary)
        .swipeActions {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Image(systemName: "trash")
            }
        }
    }
}

#Preview {
    VisitedPOIRow(
        visitedPOI: PreviewVisitedPOI(
            title: "Prufrock Coffee",
            latitude: 51.52004066260156,
            longitude: -0.10943098689930579,
            rating: .five,
            note: "Excellent coffee. Common place to work from."
        ),
        mapsAppOpener: PreviewMapsAppOpener()
    ) { }
}
