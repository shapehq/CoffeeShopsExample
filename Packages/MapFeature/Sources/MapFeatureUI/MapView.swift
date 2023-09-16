import MapFeatureDomain
import MapKit
import SwiftUI
import UIKit

public struct MapView<DetailView: View>: View {
    private let mapPOIService: MapPOIService
    private let makeDetailView: (MapPOI) -> DetailView
    @State private var pointsOfInterest: [MapPOI] = []
    @State private var selection: MapPOI?
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var poiTask: Task<(), Error>?

    public init(
        mapPOIService: MapPOIService,
        @ViewBuilder detailView makeDetailView: @escaping (MapPOI) -> DetailView
    ) {
        self.mapPOIService = mapPOIService
        self.makeDetailView = makeDetailView
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
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        .sheet(item: $selection.animation()) { selectedPOI in
            makeDetailView(selectedPOI)
                .presentationDetents([.medium, .large])
                .presentationBackground(.regularMaterial)
                .presentationCornerRadius(18)
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
        }
        .tabItem {
            Image(systemName: "mug")
            Text("Coffee Shops")
        }
        .onMapCameraChange { context in
            position = .region(context.region)
            showPointsOfInterest(in: context.region)
        }
        .onAppear {
            requestLocationAuthorizationIfNeeded()
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

    private func requestLocationAuthorizationIfNeeded() {
        let locationManager = CLLocationManager()
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied, .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
}

#Preview {
    MapView(mapPOIService: PreviewMapPOIService()) { _ in
        Text("POI Details")
    }
}
