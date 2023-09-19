import Foundation

public protocol DetailsService {
    associatedtype DetailsType: Details
    func coffeeShopDetails(for sparseDetails: SparseDetails) async throws -> DetailsType
}
