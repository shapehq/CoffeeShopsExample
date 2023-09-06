import AnyAsync
import XCTest

final class AnyAsyncIteratorTestsTests: XCTestCase {
    func testIteratesSameElementsAsWrappedSequence() async throws {
        let sequence = AnyAsyncSequence(["foo", "bar"])
        let anyIterator = AnyAsyncIterator(sequence)
        let expectation = XCTestExpectation(description: "timeout")
        let task = Task {
            var expectedElements = ["foo", "bar"]
            while let element = try await anyIterator.next() {
                XCTAssertEqual(element, expectedElements.removeFirst())
            }
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1)
        task.cancel()
    }
}
