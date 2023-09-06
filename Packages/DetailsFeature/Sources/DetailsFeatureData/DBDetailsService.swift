import DB
import DetailsFeatureDomain

public final actor DBDetailsService<DBPOIRepositoryType: DBPOIRepository>: DetailsService {
    private let dbPOIRepository: DBPOIRepositoryType

    public init(dbPOIRepository: DBPOIRepositoryType) {
        self.dbPOIRepository = dbPOIRepository
    }

    public func pointOfInterestDetails(for sparseDetails: SparseDetails) async throws -> some Details {
        let id = DBPOIID(latitude: sparseDetails.latitude, longitude: sparseDetails.longitude)
        if let dbPOI = try dbPOIRepository.pointOfInterest(withID: id) {
            return DBWrappingDetails(sparseDetails, dbPOI: dbPOI, dbPOIRepository: dbPOIRepository)
        } else {
            return DBWrappingDetails(sparseDetails, dbPOIRepository: dbPOIRepository)
        }
    }
}
