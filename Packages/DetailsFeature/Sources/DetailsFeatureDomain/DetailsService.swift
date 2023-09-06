import Foundation

public protocol DetailsService {
    associatedtype DetailsType: Details
    func pointOfInterestDetails(for sparseDetails: SparseDetails) async throws -> DetailsType
}
