import MapFeatureDomain

struct MockMapPOIService: MapPOIService {
    // swiftlint:disable:next function_body_length
    func pointsOfInterest(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) async throws -> AsyncThrowingStream<[MapPOI], Error> {
        AsyncThrowingStream {
            [
                MapPOI(
                    title: "Prufrock Coffee",
                    latitude: 51.52004066260156,
                    longitude: -0.10943098689930579,
                    color: .blue
                ),
                MapPOI(
                    title: "Rapha London",
                    latitude: 51.51092038993181,
                    longitude: -0.13664944343263805,
                    color: .green
                ),
                MapPOI(
                    title: "Black Sheep Coffee",
                    latitude: 51.49314528412428,
                    longitude: -0.1489984399878538,
                    color: .green
                ),
                MapPOI(
                    title: "Back in Black",
                    latitude: 48.85726817723269,
                    longitude: 2.368860624963221,
                    color: .black
                ),
                MapPOI(
                    title: "Kaffestuen Vesterbro",
                    latitude: 55.671604,
                    longitude: 12.545243,
                    color: .orange
                ),
                MapPOI(
                    title: "Il Buco",
                    latitude: 55.666320,
                    longitude: 12.580248,
                    color: .blue
                ),
                MapPOI(
                    title: "La Cabra Coffee",
                    latitude: 56.158761,
                    longitude: 10.210360,
                    color: .blue
                ),
                MapPOI(
                    title: "Lagkagehuset",
                    latitude: 56.429732,
                    longitude: 10.053857,
                    color: .red
                ),
                MapPOI(
                    title: "Jumbo",
                    latitude: 56.151616,
                    longitude: 10.214989,
                    color: .black
                )
            ]
        }
    }
}
