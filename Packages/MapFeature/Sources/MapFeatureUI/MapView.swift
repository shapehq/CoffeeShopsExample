import MapFeatureDomain
import MapKit
import SwiftUI
import UIKit

public struct MapView<DetailView: View>: View {
    private let mapCoffeeShopService: CoffeeShopMarkerService
    private let makeDetailView: (CoffeeShopMarker) -> DetailView
    @State private var coffeeShops: [CoffeeShopMarker] = []
    @State private var selection: CoffeeShopMarker?
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var coffeeShopsTask: Task<(), Error>?

    public init(
        mapCoffeeShopService: CoffeeShopMarkerService,
        @ViewBuilder detailView makeDetailView: @escaping (CoffeeShopMarker) -> DetailView
    ) {
        self.mapCoffeeShopService = mapCoffeeShopService
        self.makeDetailView = makeDetailView
    }

    public var body: some View {
        Map(position: $position, selection: $selection) {
            ForEach(coffeeShops, id: \.self) { coffeeShop in
                Marker(
                    coffeeShop.title,
                    systemImage: "mug",
                    coordinate: coffeeShop.coordinate
                )
                .tint(Color(coffeeShop.color))
            }
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        .sheet(item: $selection.animation()) { selectedCoffeeShop in
            makeDetailView(selectedCoffeeShop)
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
            showCoffeeShops(in: context.region)
        }
        .onAppear {
            requestLocationAuthorizationIfNeeded()
        }
    }
}

private extension MapView {
    private func showCoffeeShops(in region: MKCoordinateRegion) {
        coffeeShopsTask?.cancel()
        coffeeShopsTask = Task {
            let newCoffeeShopsStream = try await mapCoffeeShopService.coffeeShops(
                centerLatitude: region.center.latitude,
                centerLongitude: region.center.longitude,
                latitudeDelta: region.span.latitudeDelta,
                longitudeDelta: region.span.longitudeDelta
            )
            guard !Task.isCancelled else {
                return
            }
            for try await newCoffeeShops in newCoffeeShopsStream {
                withAnimation {
                    self.coffeeShops = newCoffeeShops
                }
                reselectCoffeeShopIfNeeded(selectingFrom: newCoffeeShops)
            }
        }
    }

    private func reselectCoffeeShopIfNeeded(selectingFrom newCoffeeShops: [CoffeeShopMarker]) {
        if let oldSelectedCoffeeShop = selection {
            selection = newCoffeeShops.first { $0.id == oldSelectedCoffeeShop.id }
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
    MapView(mapCoffeeShopService: PreviewCoffeeShopMarkerService()) { _ in
        Text("CoffeeShop Details")
    }
}
