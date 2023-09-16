import AnyAsync
import DB
import Observation
import ProfileFeatureDomain

@Observable
public final class DBVisitedPOIsRepository<DBPOIRepositoryType: DBPOIRepository>: VisitedPOIsRepository {
    public var visitedPOIs: [DBVisitedPOI<DBPOIRepositoryType.DBPOIType>] {
        if fetchTask == nil {
            fetchPOIs()
        }
        return _visitedPOIs
    }

    private var _visitedPOIs: [DBVisitedPOI<DBPOIRepositoryType.DBPOIType>] = []

    private let dbPOIRepository: DBPOIRepositoryType
    private var fetchTask: Task<Void, Never>?

    public init(dbPOIRepository: DBPOIRepositoryType) {
        self.dbPOIRepository = dbPOIRepository
    }

    public func deleteVisitedPOI(_ poi: DBVisitedPOI<DBPOIRepositoryType.DBPOIType>) {
        dbPOIRepository.deletePointOfInterest(poi.dbPOI)
    }
}

private extension DBVisitedPOIsRepository {
    private func fetchPOIs() {
        fetchTask?.cancel()
        fetchTask = Task {
            do {
                for try await pointsOfInterest in dbPOIRepository.pointsOfInterest {
                    _visitedPOIs = pointsOfInterest.map(DBVisitedPOI.init)
                }
            } catch {
                _visitedPOIs = []
            }
        }
    }
}
