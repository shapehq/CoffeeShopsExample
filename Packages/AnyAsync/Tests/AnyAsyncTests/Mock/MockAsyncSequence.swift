final class MockAsyncSequence<ElementType>: AsyncSequence, AsyncIteratorProtocol {
    typealias Element = ElementType

    private var elements: [ElementType]

    init(elements: [ElementType]) {
        self.elements = elements
    }

    func next() async -> Element? {
        if !elements.isEmpty {
            return elements.removeFirst()
        } else {
            return nil
        }
    }

    func makeAsyncIterator() -> MockAsyncSequence {
        self
    }
}
