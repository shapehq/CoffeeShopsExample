import DB
import MapFeatureDomain
import MapKit

public final class DBMapPOIService<DBPOIRepositoryType: DBPOIRepository>: MapPOIService {
    private let service: MapPOIService
    private let dbPOIRepository: DBPOIRepositoryType

    public init(decorating service: MapPOIService, dbPOIRepository: DBPOIRepositoryType) {
        self.service = service
        self.dbPOIRepository = dbPOIRepository
    }

    public func pointsOfInterest(
        centerLatitude: Double,
        centerLongitude: Double,
        latitudeDelta: Double,
        longitudeDelta: Double
    ) async throws -> AsyncThrowingStream<[MapPOI], Error> {
        AsyncThrowingStream { continuation in
            let task = Task { [weak self] in
                guard let self else {
                    return
                }
                let pointsOfInterestStream = try await self.service.pointsOfInterest(
                    centerLatitude: centerLatitude,
                    centerLongitude: centerLongitude,
                    latitudeDelta: latitudeDelta,
                    longitudeDelta: longitudeDelta
                )
                .flatMap { pointsOfInterest in
                    let dbPOIIDs = Set(pointsOfInterest.map { DBPOIID(latitude: $0.latitude, longitude: $0.longitude) })
                    return try self.dbPOIRepository.pointsOfInterest(withIDs: dbPOIIDs).map { dbPOIs in
                        return pointsOfInterest.map { poi in
                            let dbPOIID = DBPOIID(latitude: poi.latitude, longitude: poi.longitude)
                            guard let dbPOI = dbPOIs[dbPOIID] else {
                                return poi
                            }
                            let color = MapPOI.Color(dbPOI.rating)
                            return poi.withColor(color)
                        }
                    }
                }
                for try await pointsOfInterest in pointsOfInterestStream {
                    continuation.yield(pointsOfInterest)
                }
            }
            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }
}
