import XCTest
@testable import HomeCare

final class MarkTaskDoneUseCaseTests: XCTestCase {
    func testMarkDoneUpdatesDates() {
        let homeID = UUID()
        var task = TaskEntity(homeID: homeID, title: "Test", frequencyDays: 7, lastDoneAt: nil, nextDueAt: Date())
        var useCase = MarkTaskDoneUseCase()
        let now = Date()
        useCase.execute(task: &task, at: now)
        XCTAssertEqual(task.lastDoneAt, now)
        let expectedNext = Calendar.current.date(byAdding: .day, value: 7, to: now)!
        XCTAssertEqual(task.nextDueAt, expectedNext)
    }
}
