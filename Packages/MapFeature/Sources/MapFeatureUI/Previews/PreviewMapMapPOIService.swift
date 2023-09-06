import MapFeatureDomain

struct PreviewMapPOIService: MapPOIService {
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
                    latitude: 51.519922,
                    longitude: -0.109431,
                    color: .black
                ),
                MapPOI(
                    title: "Rapha",
                    latitude: 51.510852,
                    longitude: -0.136684,
                    color: .black
                ),
                MapPOI(
                    title: "Black Sheep Coffee",
                    latitude: 51.493258,
                    longitude: -0.149125,
                    color: .black
                )
            ]
        }
    }
}
