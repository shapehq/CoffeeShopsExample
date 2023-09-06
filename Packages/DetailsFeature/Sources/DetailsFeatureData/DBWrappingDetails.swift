import DB
import Foundation
import DetailsFeatureDomain

@Observable
final class DBWrappingDetails<DBPOIRepositoryType: DBPOIRepository>: Details {
    public let title: String
    public let latitude: Double
    public let longitude: Double
    public let phoneNumber: String?
    public let websiteURL: URL?
    public var rating: DetailsRating {
        didSet {
            if rating != oldValue {
                dbPOI.rating = DBRating(rating)
            }
        }
    }
    public var note: String? {
        didSet {
            if note != oldValue {
                dbPOI.note = note
            }
        }
    }

    private let dbPOIRepository: DBPOIRepositoryType
    private var _dbPOI: DBPOI?
    private var dbPOI: DBPOI {
        if let _dbPOI {
            return _dbPOI
        } else {
            let dbPOI = dbPOIRepository.addPointOfInterest(
                title: title,
                latitude: latitude,
                longitude: longitude,
                phoneNumber: phoneNumber,
                websiteURL: websiteURL
            )
            _dbPOI = dbPOI
            return dbPOI
        }
    }

    convenience init(
        _ sparseDetails: SparseDetails,
        dbPOI: DBPOI,
        dbPOIRepository: DBPOIRepositoryType
    ) {
        self.init(sparseDetails, dbPOIRepository: dbPOIRepository)
        _dbPOI = dbPOI
        rating = DetailsRating(dbPOI.rating)
        note = dbPOI.note
    }

    init(_ sparseDetails: SparseDetails, dbPOIRepository: DBPOIRepositoryType) {
        self.dbPOIRepository = dbPOIRepository
        self.title = sparseDetails.title
        self.latitude = sparseDetails.latitude
        self.longitude = sparseDetails.longitude
        self.phoneNumber = sparseDetails.phoneNumber
        self.websiteURL = sparseDetails.websiteURL
        self.rating = .unavailable
        self.note = nil
    }
}
