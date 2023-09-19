import AnyAsync
import Observation

public protocol VisitedPOIRepository: AnyObject, Observable {
    associatedtype VisitedPOIType: VisitedPOI
    var visitedPOIs: [VisitedPOIType] { get }
    func deleteVisitedPOI(_ poi: VisitedPOIType)
}
