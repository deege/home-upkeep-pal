import XCTest
@testable import HomeCare

final class ComputeNextDueUseCaseTests: XCTestCase {
    func testNextDueUsesFrequencyFromLastDone() {
        let useCase = ComputeNextDueUseCase()
        let last = ISO8601DateFormatter().date(from: "2024-01-01T00:00:00Z")!
        let next = useCase.execute(lastDone: last, frequencyDays: 10)
        let expected = Calendar.current.date(byAdding: .day, value: 10, to: last)!
        XCTAssertEqual(next, expected)
    }

    func testNextDueWithNilLastDoneUsesToday() {
        let useCase = ComputeNextDueUseCase()
        let next = useCase.execute(lastDone: nil, frequencyDays: 5)
        let today = Calendar.current.startOfDay(for: Date())
        let expected = Calendar.current.date(byAdding: .day, value: 5, to: today)!
        let comp = Calendar.current.compare(next, to: expected, toGranularity: .day)
        XCTAssertEqual(comp, .orderedSame)
    }
}
