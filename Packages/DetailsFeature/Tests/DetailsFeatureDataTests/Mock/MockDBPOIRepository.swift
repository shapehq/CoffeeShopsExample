import AnyAsync
import DB
import Foundation

final class MockDBPOIRepository: DBPOIRepository {
    let pointsOfInterest: AnyAsyncSequence<[MockDBPOI]>

    private(set) var insertedPOI: MockDBPOI?
    private(set) var deletedPOIID: DBPOIID?
    private let content: [MockDBPOI]

    init(content: [MockDBPOI] = []) {
        self.content = content
        self.pointsOfInterest = AnyAsyncSequence([content])
    }

    func pointOfInterest(withID id: DBPOIID) throws -> MockDBPOI? {
        content.first { $0.id == id }
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
        let insertedPOI = MockDBPOI(
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
        self.insertedPOI = insertedPOI
        return insertedPOI
    }

    func deletePointOfInterest(_ poi: MockDBPOI) {
        deletedPOIID = poi.id
    }
}
