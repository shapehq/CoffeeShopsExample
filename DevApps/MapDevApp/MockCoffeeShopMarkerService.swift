import MapFeatureDomain

struct MockCoffeeShopMarkerService: CoffeeShopMarkerService {
    // swiftlint:disable:next function_body_length
    func coffeeShops(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) async throws -> AsyncThrowingStream<[CoffeeShopMarker], Error> {
        AsyncThrowingStream {
            [
                CoffeeShopMarker(
                    title: "Prufrock Coffee",
                    latitude: 51.52004066260156,
                    longitude: -0.10943098689930579,
                    color: .blue
                ),
                CoffeeShopMarker(
                    title: "Rapha London",
                    latitude: 51.51092038993181,
                    longitude: -0.13664944343263805,
                    color: .green
                ),
                CoffeeShopMarker(
                    title: "Black Sheep Coffee",
                    latitude: 51.49314528412428,
                    longitude: -0.1489984399878538,
                    color: .green
                ),
                CoffeeShopMarker(
                    title: "Back in Black",
                    latitude: 48.85726817723269,
                    longitude: 2.368860624963221,
                    color: .black
                ),
                CoffeeShopMarker(
                    title: "Kaffestuen Vesterbro",
                    latitude: 55.671604,
                    longitude: 12.545243,
                    color: .orange
                ),
                CoffeeShopMarker(
                    title: "Il Buco",
                    latitude: 55.666320,
                    longitude: 12.580248,
                    color: .blue
                ),
                CoffeeShopMarker(
                    title: "La Cabra Coffee",
                    latitude: 56.158761,
                    longitude: 10.210360,
                    color: .blue
                ),
                CoffeeShopMarker(
                    title: "Lagkagehuset",
                    latitude: 56.429732,
                    longitude: 10.053857,
                    color: .red
                ),
                CoffeeShopMarker(
                    title: "Jumbo",
                    latitude: 56.151616,
                    longitude: 10.214989,
                    color: .black
                )
            ]
        }
    }
}
