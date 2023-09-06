import MapFeatureDomain
import MapKit
import SwiftUI
import UIKit

public struct MapView<
    MapChildViewFactoryType: MapChildViewFactory
>: View {
    private let mapPOIService: MapPOIService
    private let childViewFactory: MapChildViewFactoryType
    @State private var pointsOfInterest: [MapPOI] = []
    @State private var selection: MapPOI?
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var poiTask: Task<(), Error>?

    public init(mapPOIService: MapPOIService, childViewFactory: MapChildViewFactoryType) {
        self.mapPOIService = mapPOIService
        self.childViewFactory = childViewFactory
    }

    public var body: some View {
        Map(position: $position, selection: $selection) {
            ForEach(pointsOfInterest, id: \.self) { poi in
                Marker(
                    poi.title,
                    systemImage: "mug",
                    coordinate: poi.coordinate
                )
                .tint(Color(poi.color))
            }
        }
        .sheetPresentation(
            presentedItem: $selection.animation(),
            detents: [.medium()],
            largestUndimmedDetentIdentifier: .medium,
            prefersGrabberVisible: false
        ) { selectedPOI in
            childViewFactory.makeDetailsView(showing: selectedPOI)
        }
        .tabItem {
            Image(systemName: "mug")
            Text("Coffee Shops")
        }
        .onMapCameraChange { context in
            position = .region(context.region)
            showPointsOfInterest(in: context.region)
        }
    }
}

private extension MapView {
    private func showPointsOfInterest(in region: MKCoordinateRegion) {
        poiTask?.cancel()
        poiTask = Task {
            let newPOIsStream = try await mapPOIService.pointsOfInterest(
                centerLatitude: region.center.latitude,
                centerLongitude: region.center.longitude,
                latitudeDelta: region.span.latitudeDelta,
                longitudeDelta: region.span.longitudeDelta
            )
            guard !Task.isCancelled else {
                return
            }
            for try await newPOIs in newPOIsStream {
                withAnimation {
                    self.pointsOfInterest = newPOIs
                }
                reselectPOIIfNeeded(selectingFrom: newPOIs)
            }
        }
    }

    private func reselectPOIIfNeeded(selectingFrom newPOIs: [MapPOI]) {
        if let oldSelectedPOI = selection {
            selection = newPOIs.first { $0.id == oldSelectedPOI.id }
        }
    }
}

#Preview {
    MapView(
        mapPOIService: PreviewMapPOIService(),
        childViewFactory: PreviewMapChildViewFactory()
    )
}
