import MapsLauncherDomain
import ProfileFeatureDomain
import SwiftUI

struct VisitedCoffeeShopRow: View {
    let visitedCoffeeShop: any VisitedCofeeShop
    let mapsLauncher: MapsLaunching
    let onDelete: () -> Void

    var body: some View {
        Button {
            mapsLauncher.openMaps(
                showingLatitude: visitedCoffeeShop.latitude,
                longitude: visitedCoffeeShop.longitude
            )
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(visitedCoffeeShop.title)
                    Spacer()
                    RatingView(rating: visitedCoffeeShop.rating)
                }
                if let note = visitedCoffeeShop.note {
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
    VisitedCoffeeShopRow(
        visitedCoffeeShop: PreviewVisitedCoffeeShop(
            title: "Prufrock Coffee",
            latitude: 51.52004066260156,
            longitude: -0.10943098689930579,
            rating: .five,
            note: "Excellent coffee. Common place to work from."
        ),
        mapsLauncher: PreviewMapsLauncher()
    ) { }
}
