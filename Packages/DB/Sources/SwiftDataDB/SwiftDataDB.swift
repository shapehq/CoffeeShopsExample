import Foundation
import SwiftData

public final class SwiftDataDB {
    public let modelContainer: ModelContainer

    public init(isStoredInMemoryOnly: Bool) {
        // swiftlint:disable:next force_try
        modelContainer = try! ModelContainer(
            for: SwiftDataCoffeeShop.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: isStoredInMemoryOnly
            )
        )
    }
}
