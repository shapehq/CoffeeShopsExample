import AnyAsync
import DB
import Foundation

final class MockDBPOIRepository: DBPOIRepository {
    let pointsOfInterest: AnyAsyncSequence<[MockDBPOI]>

    private(set) var deletedPOIID: DBPOIID?

    init(content: [MockDBPOI] = []) {
        pointsOfInterest = AnyAsyncSequence([content])
    }

    func pointOfInterest(withID id: DBPOIID) throws -> MockDBPOI? {
        nil
    }

    func pointsOfInterest(withIDs ids: Set<DBPOIID>) throws -> AnyAsyncSequence<[DBPOIID: MockDBPOI]> {
        AnyAsyncSequence([])
    }

    func addPointOfInterest(
        title: String,
        latitude: Double,
        longitude: Double,
        phoneNumber: String?,
        websiteURL: URL?
    ) -> MockDBPOI {
        MockDBPOI(
            id: DBPOIID(
                latitude: latitude, 
                longitude: longitude
            ),
            title: title,
            latitude: latitude,
            longitude: longitude,
            websiteURL: websiteURL,
            phoneNumber: phoneNumber
        )
    }

    func deletePointOfInterest(_ poi: MockDBPOI) {
        deletedPOIID = poi.id
    }
}
