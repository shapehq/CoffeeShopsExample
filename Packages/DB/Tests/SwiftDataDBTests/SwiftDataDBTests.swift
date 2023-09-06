import SwiftData
import SwiftDataDB
import XCTest

final class SwiftDataDBTests: XCTestCase {
    func testItCreatesInMemoryDB() {
        let db = SwiftDataDB(isStoredInMemoryOnly: true)
        let context = ModelContext(db.modelContainer)
        let configuration = db.modelContainer.configurations.first
        XCTAssertNotNil(context)
        XCTAssertTrue(configuration!.isStoredInMemoryOnly)
    }

    func testItCreatesOnDiskDB() {
        let db = SwiftDataDB(isStoredInMemoryOnly: false)
        let context = ModelContext(db.modelContainer)
        let configuration = db.modelContainer.configurations.first
        XCTAssertNotNil(context)
        XCTAssertFalse(configuration!.isStoredInMemoryOnly)
    }
}
