import AnyAsync
import XCTest

final class AnyAsyncSequenceTestsTests: XCTestCase {
    func testContainsSameElementsAsWrappedSequence() async throws {
        let sequence = MockAsyncSequence(elements: ["foo", "bar"])
        let anySquence = AnyAsyncSequence(sequence)
        let expectation = XCTestExpectation(description: "timeout")
        let task = Task {
            var expectedElements = ["foo", "bar"]
            for try await element in anySquence {
                XCTAssertEqual(element, expectedElements.removeFirst())
            }
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1)
        task.cancel()
    }
}
