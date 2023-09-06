import AnyAsync
import Foundation

public protocol DBPOIRepository {
    associatedtype DBPOIType: DBPOI
    var pointsOfInterest: AnyAsyncSequence<[DBPOIType]> { get }
    func pointsOfInterest(withID id: DBPOIID) throws -> DBPOIType?
    func pointsOfInterest(withIDs ids: Set<DBPOIID>) throws -> AnyAsyncSequence<[DBPOIID: DBPOIType]>
    func addPointOfInterest(
        title: String,
        latitude: Double,
        longitude: Double,
        phoneNumber: String?,
        websiteURL: URL?
    ) -> DBPOIType
    func deletePointOfInterest(_ poi: DBPOIType)
}
